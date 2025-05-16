# GLM_Function

##Assignment from STA 711: Advanced Statistical Inference
### Information from Dr. Ciaran Evans

We are tasked with writing a function in R that acts identically to the `glm` function--for linear, logistic, and Poisson regression. The main exercise is to practice using the iterative process, *Fisher scoring*. 

### Fitting a generalized linear model

Linear regression is convenient because there exists a close form solution. There is no such solution for logistic and Poisson regression. The steps to use Fisher scoring are 

  - Step 1: Initialize the coefficients. Let $\beta^{(0)}$ denote the vector of initial coefficients.
  - Step 2: Calculate the score $U(\beta^{(0)})$ and the information $\mathcal{I}(\beta^{(0)})$ for the initial coefficients (see below).
  - Step 3: Update the estimated coefficients: $$\beta^{(1)}=\beta^{(0)}+(\mathcal{I}(\beta^{(0)}))^{−1} U(\beta^{(0)})$$
  - Step 4: Continue the process. If $\beta^{(r)}$ is the estimated coefficients on iteration $r$, then the estimated coefficients on iteration $r+1$ are $$\beta^{(r+1)}=\beta^{(r)}+(\mathcal{I}(\beta^{(0)}))^{−1} U(\beta^{(r)})$$
  - Step 5: Stop when the algorithm converges, or when a maximum number of iterations is reached.
  
### Score and Fisher Information  
  
The score and information for a generalized linear model are functions of the parameter vector $\beta$:
  - $U(\beta^{(r)}) = X^T (Y - \mu^{(r)}) $
  - $\mathcal{I}(\beta^{(r)}) = X^T W^{(r)} X$
  
#### For Logistic Regression

$$\mu^{(r)} = \begin{bmatrix} \mu^{(r)}_1 \\ 
                              \vdots \\ 
                              \mu^{(r)}_n \end{bmatrix}
            = \frac{\exp\{X \beta^{(r)}\}}{1 + \exp\{X \beta^{(r)}\} }$$
            
$$W^{(r)} = \begin{bmatrix} \mu_1^{(r)} (1 - \mu_1^{(r)}) & 0 & 0 & \cdots & 0 \\
                            0 & \mu_2^{(r)} (1 - \mu_2^{(r)}) & 0 & \cdots & 0 \\ 
                            \vdots & \vdots & \vdots & \ddots & \vdots \\
                            0 & 0 & 0 & \cdots & \mu_n^{(r)} (1 - \mu_n^{(r)})
                            \end{bmatrix}$$
                            
#### For Poisson Regression

$$\mu^{(r)} = \begin{bmatrix} \mu^{(r)}_1 \\ 
                              \vdots \\ 
                              \mu^{(r)}_n \end{bmatrix}
            = \exp\{X \beta^{(r)}\}$$
            
$$W^{(r)} = \begin{bmatrix} \mu_1^{(r)}  & 0 & 0 & \cdots & 0 \\
                            0 & \mu_2^{(r)}  & 0 & \cdots & 0 \\ 
                            \vdots & \vdots & \vdots & \ddots & \vdots \\
                            0 & 0 & 0 & \cdots & \mu_n^{(r)} 
                            \end{bmatrix}$$
