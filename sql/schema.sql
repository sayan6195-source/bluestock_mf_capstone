
-- dim_fund: Fund dimension table
CREATE TABLE IF NOT EXISTS dim_fund (
    amfi_code       INTEGER PRIMARY KEY,
    scheme_name     TEXT NOT NULL,
    fund_house      TEXT NOT NULL,
    scheme_category TEXT,
    risk_grade      TEXT
);

-- dim_date: Date dimension table
CREATE TABLE IF NOT EXISTS dim_date (
    date_id     TEXT PRIMARY KEY,
    date        TEXT NOT NULL,
    day         INTEGER,
    month       INTEGER,
    year        INTEGER,
    quarter     INTEGER,
    day_of_week TEXT
);

-- fact_nav: NAV fact table
CREATE TABLE IF NOT EXISTS fact_nav (
    nav_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code   INTEGER NOT NULL,
    date_id     TEXT NOT NULL,
    nav         REAL NOT NULL,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (date_id)   REFERENCES dim_date(date_id)
);

-- fact_transactions: Transactions fact table
CREATE TABLE IF NOT EXISTS fact_transactions (
    transaction_id   INTEGER PRIMARY KEY,
    amfi_code        INTEGER NOT NULL,
    date_id          TEXT NOT NULL,
    transaction_type TEXT NOT NULL,
    amount           REAL NOT NULL,
    kyc_status       TEXT,
    state            TEXT,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (date_id)   REFERENCES dim_date(date_id)
);

-- fact_performance: Performance fact table
CREATE TABLE IF NOT EXISTS fact_performance (
    perf_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code      INTEGER NOT NULL,
    year           INTEGER NOT NULL,
    return_1yr     REAL,
    return_3yr     REAL,
    return_5yr     REAL,
    expense_ratio  REAL,
    sharpe_ratio   REAL,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- fact_aum: AUM fact table
CREATE TABLE IF NOT EXISTS fact_aum (
    aum_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code   INTEGER NOT NULL,
    date_id     TEXT NOT NULL,
    aum_crores  REAL NOT NULL,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (date_id)   REFERENCES dim_date(date_id)
);
