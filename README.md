# DC-WMATA-Metro-Ridership
IC25 Challenge


Areas to look into:

weather, breaks (March 23) / moving day for UMD-Dulles, 

We matched the provided dates by the xlsx with the coresponding events that took place in Washington DC.
This would also to determine whether there is an external factor that would incentivise people to use use the metro.

March 06 --> (Navy yard or Capital(ice hockey) ) March 06
March 23 --> Cherry Blossom Festival (March 20 - April) (spring break comeback for students) (NavyYard Ball park), March time frame

June 04 --> (internships in DC)
June 15 --> Taste of the DMV

Sep 04 --> (laborday fireworks)
Sep 21 --> (NavyYard Ball park), March time frame

(Weekdays: higher progression of commuting- Peek pm, Midday and Am)

Dec 04 --> Not an Ostrich K Others Images from American's Libary (Dec 4) (Union status )
Dec 21 --> Temple Festival of Kight II (Dec 2-8) (winter break)


Sources we used:

  https://infinitylimocar.com/upcoming-events-2024-in-washington-dc/ 
  https://washington.org/find-dc-listings/events
  https://world-weather.info/forecast/usa/washington_1/june-2024/
  https://opendata.dc.gov/datasets/DCGIS::washington-dc-boundary/explore?location=38.768454%2C-76.797989%2C10.00 
  https://opendata.dc.gov/datasets/DCGIS::metro-stations-regional/explore  
  

Use of AI:

- ChatGPT
  - finding reliable websites that contain events occuring in Washington DC for that specific day
  - finding reliable websites that contain weather conditions during that specific day in Washington DC
  - deepen our understand with Panda lib in Python
  
Plan:

  We decided to split the data into the 5 time categories: Late Night (12am-Close), 
Evening (7pm-12am), PM Peak (3pm-7pm), Midday (9:30am-3pm), AM Peak (Open-9:30am).
Then by time category, we plan to the sum the amount of people that took the metro.

Different Trends:

Histogram

  Difference between the time of day and the amount of people that use the metro station
    Hypothesis: On average AM Peek, PM Peek, and Evening receive a greater amount of people using the metro when compared to Late night and Midday.

  Difference in the amount of people using metro between weekday and weekend per time of day
    Hypothesis: Midday, Evening, and Late night receive a greater amount of people using the metro when compared to AM Peek and PM Peek.

  Difference between summer(4-9 inc) and winter(10-3 inc) based on the time of day
    Hypothesis: People will be more likely to stay later in the summer as opposed to the winter due to temperature.

  Approach: Create 8 separate csv files where each csv file represents a specific day. The csv files contain 2 columns: TimeOfDay and Amount of People. Using these csv files, we would create a series of histograms to represent the relationship between the variables.

Map

  Difference between the location of the metro station and the amount of people that use the metro station per day
    Hypothesis: Locations near monuments, memorials, museums and residential areas receive a higher amount of people.
  General difference in people between the weekday and weekend per location of the metro station
    Hypothesis: During weekdays, stations located near commercial and industrial areas receive the most amount of people. Whereas during the weekends, stations located near monuments, memorials and museums will receive a greater number of people.

  Approach: Create 3 separate csv files. The csv files contain 2 columns: Station and Amount of People. Using these csv files, we would create 3 maps of Washington DC with a point at the location of each station. The size of the point represents the average number of people for all of the 8 days.

  
  
