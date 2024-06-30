# ออกแบบ Database สำหรับจัดการข้อมูลพนักงาน #

hihi

## One to One ##
Table: emp_profile
```
CREATE TABLE `emp_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tel` int NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empcontact_empprofile_idx` (`emp_profile_id`),
  CONSTRAINT `fk_empcontact_empprofile` FOREIGN KEY (`emp_profile_id`) REFERENCES `emp_profile` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
![image](https://github.com/pying-hathai/Projgit/assets/132686635/8cff9f0d-00ec-42c4-95bc-85e8b4a78ecb)

### 2) emp_groupuser to profile_group ###

![image](https://github.com/pying-hathai/Projgit/assets/132686635/4ad579e0-00a5-40cc-9806-672771ed2310)

![image](https://github.com/pying-hathai/Projgit/assets/132686635/9aba6da5-a570-4657-bca7-6b48a9f79c3a)





