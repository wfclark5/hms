
CREATE TABLE user(
    id INT(6) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    password CHAR(60) NOT NULL,
    user_type VARCHAR(20) NOT NULL
);

###sets the default id value to 10001
ALTER TABLE user AUTO_INCREMENT=10001; 

CREATE TABLE pre_user(
    id INT(6) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    password CHAR(60) NOT NULL,
    user_type VARCHAR(20) NOT NULL
);

###sets the default id value to 10001
ALTER TABLE pre_user AUTO_INCREMENT=10001;

### Trigger to insert value from pre-user to user after checking user_type
DELIMITER $$
CREATE TRIGGER user_type_check 
    AFTER INSERT ON pre_user
    FOR EACH ROW 
BEGIN
    IF (NEW.user_type='Staff' OR NEW.user_type='Nurse' OR NEW.user_type='Doctor' OR NEW.user_type='Patient') THEN
    INSERT INTO user
   ( username,
     password,
     user_type)
   VALUES
   ( NEW.username,
     NEW.password,
     NEW.user_type );
     END IF;
     
END; $$
DELIMITER ;


### Trigger to delete from pre_user after deleting user from user table
DELIMITER $$
CREATE TRIGGER delete_on_pre_user 
    AFTER DELETE ON user
    FOR EACH ROW 
BEGIN
    DELETE from pre_user 
    WHERE pre_user.username = old.username;
END; $$
DELIMITER ;

### Required sample staff/admin entry to the system
INSERT INTO pre_user (username, password, user_type) VALUES('fahim', '123456', 'Staff');

INSERT INTO pre_user (username, password, user_type) VALUES('staff', '123456', 'Staff');
INSERT INTO pre_user (username, password, user_type) VALUES('nurse', '123456', 'Nurse');
INSERT INTO pre_user (username, password, user_type) VALUES('doctor', '123456', 'Doctor');
INSERT INTO pre_user (username, password, user_type) VALUES('patient', '123456', 'Patient');


### Trigger to check if the new inserted user type is - Staff,Doctor or Nurse (both capital and small letters are acceptable)

DELIMITER $$
CREATE TRIGGER user_type_check 
    AFTER INSERT ON pre_user
    FOR EACH ROW 
BEGIN
	IF (NEW.user_type='Staff' OR NEW.user_type='Nurse' OR NEW.user_type='Doctor' OR NEW.user_type='Patient') THEN
    INSERT INTO user
   ( username,
     password,
     user_type)
   VALUES
   ( NEW.username,
     NEW.password,
     NEW.user_type );
     END IF;
     
END; $$
DELIMITER ;


show triggers;
drop trigger user_type_check;




##Doctor Entity
CREATE TABLE doctor(
    did INT(6) UNSIGNED NOT NULL PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    mname VARCHAR(20),
    lname VARCHAR(20) NOT NULL,
    bdate DATE NOT NULL,
    adate DATE NOT NULL,
    gender VARCHAR(20) NOT NULL,
    rid INT(6) UNSIGNED NOT NULL,
    assigned_ward INT(6) UNSIGNED NOT NULL,
    FOREIGN KEY(rid) REFERENCES doctor(did)    
);

CREATE TABLE education_qualification(
    did INT(6) UNSIGNED NOT NULL,
    degree VARCHAR(20) NOT NULL,
    board VARCHAR(20) NOT NULL,
    year VARCHAR(20) NOT NULL,
    cgpa VARCHAR(20) NOT NULL,
    position VARCHAR(20) NOT NULL
);

CREATE TABLE experience(
    did INT(6) UNSIGNED NOT NULL,
    title VARCHAR(20) NOT NULL,
    dfrom DATE,
    dto DATE,
    organization VARCHAR(20) NOT NULL
);

INSERT INTO pre_user (username, password, user_type) VALUES('doctor', '123456', 'Doctor');
insert into doctor values(10007,'Fahim','Ahmed','Shakil', STR_TO_DATE('07-03-1972', '%d-%m-%Y'), 
STR_TO_DATE('1-01-2012', '%d-%m-%Y'), 'Male', 10007, 001);
insert into doctor values(10010,'Mahi','','Muddashir', STR_TO_DATE('07-03-1972', '%d-%m-%Y'), 
STR_TO_DATE('1-01-2012', '%d-%m-%Y'), 'Male', 10007, 001);
insert into education_qualification values(10007, 'SSC', 'Dhaka', '2000', '1st', '4th');
insert into education_qualification values(10007, 'HSC', 'Dhaka', '2002', '5.00', '1st');
insert into education_qualification values(10007, 'MBBS', 'Dhaka', '2008', '3.65', '2nd');
insert into education_qualification values(10010, 'SSC', 'Dhaka', '2000', '1st', '4th');
insert into education_qualification values(10010, 'HSC', 'Dhaka', '2002', '5.00', '1st');
insert into education_qualification values(10010, 'MBBS', 'Dhaka', '2008', '3.65', '2nd');

insert into experience values(10007, 'Senior Doctor', STR_TO_DATE('07-03-2012', '%d-%m-%Y'), 
STR_TO_DATE('07-03-2018', '%d-%m-%Y'), 'DMC');
insert into experience values(10010, 'Junior Doctor', STR_TO_DATE('07-03-2008', '%d-%m-%Y'), 
STR_TO_DATE('07-03-2010', '%d-%m-%Y'), 'DMC');
insert into experience values(10010, 'Senior Doctor', STR_TO_DATE('07-03-2011', '%d-%m-%Y'), 
STR_TO_DATE('07-03-2012', '%d-%m-%Y'), 'DMC');
insert into experience values(10010, 'Supreme Doctor', STR_TO_DATE('07-03-2013', '%d-%m-%Y'), 
STR_TO_DATE('07-03-2018', '%d-%m-%Y'), 'DMC');



##Nurse Entity


CREATE TABLE nurse(
    nid INT(6) UNSIGNED NOT NULL PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    mname VARCHAR(20),
    lname VARCHAR(20) NOT NULL,
    bdate DATE NOT NULL,
    adate DATE NOT NULL,
    gender VARCHAR(20) NOT NULL,
    sid INT(6) UNSIGNED NOT NULL,
    assigned_ward INT(6) UNSIGNED NOT NULL,
    FOREIGN KEY(sid) REFERENCES nurse(nid)    
);


##Patient Entity

CREATE TABLE patient(
    pid INT(6) UNSIGNED NOT NULL PRIMARY KEY,           
    fname VARCHAR(20) NOT NULL,                                             
    mname VARCHAR(20),                                  
    lname VARCHAR(20) NOT NULL,                                     
    bdate DATE NOT NULL,                                                            
    adate DATE NOT NULL,                                            
    mblnoOne VARCHAR(20),                                               
    mblnoTwo VARCHAR(20),                                                   
    gender VARCHAR(20) NOT NULL,                                                    
    streetno VARCHAR(20) NOT NULL,                                                      
    streetname VARCHAR(20) NOT NULL,                                                                        
    area VARCHAR(20) NOT NULL,                                              
    thana VARCHAR(20) NOT NULL,                                                 
    district VARCHAR(20) NOT NULL,                                                          
    pstreetno VARCHAR(20) NOT NULL,                                                         
    pstreetname VARCHAR(20) NOT NULL,                                               
    parea VARCHAR(20) NOT NULL,
    pthana VARCHAR(20) NOT NULL,
    pdistrict VARCHAR(20) NOT NULL,
    job VARCHAR(20) NOT NULL,
    deposit INT,
    admitted_ward INT(6) UNSIGNED NOT NULL    
);



##Ward Entity //this table needs to be modified later on
CREATE TABLE ward(
    wid INT(6) UNSIGNED NOT NULL PRIMARY KEY,                                             
    name VARCHAR(20) NOT NULL,
    rid INT(6) UNSIGNED NOT NULL,
    sid INT(6) UNSIGNED NOT NULL    
);

ALTER TABLE ward AUTO_INCREMENT=10001; 

CREATE TABLE bed(
    wid INT(6) UNSIGNED NOT NULL,
    bedNo INT,
    type VARCHAR(20)NOT NULL,
    rent INT,
    status VARCHAR(20) NOT NULL

);

create table bill(
    id varchar(20) not null unique,
    foreign key(id) references patient(id)
        on delete cascade,
    total_payable int(40),
    paid int(20)
);

create view bill_due as
select id , total_payable - paid as due
from bill;

create table report(
    id varchar(20) not null unique,
    foreign key(id) references patient(id)
        on delete cascade,
    pathology_report varchar(10000),
    radiology_report varchar(10000),
    imaging_report varchar(10000),
    payable_amount int(20)
);


CREATE TABLE patient(
    pid int,
    fname varchar(20) not null,
    lname varchar(20),
    gender varchar(6) not null,
    dob date not null,
    blood_group varchar(3),
    doc_id int,
    HNo varchar(10),
    street varchar(20),
    city varchar(16),
    state varchar(20),
    email varchar(30),
    Primary Key(pid));


CREATE TABLE Employee(
    empid int,
    fname varchar(20) not null,
    mname varchar(20),
    lname varchar(20),
    gender varchar(6) not null,
    emptype varchar(20) not null,
    Hno varchar(10),
    street varchar(20),
    city varchar(20),
    state varchar(20),
    date_of_joining date,
    email varchar(30),
    deptid int,
    since date,
date_of_birth date,
    PRIMARY key(empid));

CREATE TABLE department(
    deptid int,
    dname varchar(20) not null,
    dept_headid int(10),
    PRIMARY key(deptid));


CREATE table salary(
    etype varchar(20),
    salary float(20,2),
    PRIMARY key(etype));

CREATE TABLE nurse_assigned(
    nid int,
    countpatient int,
    PRIMARY KEY(nid),
     FOREIGN KEY(nid) REFERENCES employee(empid));

CREATE TABLE out_patient(
    pid  int,
    arrival_date date,
    disease varchar(40),
    PRIMARY key(pid,arrival_date),
    FOREIGN KEY(pid) REFERENCES patient(pid));

CREATE TABLE room(
    rid int,
    roomtype varchar(20),
    PRIMARY key(rid));


    CREATE TABLE in_patient(
    pid int,
    nid int,
    rid int,
    arrival_date date,
        discharge_date date,
        disease varchar(40),
        primary key(pid,arrival_date),
        FOREIGN key(pid) REFERENCES patient(pid),
        FOREIGN KEY(nid) REFERENCES employee(empid),
        FOREIGN key(rid) REFERENCES room(rid));


CREATE TABLE room_cost(
    roomtype varchar(20),
    rcost  int,
    PRIMARY KEY(rtype));

CREATE TABLE relative(
    pid int,
    rname varchar(30),
    rtype varchar(30),
    pno varchar(11),
    PRIMARY key(pid));


CREATE TABLE test(
    tid int,
    tname varchar(20),
    tcost float(10,2),
    primary KEY(tid));

CREATE TABLE hadtest(
    pid int,
    tid int,
    testdate date,
    PRIMARY KEY(pid,tid,testdate),
    FOREIGN KEY(pid) REFERENCES patient(pid),
    FOREIGN key(tid) REFERENCES test(tid));

CREATE TABLE medicine(
    mid int,
    mname varchar(40) not null,
    mcost float(20,2),
    PRIMARY key(mid));

CREATE TABLE had_medicine(
    pid int,
    mid int,
    med_date date,
    qty int,
    PRIMARY KEY(pid,mid,med_date),
    FOREIGN KEY(pid) REFERENCES patient(pid),
    FOREIGN KEY(mid) REFERENCES medicine(mid));


CREATE TABLE pt_phone(
    pid int,
    phoneno varchar(10),
    PRIMARY KEY(pid,phoneno),
    FOREIGN KEY(pid) REFERENCES patient(pid));


CREATE TABLE emp_phone(
    empid int,
    phoneno varchar(10),
    PRIMARY KEY(empid,phoneno));


CREATE TABLE bill(
    pid int,
    mcost float(20,2),
    tcost float(20,2),
    roomcharges float(20,2),
    othercharges float(20,2),
    billdate date,
    PRIMARY KEY(pid,billdate));
    
    
    CREATE TABLE employee_inactive(
    empid int,
    fname varchar(20) not null,
    mname varchar(20),
    lname varchar(20),
    gender varchar(6) not null,
    emptype varchar(20) not null,
    Hno varchar(10),
    street varchar(20),
    city varchar(20),
    state varchar(20),
    date_of_joining date,
    date_of_leaving date,
    email varchar(30),
    PRIMARY key(empid));

DELIMITER //
CREATE TRIGGER transfer_to_passive BEFORE DELETE ON employee 
FOR EACH ROW 
BEGIN 
      INSERT into employee_inactive
       SELECT empid,fname,mname,lname,gender,emptype,hno,street,city,state,date_of_joining,CURRENT_DATE,email FROM employee WHERE employee.empid=OLD.empid;
END;//
DELIMITER ;


DELIMITER //
CREATE TRIGGER  on_insertemployee_update_dept
AFTER INSERT ON employee 
for EACH ROW 
BEGIN 
SET @ab=(SELECT dept_headid FROM department WHERE department.deptid=NEW.deptid);
UPDATE department SET dept_headid=CASE
WHEN (@ab is NULL AND department.deptid=NEW.deptid)
THEN new.empid
else dept_headid
END;
END;//
DELIMITER ;


CREATE TABLE prev_department(
    empid int,
    deptid int,
    date_of_joining date,
    date_of_leaving date,
    PRIMARY KEY(empid,deptid,date_of_leaving));


DELIMITER //
CREATE TRIGGER transfer_to_prev_department AFTER UPDATE ON employee 
FOR EACH ROW 
BEGIN 
     IF NEW.deptid<>OLD.deptid THEN
     INSERT into prev_department  values(OLD.empid,OLD.deptid,OLD.since,CURRENT_TIMESTAMP);
     SET @ab=(SELECT dept_headid FROM department WHERE department.deptid=NEW.deptid);
     UPDATE department SET dept_headid=CASE
     WHEN (@ab is NULL)
     THEN new.empid
     else dept_headid
     END;
     SET @bb=(SELECT dept_headid FROM department WHERE department.deptid=OLD.deptid);
     
     IF OLD.empid=@bb THEN
     SET @gb=(SELECT empid FROM employee WHERE deptid=OLD.deptid);
     SET @mn=(SELECT MIN(since) FROM employee WHERE empid=@gb);
     SET @mm=(SELECT MIN(empid) FROM employee WHERE employee.since=@mn);
     UPDATE department SET dept_headid=@mm WHERE department.deptid=OLD.deptid;
     END IF;
     END IF;
END;//
DELIMITER ;


DELIMITER //
CREATE TRIGGER employee_on_delete AFTER DELETE ON employee 
FOR EACH ROW 
BEGIN 
     INSERT into prev_department  values(OLD.empid,OLD.deptid,OLD.since,CURRENT_TIMESTAMP);
    
     SET @bb=(SELECT dept_headid FROM department WHERE department.deptid=OLD.deptid);
     
     IF OLD.empid=@bb THEN
     SET @gb=(SELECT empid FROM employee WHERE deptid=OLD.deptid);
     SET @mn=(SELECT MIN(since) FROM employee WHERE empid=@gb);
     SET @mm=(SELECT MIN(empid) FROM employee WHERE employee.since=@mn);
     UPDATE department SET dept_headid=@mm WHERE department.deptid=OLD.deptid;
     END IF;
    
END;//
DELIMITER ;


INSERT INTO test VALUES(1,"X-RAY",100);
INSERT INTO test VALUES(2,"BLOOD TEST",300);
INSERT INTO test VALUES(3,"URINE TEST",100);
INSERT INTO test VALUES(4,"MRI SCAN",1200);
INSERT INTO test VALUES(5,"ENDOSCOPY",3000);
INSERT INTO test VALUES(6,"BIOPSY",3500);
INSERT INTO test VALUES(7,"ULTRASOUND",900);
INSERT INTO test VALUES(8,"CT-SCAN",1100);
INSERT INTO test VALUES(9,"CBC",350);
INSERT INTO test VALUES(10,"FLU TEST",1500);


INSERT INTO salary VALUES("DOCTOR",70000);
INSERT INTO salary VALUES("NURSE",25000);
INSERT INTO salary VALUES("RECEPTIONIST",20000);
INSERT INTO salary VALUES("ACCOUNTANT",15000);
INSERT INTO salary VALUES("CLEANER",14000);
INSERT INTO salary VALUES("SECURITY",12000);
INSERT INTO salary VALUES("AMBULANCE DRIVER",13000);


INSERT INTO medicine VALUES(1,"CROCINE",10);
INSERT INTO medicine VALUES(2,"ASPIRIN",8);
INSERT INTO medicine VALUES(3,"NAMOSLATE",8);
INSERT INTO medicine VALUES(4,"GLUCOSE",200);
INSERT INTO medicine VALUES(5,"TARIVID",80);
INSERT INTO medicine VALUES(6,"CANESTEN",12);
INSERT INTO medicine VALUES(7,"DICLOFENAC",18);
INSERT INTO medicine VALUES(8,"ANTACIDS",8);
INSERT INTO medicine VALUES(9,"VERMOX",40);
INSERT INTO medicine VALUES(10,"OVEX",25);
INSERT INTO medicine VALUES(11,"OMEE",35);
INSERT INTO medicine VALUES(12,"AVIL",4);
INSERT INTO medicine VALUES(13,"HIDRASEC",50);
INSERT INTO medicine VALUES(14,"UTINOR",80);
INSERT INTO medicine VALUES(15,"PARIET",8);
INSERT INTO medicine VALUES(16,"CIPROXIN",6);
INSERT INTO medicine VALUES(17,"CYPROSTAT",12);
INSERT INTO medicine VALUES(18,"ANDROCUR",80);
INSERT INTO medicine VALUES(19,"DESTOLIT",82);
INSERT INTO medicine VALUES(20,"URSOFALK",15);
INSERT INTO medicine VALUES(21,"ORS",7);
INSERT INTO medicine VALUES(22,"URSOGAL",20);
INSERT INTO medicine VALUES(23,"OMNI GEL",30);
INSERT INTO medicine VALUES(24,"DETTOL",45);
INSERT INTO medicine VALUES(25,"BETADINE",8);
INSERT INTO medicine VALUES(26,"LIVER-52",100);
INSERT INTO medicine VALUES(27,"METHYLPHENIDATE",12);
INSERT INTO medicine VALUES(28,"BETA-BLOCKER",90);
INSERT INTO medicine VALUES(29,"BENZODIAZEPINES",120);
INSERT INTO medicine VALUES(30,"Z-DRUG",150);
INSERT INTO medicine VALUES(31,"ANTIPSYCHOTIC",200);
INSERT INTO medicine VALUES(32,"SSRI-ANTIDEPRESSANT",250);
INSERT INTO medicine VALUES(33,"MAOI-DRUG",140);
INSERT INTO medicine VALUES(34,"BICASUL",1);
INSERT INTO medicine VALUES(35,"NASAL DECONGESTANTS",20);
INSERT INTO medicine VALUES(36,"EXPECTORANTS",10);
INSERT INTO medicine VALUES(37,"COUGH SUPRESSANTS",60);
INSERT INTO medicine VALUES(38,"ANTI HISTAMINES",40);
INSERT INTO medicine VALUES(39,"ACETAMINOPHEN",60);
INSERT INTO medicine VALUES(40,"HPV VACCINE",140);
INSERT INTO medicine VALUES(41,"SYRINGE",3);
INSERT INTO medicine VALUES(42,"INJECTION",10);
INSERT INTO medicine VALUES(43,"MORFIN",5);
INSERT INTO medicine VALUES(44,"ORLISTAT",10);
INSERT INTO medicine VALUES(45,"ZALASTA",85);
INSERT INTO medicine VALUES(46,"ZANTAC",84);
INSERT INTO medicine VALUES(47,"ZEFFIX",82);
INSERT INTO medicine VALUES(48,"ZINNAT",100);
INSERT INTO medicine VALUES(49,"ZOFRAN",80);
INSERT INTO medicine VALUES(50,"ZOCOR",18);



DELIMITER //
CREATE TRIGGER update_nurse_assigned BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
IF NEW.emptype="NURSE" THEN
INSERT INTO nurse_assigned VALUES(New.empid,0);
end if;
end; //
DELIMITER ;



DELIMITER //
CREATE TRIGGER decrease_on_discharge BEFORE INSERT ON bill
FOR EACH ROW
BEGIN 
UPDATE room set isfree=0 WHERE rid=(SELECT rid FROM in_patient WHERE in_patient.pid=NEW.pid AND discharge_date is null);
UPDATE nurse_assigned SET countpatient=countpatient-1 WHERE nid=(SELECT nid FROM in_patient WHERE in_patient.pid=NEW.pid AND discharge_date is null);
END; //
DELIMITER ;


insert into department values(1,"ALLERGY",NULL);
insert into department values(2,"INTENSIVE CARE",NULL);
insert into department values(3,"ANESTHESIOLOGY",NULL);
insert into department values(4,"CARDIOLOGY",NULL);
insert into department values(5,"ENT",NULL);
insert into department values(6,"NEUROLOGY",NULL);
insert into department values(7,"ORTHOPEDICS",NULL);
insert into department values(8,"PATHOLOGY",NULL);
insert into department values(9,"RADIOLOGY",NULL);
insert into department values(10,"SURGERY",NULL);
insert into department values(11,"NURSE",NULL);
insert into department values(12,"ACCOUNTS",NULL);
insert into department values(13,"SECURITY",NULL);
insert into department values(14,"CLEANER",NULL);


ALTER TABLE employee ADD FOREIGN KEY(deptid) REFERENCES department(deptid) ON UPDATE CASCADE;


ALTER TABLE employee ADD FOREIGN KEY(emptype) REFERENCES salary(etype) ON DELETE RESTRICT;

DELIMITER //
CREATE TRIGGER delete_null_disease_from_outpatient AFTER INSERT ON bill
FOR EACH ROW
BEGIN 
#SET @bb=SELECT pid,arrival_date FROM out_patient WHERE out_patient.pid=NEW.pid AND arrival_date is NULL;
DELETE FROM out_patient WHERE  disease is NULL;
END; //
DELIMITER ;


CREATE TABLE doctor(
    doc_id int,
    qualification varchar(20),
    PRIMARY KEY(doc_id),
    FOREIGN KEY(doc_id) REFERENCES employee(empid) ON DELETE CASCADE);


-- DELIMITER $$
-- CREATE TRIGGER user_type_check 
--     AFTER INSERT ON pre_user
--     FOR EACH ROW 
-- BEGIN
--     IF (NEW.user_type='Staff' OR NEW.user_type='Nurse' OR NEW.user_type='Doctor' OR NEW.user_type='Patient') THEN
--     INSERT INTO user
--    ( username,
--      password,
--      user_type)
--    VALUES
--    ( NEW.username,
--      NEW.password,
--      NEW.user_type );
--      END IF;
     
-- END; $$
-- DELIMITER ;

-- DELIMITER $$
-- CREATE TRIGGER delete_on_pre_user 
--     AFTER DELETE ON user
--     FOR EACH ROW 
-- BEGIN
--     DELETE from pre_user 
--     WHERE pre_user.username = old.username;
-- END; $$
-- DELIMITER ;

-- DELIMITER $$
-- CREATE TRIGGER report_bill 
--     AFTER insert ON report
--     FOR EACH ROW 
-- BEGIN
--     update bill
--     set total_payable = total_payable + new.payable_amount
--     where bill.id = new.id;
-- END; $$
-- DELIMITER ;

-- DELIMITER $$
-- CREATE TRIGGER patient_bill 
--     AFTER insert ON patient
--     FOR EACH ROW 
-- BEGIN
--     insert into bill (id,total_payable,paid) values (new.id,0,0);
-- END; $$
-- DELIMITER ;

-- DELIMITER $$
-- CREATE TRIGGER user_delete 
--     AFTER delete ON user
--     FOR EACH ROW 
-- BEGIN
--     delete from patient where patient.id = old.username;
-- END; $$
-- DELIMITER ;