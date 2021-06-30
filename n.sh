



sed -i "s|'# 处理文件夹'|'sed -i \"s\|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')\|'\${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'\|g\" /usr/src/app/service/api/db.py'|g" a.sh



sed -i "s|'\#\ 处理文件夹'|'niha'|g" a.sh


sed -i 's|\# 处理文件夹|sed -i \"s\|\'sqlite:///\'+os.path.join\(SQL_PATH,\'kamifaka.db\'\)\|'\$\{DATABASE_URL/\'postgres\'/\'postgresql+psycopg2\'\}'\|g\" /usr/src/app/service/api/db.py|g' a.sh



sed -i \"s\|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')\|'\${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'\|g\" /usr/src/app/service/api/db.py


sed -i "s|\# 处理文件夹|'niha'|g" a.sh
sed -i "s|\# 处理文件夹|'niha'|g" a.sh

sed -i "s|\# 处理文件夹|sed -i \"s\|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')\|'\${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'\|g\" /usr/src/app/service/api/db.py|g" a.sh

sed -i "s|\# 处理文件夹|sed -i \"s\|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')\|'\${DATABASE_URL8}'\|g\" /usr/src/app/service/api/db.py|g" a.sh




sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'|g" /usr/src/app/service/api/db.py



sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|${DATABASE_URL/postgres'/'postgresql+psycopg2'}|g" /usr/src/app/service/api/db.py


${DATABASE_URL/postgres/postgresql+psycopg2}


sed -i 's|postgresql+psycopg2://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}|'${DATABASE_URL}'|g' /usr/src/app/docker-entrypoint.sh
sed -i 's|postgres://|postgresql+psycopg2://|g' /usr/src/app/docker-entrypoint.sh