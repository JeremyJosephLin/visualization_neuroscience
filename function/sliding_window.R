#' Sliding Window
#' #' Apply a Sliding Window to a Matrix (Time Series)
#'
#' This function applies a sliding window to a matrix (time series) and outputs
#' a list of windows.
#' @param mat a matrix (Time Series)
#' @param win_len an integer, length of the window (default = 20)
#' @param stride an integer, sliding window step size (default = 5)
#' @param row_mean 
#'
#' @return a list containing the windows and row means of each window if row_mean = TRUE or windows if row_mean = FALSE
#' @export
#'
#' @examples
#' 
#' 


sliding_window <- function(mat, win_len = 20, stride = 5,row_mean = FALSE) {
    
    require("purrr")
    
    n_col <- ncol(mat)
    n_row <- nrow(mat)
    
    if (n_row > n_col) {
        #
        warning("This is a tall matrix, we will assume you meant the transpose of the matrix")
        
        # transposing matrix
        mat <- t(mat)
        
        # swapping row and col
        dummy_var <- n_col
        n_col <- n_row
        n_row <- dummy_var
    }
    
    
    if (win_len > n_col) {
        stop("The length of window is bigger than the data")
    } else if (stride > win_len) {
        stop ("The windows are not connected, please choose a larger window length or smaller stride")
    } else {
        # vectors that holds starting position of each sliding windows
        # start from one and end at ncol - win_len + 1 because it ends at ncol
        win_start_ind <- seq(from = 1,
                             to = n_col - win_len + 1,
                             by = stride)
        # total number of  windows matrix
        n_windows <- length(win_start_ind)
        
        # list of all sliding windows n_windows item
        # start from i and ends at start + win len - because it start from i 
        windows <- map(1:n_windows,
                       function(i)
                           mat[, win_start_ind[i]:(win_start_ind[i] + win_len - 1)])
    }
    return(windows)
    if (row_mean == TRUE) {
        # rowmean_lst <- map(windows, rowMeans) %>%
        #     unlist() %>%
        #     matrix(., nrow = n_row, ncol = n_windows)
        rowmean_lst <- map_dfc(windows, rowMeans) %>%
            as.matrix()
        # create a list of windows and rowmean 
        list(windows = windows, row_means = rowmean_lst)
        return(list(windows = windows, row_means = rowmean_lst))
    }
    
    
}