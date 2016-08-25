#!/bin/bash
rm *.txt
/usr/bin/Rscript /home/j1axs01/twproject/rexample_1.r
for i in *.txt; do sed -i '/^\s*$/d' $i; done
for i in *.txt; do sed -i 's///g' $i; done
for i in *.txt; do sed -i 's/\n//g' $i; done
for i in *.txt; do sed -i 's/\r//g' $i; done
for i in *.txt; do awk '{gsub(/~~~~/,"\n")}1' $i > $i.csv; done
for i in *.csv; do sed -i '/^\s*$/d' $i; done
psql -d data -c"truncate table twitter.stage;"
psql -d data -c"\copy twitter.stage from '/home/j1axs01/twproject/clinton_tweet.txt.csv'"
psql -d data -c"insert into twitter.post select s.* from twitter.stage s left join twitter.post p on (p.line=s.line) where p.line is null;" 
psql -d data -c"\copy twitter.stage from '/home/j1axs01/twproject/clinton_tweet_univ.txt.csv'"
psql -d data -c"insert into twitter.post select s.* from twitter.stage s left join twitter.post p on (p.line=s.line) where p.line is null;"
psql -d data -c"\copy twitter.stage from '/home/j1axs01/twproject/trump_tweet_univ.txt.csv'"
psql -d data -c"insert into twitter.post select s.* from twitter.stage s left join twitter.post p on (p.line=s.line) where p.line is null;"
psql -d data -c"\copy twitter.stage from '/home/j1axs01/twproject/trump_tweet.txt.csv'"
psql -d data -c"insert into twitter.post select s.* from twitter.stage s left join twitter.post p on (p.line=s.line) where p.line is null;"
rm *.csv
