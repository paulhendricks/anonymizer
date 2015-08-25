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
suppressPackageStartupMessages({
  library(dplyr)
  library(generator)
  library(detector)
  library(anonymizer)
})

set.seed(2)
letters
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
#> [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
letters %>% salt
#>  [1] "esoeyaesoey" "ydvmobydvmo" "ogtekcogtek" "wzflbdwzflb" "rkvdjerkvdj"
#>  [6] "mdjzdfmdjzd" "aevwngaevwn" "qvhrdhqvhrd" "zhceyizhcey" "uzjnvjuzjnv"
#> [11] "aaryhkaaryh" "vuzpslvuzps" "uxqgwmuxqgw" "lklfbnlklfb" "hibeeohibee"
#> [16] "thwkopthwko" "jrakfqjrakf" "wzitirwziti" "zkjomszkjom" "flccltflccl"
#> [21] "flzvhuflzvh" "pxlddvpxldd" "atjovwatjov" "vwcyoxvwcyo" "agzxgyagzxg"
#> [26] "tohsiztohsi"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "4194dc76" "d315166e" "7177cb77" "9213935"  "992f98f5" "6bde7398"
#>  [7] "6f17e67b" "57725b30" "8a78c8d7" "9a3d7fda" "73fe3b46" "fe105452"
#> [13] "c30ebac"  "3a8a5d7c" "c6c5a82d" "d5639bd9" "400c7f3"  "f1c8ed2f"
#> [19] "7ea02b28" "1d4aa1a7" "7a709e7d" "f47a0fed" "f3c06827" "5b4eba5a"
#> [25] "be3ba052" "75dc348b"
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

| name                | email                    | phone\_number |
|:--------------------|:-------------------------|:--------------|
| Lillia Stanton      | <h@zqy.fym>              | 162-215-1894  |
| Timothy Greenfelder | <jghrko@kfbdlrji.wtb>    | 695-385-1943  |
| Jessi Sawayn        | <xb@clsdoam.lse>         | 315-457-7982  |
| Valentin Kuhn       | <gcjeofb@be.wyj>         | 291-279-7541  |
| Ngan Wunsch         | <c@o.vuy>                | 186-632-8653  |
| Arnette Fisher      | <anioudxek@kvesrmbn.dfc> | 135-745-8712  |

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
| a6e47f3  | 3ce7a903 | df7f2e2       |
| 3ee38a40 | 190dc77f | 925f0632      |
| d9314fa2 | 647392db | 66011fcc      |
| 80a729b8 | 87f5b8eb | 7d7cb464      |
| 54a1fe5d | 1fda11b7 | 9327a120      |
| b121bd0  | 92eb48c7 | ee0213a2      |
