# Title: Private Checker Functions for Binomial Package
# Author: Noah Forougi
# Date: May 1 2019
# Description: this R script includes the functions that are used as private checker functions, which include check_prob(), check_trials(), and check_success().



# title: check_prob
# description: a private auxillary function that tests if an input prob (numeric vector of length 1) is a valid probability value (i.e. 0 ≤ p ≤ 1).
# param: prob value for probability
# return: logical value of TRUE if probability is valid or an error if probability invalid
check_prob <- function(prob) {
  if (!is.numeric(prob) | length(prob) != 1 | prob < 0 | prob > 1  ) {
    stop("prob must be a numeric value between 0 and 1")
  }
  TRUE
}


# title: check_trials
# description: tests if an input, trials, is a valid value for number of trials (i.e. n is a non-negative integer).
# param: trials, value for number of trials
# return: logical value of TRUE if valid input
check_trials <- function(trials) {
  if (trials < 0) {
    stop("trials must be a non-negative integer")
  }
  else if (trials %% 1 != 0) {
    stop("trials must be a non-negative integer")
  }
  else if (length(trials) != 1) {
    stop("trials must be a non-negative")
  }
  TRUE
}

# title: check_success
# description: tests if an input, success, is a valid value for number of successes (i.e. 0 ≤ k ≤ n).
# param: success, value for number of successful trials
# param: trials, value for number of total trials
# return: logical value of TRUE if valid value for success
check_success<-function(success, trials){
  if (success >= 0 & success <= trials){
    return(TRUE)
  }  else{
    stop("invalid success value")
  }
}

