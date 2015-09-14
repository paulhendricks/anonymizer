library(anonymizer)
context("hash()")

test_that("Produces the correct output.", {
  expect_equal(hash("a", .algo = "crc32"), "c0749952")
  expect_equal(hash("a", .algo = "crc32", .seed = 1), "c0749952")
  expect_equal(hash("a", .algo = "crc32", .seed = 2), "c0749952")
})

test_that("Produces the correct output type.", {
  expect_is(hash(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(hash(mtcars))
})
