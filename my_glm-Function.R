############################ Main Function (my_glm) ############################
################################################################################


################################ GLM function ##################################

my_glm <- function(formula, family, data, max.it = 50){
  switch(family, "gaussian" = Linear.Regression.Fun(formula, df),
         "binomial" = Logistic.Regression.fun(formula, df, max.it),
         "poisson"  = Poisson.Regression.Fun(formula, df, max.it))
}
