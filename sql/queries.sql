-- Q1: Top 5 Funds by Total AUM
SELECT f.scheme_name, ROUND(SUM(a.aum_crores), 2) AS total_aum
        FROM fact_aum a
        JOIN dim_fund f ON a.amfi_code = f.amfi_code
        GROUP BY f.scheme_name
        ORDER BY total_aum DESC
        LIMIT 5;

-- Q2: Average NAV Per Month
SELECT d.year, d.month, f.scheme_name,
               ROUND(AVG(n.nav), 2) AS avg_nav
        FROM fact_nav n
        JOIN dim_date d ON n.date_id = d.date_id
        JOIN dim_fund f ON n.amfi_code = f.amfi_code
        GROUP BY d.year, d.month, f.scheme_name
        ORDER BY d.year, d.month
        LIMIT 20;

-- Q3: SIP YoY Growth
SELECT d.year,
               COUNT(*) AS sip_count,
               ROUND(SUM(t.amount), 2) AS total_sip_amount
        FROM fact_transactions t
        JOIN dim_date d ON t.date_id = d.date_id
        WHERE t.transaction_type = 'Sip'
        GROUP BY d.year
        ORDER BY d.year;

-- Q4: Transactions by State
SELECT state,
               COUNT(*) AS total_transactions,
               ROUND(SUM(amount), 2) AS total_amount
        FROM fact_transactions
        GROUP BY state
        ORDER BY total_transactions DESC;

-- Q5: Funds with Expense Ratio < 1%
SELECT f.scheme_name, p.year, p.expense_ratio
        FROM fact_performance p
        JOIN dim_fund f ON p.amfi_code = f.amfi_code
        WHERE p.expense_ratio < 1.0
        ORDER BY p.expense_ratio ASC;

-- Q6: Best Performing Funds by 1yr Return
SELECT f.scheme_name, p.year,
               p.return_1yr, p.return_3yr, p.return_5yr
        FROM fact_performance p
        JOIN dim_fund f ON p.amfi_code = f.amfi_code
        ORDER BY p.return_1yr DESC
        LIMIT 10;

-- Q7: KYC Verified vs Pending Transactions
SELECT kyc_status,
               COUNT(*) AS count,
               ROUND(SUM(amount), 2) AS total_amount,
               ROUND(AVG(amount), 2) AS avg_amount
        FROM fact_transactions
        GROUP BY kyc_status;

-- Q8: Monthly AUM Trend per Fund
SELECT f.scheme_name, d.year, d.month,
               ROUND(AVG(a.aum_crores), 2) AS avg_aum
        FROM fact_aum a
        JOIN dim_fund f ON a.amfi_code = f.amfi_code
        JOIN dim_date d ON a.date_id = d.date_id
        GROUP BY f.scheme_name, d.year, d.month
        ORDER BY f.scheme_name, d.year, d.month
        LIMIT 20;

-- Q9: Highest Sharpe Ratio Funds
SELECT f.scheme_name, p.year,
               p.sharpe_ratio, p.return_1yr, p.expense_ratio
        FROM fact_performance p
        JOIN dim_fund f ON p.amfi_code = f.amfi_code
        ORDER BY p.sharpe_ratio DESC
        LIMIT 10;

-- Q10: Transaction Type Breakdown by Fund
SELECT f.scheme_name, t.transaction_type,
               COUNT(*) AS count,
               ROUND(SUM(t.amount), 2) AS total_amount
        FROM fact_transactions t
        JOIN dim_fund f ON t.amfi_code = f.amfi_code
        GROUP BY f.scheme_name, t.transaction_type
        ORDER BY f.scheme_name, t.transaction_type;

