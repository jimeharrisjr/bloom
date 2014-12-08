<!-- README.md is generated from README.Rmd. Please edit that file -->
bloom
=====

Bloom filter for R using Rcpp bindings for [dablooms](https://github.com/bitly/dablooms/).

### Example usage

``` r
library(bloom)
bloom <- bloom(capacity = 1000, error_rate = .05, filename = "/tmp/bloom.bin")
bloom$add("foo", 2)
#> [1] 1
bloom$contains("bar")
#> [1] FALSE
bloom$contains("foo")
#> [1] TRUE
bloom$remove("foo", 2)
#> [1] 1
bloom$contains("foo")
#> [1] TRUE
bloom$add("foo", 2)
#> [1] 1
rm(bloom)
bloom <- bloom(capacity = 1000, error_rate = .05, filename = "/tmp/bloom.bin", exists = TRUE)
bloom$contains("foo")
#> [1] TRUE
```