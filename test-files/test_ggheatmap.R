# library(testthat)

# context() is no longer recommended?


# testing cases for ggheatmap ---------------------------------------------

ggheatmap(mat = NULL, mat_list = mat_list, show_values = FALSE)
ggheatmap(mat_list = mat_list, show_values = TRUE)

ggheatmap(mat = mat, show_values = TRUE)
ggheatmap(mat, show_values = FALSE)

ggheatmap(mat_list, show_values = TRUE)


# error for entering different dimension matrices
mat <- matrix(rchisq(24, 2), nrow = 4, ncol = 6)
mat2 <- matrix(rchisq(30, 2), nrow = 5, ncol = 6)
mat3 <- matrix(rchisq(30, 2), nrow = 5, ncol = 6)
mat_list <- list(mat3, mat2, mat)


# multiple cases to check representations
mat <- matrix(rchisq(30, 2), nrow = 5, ncol = 6)
mat2 <- matrix(rchisq(30, 2), nrow = 5, ncol = 6)
mat_list <- list(mat, mat2)


mat <- matrix(rchisq(30, 2), nrow = 5, ncol = 6)
mat2 <- matrix(rnorm(30), nrow = 5, ncol = 6)
mat_list <- list(mat, mat2)


# larger size matrices
mat <- matrix(rchisq(100*6, 2), nrow = 100, ncol = 6)
mat2 <- matrix(rnorm(100*6), nrow = 100, ncol = 6)
mat_list <- list(mat, mat2)


mat <- matrix(rchisq(100*60, 2), nrow = 100, ncol = 60)
mat2 <- matrix(rnorm(100*60), nrow = 100, ncol = 60)
mat_list <- list(mat, mat2)


mat <- matrix(rchisq(100*60, 2), nrow = 60, ncol = 100)
mat2 <- matrix(rnorm(100*60), nrow = 60, ncol = 100)
mat_list <- list(mat, mat2)


mat <- matrix(rchisq(100*100, 2), nrow = 100, ncol = 100)
mat2 <- matrix(rchisq(100*100, 2), nrow = 100, ncol = 100)
mat_list <- list(mat, mat2)


mat <- matrix(rchisq(10*10, 2), nrow = 10, ncol = 10)
mat2 <- matrix(rchisq(10*10, 2), nrow = 10, ncol = 10)
mat_list <- list(mat, mat2)


# up until how many cells can show_value still be valid -------------------
# too many entries
mat <- matrix(rchisq(25*25, 2), nrow = 25, ncol = 25)
mat2 <- matrix(rchisq(25*25, 2), nrow = 25, ncol = 25)
mat_list <- list(mat, mat2)

# so so
mat <- matrix(rnorm(20*20), nrow = 20, ncol = 20)
mat2 <- matrix(rchisq(20*20, 2), nrow = 20, ncol = 20)
mat_list <- list(mat, mat2)


# more than 2 matrices ----------------------------------------------------

mat <- matrix(rnorm(20*20), nrow = 20, ncol = 20)
mat2 <- matrix(rchisq(20*20, 2), nrow = 20, ncol = 20)
mat3 <- matrix(rchisq(20*10, 2), nrow = 20, ncol = 10)
mat_list <- list(mat, mat2, mat3)

mat1 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat2 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat3 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat4 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat5 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat6 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)
mat7 <- matrix(rnorm(5*5), nrow = 5, ncol = 5)

mat_list <- list(mat1, mat2, mat3, mat4)
mat_list <- list(mat1, mat2, mat3, mat4, mat5, mat6)
mat_list <- list(mat1, mat2, mat3, mat4, mat5, mat6, mat7)


