<!-- README.md is generated from README.Rmd. Please edit that file -->
bloom
=====
### Forking Jim Hester's Bloom repo for maintenance and feature enhancement
WARNING: This _might_ still be buggy, and crash in Rstudio, but avoiding recursive stack overflow seems to have helped

Scaling, counting Bloom filter for R using Rcpp bindings for [dablooms](https://github.com/bitly/dablooms/).

Note the dablooms implementation requires an additional metadata id for insertions and deletions. This id is a monotonically increasing integer which is used to determine which scaling filter the item should be added or removed from.

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

Or use the new wraparound functions:
``` r
library(bloom)
bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
t<-unlist(strsplit('this is a test',' '))
bloom_add(bloomf, t)
#> [1] 1
bloom_contains(bloomf,t)
#>[1] TRUE TRUE TRUE TRUE
bloom_remove(bloomf,'this',1)
#> [1] 1
bloom_contains(bloomf, t)
#>[1] FALSE  TRUE  TRUE  TRUE

```
