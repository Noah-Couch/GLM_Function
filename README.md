# GLM_Function

##Assignment from STA 711: Advanced Statistical Inference

We are tasked with writing a function in R that acts identically to the `glm` function--for linear, logistic, and Poisson regression. The main exercise is to practice using the iterative process, *Fisher scoring*. 

Linear regression is convenient because there exists a close form solution. There is no such solution for logistic and Poisson regression. The steps to use Fisher scoring are 

  - Step 1: Initialize the coefficients. Let $\beta^{(0)}$ denote the vector of initial coefficients.
  - Step 2: Calculate the score $U(\beta^{(0)})$ and the information $\mathcal{I}(\beta^{(0)})$ for the initial coefficients (see below).
  - Step 3: Update the estimated coefficients: $$\beta^{(1)}=\beta^{(0)}+(\mathcal{I}(\beta^{(0)}))^{−1} U(\beta^{(0)})$$
  - Step 4: Continue the process. If $\beta^{(r)}$ is the estimated coefficients on iteration $r$, then the estimated coefficients on iteration $r+1$ are $$\beta^{(r+1)}=\beta^{(r)}+(\mathcal{I}(\beta^{(0)}))^{−1} U(\beta^{(r)})$$
  - Step 5: Stop when the algorithm converges, or when a maximum number of iterations is reached.

