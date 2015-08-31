library(anonymizer)
context("unsalt()")

test_that("Produces the correct output.", {
  expect_equal(unsalt(salt(letters, .seed = 1), .seed = 1), letters)
})

test_that("Produces the correct output type.", {
  expect_is(unsalt(salt(letters, .seed = 1), .seed = 1), "character")
})

test_that("Produces the correct errors.", {
})

