-- Derm AI Diagnostics Skin Capstone Project

-- 1. Retrieve a combined dataset of employees by joining the two tables
SELECT * 
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id;

-- 2. Which age group has the highest occurrence of skin cancer type?
SELECT 
    CASE 
        WHEN T1.age BETWEEN 0 AND 20 THEN '0-20'
        WHEN T1.age BETWEEN 21 AND 40 THEN '21-40'
        WHEN T1.age BETWEEN 41 AND 60 THEN '41-60'
        WHEN T1.age BETWEEN 61 AND 80 THEN '61-80'
        ELSE '81+'
    END AS age_group, T2.diagnostic,
COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY age_group, T2.diagnostic
ORDER BY total_cases DESC; 

-- 3. Is there a gender bias in the diagnosis of ACK?
SELECT gender, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY gender, T2.diagnostic
ORDER BY total_cases DESC;

-- 4. What is the distribution of skin cancer types across different ethnicities?
SELECT 
	COALESCE(background_father, background_mother) AS country, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
GROUP BY country, T2.diagnostic
ORDER BY total_cases DESC
LIMIT 5;

-- 5. Is pesticide exposure associated with which certain skin lesion types?
SELECT pesticide, diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE pesticide = 'true'
GROUP BY pesticide, T2.diagnostic
ORDER BY total_cases DESC

-- 6. How are lesion types distributed across Fitzpatrick skin types and pesticide exposure?
SELECT pesticide, fitspatrick, diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE pesticide = 'true'
GROUP BY pesticide, T2.fitspatrick, T2.diagnostic
ORDER BY total_cases DESC
LIMIT 10

-- 7. No access to Piped Water, associated with skin lesions types?
SELECT T1.has_piped_water, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T1.has_piped_water = 'false'
GROUP BY T1.has_piped_water, T2.diagnostic
ORDER BY total_cases DESC

-- 8. No access to sewage system, associated with skin lesions types?
SELECT T1.has_sewage_system, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T1.has_sewage_system = 'false'
GROUP BY T1.has_sewage_system, T2.diagnostic
ORDER BY total_cases DESC

-- 9. Which combinations of age group, gender, and Fitzpatrick type have the highest number of ACK cases?
SELECT 
    CASE 
        WHEN T1.age BETWEEN 0 AND 20 THEN '0-20'
        WHEN T1.age BETWEEN 21 AND 40 THEN '21-40'
        WHEN T1.age BETWEEN 41 AND 60 THEN '41-60'
        WHEN T1.age BETWEEN 61 AND 80 THEN '61-80'
        ELSE '81+'
    END AS age_group, T1.gender, T2.fitspatrick, T2.diagnostic,
COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY age_group, T1.gender, T2.fitspatrick, T2.diagnostic
ORDER BY total_cases DESC
LIMIT 5;

-- 10. ACK more likely changed?
SELECT diagnostic, changed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.changed = 'true'
GROUP BY T2.diagnostic, T2.changed
ORDER BY total_cases DESC 

-- 11. ACK more likely itched?
SELECT diagnostic, itch, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.itch = 'true'
GROUP BY T2.diagnostic, T2.itch
ORDER BY total_cases DESC 

-- 12. ACK more likely to bleed?
SELECT diagnostic, bleed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.bleed = 'true'
GROUP BY T2.diagnostic, T2.bleed
ORDER BY total_cases DESC 

-- 13. ACK more likely grew?
SELECT diagnostic, grew, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.grew = 'true'
GROUP BY T2.diagnostic, T2.grew
ORDER BY total_cases DESC 

-- 14. ACK more likely bled, itched, hurt, and changed?
SELECT diagnostic, itch, bleed, hurt, changed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'BCC' AND T2.itch = 'true' AND T2.bleed ='true' AND T2.hurt = 'true' AND T2.changed = 'true'
GROUP BY T2.diagnostic, T2.itch, T2.bleed, T2.hurt, T2.changed
ORDER BY total_cases DESC 

-- 15. Which skin lesion more likely bled, itched, hurt, and changed?
SELECT diagnostic, itch, bleed, hurt, changed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.itch = 'true' AND T2.bleed ='true' AND T2.hurt = 'true' AND T2.changed = 'true'
GROUP BY T2.diagnostic, T2.itch, T2.bleed, T2.hurt, T2.changed
ORDER BY total_cases DESC;

-- 16. Patient with ACK that likely bled, itched, hurt, and changed?
SELECT T2.patient_id, T2.diagnostic, T2.itch, T2.bleed, T2.hurt, T2.changed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.itch = 'true' AND T2.bleed ='true' AND T2.hurt = 'true' AND T2.changed = 'true'
GROUP BY T2.patient_id, T2.diagnostic, T2.itch, T2.bleed, T2.hurt, T2.changed;

-- 17. Is lesion size (diameter) correlated with ACK?
SELECT T2.diameter_1, T2.diagnostic, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' 
GROUP BY T2.diameter_1, T2.diagnostic
ORDER BY total_cases DESC;

-- 18. Did the second diameter measurement correlated with ACK?
SELECT T2.diameter_2, T2.diagnostic, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' 
GROUP BY T2.diameter_2, T2.diagnostic
ORDER BY total_cases DESC; 

-- 19. Do patients with a family history of cancer have higher rates of ACK.
SELECT cancer_history, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY cancer_history, T2.diagnostic
ORDER BY total_cases DESC;

-- 20. Do patients with a history of cancer have higher rates of ACK.
SELECT skin_cancer_history, T2.diagnostic, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY skin_cancer_history, T2.diagnostic
ORDER BY total_cases DESC;

-- 21. Are biopsy-confirmed lesions more common in ACK?
SELECT T2.diagnostic, biopsed, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK' AND T2.biopsed = 'true' 
GROUP BY T2.diagnostic, T2.biopsed
ORDER BY total_cases DESC; 

-- 22. Total number of cases with ACK 
SELECT T2.diagnostic, COUNT(*) AS total_cases
FROM Table2 T2
WHERE T2.diagnostic = 'ACK'
GROUP BY T2.diagnostic;

-- 23. Total number of cases with lesions 
SELECT T2.diagnostic, COUNT(*) AS total_cases
FROM Table2 T2
GROUP BY T2.diagnostic
ORDER BY total_cases DESC;

-- 24. Is there a higher frequency of malignant skin lesions (ACK) among patients who smoke compared to those who don't?
SELECT smoke, diagnostic, itch, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK' AND T2.itch = 'true'
GROUP BY smoke, T2.diagnostic, T2.itch
ORDER BY total_cases DESC;

-- 25. Is there a higher frequency of malignant skin lesions (ACK) among patients who consumed alcohol compared to those who don't?
SELECT drink, diagnostic, itch, COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK' AND T2.itch = 'true'
GROUP BY drink, T2.diagnostic, T2.itch
ORDER BY total_cases DESC;











