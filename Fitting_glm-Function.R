################################################################################
################# Functions to Fit (Generalized) Linear Models #################
################################################################################


############################## Linear Regression ###############################

Linear.Regression.Fun <- function(formula, data, family = "gaussian") {
  ### Defining X, Y
  Y <- get.Y(formula, df)
  X <- get.Design(formula, df)
  
  ### Calculating Beta Hat
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  
  ### Deviance
  deviance <- Deviance.Lin(X, beta, Y)
  
  ### Number of Iterations
  iterations <- 1
  
  ### SE of beta hat
  se <- SE.Lin(X, beta, Y)
  
  ### Z score for beta hat
  t_score <- t.Lin(X, beta, Y)
  
  ### Calculating p-values
  p_value <- P.value.Lin(X, beta, Y)
  
  ### Preparing Data Frame for "coefficients" output
  coefficients <- data.frame(beta = beta,
                             se = se,
                             t_score = t_score,
                             p_value = p_value)
  
  ### Returning a list of output
  return(list(coefficients = coefficients,
              iterations = iterations,
              family = family,
              deviance = deviance))
}


############################# Logistic Regression ##############################

Logistic.Regression.fun <- function(formula, data, max.it = 50, family = "binomial"){
  ### Defining X, Y, and Beta
  Y <- get.Y(formula, df)
  X <- get.Design(formula, df)
  beta.initial <- c(log(mean(Y)/(1 - mean(Y))), rep(0, ncol(X) - 1))
  
  ### Defining initial values for iteration
  beta <- beta.initial
  p.hat <- c(exp(X %*% beta) / (1 + exp(X %*% beta)))
  deviance.change <- 1
  it.count <- 0
  
  ### Calculating estimates for beta hat
  while (deviance.change > 0.001 & it.count <= max.it) {
    ### Deviance from previous iteration
    deviance.old <- Deviance.Log(beta, X, Y)
    ### Updated calculation for beta
    beta <- beta - solve(Information.Log(beta, X, Y)) %*% Score.Log(beta, X, Y)
    ### Calculating new deviance with updated beta
    deviance.new <- Deviance.Log(beta, X, Y)
    ### Measuring the Change in Deviance
    deviance.change <- abs(deviance.new - deviance.old)
    ### Iteration counter
    it.count <- it.count + 1
  }
  
  ### Deviance
  deviance <- deviance.new
  
  ### Number of Iterations
  iterations <- it.count
  
  ### SE of beta hat
  se <- SE.Log(X, beta)
  
  ### Z score for beta hat
  z_score <- Z.Log(X, beta)
  
  ### Calculating p-values
  p_value <- P.value.Log(X, beta)
  
  ### Preparing Data Frame for "coefficients" output
  coefficients <- data.frame(beta = beta,
                             se = se,
                             z_score = z_score,
                             p_value = p_value)
  
  ### Returning a list of output
  return(list(coefficients = coefficients,
              iterations = iterations,
              family = family,
              deviance = deviance))
}


############################# Poisson Regression ###############################

Poisson.Regression.Fun <- function(formula, data, max.it = 50, family = "poisson") {
  ### Defining X, Y, and Beta
  Y <- get.Y(formula, df)
  X <- get.Design(formula, df)
  beta.initial <- c(log(mean(Y)), rep(0, ncol(X) - 1))
  
  ### Defining initial values for iteration
  beta <- beta.initial
  mu <- exp(X %*% beta)
  deviance.change <- 1
  it.count <- 0
  
  while ( (deviance.change > 0.001) & (it.count <= max.it) ) {
    ### Deviance from previous iteration
    deviance.old <- Deviance.Pois(beta, X, Y)
    ### Updated calculation for beta
    beta <- beta - solve(Information.Pois(beta, X, Y)) %*% Score.Pois(beta, X, Y)
    ### Calculating new deviance with updated beta
    deviance.new <- Deviance.Pois(beta, X, Y)
    ### Measuring the Change in Deviance
    deviance.change <- abs(deviance.new - deviance.old)
    ### Iteration counter
    it.count <- it.count + 1
  }
  
  ### Deviance
  deviance <- deviance.new
  
  ### Number of Iterations
  iterations <- it.count
  
  ### SE of beta hat
  se <- SE.Pois(X, beta)
  
  ### Z score for beta hat
  z_score <- Z.Pois(X, beta)
  
  ### Calculating p-values
  p_value <- P.value.Pois(X, beta)
  
  ### Preparing Data Frame for "coefficients" output
  coefficients <- data.frame(beta = beta,
                             se = se,
                             z_score = z_score,
                             p_value = p_value)
  
  ### Returning a list of output
  return(list(coefficients = coefficients,
              iterations = iterations,
              family = family,
              deviance = deviance))
}