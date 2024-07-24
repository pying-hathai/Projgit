## Database ER.md
![image](https://github.com/user-attachments/assets/9706dcf9-191b-4d87-ae53-bd4bc1692797)

```

Table emp_contact {
  id int [PK]
  tel int [not null]
  email varchar [not null]
  emp_profile_id int
}

Table emp_profile {
  id int [PK]
  nametitle varchar [not null]
  firstname varchar [not null]
  lastname varchar [not null]
  empusername varchar [not null]
  created_at datetime [not null]
  dep_id int [not null]
}

Ref: "emp_contact"."emp_profile_id" - "emp_profile"."id"

Table dep {
  id int [PK]
  depname varchar [not null]
  dep_id int [unique]
}

Ref: "dep"."id" < "emp_profile"."dep_id"

Table profile_groupuser {
  id int [PK]
  emp_profile_id int [not null]
  emp_groupuser_id int [not null]
}

Table emp_groupuser {
  id int [PK]
  groupuser varchar [not null]
  startdate date
  enddate date
}


Ref: "emp_profile"."id" < "profile_groupuser"."emp_profile_id"

Ref: "emp_groupuser"."id" < "profile_groupuser"."emp_groupuser_id"
```
