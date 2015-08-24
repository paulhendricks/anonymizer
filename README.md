<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/au9ww7v8mhgr59s8/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

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
#>  [1] "hlafqahlafq" "lwkuublwkuu" "yyymtcyyymt" "dmdlpddmdlp" "nbracenbrac"
#>  [6] "nvzuxfnvzux" "fkmfagfkmfa" "vpfzghvpfzg" "foxwcifoxwc" "cdhumjcdhum"
#> [11] "qsdbnkqsdbn" "yxyunlyxyun" "vlctcmvlctc" "wxfvunwxfvu" "lntszolntsz"
#> [16] "mmnripmmnri" "cidpjqcidpj" "mzddwrmzddw" "eroftseroft" "kmmsatkmmsa"
#> [21] "iynkkuiynkk" "jfknkvjfknk" "gienpwgienp" "kwrbxxkwrbx" "sttapysttap"
#> [26] "taxlgztaxlg"
letters %>% salt %>% anonymize
#>  [1] "bafc44d4a9f5e561a4344234a1d6af01ff95bc9ef0265add584dcab6255ab150"
#>  [2] "1dbfa61db6e20ea8e8ac0340995a8a3f5505147b632edf5d32f2a192b0978028"
#>  [3] "b527c9e2ad741de66eb34a1ab1a2df5d1d7e516c8d7a545b4bcb92d83bf6cc8c"
#>  [4] "c80df52170d14d825e33e4735f8841c037be8285bc513701f9fcceb04ddddd35"
#>  [5] "02836af8e0fc29ae0a7cd56dbd80df9ce8a38934d887cf82e8fb5592696ba559"
#>  [6] "81345775b0859965e729aed9de20d13bdd5b5400955e2772146ec027aca49f1d"
#>  [7] "bb459b25b8809627da9d89d32031a3e83f4f767fc47a92a6a4108e04bf86cc16"
#>  [8] "188f81c391cbb6d51909498e1b6fe6a3c5783da7cbacf17f73daa924e30e922a"
#>  [9] "e38c4d18c69a86e5ae0a7fe0af93d9bcbf5221a74eee399118f1b44423c5e944"
#> [10] "7d26b1b2bec257033c0ba07b73d435f237639bf45d49890b8bf04ecd2c2153a7"
#> [11] "74f91231fad85303298e139ad062ea800be5d816139161c01bca6b4d11885c7c"
#> [12] "fc9471c0ec48d577d04b4947f37901b42ff51f037aaeeccd8e33d10261495f14"
#> [13] "8c3f0e99280c42cc38e76149ec99325f352658316441f73c519cecba081533c8"
#> [14] "20717ecad2bc1b72e9e7925cbc403da448df09dfbe0f73b71ad9245e1f13be0e"
#> [15] "12c8fb5919deee93a3215ad69613f8934f7b8606e3568bb5e28d7003e30ccd1b"
#> [16] "da45b8bc57258eb14eb05431ba26825132f8253af3f9fb83336075f8ae36b8d6"
#> [17] "721c70ab03485fe692f45e0f241a27c0c64af261682bcc24d4dc8c75dc5ac4fb"
#> [18] "a4674e0d3f706665271f2afacfce56438ff5b546b93d9afcdfa5f15f8a3dd014"
#> [19] "d00487b64701a3e8c4dc853ed32cb72c55909fa23fd36ed69fd09d19bd147f28"
#> [20] "904846958dacd5ba0a54d653bae3e8a8d2cc899cd90519ab64ab6a1cd63b8722"
#> [21] "6af8186c8836da87fbe9cd01111a7a61d98da6075c3fa52bcb3efd1d5af1d500"
#> [22] "dc7c5b67bc6bdeacb24ad5df9000a63b0ae76c5052df74ff66f6eef4b2d85ad3"
#> [23] "6a4bbe8a46f9a8e5fe858917c389f0bdb20e7afd83a1dfaf25bdebddc44882b2"
#> [24] "d85d26f2afcf28614c52877f8dd9e854012f1cb39e8298138116be25ce3e4d5f"
#> [25] "2abc4523c644263b33a8d0b926c7a3ddacf885512e670961ec6ba7348a186d97"
#> [26] "33914cf7cfd773d80e95063b1d7a1cd331d34ebba4e212b1d98f1ec5ba6f41f6"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "e915ba7e" "9ff6e6a0" "431e555c" "95ecaa82" "ac5bd179" "1fa37b1a"
#>  [7] "36b7597d" "5775f0e1" "fa0d1f01" "1d60c54"  "82e49a4b" "70ede298"
#> [13] "feb0c472" "447908f3" "ef0e5134" "a4cd0164" "8b478e"   "ed556000"
#> [19] "19109fa4" "fc9a8be3" "5f5bfbaf" "4c43d115" "e0f95d25" "41f20bef"
#> [25] "3ea5bfa2" "30e3849d"
```

### Generate data containing PII

``` r
library(generator)
library(detector)
set.seed(2)
n <- 6
ashley_madison <- data.frame(name = r_full_names(6), 
                             email = r_email_addresses(6), 
                             phone_number = r_phone_numbers(6, use_hyphens = TRUE, use_parentheses = TRUE), 
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
         phone_number = anonymize(salt(phone_number))) %>% 
  head
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
