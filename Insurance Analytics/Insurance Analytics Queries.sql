use insurance_db;

-- No.oF.Invoices
select Account_Executive_i, count(invoice_date) from invoice group by Account_Executive_i order by  count(invoice_date) desc;

-- No.of.Meeting;
select Account_Executive_m, count(meeting_date) from meeting group by Account_Executive_m order by count(meeting_date);

-- Top 4 Oppty
SELECT opportunity_name,sum(revenue_amount) FROM opportunity group by opportunity_name ORDER BY sum(revenue_amount) DESC LIMIT 4;

-- Object-product Group
select product_group, count(opportunity_name) from opportunity group by product_group order by count(opportunity_name) desc;

-- Top 5 Product subgroup
select product_sub_group, sum(revenue_amount) from opportunity group by product_sub_group order by sum(revenue_amount) desc limit 5;

-- Stage Funnel
select stage,sum(revenue_amount) from opportunity group by stage order by sum(revenue_amount) desc;

-- Budgets
SELECT 
	SUM(New_Budget) AS new_target,
    SUM(Cross_Sell_Bugdet) AS cross_sell_target,
    SUM(Renewal_Budget) AS renewal_target
FROM individual_budget;

-- Meeting Trend
SELECT YEAR(meeting_date) AS meeting_year, monthname(meeting_date) AS meeting_month,COUNT(*) AS meeting_count FROM meeting GROUP BY YEAR(meeting_date), monthname(meeting_date) ORDER BY meeting_year, meeting_month desc;

SELECT
income_class_b,
sum(round(Amount_b)) as brokerage_target
from brokerage
WHERE income_class_b IS NOT NULL AND income_class_b <> ''
group by income_class_b
order by income_class_b;

SELECT 
income_class,  
SUM(Amount_i) AS invoice_target
FROM invoice
WHERE income_class IS NOT NULL AND income_class <> ''
GROUP BY income_class
order by income_class;

SELECT 
income_class_f,  
SUM(Amount_f) AS fees_target
FROM fees
WHERE income_class_f IS NOT NULL AND income_class_f <> ''
GROUP BY income_class_f
order by income_class_f;

SELECT CONCAT(ROUND(((SELECT SUM(amount_i) FROM invoice WHERE income_class = 'cross sell')/(SELECT SUM(cross_sell_bugdet) FROM individual_budget)) * 100, 2), '%') AS cross_sell_percentage;

SELECT CONCAT(ROUND(((SELECT SUM(amount_i) FROM invoice WHERE income_class = 'new') / (SELECT SUM(new_budget) FROM individual_budget)) * 100, 2), '%') AS new_sell_percentage;

SELECT CONCAT(ROUND(((SELECT SUM(amount_i) FROM invoice WHERE income_class = 'Renewal') / (SELECT SUM(renewal_budget) FROM individual_budget)) * 100, 2), '%') AS renewal_percentage;

SELECT
    'Cross Sell' AS income_class,
    ROUND(
        (
            (SELECT SUM(amount_b) FROM brokerage)
          + (SELECT SUM(amount_f) FROM fees)
        ) / NULLIF((SELECT SUM(cross_sell_bugdet) FROM individual_budget),0) * 100, 2
    ) AS placed_percentage,
    ROUND(
        (SELECT SUM(amount_i) FROM invoice WHERE income_class = 'Cross Sell')
        / NULLIF((SELECT SUM(cross_sell_bugdet) FROM individual_budget),0) * 100, 2
    ) AS invoice_percentage

UNION ALL

SELECT
    'New',
    ROUND(
        (
            (SELECT SUM(amount_b) FROM brokerage WHERE income_class_b = 'New')
          + (SELECT SUM(amount_f) FROM fees WHERE income_class_f = 'New')
        ) / NULLIF((SELECT SUM(new_budget) FROM individual_budget),0) * 100, 2
    ),
    ROUND(
        (SELECT SUM(amount_i) FROM invoice WHERE income_class = 'New')
        / NULLIF((SELECT SUM(new_budget) FROM individual_budget),0) * 100, 2
    )

UNION ALL

SELECT
    'Renewal',
    ROUND(
        (
            (SELECT SUM(amount_b) FROM brokerage WHERE income_class_b = 'Renewal')
          + (SELECT SUM(amount_f) FROM fees WHERE income_class_f = 'Renewal')
        ) / NULLIF((SELECT SUM(renewal_budget) FROM individual_budget),0) * 100, 2
    ),
    ROUND(
        (SELECT SUM(amount_i) FROM invoice WHERE income_class = 'Renewal')
        / NULLIF((SELECT SUM(renewal_budget) FROM individual_budget),0) * 100, 2
    );


-- Open Opportunites   
SELECT 
Stage,
count(*) as "open opportunity"
FROM opportunity
WHERE Stage IN ('Propose Solution', 'Qualify Opportunity')
group by stage;

-- Total Opportunities
SELECT 
COUNT(*) AS total_opportunities
FROM opportunity;