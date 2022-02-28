# Cyclistic Bike-Share: Case Study

This document is created as part of the capstone project of the Google Data Analytics Professional Certificate.

# Introduction

This case study is my capstone project for the Google Data Analytics Certificate. It involves analysis of historical data for a fictional company, Cyclistic, a bike sharing company located in Chicago, to make recommendations for an upcoming marketing campaign. Although the company and scenario are fictitious, the data used for this project are real data collected between August 2020 – July 2021 from a bike share program in Chicago. In this project I am working as the role of the junior analyst.

# Scenario

Cyclistic is a fictional bike sharing company located in Chicago. It operates a fleet of more than 5,800 bicycles which can be accessed from over 600 docking stations across the city. Bikes can be borrowed from one docking station, ridden, then returned to any docking station in the system Over the years marketing campaigns have been broad and targeted a cross-section of potential users. Data analysis has shown that riders with an annual membership are more profitable than casual riders. The marketing team are interested in creating a campaign to encourage casual riders to convert to members.

The marketing analyst team would like to know how annual members and casual riders differ, why casual riders would buy a membership, and how Cyclistic can use digital media to influence casual riders to become members. The team is interested in analyzing the Cyclistic historical bike trip data to identify trends in the usage of bikes by casual and member riders.
# I. ASK
# Business Objective
  To increase profitability by converting casual riders to annual members via a targeted marketing campaign.
  The junior analyst has been tasked with answering this question: How do annual members and casual riders use Cyclistic bikes differently?
# Who all are the Stakeholders in this prooject
  Lily Moreno, Director of Marketing at Cyclistic, who is responsible for the marketing campaigns at Cyclistic.

  The Cyclistic marketing analytics team. This team is responsible for collecting, analyzing and reporting data to be used in marketing campaigns. I am the junior analyst on this    team.

  The Cyclistic executive team. This team makes the final decision on the recommended marketing plan. They are notoriously detail-oriented.
# II. PREPARE
# Where is Data Located?
  The [data](https://divvy-tripdata.s3.amazonaws.com/index.html) used for this analysis were obtained from the Motivate, a company employed by the City of Chicago to collect data on bike share usage.
# How is the Data Organized?
The data is organized in monthly csv files. The most recent twelve months of data (January 2020 – December 2021) were used for this project. The files consist of 13 columns containing information related to ride id, ridership type, ride time, start location and end location and geographic coordinates, etc.
# Credibility of the Data
The [data](https://divvy-tripdata.s3.amazonaws.com/index.html) is collected directly by Motivate, Inc., the company that runs the Cyclistic Bike Share program for the City of Chicago. The data is comprehensive in that it consists of data for all the rides taken on the system and is not just a sample of the data. The data is current. It is released monthly and, as of january 2021, was to December 2021 is used for the analysis.
# Licensing, privacy, security, and accessibility
This data is anonymized as it has been stripped of all identifying information. This ensures privacy, but it limits the extent of the analysis possible. There is not enough data to determine if casual riders are repeat riders or if casual riders are residents of the Chicago area. The data is released under this [license](https://ride.divvybikes.com/data-license-agreement).
# Ability of Data to be used to answer Business Question
One of the fields in the data records the type of rider; casual riders pay for individual or daily rides and member riders purchase annual subscription. This information is crucial to be able to determine differences between how the two groups use the bike share program.
# Problems with the data
  #Rideable-type Field
The rideable_type field contains one of three values – Electric bike, Classic bike or Docked bike. Electric and Classic bikes seem self-explanatory, but what exactly a Docked bike is is unclear. From a review of the data it seems that electric bikes were available to both types of users for the entire 12 month period; classic bikes were available to both groups of users but only from December 2, 2020 to July 31, 2021; and Docked Bikes were available to members from August 1, 2020 to January 13, 2021 and to casual users for the entire 12 months. For the purpose of this analysis these rideable types will not be used to segment the data or draw any conclusions about bike preferences as data collection for this variable is not consistent across the time period being analyzed.

  #Latitude and Longitude
There is also a challenge with the latitude and longitude coordinates for the stations. Each station is represented by a range of lat/long coordinates. The start/end latitude and longitude seem to indicate the location of a particular bike. Creating a list of popular stations is not difficult, but mapping the stations is more problematic. This was remedied by averaging the lat and long values for the stations before mapping. This resulted in the rides counts for a station matching the ride count for one set of lat/long coordinates.
# III. PROCESS & CLEAN
  # What tools are you choosing and why?
    For this project I choose to use RStudio Desktop Process, analyze and clean the data and Tableau to create the visualizations. 
   Millions of rows was too large to be processed in spreadsheets/Excel and RStudio Cloud.
On reviewing of the data revealed several problems:

1. Duplicate record ID numbers
2. Records with missing start or end stations
3. Records with very short or very long ride durations
4. Records for trips starting or ending at an administrative station (repair or testing station)
# Data Cleaning
 1. Duplicate records (based on the RIDE ID field) were removed. ( 690,788 records removed )
 2. Records for trips less than 60 seconds (false starts) or longer than 24 hours were removed. Bikes out longer than 24 hours are considered stolen and the rider is charged for       a replacement. (68,493 records removed)
 3. Now, to remove Records with missing fields start_station, end_station, start/end lat/long fields were removed. (307,707 records removed)
 4. we found out some stations are administritative stations so we have to remove them(8 records removed)
  Initially the data set contained 55,94,916 records. Once data was cleaned, 45,27,650 records remained. 19% of the records were removed.
 
 # IV ANALYZE
   Figure 1 shows that weekend days are popular with casual riders whereas member rider trips are spread out more evenly throughout the week. ![Screenshot (149)](https://user-images.githubusercontent.com/64157141/155992369-9836db1b-f762-4013-9e12-9bbdb19ba36e.png)
   
   Figure 2 and Figure 3 Member riders take more trips than casual riders but casual riders take longer rides than member riders (Figure 3). Casual riders average 27.71 minutes per ride as opposed to 13.44 minutes for member riders (Figure 3).
   ![Screenshot (150)](https://user-images.githubusercontent.com/64157141/155992377-a4b664f7-d5e8-46d0-84da-8252dff3855c.png)
![Screenshot (151)](https://user-images.githubusercontent.com/64157141/155992381-5d1094f3-553a-4462-a95d-651647ac3665.png)

  Figure 3 shows the number of trips made by casual riders increases over the day, peaking at 5 pm. Member trips also peak at 5 pm but there are two smaller peaks earlier in the day at 8 am and lunch time, which corresponds with the work day.
![Screenshot (152)](https://user-images.githubusercontent.com/64157141/155992385-aff95bea-be5d-4973-927f-ce286f53be83.png)

 # V. SHARE 
  Detailed documentation of [R]() code is attached in this repository only and interactive visualizations are available on my [Tableau Public](https://public.tableau.com/app/profile/lunistic/viz/GoogleDataAnalytics_16459876471880/GoogleCapstoneProjectChicagoCyclistData?publish=yes).
  # VI. ACT
    Based on an analysis of the data, the following recommendations can be made to the Cyclistic stakeholders:
   1. The marketing campaign should be targeted at the popular start and end stations for casual riders.
   2. To reach the most riders, marketing should be targeted for the busiest casual rider days (Friday, Saturday and Sunday), busiest hours morning office time(7 A.M. to 9 A.M.)         and in afternoon(3 P.M. to 7 P.M.) and the most popular months are (June, July, August and September).
   3. Further data should be released or obtained to determine which casual riders are local to the Chicago area (as these riders are more likely to consider an annual                   membership than a tourist from out of the city) and to determine what changes might need to be made to the existing membership subscription model to make it more                 appealing to casual riders (casual riders have an average trip length of 32 minutes, longer on weekends, and the annual membership has ride lengths caps of 45 minutes).
