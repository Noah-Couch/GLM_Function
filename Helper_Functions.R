################################################################################
############################### Helper Functions ###############################
################################################################################

############################## Linear Regression ###############################

### Function to calculate deviance
Deviance.Lin <- function(X, beta, Y) {
  # Calculating mu
  mu <- X %*% beta
  # Calculating Deviance
  deviance <- sum( (Y - mu)^2 )
  
  #Returning Deviance
  return(deviance)
}

### Function to calculate the SE(beta hat)
SE.Lin <- function(X, beta, Y) {
  # Calculating mu
  sig.sqr <- (1 / (nrow(X) - ncol(X))) * sum((Y - X %*% beta)^2)
  # Calculating the SE
  SE <- sqrt(diag(sig.sqr * solve(t(X) %*% X)))
  
  # Returning the Standard Error
  return(SE)
}

### Function to calculate the Z score
t.Lin <- function(X, beta, Y) {
  # Getting SE(beta hat) from SE.Log function
  SE <- SE.Lin(X, beta, Y)
  # Calculating the Z score
  t <- beta / SE
  
  # Returning the Z score
  return(t)
}

### Function to calculate the p-value
P.value.Lin <- function(X, beta, Y) {
  # Getting the Z score from Z.Log function
  t <- t.Lin(X, beta, Y)
  # Calculating the p-value
  p <- 2 * pt(abs(t), df = (nrow(X) - ncol(X)), lower.tail = FALSE)
  
  # Returning the p-value
  return(p)
}


############################# Logistic Regression ##############################

### Function to Calculate the Score
Score.Log <- function(beta, X, Y) {
  # Calculating mu (p.hat for Logistic Regression)
  p.hat <- c(exp(X %*% beta) / (1 + exp(X %*% beta)))
  # Calculating the score (U)
  score <- t(X) %*% (Y - p.hat)
  
  # Returning the Score
  return(score)
}

### Function to calculate the Information
Information.Log <- function(beta, X, y){
  # Calculating mu (p.hat for Logistic Regression)
  p.hat <- c(exp(X %*% beta) / (1 + exp(X %*% beta)))
  # Calculating the F*scher Information Matrix
  information <- -1 * t(X) %*% diag(p.hat * (1 - p.hat)) %*% X
  
  # Returning the Information
  return(information)
}

### Function to calculate the Deviance
Deviance.Log <- function(beta, X, Y) {
  # Calculating mu (p.hat for Logistic Regression)
  p.hat <- c(exp(X %*% beta) / (1 + exp(X %*% beta)))
  # Calculating the Deviance
  deviance <- -2 * sum((Y * log(p.hat)) + (1-Y) * log(1 - p.hat))
  
  # Returning the Deviance
  return(deviance)
}

### Function to calculate the SE(beta hat)
SE.Log <- function(X, beta) {
  # Calculating mu (p.hat for Logistic Regression)
  p.hat <- c(exp(X %*% beta) / (1 + exp(X %*% beta)))
  # Calculating the SE
  SE <- sqrt(diag(solve(t(X) %*% diag(p.hat * (1 - p.hat)) %*% X)))
  
  # Returning the Standard Error
  return(SE)
}

### Function to calculate the Z score
Z.Log <- function(X, beta) {
  # Getting SE(beta hat) from SE.Log function
  SE <- SE.Log(X, beta)
  # Calculating the Z score
  Z <- beta / SE
  
  # Returning the Z score
  return(Z)
}

### Function to calculate the p-value
P.value.Log <- function(X, beta) {
  # Getting the Z score from Z.Log function
  Z <- Z.Log(X, beta)
  # Calculating the p-value
  p <- 2 * pnorm(abs(Z), mean = 0, sd = 1, lower.tail = FALSE)
  
  # Returning the p-value
  return(p)
}


############################# Poisson Regression ###############################

### Function to Calculate the Score
Score.Pois <- function(beta, X, Y) {
  # Calculating mu (p.hat for Logistic Regression)
  mu <- c(exp(X %*% beta))
  # Calculating the score (U)
  score <- t(X) %*% (Y - mu)
  
  # Returning the Score
  return(score)
}

### Function to calculate the Information
Information.Pois <- function(beta, X, Y){
  # Calculating mu (p.hat for Logistic Regression)
  mu <- c(exp(X %*% beta))
  # Calculating the F*scher Information Matrix
  information <- -1 * t(X) %*% diag(mu) %*% X
  
  # Returning the Information
  return(information)
}

### Function to calculate the Deviance
Deviance.Pois <- function(beta, X, Y) {
  # Calculating mu (p.hat for Logistic Regression)
  mu <- c(exp(X %*% beta))
  # Calculating the Deviance
  deviance <- 2 * sum((Y *  ifelse(Y == 0, 0, log(Y / mu))) - (Y-mu))
  
  # Returning the Deviance
  return(deviance)
}

### Function to calculate the SE(beta hat)
SE.Pois <- function(X, beta) {
  # Calculating mu (p.hat for Logistic Regression)
  mu <- c(exp(X %*% beta))
  # Calculating the SE
  SE <- sqrt(diag(solve(t(X) %*% diag(mu) %*% X)))
  
  # Returning the Standard Error
  return(SE)
}

### Function to calculate the Z score
Z.Pois <- function(X, beta) {
  # Getting SE(beta hat) from SE.Log function
  SE <- SE.Pois(X, beta)
  # Calculating the Z score
  Z <- beta / SE
  
  # Returning the Z score
  return(Z)
}

### Function to calculate the p-value
P.value.Pois <- function(X, beta) {
  # Getting the Z score from Z.Log function
  Z <- Z.Pois(X, beta)
  # Calculating the p-value
  p <- 2 * pnorm(abs(Z), mean = 0, sd = 1, lower.tail = FALSE)
  
  # Returning the p-value
  return(p)
}


