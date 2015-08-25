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
letters
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
#> [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
letters %>% salt
#>  [1] "gjoxfagjoxf" "xyrqbbxyrqb" "ferjucferju" "mszjudmszju" "yfqdgeyfqdg"
#>  [6] "kajwifkajwi" "mpmevgmpmev" "rucskhrucsk" "vquonivquon" "uamtsjuamts"
#> [11] "mwlgbkmwlgb" "cinrklcinrk" "xhliqmxhliq" "gmtcwngmtcw" "ivjimoivjim"
#> [16] "xwkuypxwkuy" "lskitqlskit" "fsdgdrfsdgd" "gbqwusgbqwu" "ulkvptulkvp"
#> [21] "rjhzqurjhzq" "fdmypvfdmyp" "ztjldwztjld" "asclqxasclq" "zmmetyzmmet"
#> [26] "lnffpzlnffp"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "ab686334" "e9791404" "f9e449"   "c5b7b7"   "331ed28b" "c647a092"
#>  [7] "104a0a9b" "21f1f110" "8a843efa" "b592abb4" "754fb1cc" "c1275589"
#> [13] "96623d06" "b71bef6a" "cf03cd4"  "6153a7c3" "802c9765" "f4eced95"
#> [19] "9aba9b02" "530e32bf" "786baed8" "ead5b838" "784bc09a" "40ae80a" 
#> [25] "62f6f70b" "ecd33510"
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

| name             | email                      | phone\_number |
|:-----------------|:---------------------------|:--------------|
| Bernadine Hoeger | <anvib@dizxevcs.imq>       | 824-458-9285  |
| Howard Cummings  | <b@yq.cml>                 | 817-297-5234  |
| Brenton Grimes   | <eubj@deuqfkbgrx.rhj>      | 392-627-9863  |
| Nora Dicki       | <yusgqzfhob@jldnvuxkg.rgl> | 817-936-8643  |
| Kellie Gaylord   | <sm@btkw.hvb>              | 368-458-2381  |
| Bernie Davis     | <ciugmrbnv@mknvf.fki>      | 978-913-5169  |

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
| 444381f1 | ceff2fc1 | bcd9f215      |
| 9de1d486 | 22106a8d | 11994717      |
| 1c157168 | d0aabc19 | f52f6a69      |
| 95d84db0 | 3d0a35f1 | 53a26ba9      |
| a1c6f462 | dad6f01f | d007dec7      |
| 92145a8c | 1176c244 | edc84ffc      |
