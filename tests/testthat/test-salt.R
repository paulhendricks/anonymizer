library(anonymizer)
context("salt()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(salt("a", .n_chars = 0), "a")
})

test_that("Produces the correct output type.", {
  expect_is(salt(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(salt(mtcars))
})

