USE bankaalysis;
  
-- Year wise loan amount stats
SELECT RIGHT(issue_d,4) AS year,
CONCAT(CAST(SUM(loan_amnt)/100000 AS DECIMAL(10,2)),'Millions') as total_loan_amount
from finance_1_new
group by 1
order by 1;

-- Grade and sub grade wise revol_bal
SELECT f1.grade,f1.sub_grade,SUM(f2.revol_bal) AS sum_revol_bal
FROM finance_1_new AS f1
LEFT JOIN finance_2 AS f2
ON f1.id=f2.id
GROUP BY f1.grade,f1.sub_grade
ORDER BY f1.grade,f1.sub_grade;

SELECT 
    f1.grade, 
    CONCAT(CAST(SUM(f2.revol_bal) / 1000000 AS DECIMAL(10, 2)), ' millions') AS sum_revol_bal_in_millions
FROM 
    finance_1_new AS f1
LEFT JOIN 
    finance_2 AS f2 ON f1.id = f2.id
GROUP BY 
    f1.grade
ORDER BY 
    f1.grade;

-- Total Payment for Verified Status Vs Total Payment for Non-Verified Status
SELECT f1.verification_status,
CONCAT(CAST(ROUND(SUM(f2.total_pymnt) / 1000000, 2) AS DECIMAL(10, 2)), ' millions') as total_payment
FROM finance_1_new f1
LEFT JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY f1.verification_status
HAVING f1.verification_status IN ('verified', 'not verified');



-- State wise and last_credit_pull_d wise loan status
SELECT f1.addr_state,f1.loan_status,count(f2.last_credit_pull_d)AS Total_count
FROM finance_1_new f1
LEFT JOIN finance_2 f2
ON f1.id=f2.id
GROUP BY 1,2
ORDER BY 1,2;

-- home ownership vs last payment stats
SELECT f1.home_ownership,count(last_pymnt_d) AS count_last_pymnt_d
FROM finance_1_new f1
LEFT JOIN finance_2 f2
ON f1.id=f2.id
GROUP BY 1;

 