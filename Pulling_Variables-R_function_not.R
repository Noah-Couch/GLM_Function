# Pulling Variables from the formula -------------------------------------------

### Getting the response variable
get.Y <- function(formula, data) {
  Y <- model.frame(formula, data)[,1]
  return(Y)
}

### Getting the explanatory variable(s)
get.Design <- function(formula, data) {
  X <- as.matrix(model.matrix(formula, data))
  return(X)
}