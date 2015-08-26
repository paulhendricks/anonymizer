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

`anonymzer` employs three convenience functions: `salt`, `hash`, and `anonymize`.

``` r
library(dplyr, warn.conflicts = FALSE)
library(anonymizer)
letters %>% head
#> [1] "a" "b" "c" "d" "e" "f"
set.seed(1)
letters %>% head %>% salt
#> [1] "gjoxfagjoxf" "gjoxfbgjoxf" "gjoxfcgjoxf" "gjoxfdgjoxf" "gjoxfegjoxf"
#> [6] "gjoxffgjoxf"
set.seed(1)
letters %>% head %>% hash(.algo = "crc32")
#> [1] "c0749952" "597dc8e8" "2e7af87e" "b01e6ddd" "c7195d4b" "5e100cf1"
set.seed(1)
letters %>% head %>% salt %>% hash(.algo = "crc32")
#> [1] "b0891ad8" "361d6876" "fd41bbd3" "e0448b6b" "2b1858ce" "ad8c2a60"
set.seed(1)
letters %>% head %>% anonymize(.algo = "crc32")
#> [1] "b0891ad8" "361d6876" "fd41bbd3" "e0448b6b" "2b1858ce" "ad8c2a60"
```

Generate data containing fake PII
---------------------------------

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

| name              | email                | phone\_number  |
|:------------------|:---------------------|:---------------|
| Jaimie Zemlak     | <ka@jvi.mol>         | (714)-684-5263 |
| Thi Hodkiewicz    | <rt@csjyoqlkv.alr>   | (528)-651-1674 |
| Christene Sanford | <wkfbcgy@rkvgy.iqg>  | (657)-569-3968 |
| Melvin Watsica    | <cvith@ilvtzqwx.sjh> | (261)-854-3482 |
| Franklin Ebert    | <sdfyxbmq@utk.kuo>   | (512)-237-5783 |
| Eugenio O'Conner  | <hypecks@pyri.lda>   | (136)-468-8436 |

Detect data containing PII
--------------------------

``` r
library(detector)
detect(ashley_madison)
#> Testing column: name
#> Testing column: email
#> E-mail addresses possibly detected.
#> Testing column: phone_number
#> [1] TRUE
```

Anonymize data containing PII
-----------------------------

``` r
ashley_madison %>% 
  mutate(name = anonymize(name, .algo = "crc32"), 
         email = anonymize(email, .algo = "crc32"), 
         phone_number = anonymize(phone_number, .algo = "crc32")) %>% 
  knitr::kable(format = "markdown")
```

| name     | email    | phone\_number |
|:---------|:---------|:--------------|
| 2620d129 | c7a96e57 | 512e8ba3      |
| c6db1e6c | e2dc0e00 | 2d6ea13a      |
| a46bfe18 | 1f67fd17 | 3f64c9b7      |
| 11631623 | db67e50b | a5409eb2      |
| e7b2535c | c7ded7bc | 377d5464      |
| 3a424efd | c7b812c4 | ba6c26d4      |
