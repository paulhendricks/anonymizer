library(anonymizer)
context("unsalt()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(unsalt(salt(letters)), letters)
})

test_that("Produces the correct output type.", {
  expect_is(unsalt(salt(letters)), "character")
})

test_that("Produces the correct errors.", {
})

