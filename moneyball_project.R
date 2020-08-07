rm(list=ls())

library(readxl)
#batting file
batting <- read.csv('Batting.csv')

head(batting) #check first rows
str(batting) #check structure

head(batting$AB) #check first rows of $At Bats
head(batting$X2B) #doubles

#create new column: Batting Average = Hits/At Bats
batting$BA <- batting$H / batting$AB
tail(batting$BA, 5) #check last entries of Batting Average

#new column: On Base Percentage: (Hits+Bases on Balls+Hit By Pitch) / (At Bats+Bases on Balls+Hit By Pitch+Sacrifice Fly)
batting$OBP <- (batting$H+batting$BB+batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)
#new column: singles = Hits-doubles-triples-homerums
batting$X1B <- (batting$H-batting$X2B-batting$X3B-batting$HR)
head(batting$X1B)
#new column: Slugging Percentage:
batting$SLG <- (batting$X1B+2*batting$X2B+3*batting$X3B+4*batting$HR)/batting$AB
head(batting$SLG)

str(batting)

##MERGING SALARY DATA WITH BATTING DATA (because we want undervalued players as well as best players)
sal <- read.csv('Salaries.csv')
summary(sal) #year starts 1985
summary(batting) #yearID goes back to 1871
#so get rid of batting before 1985
batting <- subset(batting, yearID >= 1985)
summary(batting)

combo <- merge(batting, sal, by=c('playerID', 'yearID'))
summary(combo)


##ANALYZING LOST PLAYERS
lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01','saenzol01') )
View(lost_players)
# players were lost from OAKLAND in after 2001 in the offseason
lost_players <- subset(lost_players, yearID == '2001')
View(lost_players)
#get rid of some columns
lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]
View(lost_players)

##FIND REPLACEMENT PLAYERS
#The total combined salary of the three players can not exceed 15 million dollars.
#Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
#Their mean OBP had to equal to or greater than the mean OBP of the lost players
library(dplyr)
available_players <- filter(combo,yearID==2001)
library(ggplot2)
#OBP
#mean OBP of the 3 lost players
meanOBP <- mean(lost_players$OBP)
meanOBP
ggplot(available_players,aes(x=OBP,y=salary)) + geom_point()
available_players <- filter(available_players,salary<8000000,OBP>0) #no point in having players with too large of a salary and 0

#have greater at bats for lost players
totalatbats <- sum(lost_players$AB)
totalatbats #1469 rougle around 500 each, so players should have at least that
available_players <- filter(available_players, AB >= 500)

#sort by OBP
possiblepicks <- arrange(available_players, desc(OBP))
head(possiblepicks, 10)
possible <- possiblepicks[2:4,] #because cant to giambja01 again who's in first
possible
#check if their mean OBP is greater than 0.3638687
possiblemeanOBP <- mean(possible$OBP)
possiblemeanOBP #yes
#check if their salary doesn't exceed 15 million
sum(possible$salary) #yes
#check if their combined AB greater than lost players (1469)
sum(possible$AB) #yes

# 3 new players: heltoto01, berkmla01, gonzalu01
