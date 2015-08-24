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
#>  [1] "droddadrodd" "ftpfnbftpfn" "sccwqcsccwq" "kqxwhdkqxwh" "humbwehumbw"
#>  [6] "ogpvkfogpvk" "clhzhgclhzh" "waswzhwaswz" "tojmditojmd" "dscrfjdscrf"
#> [11] "bdngdkbdngd" "kupmzlkupmz" "gpwzsmgpwzs" "xfjfxnxfjfx" "xpwwzoxpwwz"
#> [16] "klxnipklxni" "lbhqcqlbhqc" "smsqkrsmsqk" "gmwlysgmwly" "cwvnjtcwvnj"
#> [21] "pbybpupbybp" "rztuivrztui" "fkhkpwfkhkp" "xvxwnxxvxwn" "jrpikyjrpik"
#> [26] "dmbclzdmbcl"
letters %>% salt %>% anonymize
#>  [1] "f835d22f9aebd310f5b98d63cb59a6d9c023f3310892c1b512c9b9f23fdc5a12"
#>  [2] "26a4adaa72a2530ad690f73280c61506070791e0eaa85218b8fe543a3cfcffec"
#>  [3] "cba638a78ee8f1522a2832ecd88041ce53fdb1688800af7dc1a4745002b28939"
#>  [4] "5b31455fa2b732c65b41b01da63e8a170443d4cbee20077388bdb61e6a1c4bfd"
#>  [5] "ff67ad25937e1cd8743c669a3480cd9c71605b6cd9edc91e45d899f247e88e3f"
#>  [6] "2184c998ec8a904afd2b2e3548e71d276b2837d909e0ae0b382adede3cf5ed8e"
#>  [7] "af9368faa74443e3dd969a4b2b36f475aae9e990d19f8e8bf2880922b64ad444"
#>  [8] "413727fb0a0629a887c8703f4da048809ba0d894453e9dafc15d169fceca52e3"
#>  [9] "2ff8f094652aa3ec8a43af8703f4617b150725326b86b5232fde64d187ffc2ab"
#> [10] "0e6910ff4f88ff1c18980ceffc8c734660b2960556686d5a6834e885291f1caa"
#> [11] "6377c16e06402b65c2257c1953c8403644bea6a81466aae6346d3a13a9103277"
#> [12] "18f8a243726df4101496dd379b4628d5a036cafe714023b98a3f1e2fa8e2d890"
#> [13] "f28133c2e063c4e9887909ff15b9741657ba0248d6b649e3b9f13f4f5d2387d8"
#> [14] "af0e1d93a8195b899f131b15a8fcfd45c52fa0c6ca1472972e2599dcb307fa1a"
#> [15] "0035cd8a1b9ad7f2a232145b5980df0176f6639fa4c2b14e3805fcf39dd30a6a"
#> [16] "621f6a1768200e16e9db293df1fe14ca54e56831bc998da65740bc5d9f862f92"
#> [17] "c4da7c6f4d8cc3a615ee65ba96d80fda496454dad383dd568994b2513febe0ed"
#> [18] "98e16af9abcaabc5b2924de4918280859fd107661f30c9ee57739b2d01bf6cc1"
#> [19] "16c063cf4d838b70dde70ec58eccbe3479ea53e253c7efcdaa15415f8868cc19"
#> [20] "4e18f12181ce7b38635d91cf4ad1226145080c7ee4404f283b198ff32868b9a7"
#> [21] "8a5c7a665ddf0f9f746b236733ad0d8d8d81eec2a80d87f1c8b4f865f89b7aaa"
#> [22] "fc6d744c8c5b529bc0743932548472981dbca122358b9807eb3db058d84b7d75"
#> [23] "acda8f62476cb1e30800e1042b2fafa9442cd00cc25c8eba08279968bae07cd3"
#> [24] "854cb15f550315e39f8701bffca72fc5298a6f5915aabe3c9acad13042517b1a"
#> [25] "82f5f3dd75641f0c7f8fdeb6e5bdb582a21607d8db0a54dd2c85f022326e5cee"
#> [26] "68775ad58195a1e04076b93eaf43cadefbce97384aa7ea530968d44ba2e74ae8"
letters %>% salt %>% anonymize(.algo = "crc32")
#>  [1] "707bc477" "849d374a" "deffb90c" "648fef5a" "ad3b00af" "a8767463"
#>  [7] "4bfb00fe" "513a790d" "757c6d38" "195cc4a1" "628f5cb9" "4fcfd234"
#> [13] "441a2d"   "3082670e" "ec61b05a" "6a2fdb21" "7a6cee2e" "2e5a1eef"
#> [19] "82eae382" "a43ca68d" "515165c5" "ba122f71" "d6621bd9" "566405f0"
#> [25] "64ed7663" "ed59a548"
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
