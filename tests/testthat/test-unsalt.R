library(anonymizer)
context("unsalt()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(unsalt(), 1L)
})

test_that("Produces the correct output type.", {
  expect_is(unsalt(), "integer")
})

test_that("Produces the correct errors.", {
})

