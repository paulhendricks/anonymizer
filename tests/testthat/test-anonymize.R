library(anonymizer)
context("anonymize()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(anonymize("a"), "ed879445e47969394b3f8eb818501976bed22b9ab0e7f7c5fdf2a96df0aec80e")
})

test_that("Produces the correct output type.", {
  expect_is(anonymize(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(anonymize(mtcars))
})

