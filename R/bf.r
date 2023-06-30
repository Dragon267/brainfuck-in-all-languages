data <- integer(30000)
s <- ""
p <- 1

process <- function(loc) {
  stack <- c()
  t <- loc
  while (t <= nchar(s)) {
    c <- substr(s, t, t)
    if (p < 1) { print("ERROR"); exit(0); }
    if (c == "+") {
      data[p] <- data[p] + 1
    }
    if (c == "-") data[p] <- data[p] - 1
    if (c == ">") p <- p + 1
    if (c == "<") p <- p - 1
    if (c == ".") cat(intToUtf8(data[p]))
    if (c == ",") data[p] <- utf8ToInt(readLines("stdin", 1))
    if (c == "[") {
      if (data[p] == 0) {
        level <- 1
        while (level > 0) {
          t <- t + 1
          if (substr(s, t, t) == "[") level <- level + 1
          if (substr(s, t, t) == "]") level <- level - 1
        }
      } else {
        stack <- c(stack, t)
      }
    }
    if (c == "]") {
      if (data[p] != 0) {
        t <- stack[length(stack)]
      } else {
        stack <- stack[-length(stack)]
      }
    }
    t <- t + 1
  }
  invisible(nchar(s))
}

args <- commandArgs(trailingOnly = TRUE)
fileName <- args[1]
fileContent <- readLines(fileName, warn = FALSE)
s <- paste(fileContent, collapse = "\n")
process(1)

