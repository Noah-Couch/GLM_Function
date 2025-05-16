################################################################################
############################ Testing my_glm Function ###########################
################################################################################

############################### Required Packages ##############################

library(palmerpenguins)
library(tidyverse)


################################ Source Scripts ################################

source("Pulling_Variables-R_function_not.R")
source("Helper_Functions.R")
source("Fitting_glm-Function.R")
source("my_glm-Function.R")

############################## Linear Regression ###############################

# Creating a data frame for Penguin data from palmerpenguins library
Lin.Reg_data <- penguins |>
  drop_na()

### Using my_glm
m.linear <- my_glm(formula = body_mass_g ~ flipper_length_mm + bill_length_mm, 
                   family = "gaussian", Lin.Reg_data)

m.linear$coefficients
m.linear$iterations
m.linear$family
m.linear$deviance

############################# Logistic Regression ##############################

# Creating a data frame for Penguin data from palmerpenguins library
Log.Reg_data <- penguins |>
  drop_na() |>
  mutate(sex = ifelse(sex == "female", 1, 0))

### Using my_glm
m.logistic <- my_glm(formula = sex ~ flipper_length_mm + bill_length_mm, 
                     family = "binomial", Log.Reg_data)

m.logistic$coefficients
m.logistic$iterations
m.logistic$family
m.logistic$deviance


############################# Poisson Regression ###############################

### Simulating Data for Poisson Regression 
set.seed(214)

n <- 300
x1 <- rbinom(n, 1, 0.5)
x2 <- runif(n)
x3 <- runif(n)
y <- rpois(n, exp(0.5 - x1 + x2 - 0.5*x3))

# Creating a data frame for the simulated data 
Pois.Reg_data <- data.frame(y, x1, x2, x3)

### Using my_glm
m.poisson <- my_glm(formula = y ~ x1 + x2 + x3, 
                    family = "poisson", Pois.Reg_data)

m.poisson$coefficients
m.poisson$iterations
m.poisson$family
m.poisson$deviance