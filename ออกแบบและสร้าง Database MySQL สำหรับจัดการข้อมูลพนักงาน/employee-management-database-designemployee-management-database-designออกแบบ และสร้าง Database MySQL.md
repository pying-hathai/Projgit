# ออกแบบ Database สำหรับจัดการข้อมูลพนักงาน #

hihi
![image](https://github.com/user-attachments/assets/88fd6e1f-0d1a-4b67-95b6-1cb99d5e392c)


## One to One ##
Table: emp_profile
```
CREATE TABLE `emp_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nametitle` varchar(10) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `empusername` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dep_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emp_code_UNIQUE` (`empusername`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

```

Table: emp_contact
```
CREATE TABLE `emp_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tel` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `emp_profile_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empcontact_empprofile_idx` (`emp_profile_id`),
  CONSTRAINT `fk_empcontact_empprofile` FOREIGN KEY (`emp_profile_id`) REFERENCES `emp_profile` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

![image](https://github.com/pying-hathai/Projgit/assets/132686635/0a1fe8b6-d54b-4d4e-855c-1c34d138cf33)

![image](https://github.com/pying-hathai/Projgit/assets/132686635/0d429938-e67e-4f58-b242-e5e3d3d54fb1)

## One to Many ##


Table: Department information
```
CREATE TABLE `dep` (
  `id` int NOT NULL AUTO_INCREMENT,
  `depname` varchar(45) NOT NULL,
  `dep_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `depname_UNIQUE` (`depname`),
  KEY `fk_dep_empprofile` (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```


![image](https://github.com/pying-hathai/Projgit/assets/132686635/b34477d5-b273-4220-9963-ccb15a599658)

![image](https://github.com/pying-hathai/Projgit/assets/132686635/bfbbb7a0-9d0f-4e8c-bd09-507752a2da8b)

## Many to Many ##
![image](https://github.com/pying-hathai/Projgit/assets/132686635/0b820667-9412-4e6d-aaf8-6c0005c48131)

![image](https://github.com/pying-hathai/Projgit/assets/132686635/9aabcda5-c135-41b9-853c-44624dc227bd)

### สร้าง Relational table เพื่อเชื่อมความสัมพันธ์ One to Many 2 Table เข้าด้วยกัน ###
### 1) emp_profile to profile_group ###

Table: profile_group
```
CREATE TABLE `profile_groupuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emp_profile_id` int DEFAULT NULL,
  `emp_groupuser_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profile_groupuser_to_emp_profile_idx` (`emp_profile_id`),
  KEY `fk_profile_groupuser_to_emp_groupuser_idx` (`emp_groupuser_id`),
  CONSTRAINT `fk_profile_groupuser_to_emp_groupuser` FOREIGN KEY (`emp_groupuser_id`) REFERENCES `emp_groupuser` (`id`),
  CONSTRAINT `fk_profile_groupuser_to_emp_profile` FOREIGN KEY (`emp_profile_id`) REFERENCES `emp_profile` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```


![image](https://github.com/pying-hathai/Projgit/assets/132686635/8cff9f0d-00ec-42c4-95bc-85e8b4a78ecb)

### 2) emp_groupuser to profile_group ###

Table: emp_groupuser

```
CREATE TABLE `emp_groupuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupuser` varchar(45) NOT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

![image](https://github.com/pying-hathai/Projgit/assets/132686635/4ad579e0-00a5-40cc-9806-672771ed2310)

![image](https://github.com/pying-hathai/Projgit/assets/132686635/9aba6da5-a570-4657-bca7-6b48a9f79c3a)

### สร้าง Foreign key ###

สร้าง Foreign key แบบ ```Casecade``` - เมื่อ PK ถูกลบ FK จะถูกลบด้วย

Foreign key แบบ ```SET NULL``` - เมื่อ PK ถูกลบ FK จะเป็น Null

Foreign key แบบ ```RESTRICT``` - PK จะไม่ถูกลบเมื่อมี FK ห้อยตามอยู่

### Query1 ###
โจทย์: แสดง employee , department
```
select p.empusername, d.depname, d.dep_id
from emp_profile p
join dep d
on p.dep_id = d.id
```
![image](https://github.com/pying-hathai/Projgit/assets/132686635/66121bb2-5db8-41e4-a12b-c6d3e6f7c0c3)

### Query2 ###
โจทย์: แสดง employee , department และนับ จำนวนคณะ
```
select 
	d.depname as department_name,
	d.dep_id as department_id,
    count(p.empusername) as count_username,
    group_concat(p.empusername) as username
from dep d
join emp_profile p
on d.id = p.dep_id
group by d.depname;
```
![image](https://github.com/pying-hathai/Projgit/assets/132686635/5cb02486-000c-4cad-8212-c4c77fb62f88)


### Query3 ###
โจทย์: แสดงข้อมูลemp_codeและข้อมูลการติดต่อ

```
select p.nametitle, p.lastname, p.empusername, c.tel, c.email
from emp_profile p
join emp_contact c
on p.id = c.emp_profile_id;
```
![image](https://github.com/pying-hathai/Projgit/assets/132686635/bbcadf70-5678-4dad-ae8e-9a5248624c04)


