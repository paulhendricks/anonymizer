
<!-- README.md is generated from README.Rmd. Please edit that file -->
anonymizer
==========

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/anonymizer)](http://cran.r-project.org/package=anonymizer) [![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/anonymizer)](http://cran.rstudio.com/package=anonymizer) [![Build Status](https://travis-ci.org/paulhendricks/anonymizer.png?branch=master)](https://travis-ci.org/paulhendricks/anonymizer) [![Build status](https://ci.appveyor.com/api/projects/status/qu5j8q9wvit2i3pe/branch/master?svg=true)](https://ci.appveyor.com/project/paulhendricks/anonymizer/branch/master) [![codecov.io](http://codecov.io/github/paulhendricks/anonymizer/coverage.svg?branch=master)](http://codecov.io/github/paulhendricks/anonymizer?branch=master) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

`anonymizer` [anonymizes](https://en.wikipedia.org/wiki/Data_anonymization) data containing [Personally Identifiable Information](https://en.wikipedia.org/wiki/Personally_identifiable_information) (PII) using a combination of [salting](https://en.wikipedia.org/wiki/Salt_%28cryptography%29) and [hashing](https://en.wikipedia.org/wiki/Hash_function). You can find quality examples of data anonymization in R [here](http://jangorecki.github.io/blog/2014-11-07/Data-Anonymization-in-R.html), [here](http://stackoverflow.com/questions/10454973/how-to-create-example-data-set-from-private-data-replacing-variable-names-and-l), and [here](http://4dpiecharts.com/2011/08/23/anonymising-data/).

Installation
------------

You can install the latest development version from CRAN:

``` r
install.packages("anonymizer")
```

Or from GitHub with:

``` r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("paulhendricks/anonymizer")
```

If you encounter a clear bug, please file a [minimal reproducible example](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example) on [GitHub](https://github.com/paulhendricks/anonymizer/issues).

API
---

`anonymizer` employs four convenience functions: `salt`, `unsalt`, `hash`, and `anonymize`.

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

<table style="width:100%;">
<colgroup>
<col width="15%" />
<col width="8%" />
<col width="8%" />
<col width="16%" />
<col width="11%" />
<col width="8%" />
<col width="14%" />
<col width="8%" />
<col width="8%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">name</th>
<th align="left">snn</th>
<th align="left">dob</th>
<th align="left">email</th>
<th align="left">ip</th>
<th align="left">phone</th>
<th align="left">credit_card</th>
<th align="right">lat</th>
<th align="right">lon</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Eldridge Pfannerstill</td>
<td align="left">442-34-5338</td>
<td align="left">1993-04-28</td>
<td align="left"><a href="mailto:ntakqojv@lgbcyk.rkv">ntakqojv@lgbcyk.rkv</a></td>
<td align="left">45.84.71.225</td>
<td align="left">6794976958</td>
<td align="left">4125-7204-9193-5140</td>
<td align="right">-2.7018575</td>
<td align="right">8.634988</td>
</tr>
<tr class="even">
<td align="left">Augustine Homenick</td>
<td align="left">799-44-6396</td>
<td align="left">1912-09-08</td>
<td align="left"><a href="mailto:iqg@mtcuh.viy">iqg@mtcuh.viy</a></td>
<td align="left">191.116.55.106</td>
<td align="left">3275827694</td>
<td align="left">2182-5994-2283-9486</td>
<td align="right">-70.4148630</td>
<td align="right">-65.827918</td>
</tr>
<tr class="odd">
<td align="left">Jennie Runte</td>
<td align="left">941-11-5441</td>
<td align="left">1985-01-12</td>
<td align="left"><a href="mailto:wjszy@sjhreocvt.gbp">wjszy@sjhreocvt.gbp</a></td>
<td align="left">27.128.73.17</td>
<td align="left">7419351735</td>
<td align="left">4370-4866-4735-7857</td>
<td align="right">-45.4091701</td>
<td align="right">-79.932229</td>
</tr>
<tr class="even">
<td align="left">Araceli Kunde</td>
<td align="left">290-44-2675</td>
<td align="left">1948-04-28</td>
<td align="left"><a href="mailto:uljsnvhfr@qfdkumtn.jkd">uljsnvhfr@qfdkumtn.jkd</a></td>
<td align="left">221.47.229.86</td>
<td align="left">3243246285</td>
<td align="left">6682-5074-2898-9396</td>
<td align="right">-0.2673845</td>
<td align="right">103.514583</td>
</tr>
<tr class="odd">
<td align="left">Josue Rau</td>
<td align="left">686-88-8446</td>
<td align="left">1996-06-14</td>
<td align="left"><a href="mailto:c@lqxzkdpi.nfy">c@lqxzkdpi.nfy</a></td>
<td align="left">157.136.114.185</td>
<td align="left">9169736873</td>
<td align="left">4510-3757-4858-5236</td>
<td align="right">-22.8839925</td>
<td align="right">72.886505</td>
</tr>
<tr class="even">
<td align="left">Elnora Zemlak</td>
<td align="left">212-40-7016</td>
<td align="left">1976-01-09</td>
<td align="left"><a href="mailto:capvnl@nympzf.gsk">capvnl@nympzf.gsk</a></td>
<td align="left">143.20.199.87</td>
<td align="left">3295843196</td>
<td align="left">7206-6205-2194-6432</td>
<td align="right">78.2444466</td>
<td align="right">-120.590050</td>
</tr>
</tbody>
</table>

### Detect data containing PII

``` r
library(detector)
ashley_madison %>% 
  detect %>% 
  knitr::kable(format = "markdown")
```

<table>
<colgroup>
<col width="14%" />
<col width="23%" />
<col width="21%" />
<col width="41%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">column_name</th>
<th align="left">has_email_addresses</th>
<th align="left">has_phone_numbers</th>
<th align="left">has_national_identification_numbers</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">name</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
</tr>
<tr class="even">
<td align="left">snn</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
<td align="left">TRUE</td>
</tr>
<tr class="odd">
<td align="left">dob</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
</tr>
<tr class="even">
<td align="left">email</td>
<td align="left">TRUE</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
</tr>
<tr class="odd">
<td align="left">ip</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
</tr>
<tr class="even">
<td align="left">phone</td>
<td align="left">FALSE</td>
<td align="left">TRUE</td>
<td align="left">FALSE</td>
</tr>
<tr class="odd">
<td align="left">credit_card</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
<td align="left">FALSE</td>
</tr>
<tr class="even">
<td align="left">lat</td>
<td align="left">FALSE</td>
<td align="left">TRUE</td>
<td align="left">FALSE</td>
</tr>
<tr class="odd">
<td align="left">lon</td>
<td align="left">FALSE</td>
<td align="left">TRUE</td>
<td align="left">FALSE</td>
</tr>
</tbody>
</table>

### Anonymize data containing PII

``` r
ashley_madison[] <- lapply(ashley_madison, anonymize, .algo = "crc32")
ashley_madison %>% 
  knitr::kable(format = "markdown")
```

| name     | snn      | dob      | email    | ip       | phone    | credit\_card | lat      | lon      |
|:---------|:---------|:---------|:---------|:---------|:---------|:-------------|:---------|:---------|
| c83b4030 | 393d73d7 | 18fe3e97 | aa5dead  | e4b6e2c6 | d3af086b | cb7b5ba      | 80064d9e | 7dc18006 |
| 98a6974d | 70ac65b0 | bf8857eb | a75947f0 | 5e0e7cef | 5c562036 | 7cd11025     | fdf9526d | 5828b961 |
| 77dcbc4d | 391740d7 | f0b13e46 | 6cefaee2 | fbaaa8f1 | 9a66f57d | 299a42fe     | 734886e3 | 9ea0e9a5 |
| a48e2b0b | 6704117d | 2e40fae7 | e1598468 | b7a422ba | 1f0a0373 | f420590f     | 53155b41 | 81018fc  |
| 4fecaeb2 | 9d6bf732 | e881bbe7 | 4b412ff9 | d1f2740c | ac553e93 | e3716031     | f3d9a005 | ef3bdb8d |
| abc3b85c | 90866189 | 6cefc2f4 | f26e84b1 | 52596e0e | b14fa5df | 9189fc4f     | 85c69f65 | f0db3bb0 |

Citation
--------

To cite package ‘anonymizer’ in publications use:

    Paul Hendricks (2015). anonymizer: Anonymize Data Containing Personally Identifiable Information. R package version 0.2.0. https://github.com/paulhendricks/anonymizer

A BibTeX entry for LaTeX users is

    @Manual{,
      title = {anonymizer: Anonymize Data Containing Personally Identifiable Information},
      author = {Paul Hendricks},
      year= {2015}, 
      note = {R package version 0.2.0},
      url = {https://github.com/paulhendricks/anonymizer},
    }
