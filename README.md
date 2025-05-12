# 🏥 Healthcare Analytics with SQL

## 🧩 Problem Statement

The project aims to analyze healthcare data, focusing on extracting meaningful insights about patients, doctors, appointments, diagnoses, and treatments using advanced SQL techniques.

---

## 🛠️ Tools Used

- 🐬 **MySQL Workbench**

---

## 🏷️ Technical Tags

- 🔗 Joins (Inner, Left, Right, Full Outer)  
- ➕ Aggregate Functions (e.g., COUNT, SUM)  
- 🪜 Window Functions (e.g., RANK, DENSE_RANK)  
- 🔍 Subqueries and Conditional Logic  
- 📆 Date and Time Functions

---

## 📊 Results

1️⃣ Query to fetch details of all completed appointments, including the patient’s name, doctor’s name, and specialization.  
Out of 10,000 appointments, 3,392 appointments have been completed with specialized doctors.

2️⃣ Retrieve all patients who have never had an appointment. Include their name, contact details, and address in the output.  
There are no patients who have never had an appointment with any doctor. This means that all patients have had at least one appointment.

3️⃣ Find the total number of diagnoses for each doctor, including doctors who haven’t diagnosed any patients. Display the doctor’s name, specialization, and total diagnoses.  
Doctor_281, specializing in orthopaedics, has made the highest number of total diagnoses that is 75, while Doctor_253, specializing in general medicine, has made the lowest number of total diagnoses that is 25.

4️⃣ Write a query to identify mismatches between the appointments and diagnoses tables. Include all appointments and diagnoses with their corresponding patient and doctor details.  
Out of 10,000 appointment records and 15,000 diagnosis records, only 19 records have been matched. The remaining patients may have had appointments, but no diagnosis records were found. The below are the possible reasons for that:  
- Missing data entry for the diagnosis.  
- The appointment being cancelled or yet to occur.  
- Diagnosis records related to completed treatments were removed from the system.

5️⃣ For each doctor, rank their patients based on the number of appointments in descending order.  
Ranked each patient for each doctor based on the number of appointments they had.  
Patients with the same appointment count got the same rank. Even though all patients have only one appointment, the ranking might still be 1, 2, 3... due to how DENSE_RANK() assigns ranks.

6️⃣ Write a query to categorize patients by age group (e.g., 18–30, 31–50, 51+). Count the number of patients in each age group.  
The number of patients in each age group is as follows:  
- 18–30 years: 900 patients  
- 31–40 years: 718 patients  
- 41–50 years: 698 patients  
- 51–60 years: 685 patients  
- 61–70 years: 687 patients  
- 71–80 years: 731 patients  
- 81–90 years: 581 patients

7️⃣ Retrieve a list of patients whose contact numbers end with "1234" and display their names in uppercase.  
Only one patient has a contact number ending in 1234.  
The patient's name is PATIENT_1234.  
Their contact number is 98765431234.

8️⃣ Find patients who have only been prescribed "Insulin" in any of their diagnoses.  
A total of 252 patients have been prescribed only "Insulin" in all their diagnoses.  
No other medications have been prescribed to these patients.

9️⃣ Calculate the average duration (in days) for which medications are prescribed for each diagnosis.  
The highest average prescription duration is 1,080 days for Flu (Diagnosis ID: 12103).  
The lowest average prescription duration is 0 days for Migraine (Diagnosis ID: 12300).  
Some records show a negative prescription duration due to incorrect start and end dates entered in the medication table.

🔟 Write a query to identify the doctor who has attended the most unique patients. Include the doctor’s name, specialization, and the count of unique patients.  
There is only one doctor who has attended the most unique patients: Doctor_37, specializing in General Medicine, with a total of 51 unique patients.

---

## 📢 Recommendations

- 🔧 Fix negative prescription durations and ensure complete diagnosis records.  
- 📋 Improve data entry protocols and ensure every appointment outcome is recorded properly.  
- 🩻 Encourage specialized doctors with lower diagnoses to take more patients.  
- 👴 Prioritize geriatric care services and targeted healthcare programs for senior citizens.  
- 👨‍⚕️ Increase the availability of specialists to meet demand and reduce patient wait times.  
- 🎯 Train other doctors based on successful patient management strategies used by high-performing doctors.

---
