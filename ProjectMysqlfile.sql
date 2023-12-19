create database hospital_portal;

use hospital_portal;

create table patients (
	         patient_id int not null unique primary key auto_increment,
             patient_name varchar(45) not null,
             age int not null,
             admission_date date,
             discharge_date date
);

create table Appointments (
             appointment_id int not null unique primary key auto_increment,
             patient_id int not null,
             doctor_id int not null,
             appointment_date date not null,
             appointment_time decimal(5,2) not null,
             foreign key (patient_id) references patients(patient_id),
             foreign key (doctor_id) references doctors(doctor_id)
);

select * from Appointments;

insert into patients (patient_name, age, admission_date, discharge_date)
            values ("Maria moon",35, "2023-10-15","2023-10-25"),
				   ("Will smith",50, "2023-10-09","2023-10-19"),
                   ("John cina",47, "2023-09-15","2023-10-11"),
                   ("John wick",34, "2023-10-01","2023-11-15");
                
select * from patients;//

delimiter //
create procedure appointment_scheduling (in p_patient_id int, in d_doctor_id int, in p_appointment_date date,
										in p_appointment_time decimal(5,2))

begin 
    insert into Appointments (patient_id, doctor_id, appointment_date, appointment_time)
	values (p_patient_id,d_doctor_id, p_appointment_date, p_appointment_time);

end //
delimiter ;

call appointment_scheduling(1,2,'2023-12-10',11.45);

delimiter //
create procedure dischargePatient (in p_patient_id int)
begin
    update patients set discharge_date = current_date()
    where patient_id = p_patient_id;
end //
delimiter ;

call dischargePatient(3);


create table doctors (
    doctor_id int not null primary key auto_increment,
    doctor_name varchar(20),
    specialist_in varchar(25)
);

select * from doctors;

insert into doctors (doctor_name, specialist_in)
           values ("Dr. Maria","neurology") , ("Dr. Author","orthopedics"), 
				  ("Dr. Grey","pediatrics"), ("Dr. Chen","otolaryngology");
           
create view ViewAppointments as
  select a.appointment_id, a.appointment_date, a.appointment_time, p.patient_id, d.doctor_id
  from Appointments a
  join patients p on a.patient_id = p.patient_id
  join doctors d on a.doctor_id = d.doctor_id;       

select * from  ViewAppointments;

create view ViewAllrecords as
  select a.appointment_id, a.appointment_date, a.appointment_time,p.patient_id,p.patient_name,p.age,
  p.admission_date, p.discharge_date,d.doctor_id, d.doctor_name,d.specialist_in
  from Appointments a
  join patients p on a.patient_id = p.patient_id
  join doctors d on a.doctor_id = d.doctor_id;


select * from ViewAllrecords;









