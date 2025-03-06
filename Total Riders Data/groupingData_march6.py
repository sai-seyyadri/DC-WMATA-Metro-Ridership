import pandas as pd


### Evening riders
df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - March_6_2024.csv")
df.columns = df.columns.str.strip()

evening = "Evening (7pm-12am)"

evening_riders_df = df[df["Time Period"] == evening].copy()  
entries_list = evening_riders_df["Avg Daily Entries"].tolist()
converted_ridership = []
i = 0
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value[:-1]) * 1000 
    else:
        value = float(value)  
    converted_ridership.append(value)
    i += 1
evening_riders_df.loc[:, "Avg Daily Entries"] = converted_ridership  
total_evening_riders = sum(converted_ridership)

### Late Night Riders

late_night = "Late Night (12am-Close)"
late_night_riders_df = df[df["Time Period"] == late_night].copy()  

entries_list = late_night_riders_df["Avg Daily Entries"].tolist()

converted_ridership = []
i = 0
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value[:-1]) * 1000 
    else:
        value = float(value)  
    converted_ridership.append(value)
    i += 1

late_night_riders_df.loc[:, "Avg Daily Entries"] = converted_ridership 
total_late_night_riders = sum(converted_ridership)

### PM Peak (3pm-7pm) Riders

pm_peak = "PM Peak (3pm-7pm)"
pm_peak_riders_df = df[df["Time Period"] == pm_peak].copy()  

entries_list = pm_peak_riders_df["Avg Daily Entries"].tolist()

converted_ridership = []
i = 0
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value[:-1]) * 1000 
    else:
        value = float(value)  
    converted_ridership.append(value)
    i += 1

pm_peak_riders_df.loc[:, "Avg Daily Entries"] = converted_ridership 
total_pm_peak_riders = sum(converted_ridership)

### Midday (9:30am-3pm) Riders

midday = "Midday (9:30am-3pm)"
midday_riders_df = df[df["Time Period"] == midday].copy()  

entries_list = midday_riders_df["Avg Daily Entries"].tolist()

converted_ridership = []
i = 0
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value[:-1]) * 1000 
    else:
        value = float(value)  
    converted_ridership.append(value)
    i += 1

midday_riders_df.loc[:, "Avg Daily Entries"] = converted_ridership 
total_midday_riders = sum(converted_ridership)

### AM Peak (Open-9:30am) Riders

am_peak = "AM Peak (Open-9:30am)"
am_peak_riders_df = df[df["Time Period"] == am_peak].copy()  

entries_list = am_peak_riders_df["Avg Daily Entries"].tolist()

converted_ridership = []
i = 0
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value[:-1]) * 1000 
    else:
        value = float(value)  
    converted_ridership.append(value)
    i += 1

am_peak_riders_df.loc[:, "Avg Daily Entries"] = converted_ridership 
total_am_peak_riders = sum(converted_ridership)

## creating csv

data_march6 = {
    "Time Period": ["Evening (7pm-12am)", "Late Night (12am-Close)", 
                    "PM Peak (3pm-7pm)", "Midday (9:30am-3pm)", "Midday (9:30am-3pm)"], 
    "Total Riders":[total_evening_riders, total_late_night_riders, 
                    total_pm_peak_riders,total_midday_riders, total_am_peak_riders]
            }
index = ['0', '1', '2', '3', '4']
df_march6 = pd.DataFrame(data_march6, index=index)

df_march6.to_csv('march_6.csv', index=True, index_label="Indexes", 
                 header=True)