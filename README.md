# README

###　モデル名 Task
| name | content | time_limit | rank | status | user_id |
| ---- | ---- | ---- | ---- | ---- | ---- |  
| string | text | datetim | integer | string | bigint |
#### user_idは外部キー

###　モデル名 User
| name | email | password | 
| ---- | ---- | ---- | 
| string | string | string | 
   
###　モデル名 Label  
| name | 
| ---- | 
| string | 

###　モデル名 Task_label_connection
| task_id | lavel_id | 
| ---- | ---- |  
| bigint | bigint | 
#### task_idとlavel_idは外部キー