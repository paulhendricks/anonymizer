library(anonymizer)
context("deanonymize()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(deanonymize(), 1L)
})

test_that("Produces the correct output type.", {
  expect_is(deanonymize(), "integer")
})

test_that("Produces the correct errors.", {
})

