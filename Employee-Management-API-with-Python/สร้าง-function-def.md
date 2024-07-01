# สร้าง function def 

## สร้าง connection และ authorize ไปที่ API ##
```
!pip install requests
import requests
import random
import json
import string

import datetime
#from datetime import datetime

base_url = 'https://gorest.co.in'

#Auten_token
authen_token = 'Bearer xxxx'
```

## สร้าง function get_request
```
#get_request
def get_req():
    get_url = base_url + '/public/v2/users/'
    headers = {'Authorization': authen_token}
    res = requests.get(get_url, headers=headers)  #respone code<Response [200]>
    json_data = res.json()                        #ข้อมูลในรูปแบบ jason
    
    json_str = json.dumps(json_data, indent=4)    #ข้อความเมื่อ error
    assert res.status_code == 200,json_str        #ถ้าไม่เท่ากับ 200, แสดงข้อความ error
    
    return json_data
```

## สร้าง function get_request 1 user id
```
#get_request 1 user
#ex. get_req1('6957476')

def get_req1(ip_user_id):
    get_url = base_url + '/public/v2/users/' + ip_user_id
    headers = {'Authorization': authen_token}
    res = requests.get(get_url, headers=headers)  #respone code<Response [200]>
    json_data = res.json()                        #ข้อมูลในรูปแบบ jason
    
    json_str = json.dumps(json_data, indent=4)    #ข้อความเมื่อ error
    assert res.status_code == 200,json_str        #ถ้าไม่เท่ากับ 200, แสดงข้อความ error
    
    return json_data
```

## สร้าง function post_request 
## insert
```
def post_req(ip_fullname,ip_gender,ip_email,ip_status):
    post_url = base_url + '/public/v2/users/'
    headers = {'Authorization': authen_token}
        
    data = {
      'name': ip_fullname,
      'email': ip_email,
      'gender': ip_gender,
      'status': ip_status}
    res = requests.post(post_url, json=data, headers=headers) #คืนค่า code success หรือ unsuccess
    json_data = res.json()     #คืนค่าข้อมูลที่ update แล้ว
    
    json_str = json.dumps(json_data, indent=4)
    #ถ้าไม่เท่ากับ 201, แสดงข้อความ error
    assert res.status_code == 201, json_str
    assert json_data['name'] == data['name'], 'Name not correct'

    user_id = json_data['id']
    
    return user_id
```

## สร้าง function put_request
## update/edit
```
def put_req(user_id,new_name,new_email,new_gender,new_status):
    put_url = base_url + '/public/v2/users/' + user_id
    headers = {'Authorization': authen_token}
    data = {
      'name': new_name,
      'email': new_email,
      'gender': new_gender,
      'status': new_status
    }
    res =  requests.put(put_url, json=data, headers=headers)
    json_data = res.json()
    
    json_str = json.dumps(json_data, indent=4)
    assert res.status_code == 200, json_str
    assert json_data['name'] == data['name'], 'Name not correct'
    
    user_id = json_data['id']
    
    return user_id
```

## สร้าง function delete_request

```
#delete_request
#user_id = '6852053'

def del_req(user_id):
    del_url = base_url + '/public/v2/users/' + user_id
    headers = {'Authorization': authen_token}

    res = requests.delete(del_url, headers=headers)
    
    #json_str = res.dumps(json_data, indent=4)
    assert res.status_code == 204
    
    return res.status_code
```

## สร้าง function สร้าง email จากชื่อจริง นามสกุล

```
def gen_email(ip_fullname):
    domain_email = '@corpabc.co.th'
    name_list = ip_fullname.split(' ')[0],ip_fullname.split(' ')[1][0]
    ip_email = '.'.join(name_list) + domain_email
    return ip_email
```

## สร้าง function ตรวจสอบ status
```
def check_status(ip_startdate,ip_enddate):
    present = datetime.datetime.today()
    ip_startdate2 = datetime.datetime.strptime(ip_startdate, "%d-%m-%Y")
    ip_enddate2 = datetime.datetime.strptime(ip_enddate, "%d-%m-%Y")
    
    #วันปัจจุบัน มากกว่าเท่ากับ ถ้าวันเริ่มงาน - True(active)
    status_start_boolean = present.date() >= ip_startdate2.date()  
    
    #วันปัจจุบัน น้อยกว่า วันสิ้นสุดงาน - True(active)
    status_end_boolean = present.date() < ip_enddate2.date()    

    if present.date() >= ip_startdate2.date() and present.date() < ip_enddate2.date():
        status = 'active'
    else:
        status = 'inactive'

    return status
```

## สร้าง function ตรวจสอบชื่อเดิม

```
def find_edited_id(ip_fullname):
    #หา user_id ที่จะแก้ จาก ชื่อเดิม 
    all_employee_data = get_req()
    employee_list = []
    for i in all_employee_data:
        #print(i['name'])
        if i['name'] == ip_fullname:
            employee_IsContain = 1  #มี userอยู่แล้ว flag 1
            ip_user_id = i['id']
        else:
            employee_IsContain = 0  #ไม่มี user ให้ flag 0
        employee_list.append(employee_IsContain)
    print(ip_user_id)
    
    return ip_user_id
```

