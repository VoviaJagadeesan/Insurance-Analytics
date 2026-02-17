select AccountExecutive, count(Invoice_number) as NumberOfInvoices
from invoice
group by AccountExecutive
order by NumberOfInvoices desc;

SELECT 
    YEAR(STR_TO_DATE(meeting_date, '%d-%m-%Y')) AS 'year',
    COUNT(*) AS "meeting count"
FROM meeting
GROUP BY  YEAR(STR_TO_DATE(meeting_date, '%d-%m-%Y'))
ORDER BY "year", "meeting count" ;

SELECT 
	SUM(NewBudget) AS new_target,
    SUM(Cross_SellBugdet) AS cross_sell_target,
    SUM(RenewalBudget) AS renewal_target
FROM individualbudgets;


SELECT
income_class,
sum(round(Amount)) as brokerage_targert
from brokerage
WHERE income_class IS NOT NULL AND income_class <> ''
group by income_class
order by income_class;

SELECT 
income_class,  
SUM(Amount) AS invoice_target
FROM invoice
WHERE income_class IS NOT NULL AND income_class <> ''
GROUP BY income_class
order by income_class;

SELECT 
income_class,  
SUM(Amount) AS fees_target
FROM fees
WHERE income_class IS NOT NULL AND income_class <> ''
GROUP BY income_class
order by income_class;

SELECT
  income_class,
  round(SUM(total_amount),2) AS total_achived_target
FROM (
  SELECT income_class, Amount AS total_amount FROM brokerage
  UNION ALL
  SELECT income_class, Amount FROM fees
) AS combined
WHERE income_class IS NOT NULL AND income_class <> ''
GROUP BY income_class
ORDER BY income_class;

SELECT 
Stage,
SUM(revenue_amount) AS total_revenue
FROM opportunity
GROUP BY Stage
ORDER BY total_revenue DESC;

SELECT 
    AccountExecutive,
    COUNT(*) AS meeting_count
FROM meeting
GROUP BY AccountExecutive;

SELECT 
Stage,
COUNT(*) AS total_opportunities
FROM opportunity
GROUP BY Stage;

SELECT 
COUNT(*) AS total_opportunities
FROM opportunity;

SELECT 
Stage,
count(*) as "open opportunity"
FROM opportunity
WHERE Stage IN ('Propose Solution', 'Qualify Opportunity')
group by stage;



















