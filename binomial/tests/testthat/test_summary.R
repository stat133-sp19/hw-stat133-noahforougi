context("testing summary functions")
source("/Users/user/Desktop/hw-stat133/binomial/R/private_auxillary_functions.R")

test_that("testing that aux_mean function works", {
  expect_equal(aux_mean(10,.5), 5)
  expect_length(aux_mean(10,0.4), 1)
  expect_equal(aux_mean(0,0.99),0)
  expect_is(aux_mean(0,0.99),"numeric")

})

test_that("testing that aux_variance function works", {
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_length(aux_variance(10,0.4), 1)
  expect_equal(aux_variance(0,0.99),0)
  expect_is(aux_variance(0,0.99),"numeric")

})

test_that("testing that aux_mode function works", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_length(aux_mode(10,0.4), 1)
  expect_equal(aux_mode(0,0.99),0)
  expect_is(aux_mode(0,0.99),"numeric")
})

test_that("testing that aux_skewness function works", {
  expect_length(aux_skewness(10,0.4), 1)
  expect_equal(aux_skewness(0,0.99),-Inf)
  expect_is(aux_skewness(0,0.99),"numeric")
})

test_that("testing that aux_kurtosis function works", {
  expect_length(aux_kurtosis(10,0.4), 1)
  expect_equal(aux_kurtosis(0,0.99),Inf)
  expect_is(aux_kurtosis(0,0.99),"numeric")
})

