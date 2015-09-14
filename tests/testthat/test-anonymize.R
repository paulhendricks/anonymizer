library(anonymizer)
context("anonymize()")

test_that("Produces the correct output.", {
  expect_equal(anonymize("a", .seed = 1, .algo = "crc32"), "b0891ad8")
})

test_that("Produces the correct output type.", {
  expect_is(anonymize(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(anonymize(mtcars))
})
