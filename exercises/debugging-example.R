f <- function(a) {
  g(a)
}

g <- function(b) {
  h(b)
}

h <- function(c) {
  print(c)
  c(2,1) + c(3,1,9)
  i(c)
}

i <- function(d) {
  if(!is.numeric(d)) {
    stop("`d` must be numeric", call. = FALSE)
  }
  d + 10
}

paste("set a break point")

source("exercises/debugging-example2.R")

# f("10")
