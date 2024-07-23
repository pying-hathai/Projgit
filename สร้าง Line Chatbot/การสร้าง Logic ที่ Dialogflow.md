### การสร้าง Logic ที่ Dialogflow.md

## Logic การสร้าง
![image](https://github.com/user-attachments/assets/efcb6bb9-d842-4898-8042-afc77939a060)

## สร้างหน้าเมนูหลัก
1. สร้าง Training phrases เพื่อเรียบรู้การรับค่าข้อมูล
   ![image](https://github.com/user-attachments/assets/9a619c2a-1c4a-4c89-9f4c-60cb81717cf8)

2. เมื่อได้รับ input เช่น ฉันต้องการเปลี่ยนรหัสผ่าน จะตั้งค่า Response แบบ Line-Card
   ![image](https://github.com/user-attachments/assets/7854915d-c76c-4455-98d6-c90242c605ee)

## เมื่อได้รับ Input คำว่า SAPGUI
1. สร้าง Training phrases เพื่อเรียบรู้การรับค่าข้อมูล
![image](https://github.com/user-attachments/assets/2217405a-2f83-4bef-bd9a-98b3e16976f7)

2. สร้าง Action and parameters <br />
$ นำหน้าparameter เพื่อเรียกใช้ parameter ที่อยู่ภายใน Intent<br />
'# นำหน้าparameter เพื่อเก็บค่า parameter
![image](https://github.com/user-attachments/assets/20668e80-dc7f-456e-934a-19022414bf6b)


## สร้าง flowup กรณี "No"
กรณีไม่ไช่ ให้ตั้งค่า Output Content = HomePasswordManager คือ ให้กลับไปที่ เมนูหลัก
![image](https://github.com/user-attachments/assets/38612267-bec1-42cb-9eb0-db524866bd20)

และตอบกลับว่า "กรุณากรอกใหม่ กลับสู่เมนูหลัก"
![image](https://github.com/user-attachments/assets/2160148a-1d1f-4c67-80e3-ab812e5e36c8)

## สร้าง flowup กรณี "Yes"
กรณีใช่ ให้ตั้งค่า Response ให้ตอบกลับทาง Line แบบ  Text response
![image](https://github.com/user-attachments/assets/7de6451e-dd28-4abd-b63b-1a0d8139322e)

