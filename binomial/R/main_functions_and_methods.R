# Title: Main Functions and Methods
# Author: Noah Forougi
# Date: May 1 2019
# Description: This R script includes the main functions and methods to be called by the user, which include bin_choose(), bin_probability(), bin_distribution(), plot.bindis(), bin_cumulative(), plot.bincum(), bin_var(),  print.binvar(), summary.binvar(), print.summary.binvar(), bin_mean(), bin_variance(), bin_mode(), bin_skewness(), and bin_kurtosis()

#' @title bin_choose
#' @description calculates the amount of combinations in which k successes can occur in n trials.
#' @param n number of trials
#' @param k number of successes, less than or equal to n
#' @return  the amount of combinations in which k successes can occur in n trials
#' @export
#' @examples
#' example1 <- bin_choose(n = 5, k = 2)
bin_choose <- function(n,k) {
  if (k > n) {
    stop("number of successes cannot be greater than the number of trials")
  }
  return(factorial(n)/(factorial(k)*factorial(n-k)))
}

#' @title bin_probability
#' @description calculates the probability in which k successes occur in n trials with probablity of success p.
#' @param trials, number of trials
#' @param success, number of successes, less than or equal to n
#' @param prob, probablity of successes
#' @return returns the probabilty in which k successes occur in n trials with probablity of success p.
#' @export
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  bin_choose(trials,success)*prob^success*(1-prob)^(trials-success)
}

#' @title bin_distribution
#' @description creates a data frame of probability distrubtion and successes
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return a data frame with the probability distribution: sucesses in the first column, probability in the second column
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials,prob) {
  s <- c(0:trials)
  p <- c()
  for (i in c(0:trials)){
    p[i+1]<-bin_probability(i,trials,prob)
  }
  dat<-data.frame(success = s,
                  probability = p)
  class(dat)<-c("bindis","data.frame")
  return(dat)
}

# plot.bindis
#' @export
library(ggplot2)
plot.bindis <- function(dat) {
  ggplot(data = dat, aes(x = success, y = probability)) + geom_col() +
    ggtitle("Probability Histogram of Binomial Distribution") +
    theme_minimal()
}

#' @title bin_cumulative
#' @description creates a data frame of probability, success and cumulative
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return return a data frame with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column.
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob) {
  dat <- cbind(bin_distribution(trials,prob), "cumulative" = cumsum(bin_probability(success = 0:trials, trials, prob)) )
  return(dat)
}

# plot.bindis
#' @export
library(ggplot2)
plot.bincum <- function(dat) {
  ggplot(data = dat, aes(x = success, y = cumulative))  + geom_line() +geom_point() +
    ggtitle("Cumulative Histogram of Binomial Distribution") +
    theme_minimal()
}

#' @title bin_variable
#' @description creates a binomial random variable
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return a list with named elements: trials: number of trials, prob: probability of success
#' @export
#' @examples
#' bin_variable(trials = 5, prob = 0.5)
bin_variable <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  bin_var <- list(trials = trials, prob = prob)
  class(bin_var) <- "binvar"
  return(bin_var)
}

#' print.binvar
#' @export
print.binvar <- function(dat) {
  cat("Binomial variable \n\n")
  cat("Parameters \n")
  cat("- number of trials:", dat$trials)
  cat("\n- prob of success:", dat$prob)
}

#' summary.binvar
#' @export
summary.binvar <- function(dat) {
  list <- list(trials = dat$trials,
       prob = dat$prob,
       mean = aux_mean(dat$trials, dat$prob),
       variance = aux_variance(dat$trials, dat$prob),
       mode = aux_mode(dat$trials, dat$prob),
       skewness = aux_skewness(dat$trials, dat$prob),
       kurtosis = aux_kurtosis(dat$trials, dat$prob)
       )
  list
}

#' print.summary.binvar
#' @export
print.summary.binvar <- function(dat){
  cat("Summary Binomial  \n\n")
  cat("Parameters \n")
  cat("- number of trials:", dat$trials)
  cat("\n- prob of success:", dat$prob)
  cat("\n\n Measures")
  cat("\n- mean:", aux_mean(dat$trials, dat$prob))
  cat("\n- variance:", aux_variance(dat$trials, dat$prob))
  cat("\n- mode:", aux_mode(dat$trials, dat$prob))
  cat("\n- skewness:", aux_skewness(dat$trials, dat$prob))
  cat("\n- kurtosis:", aux_kurtosis(dat$trials, dat$prob))

}

#' @title bin_mean
#' @description calculates the mean of binomial distribution
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return value of the mean of binomial distribution
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mean(trials, prob)
}

#' @title bin_variance
#' @description calculates the variance of binomial distribution
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return value of the variance of binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_variance(trials, prob)
}

#' @title bin_mode
#' @description calculates the mode of binomial distribution
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return value of the mode of binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mode(trials, prob)
}

#' @title bin_skewness
#' @description calculates the skewness of binomial distribution
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return value of the skewness of binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_skewness(trials, prob)
}

#' @title bin_kurtosis
#' @description calculates the kurtosis of binomial distribution
#' @param trials, number of trials
#' @param prob, probablity of successes
#' @return value of the kurtosis of binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_kurtosis(trials, prob)
}

