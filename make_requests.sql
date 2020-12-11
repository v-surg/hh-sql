-- Task 3
SELECT v.name AS vacancy, a.name AS city, er.name AS employer 
    FROM vacancy AS v 
    LEFT JOIN area AS a ON v.area_id = a.area_id
    LEFT JOIN employer AS er ON v.employer_id = er.employer_id 
    WHERE (v.compensation_from IS NULL AND v.compensation_to IS NULL)
    ORDER BY v.created_on DESC
    LIMIT 10
;


-- Task 4
SELECT 
    AVG(CASE WHEN compensation_gross = true THEN compensation_from ELSE compensation_from/0.87 END) AS avg_min_salary, 
    AVG(CASE WHEN compensation_gross = true THEN compensation_to ELSE compensation_to/0.87 END) AS avg_max_salary,
    AVG((CASE WHEN compensation_gross = true THEN compensation_from ELSE compensation_from/0.87 END) + 
    ((CASE WHEN compensation_gross = true THEN compensation_to ELSE compensation_to/0.87 END) - 
    (CASE WHEN compensation_gross = true THEN compensation_from ELSE compensation_from/0.87 END))/2) AS avg_avg_salary
    FROM vacancy;


-- Task 5
SELECT COUNT(r.response_id) AS responses_per_employer, er.name AS employer
    FROM response AS r 
    LEFT JOIN vacancy AS v ON r.vacancy_id = v.vacancy_id
    LEFT JOIN employer AS er ON v.employer_id = er.employer_id
    GROUP BY er.employer_id
    ORDER BY responses_per_employer DESC, employer
    LIMIT 5;


-- Task 6
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vac_per_er) AS median_vacancies_per_employer
    FROM (SELECT count(v.vacancy_id) AS vac_per_er
        FROM vacancy AS v
        LEFT JOIN employer AS er ON v.employer_id = er.employer_id
        GROUP BY v.employer_id
    ) AS subquery
;


--Task 7
SELECT MIN(first_resp - vac_created) AS min_lag, MAX(first_resp - vac_created) AS max_lag, a.name AS city
   FROM (
   SELECT MIN(r.created_on) AS first_resp, v.created_on AS vac_created, v.area_id AS area_id
       FROM response AS r 
       LEFT JOIN vacancy as v ON v.vacancy_id = r.vacancy_id
       GROUP BY v.vacancy_id
   ) AS subquery LEFT JOIN area AS a ON a.area_id = subquery.area_id
   GROUP BY a.area_id
;
