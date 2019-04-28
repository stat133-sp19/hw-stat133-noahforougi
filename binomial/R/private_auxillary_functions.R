# Title: Private Auxillary Functions for Binomial Package
# Author: Noah Forougi
# Date: May 1 2019
# Description: this R script includes the functions that are used as private auxillary functions, which include aux_mean(), aux_variance(), aux_mode(), aux_skewness(), and aux_kurtosis()

# title: aux_mean
# description: expected number of successes in a given amount of trials
# param: trials, number of trials
# param: prob, probability of success
# return: returns a numeric value that gives the expected number of successes for n trials
aux_mean <- function(trials, prob) {
  return(trials * prob)
}

# title: aux_variance
# description: variance of binomial distribution of a certain amount of trials and certain probability of success
# param: trials, number of trials
# param: prob, probability of success
# return: returns a numeric value that gives the variance
aux_variance <- function(trials, prob) {
  return( trials * prob * ( 1 - prob ) )
}

# title: aux_mode
# description: gives the most likely number of successes
# param: trials, number of trials
# param: prob, probability of success
# return: returns a numeric value that gives the mode, or if there are two modes, a vector with the two modes
aux_mode <- function(trials, prob) {
  m <- trials * prob + prob
  if (m == floor(m)) {
    return(c(m, m - 1))
  }
  return(floor(m))
}

# title: aux_skewness
# description: gives a measure of the asymmetry of the probability distribution of a random variable about its mean
# param: trials, number of trials
# param: prob, probability of success
# return: returns a numeric value that gives the skewness of a binomial random variable
aux_skewness <- function(trials, prob) {
  return((1-2*prob)/sqrt(trials*prob*(1-prob)))
}

# title: aux_kertosis
# description: gives a measure of the “tailedness” of the probability distribution of a random variable
# param: trials, number of trials
# param: prob, probability of success
# return: returns a numeric value that gives the kurtosis of a binomial random variable
aux_kurtosis <- function(trials, prob) {
  return((1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob)))
}

