#!/usr/bin/Rscript
library(twitteR)
library(RPostgreSQL)
con=dbConnect("PostgreSQL",dbname="data",port=5432,user="j1axs01",password="Ja!pur27")
con_key='2aNW0Dm7Z0F5YDBU5tQMEt9mg'
con_sec='EzxvDcvgkdwQ2G7yN9xXGD2RMuzZRhW9wgDp99TKMygjWFjKcP'
con_at='766655528315392005-RCF5Ls7EhPTTMaSv5NONIT7jw0b0jp4'
con_at_sec='KOFXBZfrgxgPrRVSt39b6PVPez9nDhrth6GjzjE8LIQOM'
setup_twitter_oauth(con_key,con_sec,con_at,con_at_sec)
trump=getUser('realDonaldTrump')
clinton=getUser('HillaryClinton')
trumpCount=trump$followersCount
clintonCount=clinton$followersCount
query=paste("insert into followers(clinton,trump) values (",clintonCount,",",trumpCount,");"                 )
dbSendQuery(con,query)
dbDisconnect(con)
