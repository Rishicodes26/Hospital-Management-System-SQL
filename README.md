# Hospital-Management-System-SQL
A relational database project built in PostgreSQL/pgAdmin 4 for managing hospital data and financial reporting.

# 🏥 Project Overview

This project is a comprehensive relational database solution designed to streamline hospital operations, including patient registration, doctor-department allocation, appointment scheduling, and billing management. Built using PostgreSQL, the system ensures data integrity through normalized table structures and complex constraints.

# 📊 Database Architecture (ERD)

The database follows a normalized relational model to minimize redundancy and ensure referential integrity.

Key Entities:

1. Departments: Manages hospital wings (e.g., Cardiology, Neurology).
2. Doctors: Stores practitioner details linked to specific departments via Foreign Keys.
3. Patients: Maintains demographic data with age-validation constraints.
4. Appointments: The central junction table connecting patients and doctors.
5. Bills: Handles financial records linked directly to specific appointments.

# 🛠️ Technical Implementation

1. Data Integrity & Constraints

   a) Implemented Primary Keys and Foreign Keys to maintain relational links.
   b) Used CHECK Constraints to prevent invalid data (e.g., negative patient age).
   c) Applied ON DELETE SET NULL/CASCADE rules to handle data deletion gracefully.

2. Advanced SQL Features
   
   a) Joins: Utilized INNER JOIN and LEFT JOIN to consolidate data across five tables for reporting.
   b) Views: Created a front_desk_dashboard to abstract complex join logic for end-users.
   c) Aggregations: Built revenue reports using SUM, COUNT, and GROUP BY functions.

# 🔧 Tools Used

  1. Database: PostgreSQL
  2. Management: pgAdmin 4
  3. Modeling: dbdiagram.io
