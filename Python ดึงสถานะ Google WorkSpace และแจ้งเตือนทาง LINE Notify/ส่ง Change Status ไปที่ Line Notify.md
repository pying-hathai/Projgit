# ส่ง Change Status ไปที่ Line Notify.md

hihi

![aa](https://github.com/pying-hathai/Projgit/assets/132686635/bed1ff21-dae6-48be-af24-b9f4073053b5)

```
import requests

def linenoti(ip_msg,status):
    #linenoti('Yo!')
    token = 'xxxx'
    url = 'https://notify-api.line.me/api/notify'
    headers = {'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ' + token}
    msg = ip_msg
    if status == 'available':
        req = requests.post(url, headers=headers, data= {'stickerPackageId': 789, 'stickerId':10858, 'message':msg})
    else:
        req = requests.post(url, headers=headers, data= {'stickerPackageId': 4, 'stickerId':274, 'message':msg})
    
    #print(req)
```
