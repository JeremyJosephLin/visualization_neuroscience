# Testing Functionality ---------------------------------------------------

p <- 5

spike_train <- matrix(rbinom(n = 10 * p, size = 1, prob = 0.5), 
                      nrow = p, 
                      ncol = 10)

spike_raster_plot(spike_train)
spike_raster_plot(spike_train, interactive_plot = TRUE)

rownames(spike_train) <- paste0("neuron-", 1:p)
spike_raster_plot(spike_train)
spike_raster_plot(spike_train, interactive_plot = TRUE)

# Testing Errors ----------------------------------------------------------

# non-binary matrix
spike_raster_plot(spike_train + rnorm(1))

# length of time longer than the number of columns of spike train
spike_raster_plot(spike_train, time = 1:11)

