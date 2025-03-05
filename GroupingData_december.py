import pandas as pd

df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
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
print(f"Total evening riders across all stations: {total_evening_riders}")


##### Late Night Riders
df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
df.columns = df.columns.str.strip()

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

print(f"Total late-night riders across all stations: {total_late_night_riders}")
