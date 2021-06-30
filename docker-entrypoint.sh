#!/bin/sh
echo '====^_^===='
echo '欢迎使用佰阅发卡(KAMIFAKA)程序'

echo ${DATABASE_URL}
# echo ${DATABASE_URL/postgres/postgresql\+psycopg2}
# echo $a | sed 's/postgres/postgresql\+psycopg2/'
# postgres://ooqvwiuhhrkpcs:938ae7d12ddce11b941a1070bcbab92006615d1b33df6cd4b3459bf7989585a7@ec2-34-202-54-225.compute-1.amazonaws.com:5432/dbt364afgkf42
if [ ${DB_TYPE} = 'Mysql' ];then
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'mysql+pymysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}\?charset=utf8mb4'|g" /usr/src/app/service/api/db.py
elif [ ${DB_TYPE} = 'PostgreSQL' ];then
   # sed -i 's|postgresql://|postgresql+psycopg2://|g' /usr/src/app/docker-entrypoint.sh
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'postgresql+psycopg2://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'|g" /usr/src/app/service/api/db.py
elif [ ${DB_TYPE} = 'PostgreSQL-Heroku' ];then
   # sed -i 's|postgresql://|postgresql+psycopg2://|g' /usr/src/app/docker-entrypoint.sh
#    sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'${DATABASE_URL}'|g" /usr/src/app/service/api/db.py
#    sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`'|g" /usr/src/app/service/api/db.py    # 成功
#    sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`|g" /usr/src/app/service/api/db.py
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|`echo ${DATABASE_URL/postgres/postgresql\+psycopg2}`|g" /usr/src/app/service/api/db.py
#    sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|`${DATABASE_URL/postgres/postgresql\+psycopg2}`|g" /usr/src/app/service/api/db.py    # 失败
fi

# 处理文件夹
if [ ! -d '/usr/src/app/public/images' ]; then
   mkdir /usr/src/app/public/images
fi

if [ ! -d '/usr/src/app/public/sql' ]; then
   mkdir /usr/src/app/public/sql
fi

if [ ! -d '/usr/src/app/public/backups' ]; then
   mkdir /usr/src/app/public/backups
fi

if [ ! -e '/usr/src/app/public/images/null.png' ]; then
    cp -a /usr/src/app/service/system/* /usr/src/app/public/images/
fi

# 然后初始化数据库
python init_mysql.py

# TG发卡后台任务
#python app_tg.py >/dev/null 2>&1 &

echo '程序初始化完成'
# ["gunicorn","-k", "gevent", "--bind", "0.0.0.0:8000", "--workers", "8", "app:app"]
# gunicorn -k gevent --bind 0.0.0.0:8000 --workers $(( 2 * `cat /proc/cpuinfo | grep 'core id' | wc -l` + 1 )) --log-level critical app:app
gunicorn -k gevent --bind 0.0.0.0:${PORT} --workers 4 app:app