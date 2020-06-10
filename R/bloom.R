#' @useDynLib bloom
#' @import Rcpp
loadModule("Bloom", TRUE)

#' Bloom filter
#'
#' Create a new scaling, counting bloom filter, or load a bloom filter from a pre-existing file.
#' @param capacity the approximate expected capacity
#' @param error_rate the desired error rate
#' @param filename the location to store the filter
#' @param exists if the filter exists, load the new filter from a pre-existing file, otherwise
#' create a new filer.
#' @details The filter has the following methods available
#' \describe{
#'   \item{\code{add}}{Add a new item to the bloom filter, each item should be assigned a monotonically increasing integer id as the second argument.}
#'   \item{\code{contains}}{Check if a given item is contained within the bloom filter.}
#'   \item{\code{remove}}{Remove a given item from the filter, the id should match the id given when the item was added.}
#' }
#' @export
#' @examples
#' library(bloom)
#' bloom <- bloom(capacity = 1000, error_rate = .05, filename = "/tmp/bloom.bin")
#' bloom$add("foo", 2)
#' bloom$contains("bar")
#' bloom$contains("foo")
#' bloom$remove("foo", 2)
#' bloom$contains("foo")
#' bloom$add("foo", 2)
#' rm(bloom)
#' bloom <- bloom(capacity = 1000, error_rate = .05, filename = "/tmp/bloom.bin", exists = TRUE)
#' bloom$contains("foo")
bloom <- function(
  capacity = 1000,
  error_rate = 0.05,
  filename = tempfile(fileext=".bin"),
  exists = file.exists(filename)
  ) {
  new(Bloom, capacity, error_rate, filename, exists)
}

#' Create Bloom filter
#'
#' Create a new scaling, counting bloom filter, or load a bloom filter from a pre-existing file.
#' @param capacity the approximate expected capacity
#' @param error_rate the desired error rate
#' @param filename the location to store the filter
#' @param exists if the filter exists, load the new filter from a pre-existing file, otherwise
#' create a new filer.
#' @details This is a wrapper around the bloom function.
#' @export
#' @examples
#' library(bloom)
#' bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
bloom_create<-function(capacity = 1000,
                       error_rate = 0.05,
                       filename = tempfile(fileext=".bin"),
                       exists = file.exists(filename)){
  return(bloom(capacity,error_rate,filename,exists))
}

#' Add Items to a Bloom filter
#'
#' Add items to the index of a previously created bloom filter object.
#' @param bl the bloom filter created with bloom() or bloom_create()
#' @param x a string or character vector
#' @param n an integer index or vector of integers (MUST be of same length as x), defaults to 1:length(x)
#' @details This is a wrapper around the bloom function.
#' @export
#' @examples
#' library(bloom)
#' bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
#' t<-unlist(strsplit('this is a test',' '))
#' bloom_add(bloomf, t)
bloom_add<-function(bl,x,n=1:length(x)){
  if(length(x)!=length(n)){ stop('x and n must be the same length')}
  if (length(x)>1){
    bl$add(x[1],n[1])
    bloom_add(bl,x[2:length(x)],n[2:length(n)])
  } else {
    bl$add(x,n)
  }
}

#' Query Items in a Bloom filter
#'
#' Check to see if an item exists in a previously created bloom filter object.
#' @param bl the bloom filter created with bloom() or bloom_create()
#' @param x a string or character vector
#' @details This is a wrapper around the bloom function.Returns a vector of logical values
#' @export
#' @examples
#' library(bloom)
#' bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
#' t<-unlist(strsplit('this is a test',' '))
#' bloom_add(bloomf, t)
#' bloom_contains(bl,'this')
bloom_contains<-function(bl,x){
  unlist(lapply(x, function(y){bl$contains(y)}))
}

#' Remove Items from a Bloom filter
#'
#' Remove items to the index of a previously created bloom filter object.
#' @param bl the bloom filter created with bloom() or bloom_create()
#' @param x a string or character vector
#' @param n an integer index or vector of integers (MUST be of same length as x)
#' @details This is a wrapper around the bloom function.
#' @export
#' @examples
#' library(bloom)
#' bloomf<-bloom_create(capacity=2000, error_rate=0.05, filename='/tmp/bloom.bin')
#' t<-unlist(strsplit('this is a test',' '))
#' bloom_add(bloomf, t)
#' bloom_contains(bl,t)
#' bloom_remove(bloomf,'this',1)
#' bloom_add(bloomf, t)
bloom_remove<-function(bl,x,n){
  if(length(x)!=length(n)){ stop('x and n must be the same length')}
  if (length(x)>1){
    bl$remove(x[1],n[1])
    bloom_remove(bl,x[2:length(x)],n[2:length(n)])
  } else {
    bl$remove(x,n)
  }
}
