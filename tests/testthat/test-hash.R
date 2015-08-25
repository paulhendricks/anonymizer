library(anonymizer)
context("hash()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(hash("a"), "fb1a678ef965ad4a66c712d2161f20319091cb4e7611e1925df671018c833f72")
})

test_that("Produces the correct output type.", {
  expect_is(hash(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(hash(mtcars))
})

