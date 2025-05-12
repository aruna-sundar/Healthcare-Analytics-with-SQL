Queries: 


CREATING DATABASE AND TABLES AND EXPORTING THE DATA INSIDE IT: 



CREATE DATABASE healthcare; 


USE healthcare; 


CREATE TABLE patients ( 

  patient_id INT PRIMARY KEY, 

  patient_name VARCHAR(50), 

  age INT, 

  gender VARCHAR(20), 

  address VARCHAR(20), 

  contact_number VARCHAR(15) 

  ); 

 

USE healthcare; 


CREATE TABLE doctors ( 

  doctor_id INT PRIMARY KEY, 

  doctor_name VARCHAR(50), 

  specialization VARCHAR(50), 

  experience_years INT, 

  contact_number VARCHAR(50) 

  ); 

 

USE healthcare; 


CREATE TABLE appointments (  

    appointment_id INT PRIMARY KEY,  

    patient_id INT, doctor_id INT,  

    appointment_date DATE,  

    reason VARCHAR(50),  

    appointment_status VARCHAR(15),  

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),  

    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)   

); 

 

USE healthcare; 

CREATE TABLE diagnosis (  

   diagnosis_id INT PRIMARY KEY,  

   patient_id INT, doctor_id INT,  

 diagnosis_date DATE, diagnosis VARCHAR(50),  

 treatment VARCHAR(50),  

FOREIGN KEY (patient_id) REFERENCES patients(patient_id),  

FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)  

); 

 

USE healthcare; 

CREATE TABLE medications (  

  medication_id INT PRIMARY KEY,  

  diagnosis_id INT,  

  medication_name VARCHAR(50),  

  dosage VARCHAR(20),  

  start_date DATE,  

  end_date DATE,  

 FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(diagnosis_id)  

); 

 

 

To export data:  

Right click on the table name 

Select Table Data Import Wizard 

Follow the steps over there 





1) Write a query to fetch details of all completed appointments, including the patient’s name, doctor’s name, and specialization. 

USE healthcare; 
 
SELECT a.*, p.patient_name, d.doctor_name, d.specialization  
FROM appointments a  
INNER JOIN patients p on a.patient_id = p.patient_id  
INNER JOIN doctors d on a.doctor_id = d.doctor_id  
WHERE a.appointment_status = 'Completed'; 

 

 

2) Retrieve all patients who have never had an appointment. Include their name, contact details, and address in the output. 

USE healthcare; 

SELECT p.patient_name, p.contact_number, p.address  
FROM patients p  
LEFT JOIN appointments a on p.patient_id = a.patient_id  
WHERE p.patient_id IS NULL; 

Every patient in the Patients table has at least one appointment recorded in the Appointments table. 

 

 

3) Find the total number of diagnoses for each doctor, including doctors who haven’t diagnosed any patients. Display the doctor’s name, specialization, and total diagnoses. 

USE healthcare; 

SELECT d.doctor_name, d.specialization, COUNT(di.diagnosis_id) AS total_diagnoses  
FROM diagnosis di  
RIGHT JOIN doctors d on di.doctor_id = d.doctor_id  
GROUP BY d.doctor_name, d.specialization  
ORDER BY total_diagnoses DESC; 

 

4) Write a query to identify mismatches between the appointments and diagnoses tables. Include all appointments and diagnoses with their corresponding patient and doctor details. 

SELECT a.appointment_id, a.appointment_date,  
                 p.patient_id, p.patient_name,  
                 d.doctor_id, d.doctor_name,  
                 di.diagnosis_id, di.diagnosis, di.diagnosis_date  
FROM appointments a  
LEFT JOIN patients p on a.patient_id = p.patient_id  
LEFT JOIN doctors d on a.doctor_id = d.doctor_id  
LEFT JOIN diagnosis di on a.patient_id = di.patient_id AND a.doctor_id = di.doctor_id 

UNION 

SELECT a.appointment_id, a.appointment_date,  
                 p.patient_id, p.patient_name,  
                 d.doctor_id, d.doctor_name,  
                 di.diagnosis_id, di.diagnosis, di.diagnosis_date  
FROM diagnosis di  
LEFT JOIN patients p on di.patient_id = p.patient_id  
LEFT JOIN doctors d on di.doctor_id = d.doctor_id  
LEFT JOIN appointments a on di.patient_id = a.patient_id AND di.doctor_id = a.doctor_id; 

 

 

5) For each doctor, rank their patients based on the number of appointments in descending order. 

SELECT doctor_id, doctor_name, patient_id, patient_name, no_of_appointments, DENSE_RANK() OVER(PARTITION BY doctor_id ORDER BY no_of_appointments DESC) AS ranks FROM (  
       SELECT d.doctor_id, d.doctor_name, p.patient_id, p.patient_name, 
       COUNT(a.appointment_id) as no_of_appointments  
       FROM appointments a  
       JOIN patients p on a.patient_id = p.patient_id  
       JOIN doctors d on a.doctor_id = d.doctor_id  
      GROUP BY d.doctor_id, d.doctor_name, p.patient_id, p.patient_name ) SUBQUERY  
ORDER BY doctor_id, ranks; 

 

 

6) Write a query to categorize patients by age group (e.g., 18-30, 31-50, 51+). Count the number of patients in each age group. 

SELECT  
          CASE  
                  WHEN age BETWEEN 18 AND 30 THEN '18-30'  
                  WHEN age BETWEEN 31 AND 40 THEN '31-40'  
                  WHEN age BETWEEN 41 AND 50 THEN '41-50'  
                  WHEN age BETWEEN 51 AND 60 THEN '51-60'  
                  WHEN age BETWEEN 61 AND 70 THEN '61-70'  
                  WHEN age BETWEEN 71 AND 80 THEN '71-80'  
                  WHEN age BETWEEN 81 AND 90 THEN '81-90'  
          END AS age_group, COUNT(*) AS no_of_patients  
FROM patients  
GROUP BY age_group  
ORDER BY age_group; 

 

 

7) Retrieve a list of patients whose contact numbers end with "1234" and display their names in uppercase. 

SELECT UPPER(patient_name) as patient_name, contact_number  
FROM patients  
WHERE contact_number LIKE '%1234'; 

 

 

8) Find patients who have only been prescribed "Insulin" in any of their diagnoses. 

SELECT patient_id, patient_name  
FROM patients  
WHERE patient_id IN (  
                  SELECT DISTINCT di.patient_id  
                  FROM diagnosis di  
                  JOIN medications m on di.diagnosis_id = m.diagnosis_id  
                  WHERE m.medication_name = 'Insulin')  
AND patient_id NOT IN (  
                   SELECT DISTINCT di.patient_id  
                   FROM diagnosis di  
                   JOIN medications m on di.diagnosis_id = m.diagnosis_id  
                   WHERE m.medication_name <> 'Insulin'); 

 

 

9) Calculate the average duration (in days) for which medications are prescribed for each diagnosis. 

SELECT di.diagnosis_id, di.diagnosis,  
AVG(DATEDIFF(m.end_date, m.start_date)) as avg_prescription_duration  
FROM diagnosis di  
JOIN medications m on di.diagnosis_id = m.diagnosis_id  
GROUP BY di.diagnosis_id, di.diagnosis  
ORDER BY avg_prescription_duration DESC; 

 

 

10) Write a query to identify the doctor who has attended the most unique patients. Include the doctor’s name, specialization, and the count of unique patients. 

Select d.doctor_id, d.doctor_name, d.specialization,  
COUNT(DISTINCT a.patient_id) as no_of_unique_patients  
FROM doctors d  
JOIN appointments a on d.doctor_id = a.doctor_id  
GROUP BY d.doctor_id, d.doctor_name, d.specialization  
ORDER BY no_of_unique_patients DESC  
LIMIT 1; 