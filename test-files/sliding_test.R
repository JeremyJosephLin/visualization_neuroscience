# Test File for sliding window function 
source(here::here("function","sliding_window.R"))

# generate input 
mat <- matrix(rnorm(15),3,5)
tall_mat <- t(mat)

mat
# regular long matrix case 
df<-sliding_window(mat, win_width = 3, stride = 2)

# tall matrix case 
sliding_window(tall_mat, win_len = 3, stride = 2)

#length of windows is bigger than matrix
sliding_window(mat, win_len = 8, stride = 6)

# stride is bigger than matrix 
sliding_window(mat, win_len = 5, stride = 5)

# sliding windows are not connected
sliding_window(mat, win_len = 2, stride = 3)

# sliding window with row mean 
sliding_window(mat, win_len = 3, stride = 2, row_mean = TRUE)


# possible error message------------------------------------- 
# when windows is bigger than matrix (ncol < win len ) (Done)
# warning when rows is bigger than columns (Done)
# Possible Issues when # jump during windows (stride > n_windows) fix !
# output should be a list ( list of windows, matrix that contains row means)
# create a script and folder for testing 
# check map_dfr map_dfc