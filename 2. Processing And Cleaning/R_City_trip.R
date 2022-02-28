library(tidyverse)  #helps wrangle data
library(janitor)
library(readr)
library(lubridate)  #helps wrangle date attributes
library(skimr)
library(ggplot2)  #helps visualize data
getwd() #displays your working directory
setwd("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data") #sets your working directory to simplify calls to data ... make sure to use your OWN username instead of mine ;)
jan <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202101-divvy-tripdata.csv")
feb <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202102-divvy-tripdata.csv")
mar <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202103-divvy-tripdata.csv")
apr <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202104-divvy-tripdata.csv")
may <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202105-divvy-tripdata.csv")
jun <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202106-divvy-tripdata.csv")
jul <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202107-divvy-tripdata.csv")
aug <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202108-divvy-tripdata.csv")
sep <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202109-divvy-tripdata.csv")
oct <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202110-divvy-tripdata.csv")
nvm <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202111-divvy-tripdata.csv")
dec <- read_csv("D:/LEARNING/All About Data analytics/DAta Analysis google/city trip data/202112-divvy-tripdata.csv")
colnames(jan)
colnames(feb)
colnames(mar)
colnames(apr)
colnames(may)
colnames(jun)
colnames(jul)
colnames(aug)
colnames(sep)
colnames(oct)
colnames(nvm)
colnames(dec)
#Merge all the files together
bike_rides <- bind_rows(jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nvm,dec)
#To Display all the basic things about the data.
skim_without_charts(bike_rides)
# start of data cleaning process
bike_rides1 <- distinct(bike_rides, ride_id, .keep_all=TRUE)

bike_rides1 <- bike_rides1[!(bike_rides1$ride_length<60 | bike_rides1$ride_length>86400),]

bike_rides2 <- bike_rides1[!(is.na(bike_rides1$start_station_id) | 
                            is.na(bike_rides1$end_station_id) | is.na(bike_rides1$ride_id) |
                            is.na(bike_rides1$rideable_type) | is.na(bike_rides1$started_at) |
                            is.na(bike_rides1$ended_at) | is.na(bike_rides1$end_lat) | 
                            is.na(bike_rides1$end_lng)),]
bike_rides2<- bike_rides2[!(bike_rides2$start_station_name == "DIVVY CASSETTE REPAIR MOBILE STATION" | bike_rides2$start_station_name == "HUBBARD ST BIKE CHECKING (LBS-WH-TEST)" | bike_rides2$start_station_name == "WATSON TESTING DIVVY" | bike_rides2$end_station_name == "DIVVY CASSETTE REPAIR MOBILE STATION" | bike_rides2$end_station_name == "HUBBARD ST BIKE CHECKING (LBS-WH-TEST)" | bike_rides2$end_station_name == "WATSON TESTING DIVVY"),]

#end of data cleaning process
#cleaned Data is stored in bike_rides2 object.
bike_rides2 <-  bike_rides2 %>% 
  mutate(member_casual = recode(member_casual
                                ,"Subscriber" = "member"
                                ,"Customer" = "casual"))

table(bike_rides2$member_casual)

bike_rides2$date <- as.Date(bike_rides2$started_at) #The default format is yyyy-mm-dd
bike_rides2$month <- format(as.Date(bike_rides2$date), "%m")
bike_rides2$day <- format(as.Date(bike_rides2$date), "%d")
bike_rides2$year <- format(as.Date(bike_rides2$date), "%Y")
bike_rides2$day_of_week <- format(as.Date(bike_rides2$date), "%A")
bike_rides2$ride_length <- difftime(bike_rides2$ended_at,bike_rides2$started_at)


bike_rides2$ride_length <- as.numeric(as.character(bike_rides2$ride_length))
is.numeric(bike_rides2$ride_length)

# The data frame includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# We will create a new version of the data frame (1) since data is being removed

bike_rides2 <- bike_rides2[!(bike_rides2$start_station_name == "HQ QR" | bike_rides2$ride_length<0),]
bike_rides2 <- na.omit(bike_rides2)  # removing the NA values or empty rows
mean(bike_rides2$ride_length) #straight average 
median(bike_rides2$ride_length) #midpoint number in the ascending array of ride lengths
max(bike_rides2$ride_length) #longest ride
min(bike_rides2$ride_length) #shortest ride

summary(bike_rides1$ride_length) #condense all four above commands in one

# Now we can compare both the member and casual user in different terms
  #average use of cyclist in seconds by member and casual
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual, FUN = mean)
  #Midpoint of cyclist in seconds by member and casual
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual, FUN = median)
  #Maximum use of cyclist in seconds by member and casual 
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual, FUN = max)
  #Minimum use of cyclist in seconds by member and casual
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual, FUN = min)
#Arranging the order of days in a proper way
bike_rides2$day_of_week <- ordered(bike_rides2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
#see average time used by each day for member as well as casual user
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual + bike_rides2$day_of_week, FUN = mean)
#see MAX time used by each day for member as well as casual user
aggregate(bike_rides2$ride_length ~ bike_rides2$member_casual + bike_rides2$day_of_week, FUN = max)

bike_rides2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%      #creates weekday field using wday()
  group_by(member_casual, weekday) %>%                      #groups by user type and weekday
  summarise(number_of_rides = n()                           #calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>%      # calculates the average duration
  arrange(member_casual, weekday)

# Let's visualize the number of rides by rider type
user_type <- bike_rides2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
    arrange(member_casual, weekday)  
    write_csv(user_type,"user_type.csv")

# Let's create a visualization for average duration
summary_wd <- bike_rides2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)
  write_csv(summary_wd,"summary_wd.csv")
  

# Let's Summarize for average duration by month 
summary_md <- bike_rides2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, month)
  write_csv(summary_md,"summaey_md.csv")
  

# Let's summarize for which station is used by member and casual
most_station_used <- bike_rides2 %>% 
  mutate(station = start_station_name, label = TRUE) %>% 
  group_by(start_station_name, member_casual) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>%
  arrange(start_station_name)
  write_csv(most_station_used,"Most Station used.csv")


summary_station <- bike_rides1 %>% 
  mutate(station = start_station_name) %>%
  drop_na(start_station_name) %>% 
  group_by(start_station_name, member_casual) %>%  
  summarise(number_of_rides = n()) %>%    
  arrange(number_of_rides)
      write_csv(summary_station, "summary_stations.csv")

#Overall cleaned and processed data is exported for further Visualizations
write_csv(bike_rides2,"BIKE_RIDE.csv")












  
