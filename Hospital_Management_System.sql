DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    dept_id INT REFERENCES Departments(dept_id)
);

CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 0),
    gender VARCHAR(10)
);

CREATE TABLE Appointments (
    app_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patients(patient_id),
    doctor_id INT REFERENCES Doctors(doctor_id),
    app_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Scheduled'
);

CREATE TABLE Bills (
    bill_id SERIAL PRIMARY KEY,
    app_id INT REFERENCES Appointments(app_id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending'
);

INSERT INTO Departments (dept_name) VALUES ('Cardiology'), ('Neurology'), ('Pediatrics');

INSERT INTO Doctors (doctor_name, specialization, dept_id) VALUES 
('Dr. Smith', 'Cardiologist', 1),
('Dr. Jones', 'Neurologist', 2),
('Dr. Brown', 'Pediatrician', 3);

INSERT INTO Patients (first_name, last_name, age, gender) VALUES 
('Amit', 'Sharma', 45, 'Male'),
('Priya', 'Verma', 30, 'Female'),
('Rahul', 'Singh', 12, 'Male');

INSERT INTO Appointments (patient_id, doctor_id, app_date, status) VALUES 
(1, 1, '2026-03-01', 'Completed'),
(2, 2, '2026-03-02', 'Scheduled'),
(3, 3, '2026-03-03', 'Completed');

INSERT INTO Bills (app_id, amount, payment_status) VALUES 
(1, 1500.00, 'Paid'),
(3, 800.00, 'Pending');

SELECT 
    a.app_id,
    p.first_name || ' ' || p.last_name AS patient,
    d.doctor_name,
    b.amount,
    b.payment_status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN Bills b ON a.app_id = b.app_id;

SELECT 
    dept.dept_name, 
    COUNT(a.app_id) AS total_appointments
FROM Departments dept
LEFT JOIN Doctors d ON dept.dept_id = d.dept_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY dept.dept_name
ORDER BY total_appointments DESC;

SELECT 
    SUM(amount) AS total_pending_revenue
FROM Bills 
WHERE payment_status = 'Pending';

CREATE VIEW front_desk_dashboard AS
SELECT 
    a.app_date,
    p.first_name || ' ' || p.last_name AS patient_name,
    d.doctor_name,
    a.status,
    COALESCE(b.payment_status, 'No Bill') as billing
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN Bills b ON a.app_id = b.app_id;

SELECT * FROM front_desk_dashboard;

SELECT 
    d.doctor_name, 
    COUNT(a.app_id) AS total_appointments,
    SUM(COALESCE(b.amount, 0)) AS total_revenue_generated
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN Bills b ON a.app_id = b.app_id
GROUP BY d.doctor_name
ORDER BY total_revenue_generated DESC;