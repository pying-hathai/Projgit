วนหาค่าใน excel ตาม column\
การดึงตัวอักษรตั้งแต่ตำแหน่งที่ ip_index+1 ถึงก่อนตำแหน่งที่ ip_index+2

let text = "IJKLMNOPQRSTUVWXYZ";\
let result = text.substring(ip_index+1,ip_index+2);\
return result;\

I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z\
0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17

Result
text.substring(1,2)
"J"


-----------------------------------------------
