
# packages required -------------------------------------------------------

require(dplyr)
require(ggplot2)
require(testthat)
require(ggpubr)
require(purrr)
require(base)
require(gridExtra)


# ggheatmap for multiple matrices to be compared --------------------------

ggheatmap <- function(mat = NULL, mat_list = NULL, show_values = FALSE){
  #' Generate a heatmap of a list of matrices
  #'
  #' @param mat a single matrix
  #' @param mat_list a list of matrices that have the same dimensions
  #' @param show_values a logical value that indicates whether or not
  #' values are printed on each cell of the raster plot (default = FALSE)
  #' @return a ggplot object

  
  # check of the first argument is a single matrix
  if (is.null(mat_list) && !is.null(mat)) {
    # if the first argument is a list of matrices, change it to a list of
    # matrices, otherwise, return the heatmap of that matrix
    if (is.list(mat) == TRUE) {
      mat_list <- mat
      warning("You have entered a list of matrices as the first arguement.")
    } else {
      return(vanilla_ggheatmap(mat, show_values = show_values))
      break
    }
  }
  
  # check whether matrices on the list have the same dimensions
  boolean <- map_dbl(1:(length(mat_list) - 1),
                     function(x)
                       if_else(identical(dim(mat_list[[x]]),
                                         dim(mat_list[[x + 1]])),
                               true = 0, false = 1))
  
  # if not, stop the function and return an error
  if (sum(boolean) >= 1) {
    stop("You have entered matrices of different dimemsions.")
  }
  
  # create common legend
  mat_unlist <- unlist(mat_list)
  common_legend <-
    seq(floor(min(mat_unlist)), ceiling(max(mat_unlist)),
        by = (ceiling(max(mat_unlist)) - floor(min(mat_unlist))) /4)
  
  
  # generate a list of heatmaps of matrices in the list
  fig_list <-
    map(
      mat_list,
      ~ vanilla_ggheatmap(.x, legend_scale = common_legend, show_values = show_values)
    )
  
  # combine all heatmaps
  ggarrange(
    plotlist = fig_list,
    legend = "right",
    common.legend = TRUE
    )
  
}


# ggheathap for a single matrix -------------------------------------------

vanilla_ggheatmap <- function(mat, legend_scale = NULL, show_values = FALSE) {
  #' Generate a heatmap of a Matrix
  #'
  #' @param mat a matrix
  #' @param legend_scale the scale on the legend
  #' @param show_values a logical value that indicates whether or nor
  #' values are printed on each cell of the raster plot. (default = FALSE)
  #' @return a ggplot object
  
  # convert the matrix into a tibble with appropriate format to create heatmap
  df <- tibble(
    values = as.vector(mat),
    from = rep(nrow(mat):1,
               ncol(mat)),
    to = rep(1:ncol(mat),
             each = nrow(mat))
  )
  
  # generate the heatmap of the matrix with the indicated show_legend value
  if (is.null(legend_scale)) {
    fig <- df %>%
      ggplot(aes(x = to, y = from)) +
      geom_raster(aes(fill = values)) +
      scale_fill_gradientn(colors = c("#5287B9",
                                      "#fafafa",
                                      "#C15F56")) +
      theme_void()
  } else {
    fig <- df %>%
      ggplot(aes(x = to, y = from)) +
      geom_raster(aes(fill = values)) +
      scale_fill_gradient2(low = "#5287B9", 
                           mid = "#fafafa", 
                           high = "#C15F56", 
                           midpoint = (min(legend_scale) + max(legend_scale))/2,
                           breaks = legend_scale,
                           labels = legend_scale,
                           limits = c(min(legend_scale), 
                                      max(legend_scale))) +
      theme_void()
  }
  
  # add values on each cell of the heatmap
  # limit the number of rows and columns to be less than 20 to ensure that 
  # values shown are visible
  if ((show_values == TRUE) && (dim(mat) <= c(20, 20))) {
    fig <- fig +
      geom_text(data = df, aes(label = round(values, 2)))
  }
  
  # return the heatmap
  fig
}
