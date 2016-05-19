# Add custom library path:
.libPaths(c("~/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2", .libPaths()[-1]))

# Save command history even if not saving workspace:
.Last <- function() {
  if (!any(commandArgs() == '--no-readline') && interactive()){
          require(utils)
          try(savehistory(Sys.getenv("R_HISTFILE")))
  }
}
Sys.setenv(R_HISTSIZE='100000')
invisible(Sys.setlocale("LC_ALL", "C"))

# Invisible environment for functions created here (for interactive use, never
# use in code):

.env <- new.env()

# Colorschemes:
.env$tomorrowNightEighties <- function() {
  require(colorout)
  setOutputColors256(150, 210, 252, 222, 68, 81, 252, 168, 150, 177,
                     253, 210, 211, FALSE)
}

.env$solarizedLight <- function() {
  require(colorout)
  setOutputColors256(243, 167, 63, 101, 33, 33, 169, 167, 37, 63,
                     167, 167, 167, FALSE)
}

# source() is now just e() and has a timer and notifies when complete or errors:
.env$e <- function(x, notify = FALSE, ...) {
  start.time <- Sys.time()
  if (!notify) {
    source(x, ...)
  } else if (notify & grepl("linux", version$os)) {
    tryCatch(source(x, ...),
             error = function(e) {
               system(paste0("notify-send -t 1000 ",
                             "-i ~/.icons/Numix-Circle/48x48/apps/rstudio.svg",
                             " 'Error in R script'"))})
    system(paste0("notify-send -t 1000 ",
                  "-i ~/.icons/Numix-Circle/48x48/apps/rstudio.svg",
                  " 'R script complete'"))
  } else {
    stop("'notify = TRUE' not available")
  }
  print(Sys.time() - start.time)
}

# Only install a package if it's not already installed and load it too.
.env$install <- function(x) {
  if (suppressWarnings(require(x, character.only = TRUE))) {
    message("Package ", x, " is already installed.")
  } else {
    install.packages(x, lib = "~/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2")
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
  if (length(system("which feh", intern = TRUE)) == 0) {
    stop("feh must be installed. Won't work on Windows")
  }
  png("~/.tmp.png", width = 1920, height = 1080)
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

.env$convertExcelDate <- function(x) {
  as.POSIXct(x * (60 * 60 * 24), origin = "1899-12-30", tz = "GMT")
}

.env$ggColorHue <- function(n) {
  require(ggplot2)
  hues <- seq(15, 375, length = n+1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

attach(.env)

# Load up some libraries quietly and set the colorscheme:
.term <- system("echo $TERM", intern = TRUE)
.emulator <- system("echo $EMULATOR", intern = TRUE)
if (interactive() & (grepl("xterm", .term))) {
  lapply(c("bit64", "Cairo", "colorout", "data.table", "ggplot2", "setwidth"),
         function(x) {
           suppressPackageStartupMessages(require(x, character.only = TRUE))
         })
  if ((.emulator == "gnome-terminal-server") | (.emulator == "xfce4-terminal")) {
    solarizedLight()
  } else {
    tomorrowNightEighties()
  }
}

# Never ask for my CRAN mirror again:
if (system("hostname", intern = TRUE) == "scc1") {
  options(repos = c(CRAN = "http://cran.rstudio.com"))
} else {
  options(repos = c(CRAN = "https://cran.rstudio.com"))
}

# Set line and tab width:
options(tab.width = 2)
options(help_type = "text")

# Don't use exponentials to display numbers
options(scipen = 10)

# Display current release of the OS:
if (grepl("linux", version$os)) {
  .os <- system("lsb_release -a | grep -n 'Description' | cut -d':' -f3",
               intern = TRUE)
  .os <- sub("^\\s+", "", .os)
} else {
  .os <- version$os
}

# Display the following message on startup (word wrap if too long):
welcome <- strsplit(paste(version[[13]], version[[14]], "on", .os), " ")[[1]]
welcome.chars <- 0
for (i in welcome) {
  if (welcome.chars + nchar(i) + 1 < getOption("width")) {
    cat(i, "")
    welcome.chars <- welcome.chars + nchar(i) + 1
  } else {
    welcome.chars <- 0
    cat("\n")
    cat(i, "")
    welcome.chars <- welcome.chars + nchar(i) + 1
  }
}
cat("\n")
rm(welcome, welcome.chars, i)

# cat("
#             IIIIIIIIIIIII77$$            
#        II??+I7II??????II???I77$Z        
#     ???=$$7?~=?I$ZO88888OOZZ$$7I7ZZ     
#    ??:Z7+:~+Z8D8              OZ$7$Z    
#  ??,Z7+,~I8N   IIIIIIIIIIIII77    $7Z8  
# :?.ZI,,~ON     ?8ZZZZZZZZZZZOD+IZ   7ZO 
# ?=O7:,~OM      ?8???,????I?+????7O   78 
# ?:Z?.:ZD       ?8??+$M     Z+7??+Z8   I 
# I+$+.~ZN       ?8??+$N      ?8??+ZM   I 
# IIZI.:78       ?8??+$N     ?,Z??=8    Z 
#  II$?,=Z8      ?8???Z~~~~~,N7?.~DN   ?  
#   7I7I:=IO     ?8??????????=O8NM    ?$  
#    $77I?=?7Z   ?8???$D88Z???77=   ?N    
#      Z$7I?+II7$?8??+$N   $=??O+O?D      
#        ZZ$$7I?I?8??+$N77II7+???7O       
#            OOOZ?8??+$NZOO8D7Z????O      
#                ?8??+$N      IZ????O     
#                ?????$N      7I?????O\n")
# Change the prompt from "> " to "R> "
options(prompt = "R> ")
