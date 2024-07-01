hihi
# สร้าง Logic บน Python เพื่อใช้งานกับ API ข้อมูลพนักงาน #

## สร้าง Input
![image](https://github.com/pying-hathai/Projgit/assets/132686635/30ece01c-4105-4af4-82df-b3802ec4c1db)

## Logic 1 ใช้ Post ##
1. ตรวจสอบว่ามี user สร้างอยู่แล้วหรือไม่
2. ถ้าไม่มีให้ insert โดย function post

```
#main post

ip_email = gen_email(ip_fullname)
print(ip_email)
ip_status = check_status(ip_startdate,ip_enddate)
print(ip_status)

all_employee_data = get_req()
employee_IsContain_list = []
for i in all_employee_data:
    print(i['email'])
    if i['email'] == ip_email:
        employee_IsContain = 1  #มี userอยู่แล้ว flag 1
    else:
        employee_IsContain = 0  #ไม่มี user ให้ flag 0
    #print(employee_IsContain)
    employee_IsContain_list.append(employee_IsContain)

if sum(employee_IsContain_list) == 0:
    new_user_id = post_req(ip_fullname,ip_gender,ip_email,ip_status)
    print(new_user_id)
else:
    print('no user insert')
```

## Logic 2 ใช้ Put ##
แก้ไขชื่อใหม่
1. ตรวจสอบว่าชื่อเดิมมี user id อะไร
2. put request ชื่อ id นั้นเพื่อแก้ไขชื่อ
   
![image](https://github.com/pying-hathai/Projgit/assets/132686635/818aae9d-cf0a-4f43-b436-6eaeac560b19)

```
#main put 
#change name

edited_userid = find_edited_id(ip_old_fullname)

user_id = str(edited_userid)
ip_new_email = gen_email(ip_new_fullname)
ip_gender = get_req1(user_id)['gender']
ip_status = get_req1(user_id)['status']

new_info = put_req(user_id,ip_new_fullname,ip_new_email,ip_gender,ip_status)
print(new_info)
```

## Logic 3 ใช้ delete ##
ลบเมื่อ end date > 90 days
1. ตรวจสอบว่า มากกว่า 90 วันไหม
2. ลบ userid นั้น

```
from datetime import datetime

today = date.today()

# dates in string format
str_d1 = ip_enddate
str_d2 = today.strftime("%d-%m-%Y")

# convert string to date object
d1 = datetime.strptime(str_d1,"%d-%m-%Y")
d2 = datetime.strptime(str_d2, "%d-%m-%Y")

# difference between dates in timedelta
delta = d2 - d1
print(f'Difference is {delta.days} days')
```

```
#main delete
#delete when enddate > 90days

user_id = '6962393'

if delta.days > 90:
    del_req(user_id)
```


Ref. https://www.youtube.com/watch?v=6UxVC27n01M


