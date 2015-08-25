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
#>  [1] "gwqooagwqoo" "pwizlbpwizl" "minvycminvy" "vtqqsdvtqqs" "jrogwejrogw"
#>  [6] "kcbmxfkcbmx" "pygfigpygfi" "wjftmhwjftm" "heyfziheyfz" "edqqdjedqqd"
#> [11] "mzaezkmzaez" "ljsxflljsxf" "noihxmnoihx" "ubyiznubyiz" "blzxsoblzxs"
#> [16] "wxknrpwxknr" "nxhjfqnxhjf" "nmfhxrnmfhx" "bfxlesbfxle" "vvmcjtvvmcj"
#> [21] "tpgcvutpgcv" "maeamvmaeam" "kkgfawkkgfa" "slqhgxslqhg" "vrkuqyvrkuq"
#> [26] "oyjkizoyjki"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "79ad8220" "d0d0a8c1" "291f1c46" "51c26c70" "60e359e5" "1594cbd1"
#>  [7] "45b6297f" "f0dac948" "a028b932" "4ba565b5" "76084866" "a5914a5e"
#> [13] "c04e2f96" "1e25476a" "ee5576c0" "927c11a0" "8e423c15" "2eb8e685"
#> [19] "8a6f9ed7" "1698f1b3" "aca8c0d4" "4bc69cce" "ebbfeb41" "a5146c7b"
#> [25] "20d1e771" "33302285"
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
ashley_madison
#>                 name                  email   phone_number
#> 1        Ronnie Rowe            rjudh@m.dix (291)-735-8791
#> 2  Shanita Daugherty               eu@w.npu (951)-387-3742
#> 3 Albertina Jacobson        dyh@cewsvhk.vay (732)-917-3645
#> 4     Giuseppe Stehr huswnop@xpgtjivebs.ibe (249)-369-4652
#> 5         Kiera Wolf        hv@koipaxdq.zir (532)-483-8362
#> 6       Leeann Fadel    kjnz@fkcxjeisou.pwk (136)-916-3618
```

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
         phone_number = anonymize(salt(phone_number)))
#>                                                               name
#> 1 a0430ac55c478ec88ceaecb60e48644eecd755954d04a9fe982a6697132798f9
#> 2 a36494929aa63c106c4eb3b9359b3eabd524cbec64cc3e061c9f2a1506551706
#> 3 2acfa829b056750ec9a62d7c3b11167eba56892f51a6b461adf9c9b5019941ea
#> 4 7997a75bfccaa646bab97bc03ffc6177f776ec2004f8518cf22d9ba59fca389d
#> 5 563c945214ad227775b44549198fc782eb6d41d6ddc0a798abb4954b964c53e9
#> 6 9373679ac0d3152afeea46e13987b34c9c4d8aa3169671587c8bfa55f3b4e609
#>                                                              email
#> 1 5682be44cb704474fa187ddd3775dfa3e7f59ed6a18b76d980bd454cf899cbb3
#> 2 f52b27befdac59dbd635adebaec65be3be0daaa89cd926bf04db8737c8efc369
#> 3 9cb5c5f1d33a3865cf8de508d62c89ca4016a97217a94a3a072ba03a5fbd3e0a
#> 4 149627de6cae613172e0cb8ad97dbb0edcc9ec24c964277ac2d3d25f194c35a7
#> 5 cdee2813bafbad200e6db539dcfc0110b557e753f2514b050da14d5280aaf434
#> 6 da4ef8d037f2927a9db7802a1388cf6c0ddf76dbfc6aecf0b70071c3872f76e3
#>                                                       phone_number
#> 1 13c6ad6bf521ae932039ba410713108fd3ca76d2551f17d29cdeb425c2f9b47b
#> 2 37823c7e169e7ccf7c4f9dc3be4335ec0305ad37c71fb7ed14adca7449c6f473
#> 3 f1838f0ee66f8a0065170597774d50e7973761c7200a73d3c1cce376c53e64ef
#> 4 39c5047b20719bce715d0255e21c76b4485f532c2af40fcf0c8514db004e6e4f
#> 5 9b7883f76f6cac0cfe8b160367a54afbb848619f3c29cf60b0ae4b59ff840879
#> 6 b5607e73f9893b92f2db985a6d23fe37f52093b09f28a690bb09bef2912e2c2c
```
