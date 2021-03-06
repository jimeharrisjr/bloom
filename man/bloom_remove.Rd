% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bloom.R
\name{bloom_remove}
\alias{bloom_remove}
\title{Remove Items from a Bloom filter}
\usage{
bloom_remove(bl, x, n)
}
\arguments{
\item{bl}{the bloom filter created with bloom() or bloom_create()}

\item{x}{a string or character vector}

\item{n}{an integer index or vector of integers (MUST be of same length as x)}
}
\description{
Remove items to the index of a previously created bloom filter object.
}
\details{
This is a wrapper around the bloom function.
}
\examples{
library(bloom)
bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
t<-unlist(strsplit('this is a test',' '))
bloom_add(bloomf, t)
bloom_contains(bloomf,t)
bloom_remove(bloomf,'this',1)
bloom_add(bloomf, t)
}
