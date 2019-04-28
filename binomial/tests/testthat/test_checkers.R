context("testing private checker functions")
source_file("/Users/user/Desktop/hw-stat133/binomial/R/private_checker_functions.R")

test_that("test that prob is a number between 0 and 1",{
  expect_true(check_prob(0))
  expect_true(check_prob(1))})
test_that("test that prob is of length 1",{
  expect_error(check_prob(c(1,2)), "prob must be a numeric value between 0 and 1")
  expect_true(check_prob(0.55))
  expect_length(check_prob(1), 1)
})
test_that("test that prob returns error if invalid ",{
  expect_error(check_prob(1.3), "prob must be a numeric value between 0 and 1")
  expect_error(check_prob("1"), "prob must be a numeric value between 0 and 1")
})

test_that("test that trials is of length 1", {
  expect_length(check_trials(24), 1)
  expect_error(check_trials(c(1,2), "trials must be a non-negative integer"))
})
test_that("test that trials is non-negative", {
  expect_error(check_trials(-1), "trials must be a non-negative integer")
})
test_that("test that trials is an integer", {
  expect_true(check_trials(123241))
  expect_error(check_trials(1.2), "trials must be a non-negative integer")
})

test_that("test that success can be of length greater than 1" , {
  expect_true(check_success(c(1,0), 4))
  })
test_that("test that success cannot be greater than trials", {
  expect_error(check_success(4,2), "invalid success value")
  expect_error(check_success(c(1,1,0),0) ,"invalid success value")
})
test_that("test that success cannot be negative", {
  expect_error(check_success(-1,2), "invalid success value")
})

