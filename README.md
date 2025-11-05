# DERM AI DIAGNOSTICS SKIN CANCER ANALYSIS - SQL QUERIES
This project explores clinical and environmental data from Derm AI Diagnostics, focusing on patterns associated with different skin lesion types — particularly Actinic Keratosis (ACK), a precancerous form of skin cancer.

Using structured SQL queries, the analysis investigates demographic, lifestyle, and environmental factors influencing lesion occurrence, aiming to support early diagnosis, risk assessment, and public health interventions.

## Objectives

* Identify the age group and gender most affected by specific skin cancer types.
* Examine environmental and lifestyle factors (e.g., pesticide exposure, smoking, alcohol use).
* Explore the relationship between skin type, lesion characteristics, and diagnostic frequency.
* Investigate biopsy rates, family history, and health access indicators (piped water, sewage).
* Provide data-driven insights to guide dermatological risk profiling and preventive care.

## Tools & Technologies

| Category       | Tools Used                                                        |
| -------------- | ----------------------------------------------------------------- |
| Query Language | **SQL (PostgreSQL / MySQL)**                                      |
| Environment    | Jupyter Notebook / SQL IDE                                        |
| Data Sources   | Two relational tables (`Table1`, `Table2`) joined by `patient_id` |
| Analysis Type  | Descriptive & Diagnostic Analysis (EDA in SQL)                    |

## Dataset Description

The project combines two datasets:
* Table1: Patient demographics and lifestyle factors (age, gender, cancer history, smoking, alcohol, access to water/sewage, pesticide exposure).
* Table2: Diagnostic details (lesion type, Fitzpatrick skin type, biopsy status, symptoms — itch, bleed, hurt, changed — and diameter measurements).

The data was joined via patient_id to create a unified analytical view.

## Key Analytical Queries

| #     | Query Focus                                     | Insight Area                        |
| ----- | ----------------------------------------------- | ----------------------------------- |
| 1     | Joined patient and diagnostic data              | Dataset preparation                 |
| 2     | Age group with most ACK cases                   | Demographic trends                  |
| 3     | Gender bias in ACK diagnosis                    | Gender disparities                  |
| 4     | Distribution of lesion types across ethnicities | Ethnic and regional exposure        |
| 5     | Pesticide exposure vs. lesion type              | Environmental risk                  |
| 6–8   | Access to utilities (water, sewage) vs. lesions | Socioeconomic correlation           |
| 9     | Combination of age, gender & skin type for ACK  | Composite risk factors              |
| 10–13 | Lesion symptoms (itch, bleed, change, growth)   | Symptom profiling                   |
| 14–16 | Complex symptom combinations                    | Multi-factor lesion characteristics |
| 17–18 | Diameter vs. diagnosis correlation              | Morphological patterns              |
| 19–20 | Cancer history vs. ACK                          | Genetic predisposition              |
| 21    | Biopsy-confirmed lesions                        | Diagnostic confirmation             |
| 24–25 | Smoking & alcohol vs. ACK                       | Lifestyle associations              |

## Key Findings & Insights

* Age Group: Individuals aged 41–60 show the highest occurrence of Actinic Keratosis (ACK).
* Gender Distribution: Slightly higher ACK prevalence in males, suggesting potential lifestyle or occupational exposure differences.
* Environmental Exposure: Pesticide exposure and lack of access to piped water/sewage systems correlate with higher lesion frequency — highlighting environmental determinants of skin health.
* Lifestyle Factors: Patients with smoking or alcohol history demonstrated higher ACK incidence rates.
* Biopsy Data: A significant proportion of ACK lesions were biopsy-confirmed, reinforcing the importance of early dermatological screening.
* Symptom Analysis: Lesions that itched, bled, hurt, and changed simultaneously were often diagnosed as Basal Cell Carcinoma (BCC) or Actinic Keratosis (ACK).
* Family & Medical History: Patients with a personal or family history of cancer showed an increased risk of ACK.

## Recommendations

* Targeted Awareness Programs: Focus on middle-aged adults and occupationally exposed workers (e.g., agriculture).
* Environmental Health Interventions: Improve access to clean water and sanitation to mitigate environmental exposure risks.
* Lifestyle Education: Promote campaigns on smoking cessation and alcohol moderation linked to skin lesion risk.
* Preventive Screening: Encourage routine dermatological checks for individuals with cancer family history or pesticide exposure.
* Future Analysis: Apply machine learning to predict lesion type probabilities using environmental and demographic variables.

## Learning Outcomes

* Advanced use of SQL joins, grouping, and aggregation for medical analytics.
* Translating clinical datasets into public health insights.
* Building query logic for diagnostic pattern recognition.
* Understanding how environmental and lifestyle factors interplay in medical data.

## Sample Query Snippet

```sql
-- Identify the age group most affected by Actinic Keratosis (ACK)
SELECT 
    CASE 
        WHEN T1.age BETWEEN 0 AND 20 THEN '0-20'
        WHEN T1.age BETWEEN 21 AND 40 THEN '21-40'
        WHEN T1.age BETWEEN 41 AND 60 THEN '41-60'
        WHEN T1.age BETWEEN 61 AND 80 THEN '61-80'
        ELSE '81+'
    END AS age_group,
    T2.diagnostic,
    COUNT(*) AS total_cases
FROM Table1 T1
JOIN Table2 T2 ON T1.patient_id = T2.patient_id
WHERE T2.diagnostic = 'ACK'
GROUP BY age_group, T2.diagnostic
ORDER BY total_cases DESC;
```

## Tech Stack

* Language: SQL
* Libraries/Tools: PostgreSQL / MySQL, Jupyter Notebook (for query execution & visualization)
* Environment: 10Alytics Data Science Capstone Project

## Author

**Holiness Segun-Olufemi**
Public Policy Professional | Data Scientist | Researcher
