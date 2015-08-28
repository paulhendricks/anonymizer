library(anonymizer)
context("deanonymize()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(deanonymize(), "1")
})

test_that("Produces the correct output type.", {
  expect_is(deanonymize(letters), "character")
})

test_that("Produces the correct errors.", {
})

