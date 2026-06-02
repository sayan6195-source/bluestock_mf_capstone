# Data Dictionary — Bluestock MF Capstone

## 1. dim_fund
| Column | Data Type | Description | Source |
|---|---|---|---|
| amfi_code | INTEGER | Unique AMFI scheme code (Primary Key) | AMFI India |
| scheme_name | TEXT | Full name of the mutual fund scheme | AMFI India |
| fund_house | TEXT | Name of the Asset Management Company | AMFI India |
| scheme_category | TEXT | Category of fund (e.g. Large Cap) | SEBI Classification |
| risk_grade | TEXT | Risk level assigned to the scheme | AMFI India |

---

## 2. dim_date
| Column | Data Type | Description | Source |
|---|---|---|---|
| date_id | TEXT | Date in YYYY-MM-DD format (Primary Key) | Generated |
| date | TEXT | Full date string | Generated |
| day | INTEGER | Day of month (1-31) | Generated |
| month | INTEGER | Month number (1-12) | Generated |
| year | INTEGER | 4-digit year | Generated |
| quarter | INTEGER | Quarter (1-4) | Generated |
| day_of_week | TEXT | Name of day (Monday-Sunday) | Generated |

---

## 3. fact_nav
| Column | Data Type | Description | Source |
|---|---|---|---|
| nav_id | INTEGER | Auto-increment primary key | Generated |
| amfi_code | INTEGER | Foreign key to dim_fund | mfapi.in API |
| date_id | TEXT | Foreign key to dim_date | mfapi.in API |
| nav | REAL | Net Asset Value in INR on that date | mfapi.in API |

---

## 4. fact_transactions
| Column | Data Type | Description | Source |
|---|---|---|---|
| transaction_id | INTEGER | Unique transaction identifier (Primary Key) | investor_transactions.csv |
| amfi_code | INTEGER | Foreign key to dim_fund | investor_transactions.csv |
| date_id | TEXT | Foreign key to dim_date | investor_transactions.csv |
| transaction_type | TEXT | Type: SIP / Lumpsum / Redemption | investor_transactions.csv |
| amount | REAL | Transaction amount in INR | investor_transactions.csv |
| kyc_status | TEXT | KYC status: verified / pending | investor_transactions.csv |
| state | TEXT | Indian state of the investor | investor_transactions.csv |

---

## 5. fact_performance
| Column | Data Type | Description | Source |
|---|---|---|---|
| perf_id | INTEGER | Auto-increment primary key | Generated |
| amfi_code | INTEGER | Foreign key to dim_fund | scheme_performance.csv |
| year | INTEGER | Year of performance data | scheme_performance.csv |
| return_1yr | REAL | 1-year return percentage | scheme_performance.csv |
| return_3yr | REAL | 3-year CAGR percentage | scheme_performance.csv |
| return_5yr | REAL | 5-year CAGR percentage | scheme_performance.csv |
| expense_ratio | REAL | Annual expense ratio % (0.1 to 2.5) | scheme_performance.csv |
| sharpe_ratio | REAL | Risk-adjusted return metric | scheme_performance.csv |

---

## 6. fact_aum
| Column | Data Type | Description | Source |
|---|---|---|---|
| aum_id | INTEGER | Auto-increment primary key | Generated |
| amfi_code | INTEGER | Foreign key to dim_fund | Generated |
| date_id | TEXT | Foreign key to dim_date | Generated |
| aum_crores | REAL | Assets Under Management in INR Crores | Generated |

---

## Business Definitions
| Term | Definition |
|---|---|
| NAV | Net Asset Value — price per unit of a mutual fund on a given day |
| AUM | Assets Under Management — total market value of fund assets |
| AMFI | Association of Mutual Funds in India — regulatory body |
| CAGR | Compound Annual Growth Rate — annualised return over a period |
| Expense Ratio | Annual fee charged by fund as % of AUM |
| Sharpe Ratio | Return earned per unit of risk (higher is better) |
| SIP | Systematic Investment Plan — fixed periodic investment |
| Lumpsum | One-time large investment |
| Redemption | Withdrawal of investment from fund |
| KYC | Know Your Customer — investor identity verification |
