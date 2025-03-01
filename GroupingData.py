import pandas as pd

df = pd.read_csv("Data/WMATA_Ridership_Summary.xlsx - December_04_2024.csv")
times = df["Time Period"]
riders = df["Avg Daily Entries"]
print(f"Times: {times}")
print(f"Riders: {riders}")
late_night = df[(times == "Late Night (12am-Close)")]
print(f"late night data: {late_night}")
night = "Late Night (12am-Close)"
riders_late_night = df.loc[times == night, "Avg Daily Entries"].iloc[0]
print(f"late night riders: {riders_late_night}")

for 
