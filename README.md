<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/qu5j8q9wvit2i3pe/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

`anonymizer` anaonymizes data containing Personally Identifiable Information. `anonymizer` anonimyzes the following types of PII:

-   Full name
-   Home address
-   E-mail
-   National identification number
-   Passport number
-   Social Security number
-   IP address
-   Vehicle registration plate number
-   Driver's license number
-   Credit card number
-   Date of birth
-   Birthplace
-   Telephone number
-   Latitude and longtiude

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
library(anonymizer)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> 
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> 
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
letters
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
#> [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
letters %>% salt
#>  [1] "qpdigaqpdig" "uhsagbuhsag" "xotmccxotmc" "guhqtdguhqt" "bhngoebhngo"
#>  [6] "xcquzfxcquz" "zednzgzednz" "ksbgthksbgt" "tgnfpitgnfp" "oobqujoobqu"
#> [11] "hskrqkhskrq" "buvailbuvai" "ggpmbmggpmb" "efpaznefpaz" "ohtacoohtac"
#> [16] "wxwddpwxwdd" "psphuqpsphu" "ilrpwrilrpw" "poobyspooby" "sbkjltsbkjl"
#> [21] "bzlhfubzlhf" "qnrfevqnrfe" "lcyyswlcyys" "coyamxcoyam" "ihdnvyihdnv"
#> [26] "tgommztgomm"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "28758723" "b32a9617" "e40f399e" "664836f8" "4a9fc510" "fe212359"
#>  [7] "b67ceaeb" "991a477d" "6b5d760"  "bd3d447e" "91f9b6e4" "c1200d1c"
#> [13] "c7a4ca1b" "45fc7e05" "718b7fea" "8b643ab0" "4a83fc2f" "90f9a426"
#> [19] "662b4d2e" "c2ea29c7" "5a3bd347" "dffa4673" "193236"   "8cfd61a6"
#> [25] "2173732a" "723094b3"
```

### Generate data containing PII

``` r
library(generator)
library(detector)
set.seed(2)
n <- 6
ashley_madison <- 
  data.frame(name = r_full_names(n), 
             email = r_email_addresses(n), 
             phone_number = r_phone_numbers(n, use_hyphens = TRUE), 
             stringsAsFactors = FALSE)
knitr::kable(ashley_madison, format = "markdown")
```

| name               | email                    | phone\_number |
|:-------------------|:-------------------------|:--------------|
| Ronnie Rowe        | <rjudh@m.dix>            | 291-735-8791  |
| Shanita Daugherty  | <eu@w.npu>               | 951-387-3742  |
| Albertina Jacobson | <dyh@cewsvhk.vay>        | 732-917-3645  |
| Giuseppe Stehr     | <huswnop@xpgtjivebs.ibe> | 249-369-4652  |
| Kiera Wolf         | <hv@koipaxdq.zir>        | 532-483-8362  |
| Leeann Fadel       | <kjnz@fkcxjeisou.pwk>    | 136-916-3618  |

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
| 89c493b8 | f0fcde77 | 3daacbce      |
| e6f8d6c9 | b1c43e8b | 90de1f79      |
| 4921d9a4 | a60285a2 | d689cab2      |
| 4be73eda | 140ade38 | eb607d7c      |
| a4053592 | f10c29a1 | e6c8f671      |
| 93a8436f | 399993f9 | 5228fca6      |
