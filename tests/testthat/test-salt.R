library(anonymizer)
context("salt()")

test_that("Produces the correct output.", {
  expect_equal(salt("a", .seed = 1, .n_chars = 0), "a")
  expect_equal(salt("a", .seed = 1, .n_chars = 1), "gag")
  expect_equal(salt("a", .seed = 2, .n_chars = 1), "eae")
})

test_that("Produces the correct output type.", {
  expect_is(salt(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(salt(mtcars))
})

