spike_raster_plot <- function(spike_train,
                              time = NULL,
                              size = 0.5,
                              alpha = 0.5,
                              interactive_plot = FALSE) {
    #' Spike Raster Plot
    #'
    #' Displays the spike train data of a group of neurons over time
    #'
    #' @param spike_train a binary matrix that contains a p-variate time series. 
    #' The columns in this matrix represent time and rows represent neurons.
    #' @param time a vector that contains the time stamps. 
    #' If not provided, the time stamps are going to be 
    #' 1, ..., \code{ncol(spike_train))}. (Note: the length of the \code{time} 
    #' vector must be equal to the number of columns of \code{spike_train} 
    #' matrix.
    #' @param size a numeric value that indicates the size of the points 
    #' in plot.
    #' @param alpha a positive numeric value between 0 and 1 indicating the 
    #' level of transparency of the points in the plot (default = 0.5).
    #' @param interactive_plot a logical value indicating whether the output 
    #' should be a plotly object or a ggplot (TRUE = plotly, FALSE = ggplot)
    #' 
    #' @return The spike raster plot of the binary time series 
    #' (spike train data), time on the x-axis and neurons on the y-axis.
    
    require(plotly)
    
    # check if spike_train is a binary matrix
    if (!all(spike_train %in% c(0, 1))) {
        stop("'spike_train' must be a binary matrix.")
    }
    
    if (!is.null(time) & length(time) != ncol(spike_train)) {
        stop("'time' must be the same length as the number of columns in 
             'spike_train'.")
    }
    # setting the row names if there is none
    if (is.null(rownames(spike_train))) {
        rownames(spike_train) <- paste0("U-", 1:nrow(spike_train))
    }
    
    # creating the values of the x-axis if there is none
    if (is.null(time)) {
        time = 1:ncol(spike_train)
    }
    
    # data to plot
    # each spike has a time and a neuron information
    df <- spike_train %>%
        t() %>%
        as_tibble() %>%
        mutate(time = time) %>%
        pivot_longer(cols = -time,
                     names_to = "neuron",
                     values_to = "spike") %>%
        # get the y-coordinate of the neurons that spiked
        mutate(neuron = as.factor(neuron),
               neuron = as.numeric(neuron)) %>%
        # throw away non-spikes
        filter(spike == 1) %>% 
        select(time, neuron)
    
    if (!interactive_plot) {
        ggplot(df) +
            geom_point(aes(x = time, y = neuron),
                       size = size,
                       alpha = alpha) +
            labs(x = "time", y = "") +
            scale_y_continuous(
                breaks = seq(1, nrow(spike_train)),
                labels = rownames(spike_train),
                limits = c(1, nrow(spike_train)),
                minor_breaks = 1:nrow(spike_train)
            ) +
            scale_x_continuous(breaks = time) +
            theme_bw() +
            theme(panel.grid.minor = element_blank())
    } else {
        plot_ly(
            data = df,
            x = ~ time,
            y = ~ neuron,
            opacity = alpha,
            size = size
        ) %>%
            add_trace(type = "scatter", mode = "markers") %>%
            layout(
                xaxis = list(title = "time"),
                yaxis = list(
                    title = "",
                    ticktext = as.list(rownames(spike_train)),
                    tickvals = as.list(1:nrow(spike_train))))
    }
}

# library(docstring)
# docstring(spike_raster_plot)