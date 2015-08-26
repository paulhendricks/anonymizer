library(anonymizer)
context("unhash()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(unhash(), 1L)
})

test_that("Produces the correct output type.", {
  expect_is(unhash(), "integer")
})

test_that("Produces the correct errors.", {
})

