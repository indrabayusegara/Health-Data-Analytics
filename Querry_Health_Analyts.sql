--- Get All Data in table 
select * from ocd_patient_dataset;

--- 1. Count & pct of F Vs M That have OCD & --- Average Obsession Score By Gender
with data as (
    select 
        Gender, 
        Count(Patient_ID) as Total_Patient, 
        AVG(Y_BOCS_Score_Obsessions) as avg_obs_score 
    from 
        ocd_patient_dataset 
    group by 
        Gender
)
select 
    sum(case when Gender = 'Female' then Total_Patient else 0 end) as count_Female,
	sum(case when Gender = 'Male' then Total_Patient else 0 end) as count_male,
	sum(case when Gender = 'Female' then Total_Patient else 0 end)
	/CAST(sum(case when Gender = 'Female' then Total_Patient else 0 end)+sum(case when Gender = 'Male' then Total_Patient else 0 end) AS float) * 100 
	as pct_female,
	sum(case when Gender = 'Male' then Total_Patient else 0 end)
	/CAST(sum(case when Gender = 'Female' then Total_Patient else 0 end)+sum(case when Gender = 'Male' then Total_Patient else 0 end) AS float) * 100 
	as pct_Male
from data

--- 2. Count of patient by Ethnicity and their Respective Average Obsession Score 

select 
	Ethnicity, 
	count(Patient_ID) as Total_Patient, 
	AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score
from ocd_patient_dataset
group by Ethnicity
order by avg_obs_score asc

--- 3. Number of people diagnosed with OCD MoM

SELECT 
    format(OCD_Diagnosis_Date, '%y-%M-01 00:00:00') as month,    
	COUNT(Patient_ID) as Total_Patients 
FROM ocd_patient_dataset
group by format(OCD_Diagnosis_Date, '%y-%M-01 00:00:00')

select FORMAT(OCD_Diagnosis_Date, 'yyyy/MMMM') as years, count(Patient_ID) as Total_Patient from ocd_patient_dataset
group by FORMAT(OCD_Diagnosis_Date, 'yyyy/MMMM')

--- 4. What is the most common obssesion type (Count) & its represective Average Obsession Score 

select Obsession_Type, count(Patient_ID) as total_patient, avg(Y_BOCS_Score_Obsessions) as avg_obs_score
from ocd_patient_dataset
group by Obsession_Type

--- 5. What is the most common Complusion type (count) & it's Respective Average Obsesion Score 
select Compulsion_Type, count(Patient_ID) as total_patient, avg(Y_BOCS_Score_Obsessions) as avg_obs_score
from ocd_patient_dataset
group by Compulsion_Type