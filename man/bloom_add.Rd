% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bloom.R
\name{bloom_add}
\alias{bloom_add}
\title{Add Items to a Bloom filter}
\usage{
bloom_add(bl, x, n = 1:length(x))
}
\arguments{
\item{bl}{the bloom filter created with bloom() or bloom_create()}

\item{x}{a string or character vector}

\item{n}{an integer index or vector of integers (MUST be of same length as x), defaults to 1:length(x)}
}
\description{
Add items to the index of a previously created bloom filter object.
}
\details{
This is a wrapper around the bloom function.
}
\examples{
library(bloom)
bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
t<-unlist(strsplit('this is a test',' '))
bloom_add(bloomf, t)
}
