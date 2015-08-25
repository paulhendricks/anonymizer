library(anonymizer)
context("anonymize()")

set.seed(1)
test_that("Produces the correct output.", {
  expect_equal(anonymize("a"), "fb1a678ef965ad4a66c712d2161f20319091cb4e7611e1925df671018c833f72")
})

test_that("Produces the correct output type.", {
  expect_is(anonymize(letters), "character")
})

test_that("Produces the correct errors.", {
  expect_error(anonymize(mtcars))
})

