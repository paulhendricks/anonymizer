<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/qu5j8q9wvit2i3pe/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

`anonymizer` [anonymizes](https://en.wikipedia.org/wiki/Data_anonymization) data containing [Personally Identifiable Information](https://en.wikipedia.org/wiki/Personally_identifiable_information) (PII) using a combination of [salting](https://en.wikipedia.org/wiki/Salt_%28cryptography%29) and [hashing](https://en.wikipedia.org/wiki/Hash_function). You can find quality examples of data anonymization in R [here](http://jangorecki.github.io/blog/2014-11-07/Data-Anonymization-in-R.html), [here](http://stackoverflow.com/questions/10454973/how-to-create-example-data-set-from-private-data-replacing-variable-names-and-l), and [here](http://4dpiecharts.com/2011/08/23/anonymising-data/).

Installation
------------

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer)

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

`anonymzer` employs four convenience functions: `salt`, `unsalt`, `hash`, and `anonymize`.

``` r
library(dplyr, warn.conflicts = FALSE)
library(anonymizer)
letters %>% head
#> [1] "a" "b" "c" "d" "e" "f"
letters %>% head %>% salt(.seed = 1)
#> [1] "gjoxfagjoxf" "gjoxfbgjoxf" "gjoxfcgjoxf" "gjoxfdgjoxf" "gjoxfegjoxf"
#> [6] "gjoxffgjoxf"
letters %>% head %>% salt(.seed = 1) %>% unsalt(.seed = 1)
#> [1] "a" "b" "c" "d" "e" "f"
letters %>% head %>% hash(.algo = "crc32")
#> [1] "c0749952" "597dc8e8" "2e7af87e" "b01e6ddd" "c7195d4b" "5e100cf1"
letters %>% head %>% salt(.seed = 1) %>% hash(.algo = "crc32")
#> [1] "b0891ad8" "361d6876" "fd41bbd3" "e0448b6b" "2b1858ce" "ad8c2a60"
letters %>% head %>% anonymize(.algo = "crc32", .seed = 1)
#> [1] "b0891ad8" "361d6876" "fd41bbd3" "e0448b6b" "2b1858ce" "ad8c2a60"
```

### Generate data containing fake PII

``` r
library(generator)
n <- 6
set.seed(1)
ashley_madison <- 
  data.frame(name = r_full_names(n), 
             snn = r_national_identification_numbers(n), 
             dob = r_date_of_births(n), 
             email = r_email_addresses(n), 
             ip = r_ipv4_addresses(n), 
             phone = r_phone_numbers(n), 
             credit_card = r_credit_card_numbers(n), 
             lat = r_latitudes(n), 
             lon = r_longitudes(n), 
             stringsAsFactors = FALSE)
knitr::kable(ashley_madison, format = "markdown")
```

| name                  | snn         | dob        | email                    | ip              | phone      | credit\_card        |          lat|          lon|
|:----------------------|:------------|:-----------|:-------------------------|:----------------|:-----------|:--------------------|------------:|------------:|
| Eldridge Pfannerstill | 442-34-5338 | 1991-11-21 | <ntakqojv@lgbcyk.rkv>    | 45.84.71.225    | 6794976958 | 4125-7204-9193-5140 |   -2.7018575|     8.634988|
| Augustine Homenick    | 799-44-6396 | 1912-06-29 | <iqg@mtcuh.viy>          | 191.116.55.106  | 3275827694 | 2182-5994-2283-9486 |  -70.4148630|   -65.827918|
| Jennie Runte          | 941-11-5441 | 1983-09-22 | <wjszy@sjhreocvt.gbp>    | 27.128.73.17    | 7419351735 | 4370-4866-4735-7857 |  -45.4091701|   -79.932229|
| Araceli Kunde         | 290-44-2675 | 1947-08-01 | <uljsnvhfr@qfdkumtn.jkd> | 221.47.229.86   | 3243246285 | 6682-5074-2898-9396 |   -0.2673845|   103.514583|
| Josue Rau             | 686-88-8446 | 1994-12-20 | <c@lqxzkdpi.nfy>         | 157.136.114.185 | 9169736873 | 4510-3757-4858-5236 |  -22.8839925|    72.886505|
| Elnora Zemlak         | 212-40-7016 | 1974-11-08 | <capvnl@nympzf.gsk>      | 143.20.199.87   | 3295843196 | 7206-6205-2194-6432 |   78.2444466|  -120.590050|

### Detect data containing PII

``` r
library(detector)
ashley_madison %>% 
  detect %>% 
  knitr::kable(format = "markdown")
```

| column\_name | has\_email\_addresses | has\_phone\_numbers | has\_national\_identification\_numbers |
|:-------------|:----------------------|:--------------------|:---------------------------------------|
| name         | FALSE                 | FALSE               | FALSE                                  |
| snn          | FALSE                 | FALSE               | TRUE                                   |
| dob          | FALSE                 | FALSE               | FALSE                                  |
| email        | TRUE                  | FALSE               | FALSE                                  |
| ip           | FALSE                 | FALSE               | FALSE                                  |
| phone        | FALSE                 | TRUE                | FALSE                                  |
| credit\_card | FALSE                 | FALSE               | FALSE                                  |
| lat          | FALSE                 | TRUE                | FALSE                                  |
| lon          | FALSE                 | TRUE                | FALSE                                  |

### Anonymize data containing PII

``` r
ashley_madison[] <- lapply(ashley_madison, anonymize, .algo = "crc32")
ashley_madison %>% 
  knitr::kable(format = "markdown")
```

| name     | snn      | dob      | email    | ip       | phone    | credit\_card | lat      | lon      |
|:---------|:---------|:---------|:---------|:---------|:---------|:-------------|:---------|:---------|
| c83b4030 | 393d73d7 | 769fdfb1 | aa5dead  | e4b6e2c6 | d3af086b | cb7b5ba      | 80064d9e | 7dc18006 |
| 98a6974d | 70ac65b0 | 3cf25ab6 | a75947f0 | 5e0e7cef | 5c562036 | 7cd11025     | fdf9526d | 5828b961 |
| 77dcbc4d | 391740d7 | 95bc2323 | 6cefaee2 | fbaaa8f1 | 9a66f57d | 299a42fe     | 734886e3 | 9ea0e9a5 |
| a48e2b0b | 6704117d | a70d663  | e1598468 | b7a422ba | 1f0a0373 | f420590f     | 53155b41 | 81018fc  |
| 4fecaeb2 | 9d6bf732 | 1ced47c1 | 4b412ff9 | d1f2740c | ac553e93 | e3716031     | f3d9a005 | ef3bdb8d |
| abc3b85c | 90866189 | a44ae4f0 | f26e84b1 | 52596e0e | b14fa5df | 9189fc4f     | 85c69f65 | f0db3bb0 |

Author
------

The original author of `anonymizer` is [Paul Hendricks](https://github.com/paulhendricks). [![Gratipay](https://img.shields.io/gratipay/JSFiddle.svg)](https://gratipay.com/~paulhendricks/)

License
-------

[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/paulhendricks/anonymizer/blob/master/LICENSE)
