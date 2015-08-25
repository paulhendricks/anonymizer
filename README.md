<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/qu5j8q9wvit2i3pe/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

`anonymizer` anonymizes data containing Personally Identifiable Information (PII) using a combination of [salting](https://en.wikipedia.org/wiki/Salt_%28cryptography%29) and [hashing](https://en.wikipedia.org/wiki/Hash_function). You can find quality examples of data anonymization in R [here](http://jangorecki.github.io/blog/2014-11-07/Data-Anonymization-in-R.html) and [here](http://4dpiecharts.com/2011/08/23/anonymising-data/).

Installation
------------

You can install:

-   the latest released version from CRAN with

    ``` r
    install.packages("anonymizer")
    ```

-   the latest development version from github with

    ``` r
    if (packageVersion("devtools") < 1.6) {
      install.packages("devtools")
    }
    devtools::install_github("paulhendricks/anonymizer")
    ```

If you encounter a clear bug, please file a minimal reproducible example on [github](https://github.com/paulhendricks/anonymizer/issues).

API
---

``` r
library(dplyr, warn.conflicts = FALSE)
library(anonymizer)
set.seed(1)
letters %>% head
#> [1] "a" "b" "c" "d" "e" "f"
letters %>% head %>% salt
#> [1] "gjoxfagjoxf" "xyrqbbxyrqb" "ferjucferju" "mszjudmszju" "yfqdgeyfqdg"
#> [6] "kajwifkajwi"
letters %>% head %>% hash
#> [1] "fb1a678ef965ad4a66c712d2161f20319091cb4e7611e1925df671018c833f72"
#> [2] "61ba1f136aebcd31977da80fae3afffe18b83691e2aa2c61f948d85085fd8e56"
#> [3] "2eea4ca3e3a6518aaffdcd5bada74dc92c3e0170ab17f7826aa1d1222f8a1ef5"
#> [4] "d2aebba0a3c95f6d03acf85bd9d41e602b92675ef4741063ebb2091e064d86cd"
#> [5] "09cab1873b8f76f0d880aa963a5bd2f7c858af261acbde2a6cdee4ce993a12b3"
#> [6] "6f1066d075c43d9d362b871d35b6bb0aba94407427e70d2bedb28570ba06ad47"
letters %>% head %>% salt %>% hash(.algo = "crc32")
#> [1] "5877c483" "d1b55731" "f17920d3" "ad4cbf5c" "530cd27e" "73a77c84"
letters %>% head %>% anonymize
#> [1] "2356dc731242e9404deb4fdb17d1e2c25571f5b9c3f0ac64adc9e44155f3a902"
#> [2] "a67aed883d6f1bf5c6d30c9fe8ebb47471c63fb5aa9c0b8fd2d44ace8578bcf2"
#> [3] "03afaa68f08cd771691a0433e81566cffab0e9ed08388756b9728d82d1e8e477"
#> [4] "e6a3a6639ed1976c05fa1b375081214f7486918d9587010f32100bccb54133e3"
#> [5] "b167a569e5674ceff38a702bf3092ca72a9edc68b726296d6f18dd1c927689f6"
#> [6] "6b7ac5b5ef7a59e40020ef660dd168a917a85f24c950f97935d4dfe5549f55a9"
```

### Generate data containing fake PII

``` r
library(generator)
n <- 6
ashley_madison <- 
  data.frame(name = r_full_names(n), 
             email = r_email_addresses(n), 
             phone_number = r_phone_numbers(n, use_hyphens = TRUE, 
                                            use_parentheses = TRUE), 
             stringsAsFactors = FALSE)
knitr::kable(ashley_madison, format = "markdown")
```

| name               | email                   | phone\_number  |
|:-------------------|:------------------------|:---------------|
| Erwin Gleichner    | <zsijdaobxk@zmldqj.nfy> | (236)-916-9734 |
| Edmond Zemlak      | <capvnl@nympzf.gsk>     | (983)-329-5842 |
| Rosy Murray        | <cv@pnhkldwb.hfg>       | (146)-423-6457 |
| Fredericka Effertz | <uwjbhpglz@wjyuo.tpv>   | (548)-357-2493 |
| Fumiko Champlin    | <xmv@es.sxn>            | (247)-784-6412 |
| Zoraida Krajcik    | <cxgnzryo@gfmz.emn>     | (537)-532-8621 |

### Detect data containing PII

``` r
library(detector)
detect(ashley_madison)
#> Testing column: name
#> Testing column: email
#> E-mail addresses possibly detected.
#> Testing column: phone_number
#> [1] TRUE
```

### Anonymize data containing PII

``` r
ashley_madison %>% 
  mutate(name = anonymize(name, .algo = "crc32"), 
         email = anonymize(email, .algo = "crc32"), 
         phone_number = anonymize(phone_number, .algo = "crc32")) %>% 
  knitr::kable(format = "markdown")
```

| name     | email    | phone\_number |
|:---------|:---------|:--------------|
| f3817dc3 | cc750790 | d4b58895      |
| d081f0b8 | 7d164100 | 39acc497      |
| aaf0e448 | b27aeb9c | 47740a37      |
| 745cee43 | f419860e | b54acdb3      |
| 84568bb3 | a4582a03 | f33d996d      |
| 910bf193 | 7961f4   | 3d5a7068      |
