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
#>  [1] "qcxtnaqcxtn" "toblebtoble" "lbtheclbthe" "gwktbdgwktb" "dyharedyhar"
#>  [6] "lrfxrflrfxr" "ugmncgugmnc" "nomjihnomji" "nklmiinklmi" "pjcdtjpjcdt"
#> [11] "pvzzukpvzzu" "jblywljblyw" "wdxvjmwdxvj" "nlhfmnnlhfm" "yazyloyazyl"
#> [16] "uvrlrpuvrlr" "rafpxqrafpx" "kefqprkefqp" "stwdpsstwdp" "gimdatgimda"
#> [21] "egxwduegxwd" "tgemgvtgemg" "vxrhcwvxrhc" "zwibmxzwibm" "dnpxiydnpxi"
#> [26] "uiwldzuiwld"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "ee14f0bf" "a56c631c" "7a1b97f2" "e8adb4c7" "392ab5ac" "b0a7ac21"
#>  [7] "3e79b684" "b43827d6" "a66caa4d" "198d4380" "daaf12e7" "664df7cc"
#> [13] "d0367be7" "91a31cc7" "5ba8f8e1" "3aee0b3"  "e29972b2" "cb8b4097"
#> [19] "54b73839" "48078d48" "33036662" "ef5a4165" "20b3585f" "af1f1905"
#> [25] "a9f27103" "ab894eab"
```

### Generate data containing PII

``` r
library(generator)
library(detector)
set.seed(2)
n <- 6
ashley_madison <- data.frame(name = r_full_names(n), 
                             email = r_email_addresses(n), 
                             phone_number = r_phone_numbers(n, use_hyphens = TRUE, use_parentheses = TRUE), 
                             stringsAsFactors = FALSE)
knitr::kable(ashley_madison, format = "markdown")
```

| name               | email                    | phone\_number  |
|:-------------------|:-------------------------|:---------------|
| Ronnie Rowe        | <rjudh@m.dix>            | (291)-735-8791 |
| Shanita Daugherty  | <eu@w.npu>               | (951)-387-3742 |
| Albertina Jacobson | <dyh@cewsvhk.vay>        | (732)-917-3645 |
| Giuseppe Stehr     | <huswnop@xpgtjivebs.ibe> | (249)-369-4652 |
| Kiera Wolf         | <hv@koipaxdq.zir>        | (532)-483-8362 |
| Leeann Fadel       | <kjnz@fkcxjeisou.pwk>    | (136)-916-3618 |

### Detect data containing PII

``` r
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
  mutate(name = anonymize(salt(name)), 
         email = anonymize(salt(email)), 
         phone_number = anonymize(salt(phone_number))) %>% 
  knitr::kable(format = "markdown")
```

| name                                                             | email                                                            | phone\_number                                                    |
|:-----------------------------------------------------------------|:-----------------------------------------------------------------|:-----------------------------------------------------------------|
| a0430ac55c478ec88ceaecb60e48644eecd755954d04a9fe982a6697132798f9 | 5682be44cb704474fa187ddd3775dfa3e7f59ed6a18b76d980bd454cf899cbb3 | 13c6ad6bf521ae932039ba410713108fd3ca76d2551f17d29cdeb425c2f9b47b |
| a36494929aa63c106c4eb3b9359b3eabd524cbec64cc3e061c9f2a1506551706 | f52b27befdac59dbd635adebaec65be3be0daaa89cd926bf04db8737c8efc369 | 37823c7e169e7ccf7c4f9dc3be4335ec0305ad37c71fb7ed14adca7449c6f473 |
| 2acfa829b056750ec9a62d7c3b11167eba56892f51a6b461adf9c9b5019941ea | 9cb5c5f1d33a3865cf8de508d62c89ca4016a97217a94a3a072ba03a5fbd3e0a | f1838f0ee66f8a0065170597774d50e7973761c7200a73d3c1cce376c53e64ef |
| 7997a75bfccaa646bab97bc03ffc6177f776ec2004f8518cf22d9ba59fca389d | 149627de6cae613172e0cb8ad97dbb0edcc9ec24c964277ac2d3d25f194c35a7 | 39c5047b20719bce715d0255e21c76b4485f532c2af40fcf0c8514db004e6e4f |
| 563c945214ad227775b44549198fc782eb6d41d6ddc0a798abb4954b964c53e9 | cdee2813bafbad200e6db539dcfc0110b557e753f2514b050da14d5280aaf434 | 9b7883f76f6cac0cfe8b160367a54afbb848619f3c29cf60b0ae4b59ff840879 |
| 9373679ac0d3152afeea46e13987b34c9c4d8aa3169671587c8bfa55f3b4e609 | da4ef8d037f2927a9db7802a1388cf6c0ddf76dbfc6aecf0b70071c3872f76e3 | b5607e73f9893b92f2db985a6d23fe37f52093b09f28a690bb09bef2912e2c2c |
