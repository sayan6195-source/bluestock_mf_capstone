import requests
import pandas as pd
import os

os.makedirs("data/raw", exist_ok=True)

schemes = {
    125497: "HDFC Top 100 Direct",
    119551: "SBI Bluechip Direct",
    120503: "ICICI Prudential Bluechip",
    118632: "Nippon India Large Cap",
    119092: "Axis Bluechip Direct",
    120841: "Kotak Bluechip Direct"
}

all_data = []

for code, name in schemes.items():
    url = f"https://api.mfapi.in/mf/{code}"
    print(f"Fetching {name}...")
    res = requests.get(url)

    if res.status_code == 200:
        json_data = res.json()
        df = pd.DataFrame(json_data['data'])
        df['scheme_code'] = code
        df['scheme_name'] = name
        df['fund_house'] = json_data['meta'].get('fund_house', '')
        df['scheme_category'] = json_data['meta'].get('scheme_category', '')
        df.to_csv(f"data/raw/nav_{code}.csv", index=False)
        all_data.append(df)
        print(f"  ✓ {len(df)} records saved")
    else:
        print(f"  ✗ Failed: {res.status_code}")

combined = pd.concat(all_data, ignore_index=True)
combined.to_csv("data/processed/all_schemes_nav.csv", index=False)
print(f"\nDone! Combined shape: {combined.shape}")