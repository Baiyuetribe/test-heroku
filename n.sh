



sed -i "s|'# 处理文件夹'|'sed -i \"s\|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')\|'\${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'\|g\" /usr/src/app/service/api/db.py'|g" a.sh



sed -i "s|'\#\ 处理文件夹'|'niha'|g" a.sh


sed -i 's|\# 处理文件夹|'niha'|g' a.sh
