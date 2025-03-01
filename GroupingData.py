# import pandas as pd

# df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
# times = df["Time Period"]
# riders = df["Avg Daily Entries"]
# print(f"Times: {times}")
# print(f"Riders: {riders}")
# late_night = df[(times == "Evening (7pm-12am)")]
# print(f"late night data: {late_night}")
# night = "Evening (7pm-12am)"
# riders_late_night = df.loc[times == night, "Avg Daily Entries"].iloc[0]
# print(f"late night riders: {riders_late_night}")

# #for station in df:
#  #   riders_late_night += df.loc[times == night, "Avg Daily Entries"].iloc[station]
# #print(f"late night riders: {riders_late_night}")
# station = 0
# while station <= 98:
#     riders_late_night += df.loc[times == night, "Avg Daily Entries"].iloc[station]
#     station += 1
# print(f"late night riders: {riders_late_night}")

import pandas as pd

# Load the data
df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
df.columns = df.columns.str.strip()
# Define time period filter
evening = "Evening (7pm-12am)"
evening_riders_df = df[df["Time Period"] == evening]
converted_ridership = []
i = 0
entries_list = evening_riders_df["Avg Daily Entries"].tolist() 
while i < len(entries_list):
    value = entries_list[i]
    if 'K' in value: 
        value = float(value.replace('K', '')) * 1000 
    else:
        value = float(value)  # Directly convert numbers without 'K'
    
    converted_ridership.append(value)
    i += 1

# Assign converted values back to the dataframe
evening_riders_df["Avg Daily Entries"] = converted_ridership

# Get total evening ridership across all stations
total_evening_riders = sum(converted_ridership)

# Print results
print(f"Total evening riders across all stations: {total_evening_riders}")
