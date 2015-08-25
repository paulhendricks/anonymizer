<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/qu5j8q9wvit2i3pe/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

`anonymizer` anonymizes data containing Personally Identifiable Information using a combination of [salting](https://en.wikipedia.org/wiki/Salt_%28cryptography%29) and [hashing](https://en.wikipedia.org/wiki/Hash_function). You can find quality examples of data anonymization in R [here](http://jangorecki.github.io/blog/2014-11-07/Data-Anonymization-in-R.html) and [here](http://4dpiecharts.com/2011/08/23/anonymising-data/).

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
library(generator)
library(detector)
library(anonymizer)

set.seed(1)
letters %>% head
#> [1] "a" "b" "c" "d" "e" "f"
letters %>% head %>% salt
#> [1] "gjoxfagjoxf" "xyrqbbxyrqb" "ferjucferju" "mszjudmszju" "yfqdgeyfqdg"
#> [6] "kajwifkajwi"
letters %>% head %>% salt %>% anonymize(.algo = "crc32")
#> [1] "5877c483" "d1b55731" "f17920d3" "ad4cbf5c" "530cd27e" "73a77c84"
```

### Generate data containing PII

``` r
n <- 6
ashley_madison <- 
  data.frame(name = r_full_names(n), 
             email = r_email_addresses(n), 
             phone_number = r_phone_numbers(n, use_hyphens = TRUE), 
             stringsAsFactors = FALSE)
knitr::kable(ashley_madison, format = "markdown")
```

| name             | email                     | phone\_number |
|:-----------------|:--------------------------|:--------------|
| Linnie Heathcote | <lrjhqeoc@gdfbosptiz.vpy> | 735-873-4857  |
| Ashley Harris    | <zpfc@mxo.zsi>            | 683-284-8265  |
| Tad Kozey        | <arcko@zm.mes>            | 958-417-3516  |
| Tony Toy         | <fzonb@aqwnml.zmq>        | 372-259-2541  |
| Akilah Stracke   | <gskeqcr@pnh.lme>         | 367-178-8356  |
| Buster Howell    | <hfgujq@w.kbi>            | 932-234-9521  |

### Detect data containing PII

``` r
detect(ashley_madison)
#> Testing column: name
#> Testing column: email
#> E-mail addresses possibly detected.
#> Testing column: phone_number
#> Phone numbers possibly detected.
#> [1] TRUE
```

### Anonymize data containing PII

``` r
ashley_madison %>% 
  mutate(name = anonymize(salt(name), .algo = "crc32"), 
         email = anonymize(salt(email), .algo = "crc32"), 
         phone_number = anonymize(salt(phone_number), .algo = "crc32")) %>% 
  knitr::kable(format = "markdown")
```

| name     | email    | phone\_number |
|:---------|:---------|:--------------|
| c44f91b6 | bdadef87 | 8cad6138      |
| d1e54457 | 11127bba | 8ee8fcec      |
| a7583c93 | 2c7ab646 | 692092bd      |
| c2794502 | 311d8596 | 3fb3fb83      |
| 618734da | 36de9a41 | c4419125      |
| 900161ac | 3ab8e32b | e9a0f7a       |
