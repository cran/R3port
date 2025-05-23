#library(testthat)
library(R3port)
context("frequency calculations")

test_that("frequencies correctly calculated", {
  tst  <- data.frame(a=rep(1:3,4),b=c(1:6,6:1))
  res1 <- freq(tst,"b")
  expect_equal(round(sum(as.numeric(res1$Perc)),1),100)
  expect_equal(sum(as.numeric(res1$Freq)),nrow(tst))
  expect_equal(unique(as.numeric(res1$b)),sort(unique(tst$b)))
  
  res2 <- freq(tst,"b",total="")
  expect_true(any(grepl("Total",res2$b)))
  expect_equal(round(as.numeric(res2$Perc[res2$b=="Total"]),1),100)
  expect_equal(as.numeric(res2$dnm[res2$b=="Total"]),nrow(tst))
  
  res3 <- freq(tst,"b",total="",denom=10,totaldenom = 20)
  expect_equal(as.numeric(res3$dnm[res3$b=="Total"]),20)
  expect_equal(unique(as.numeric(res3$dnm[res3$b!="Total"])),10)
  
  dnmd  <- data.frame(b=1:6,dnm=1:6)
  tdnmd <- data.frame(b=1:6,tdnm=6:1)
  res4  <- freq(tst,"b",total="",denom=dnmd,totaldenom = tdnmd)
  expect_equal(res4$dnm[1],1)
  expect_equal(res4$dnm[nrow(res4)],6)
})
