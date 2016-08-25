#!/usr/bin/Rscript
library(twitteR)
library(RPostgreSQL)
Sys.setlocale("LC_ALL", "de_DE.utf8")
setwd('/home/j1axs01/twproject')
toLocalEncoding <-
function(x, sep="\t", quote=FALSE, encoding="utf-8")
{
  rawtsv <- tempfile()
  write.table(x, file=rawtsv, sep=sep, quote=quote)
  result <- read.table(file(rawtsv, encoding=encoding), sep=sep, quote=quote)
  unlink(rawtsv)
  result
}
con=dbConnect("PostgreSQL",dbname="data",port=5432,user="j1axs01",password="Ja!pur27")
con_key='2aNW0Dm7Z0F5YDBU5tQMEt9mg'
con_sec='EzxvDcvgkdwQ2G7yN9xXGD2RMuzZRhW9wgDp99TKMygjWFjKcP'
con_at='766655528315392005-RCF5Ls7EhPTTMaSv5NONIT7jw0b0jp4'
con_at_sec='KOFXBZfrgxgPrRVSt39b6PVPez9nDhrth6GjzjE8LIQOM'
setup_twitter_oauth(con_key,con_sec,con_at,con_at_sec)
trump_tweet=searchTwitter('from:realDonaldTrump', resultType="recent", n=2)
clinton_tweet=searchTwitter('from:HillaryClinton', resultType="recent", n=2)
trump_tweet=twListToDF(trump_tweet)
clinton_tweet=twListToDF(clinton_tweet)
trump_tweet_univ=searchTwitter('Trump',resultType="recent", n=1000)
clinton_tweet_univ=searchTwitter('clinton',resultType="recent", n=1000)
trump_tweet_univ=twListToDF(trump_tweet_univ)
clinton_tweet_univ=twListToDF(clinton_tweet_univ)
trump_tweet_univ$text <- iconv(trump_tweet_univ$text, from = "UTF-8", to = "latin1")
clinton_tweet_univ$text <- iconv(trump_tweet_univ$text, from = "UTF-8", to = "latin1")
clinton_tweet$text <- iconv(clinton_tweet$text, from = "UTF-8", to = "latin1")
trump_tweet$text <- iconv(trump_tweet$text, from = "UTF-8", to = "latin1")
dbWriteTable(con, "clinton_tweet_univ",clinton_tweet_univ,append = TRUE)
dbWriteTable(con, "trump_tweet",trump_tweet,append = TRUE)
dbWriteTable(con, "trump_tweet_univ",trump_tweet_univ,append = TRUE)
dbWriteTable(con, "clinton_tweet",clinton_tweet,append = TRUE)
write.table(trump_tweet,file='trump_tweet.txt',quote=FALSE, na='', col.names=FALSE, row.names = TRUE, sep='|',eol="~~~~")
write.table(trump_tweet_univ,file='trump_tweet_univ.txt',quote=FALSE, na='',col.names=FALSE, row.names = TRUE,sep='|',fileEncoding = "UTF-8",eol="~~~~")
write.table(clinton_tweet,file='clinton_tweet.txt',quote=FALSE, na='',col.names=FALSE, row.names = TRUE,sep='|',eol="~~~~")
write.table(clinton_tweet_univ,file='clinton_tweet_univ.txt',quote=FALSE, na='',col.names=FALSE, row.names = TRUE,sep='|',fileEncoding = "UTF-8",eol="~~~~")
