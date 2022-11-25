WITH RECURSIVE per_investor_amount AS (
    SELECT  0 AS investors_number,
            (0.00)::real AS investment_amount,
            (0.00)::real AS individual_amount
    UNION
 
    SELECT  investors_number + 1,
            (i.investment_amount)::real,
            (i.investment_amount / (investors_number + 1))::real
    FROM investments i, per_investor_amount pia
    WHERE investors_number < 3
)
SELECT *
FROM per_investor_amount
ORDER BY  investment_amount, investors_number;