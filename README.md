# The Moneyball Project Using Data Analysis
This project was created for my Data Science and Machine Learning in R course.

## Background
[Wikipedia Page](https://en.wikipedia.org/wiki/Moneyball)

The Oakland Athletics' 2002 campaign ranks among the most famous in franchise history. Following the 2001 season, Oakland saw the departure of three key players (the lost boys). Billy Beane, the team's general manager, responded with a series of under-the-radar free agent signings. The new-look Athletics, despite a comparative lack of star power, surprised the baseball world by besting the 2001 team's regular season record. The team is most famous, however, for winning 20 consecutive games between August 13 and September 4, 2002.[1] The Athletics' season was the subject of Michael Lewis' 2003 book Moneyball: The Art of Winning an Unfair Game (as Lewis was given the opportunity to follow the team around throughout that season)

This project is based off the book written by Michael Lewis. The book argues that the Oakland A's' front office took advantage of more analytical gauges of player performance to field a team that could better compete against richer competitors in Major League Baseball (MLB). Because of the team's smaller revenues, Oakland is forced to find players undervalued by the market, and their system for finding value in undervalued players has proven itself thus far. This approach brought the A's to the playoffs in 2002 and 2003.

## Goal
Work with data from The Lahman Baseball Database, trying to find replacement players for the ones lost at the start of the off-season - During the 2001–02 offseason, the team lost three key free agents to larger market teams: 2000 AL MVP Jason Giambi to the New York Yankees, outfielder Johnny Damon to the Boston Red Sox, and closer Jason Isringhausen to the St. Louis Cardinals.

## Data Collection
The data I'm using is from [Sean Lahaman's Website](http://www.seanlahman.com/baseball-archive/statistics/).  batting.csv is a file containing batting data for players in the MLB, and salary.csv is a file containing players' salary data.
![Batting Data Head](https://github.com/justinezth/Moneyball-Data-Analysis/blob/master/pics/battinghead.png)


## Feature Engineering
Created 3 more statistics that was used in Moneyball:

- [Batting Average BA (hits divided by at base](https://en.wikipedia.org/wiki/Batting_average)
- [On-Base Percentage OBP (how frequently a batter reaches base)](https://en.wikipedia.org/wiki/On-base_percentage)
- [Slugging Percentage (batting productivity of a hitter)](https://en.wikipedia.org/wiki/Slugging_percentage)

## Merging Batting Data and Salary Data
I replaced the batting with a subset of itself that only contained data from 1985 onwards because the salary data only starts with 1985. Then I merged the players' batting data with their respective salaries by playerID and yearID.

## Analyzing Lost Players
Analyzed Oakland A’s lost 3 key players: Jason Giambi (giambja01), Johnny Damon (damonjo01), Rainer Gustavo “Ray” Olmedo (‘saenzol01’). I filtered their info for 2001 because that was the offseason they were lost from the team and got rid of some columns with features I didn't need to use. This is the first 3 rows of the filtered data:
![Lost Players Head](https://github.com/justinezth/Moneyball-Data-Analysis/blob/master/pics/lostplayers.png)

## Finding Replacement Players
Find Replacement Players for the key three players we lost wtih three constraints:

- The total combined salary of the three players can not exceed 15 million dollars.
- Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
- Their mean OBP had to equal to or greater than the mean OBP of the lost players.

To do this, I grabbed all players from 2001 to see where I should cut-off for salary in respect to OBP:
![Plot](https://github.com/justinezth/Moneyball-Data-Analysis/blob/master/pics/salaryvsobp.png)

Based on that, I filtered out the players with the cutoff of salary>8000000 and salary<0 because there's no point of keeping those with salaries that are too high or too low. And then sorted the rest by OBP:
![Possible Picks](https://github.com/justinezth/Moneyball-Data-Analysis/blob/master/pics/possiblepicks.png)

## Results
Because the first pick is one of the players we are trying to replace, I pick the 3 players after him. I made sure the constraints were met.

The 3 new players: heltoto01, berkmla01, gonzalu01

