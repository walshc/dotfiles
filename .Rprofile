# Save command history even if not saving workspace:
.Last <- function() {
  if (!any(commandArgs() == '--no-readline') && interactive()){
          require(utils)
          try(savehistory(Sys.getenv("R_HISTFILE")))
  }
}
Sys.setenv(R_HISTSIZE='100000')
invisible(Sys.setlocale("LC_ALL", "C"))

# Load up some libraries quietly and set the colorscheme:
.term <- system("echo $TERM", intern = TRUE)
if (interactive() & (grepl("xterm", .term))) {
  lapply(c("colorout", "data.table", "ggplot2", "setwidth"), function(x)
    suppressPackageStartupMessages(require(x, character.only = TRUE)))
  # Tomorrow Night Eighties colours:
  setOutputColors256(150, 210, 252, 222, 68, 81, 252, 168, 150, 177,
                     253, 210, 211, FALSE)
}

# If script has an error, display a notification:
options(error = function() {
        system(paste0("notify-send -t 1000 ",
                      "-i ~/.icons/Numix-Circle/48x48/apps/rstudio.svg",
                      " 'Error in R script'"))})

# Never ask for my CRAN mirror again:
if (system("hostname", intern = TRUE) == "scc1") {
  options(repos = c(CRAN = "http://cran.rstudio.com"))
} else {
  options(repos = c(CRAN = "https://cran.rstudio.com"))
}
# Add custom functions:
source("~/Dropbox/.dotties/my-R-functions.R")

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

# Display the following message on startup:
if (getOption("width") >= 84) {
  cat(version[[13]], version[[14]], "on", .os, "\n")
} else {
  cat(version[[13]], version[[14]], "on\n")
  cat(.os, "\n")
}

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
