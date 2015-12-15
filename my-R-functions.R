
# Invisible environment for functions created here (for interactive use, never
# use in code):

.env <- new.env()

# Only install a package if it's not already installed and load it too.
.env$install <- function(x) {
  if (suppressWarnings(require(x, character.only = TRUE))) {
    message("Package ", x, " is already installed.")
  } else {
    install.packages(x)
    require(x, character.only = TRUE)
  }
}

# Add some aliases to make commands similar to the terminal:
.env$man <- utils::help
.env$pwd <- base::getwd
.env$cd <- base::setwd
.env$l <- base::list.files

# summary() is now just s():
.env$s <- base::summary

# head() is now just h():
.env$h <- utils::head

# clear() to delete all objects:
.env$clear <- function() rm(list=ls())

# knit and compile pdf with latexmk at once:
.env$klatex <- function(Rnw.file) {
  require(knitr)
  Rnw.file <- gsub(".Rnw", "", Rnw.file)
  knit(input = paste0(Rnw.file, ".Rnw"), output = paste0(Rnw.file, ".tex"),
       encoding = "UTF-8")
  system(paste0("latexmk -pdf -output-directory=", dirname(Rnw.file),
         " ", Rnw.file, ".tex"))
}

# Extract R code from knitr and execute it (for use in interactive mode):
.env$ksource <- function(x, ...) {
  require(knitr)
  x <- gsub(".Rnw", "", x)
  purl(input = paste0(x, ".Rnw"), output = paste0(x, ".R"))
  start.time <- Sys.time()
  source(paste0(x, ".R"), ...)
  print(Sys.time() - start.time)
}

# source() is now just e() and has a timer:
.env$e <- function(x, ...) {
  start.time <- Sys.time()
  source(x, ...)
  print(Sys.time() - start.time)
  if (!is.null(dev.list())) invisible(dev.off())
  if (grepl("linux", version$os)) {
    system(paste0("notify-send -t 1000 ",
                  "-i ~/.icons/Numix-Circle/48x48/apps/rstudio.svg",
                  " 'R script complete'"))
  }
}

# lu(x) to show number of unique elements
.env$lu <- function(x) length(unique(x))

# su(x) to sort unique elements in ascending order
.env$su <- function(x) sort(unique(x))

# pna(x) to get the percentage of NAs in a vector/data.frame
.env$pna <- function(x) {
  if (is.data.frame(x)) {
    return(1 - nrow(na.omit(x)) / nrow(x))
  } else {
    return(1 - length(na.omit(x)) / length(x))
  }
}

# Get a correlation matrix for all variables in a data frame:
.env$corr <- function(x) {
  if (!(is.data.frame(x))) stop("Argument must be a data.frame")
  return(cor(x[, unlist(lapply(x, is.numeric))], use = "pairwise.complete.obs"))
}

# Plot a kernel density estimate with kde()
.env$kde <- function(x) {
  require(ggplot2)
  qplot(x, geom = "density", fill = x, xlab = "", ylab = "", alpha = 0.2) +
    theme(legend.position = "none")
}

# Find a variable containing "x" in data.frame df:
.env$findVar <- function(x, data, ignore.case = TRUE) {
  grep(x, names(data), value = TRUE, ignore.case = ignore.case)
}

# Count the number of NAs in a vector
.env$countNA <- function(x) sum(is.na(x))

# Order objects by size in terms of memory usage (by Dirk Eddelbuettel):
# Can order objects by types below (Type, Size, etc.).
# Use head = TRUE to see only the biggest ones.
.env$lsos <- function (pos = 1, pattern, order.by,
                       decreasing = FALSE, head = FALSE, n = 5) {
  napply <- function(names, fn) sapply(names, function(x)
                                       fn(get(x, pos = pos)))
  names <- ls(pos = pos, pattern = pattern)
  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.prettysize <- napply(names, function(x) {
                           capture.output(format(utils::object.size(x),
                                                 units = "auto")) })
  obj.size <- napply(names, object.size)
  obj.dim <- t(napply(names, function(x)
                      as.numeric(dim(x))[1:2]))
  vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
  obj.dim[vec, 1] <- napply(names, length)[vec]
  out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
  names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
  if (!missing(order.by))
    out <- out[order(out[[order.by]], decreasing = decreasing), ]
  if (head)
    out <- head(out, n)
  out
}

# Shorthand for the above (show the 10 biggest objects in memory):
.env$lsBySize <- function(..., n = 10) {
    lsos(..., order.by = "Size", decreasing = TRUE, head = TRUE, n = n)
}

# Make a plot and set it as your background image:
.env$bgplot <- function(x, ...) {
  png("~/.tmp.png", width = 2560, height = 1440)
  plot(x, ...)
  dev.off()
  system("feh --bg-max ~/.tmp.png")
}

# Drop variables similar to how you can in Stata (with globs/wildcards):
.env$Drop <- function(patterns, data) {
  for (i in seq_along(patterns)) {
    data <- data[, - grep(glob2rx(patterns[i]), names(data))]
  }
  data
}

# Keep variables similar to how you can in Stata (with globs/wildcards):
.env$keep <- function(patterns, data) {
  keep.list <- character(0)
  for (i in seq_along(patterns)) {
    keep.list <- c(keep.list, grep(glob2rx(patterns[i]), names(data)))
  }
  data[, as.numeric(keep.list)]
}

# Get robust and clustered standard errors easier:
.env$reg <- function(formula, data, robust = FALSE, cluster = NULL, ...) {
  model <- lm(formula, data, ...)
  result <- summary(model)
  if (robust & is.null(cluster)) {
    require(sandwich)
    require(lmtest)
    result$coefficients <- coeftest(model, vcovHC(model, type = "HC0"))
  }
  if (!is.null(cluster)) {
    require(multiwayvcov)
    require(lmtest)
    if (class(cluster) %in% c("integer", "numeric", "factor")) {
      result$coefficients <- coeftest(model, cluster.vcov(model, cluster))
    }
    if (is.character(cluster)) {
      cvcov <- cluster.vcov(model, data[[paste(cluster)]])
      result$coefficients <- coeftest(model, cvcov)
    }
  }
  result
}

# Similar to above but for IV regressions:
.env$ivreg2 <- function(formula, data, robust = FALSE, cluster = NULL, ...) {
  require(AER)
  model <- ivreg(formula, data = data, ...)
  result <- summary(model)
  if (robust & is.null(cluster)) {
    require(sandwich)
    require(lmtest)
    result$coefficients <- coeftest(model, vcovHC(model, type = "HC0"))
  }
  if (!is.null(cluster)) {
    require(multiwayvcov)
    require(lmtest)
    if (class(cluster) %in% c("integer", "numeric", "factor")) {
      result$coefficients <- coeftest(model, cluster.vcov(model, cluster))
    }
    if (is.character(cluster)) {
      cvcov <- cluster.vcov(model, data[[paste(cluster)]])
      result$coefficients <- coeftest(model, cvcov)
    }
  }
  result
}

.env$minimizePackageList <- function(x, message.only = FALSE,
                                     pasteable = FALSE, sort = TRUE) {
  # Give it a vector of package names, it will return a vector with only the
  # necessary packages. If message.only = TRUE, it will only display a message
  # about which package is redundant. If pasteable = TRUE, it will output a
  # message that can be pasted write into the script. By default, the package
  # names will be sorted alphabetically. Use sort = FALSE to stop this.
  out <- x
  require(tools)
  pkg.dependencies <- package.dependencies(available.packages())
  for (i in seq_along(x)) {
    x.dependencies <- pkg.dependencies[[x[i]]]
    if (!any(c(is.null(x.dependencies), is.na(x.dependencies)))) {
      x.dependencies <- x.dependencies[, 1]
      for (j in seq_along(x)[-i]) {
        if (any(x[j] %in% x.dependencies)) {
          if (message.only) {
            message(x[i], " depends on ", x[j], ".")
            message(x[j], " can be removed from the package list.\n")
          } else {
            out[out == x[j]] <- NA
          }
        }
      }
    }
  }
  if (sort) {
    out <- sort(as.character(na.omit(out)))
  } else {
    out <- as.character(na.omit(out))
  }
  if (pasteable) {
    cat(".pkgs <- c(")
    for (i in seq_along(out)) {
      cat('"')
      cat(out[i])
      if (i != length(out)) {
        cat('", ')
      } else {
        cat('"')
      }
    }
    cat(")\n")
  } else {
    out
  }
}

.env$size <- function(x) {
  if (class(x)[1] %in% c("array", "data.frame", "data.table", "matrix")) {
    print(dim(x))
    print(class(x))
  } else {
    print(length(x))
    print(class(x))
  }
}

.env$classMethods <- function(cl) {
  if(!is.character(cl)) {
    cl <- class(cl)
  }
  ml <- lapply(cl, function(x) {
    sname <- gsub("([.[])", "\\\\\\1", paste0(".", x, "$"))
    m <- methods(class = x)
    if (length(m) > 0) {
      data.frame(m = as.vector(m), c = x, n = sub(sname, "", as.vector(m)),
                 attr(m, "info"), stringsAsFactors = FALSE)
    } else {
      return(NULL)
    }
  })
  df <- do.call(rbind, ml)
  df <- df[!duplicated(df$n),]
  structure(df$m, info = data.frame(visible = df$visible, from = df$from),
            class = "MethodsFunction")
}


.env$geocodeAddress <- function(address) {
  require(RJSONIO)
  if (!require(RJSONIO)) {
    msg = "Function requires package RJSONIO. Install (y/n)?"
    user.input <- readline(prompt = msg)
    if (user.input == "y") {
      install.packages("RJSONIO")
    } else {
      stop("Installation of package RJSONIO required.")
    }
  }
  root_url  <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(root_url, address, "&sensor=false", sep = ""))
  x <- fromJSON(url, simplify = FALSE)
  out <- list()
  if (x$status == "OK") {
    # Centroid coordinates of first search result:
    out$lon <- x$results[[1]]$geometry$location$lng
    out$lat <- x$results[[1]]$geometry$location$lat
    # Address of first search result (for checking):
    out$adr1 <- paste(unlist(x$results[[1]]$address_components[[1]]),
                      collapse = ", ")
    adr.length <- length(x$results[[1]]$address_components)
    if (adr.length >= 2) {
    out$adr2 <- paste(unlist(x$results[[1]]$address_components[[2]]),
                      collapse = ", ")
    } else {
      out$adr2 <- NA
    }
    if (adr.length >= 3) {
    out$adr3 <- paste(unlist(x$results[[1]]$address_components[[3]]),
                      collapse = ", ")
    } else {
      out$adr3 <- NA
    }
  } else {
    out <- NA
  }
  Sys.sleep(0.25)  # API only allows 5 requests per second
  out
}

attach(.env)
