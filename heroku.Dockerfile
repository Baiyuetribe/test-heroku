FROM baiyuetribe/kamifaka:latest
LABEL 维护者="佰阅 2894049053@qq.com"

# 备选数据库Sqlite \Mysql \ PostgreSQL
ENV DB_TYPE='PostgreSQL-Heroku'

# WORKDIR /usr/src/app

# COPY docker-entrypoint.sh docker-entrypoint.sh
# RUN sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`'|g" /usr/src/app/service/api/db.py    # 成功
# RUN 
# RUN chmod +x docker-entrypoint.sh
# 删除第十行，然后第九行写入内容
RUN cat <<EOF > docker-entrypoint.sh\n\
#!/bin/sh
echo '====^_^===='\n\
echo '欢迎使用佰阅发卡(KAMIFAKA)程序'\n\
\n\
\n\
# postgres://ooqvwiuhhrkpcs:938ae7d12ddce11b941a1070bcbab92006615d1b33df6cd4b3459bf7989585a7@ec2-34-202-54-225.compute-1.amazonaws.com:5432/dbt364afgkf42
if [ ${DB_TYPE} = 'Mysql' ];then\n\
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'mysql+pymysql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}\?charset=utf8mb4'|g" /usr/src/app/service/api/db.py\n\
elif [ ${DB_TYPE} = 'PostgreSQL' ];then\n\
   # sed -i 's|postgresql://|postgresql+psycopg2://|g' /usr/src/app/docker-entrypoint.sh
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'postgresql+psycopg2://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'|g" /usr/src/app/service/api/db.py\n\
elif [ ${DB_TYPE} = 'PostgreSQL-Heroku' ];then\n\
   sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`'|g" /usr/src/app/service/api/db.py\n\
fi\n\
\n\
# 处理文件夹
if [ ! -d '/usr/src/app/public/images' ]; then\n\
   mkdir /usr/src/app/public/images\n\
fi\n\
\n\
if [ ! -d '/usr/src/app/public/sql' ]; then\n\
   mkdir /usr/src/app/public/sql\n\
fi\n\
\n\
if [ ! -d '/usr/src/app/public/backups' ]; then\n\
   mkdir /usr/src/app/public/backups\n\
fi\n\
\n\
if [ ! -e '/usr/src/app/public/images/null.png' ]; then\n\
    cp -a /usr/src/app/service/system/* /usr/src/app/public/images/\n\
fi\n\
\n\
# 然后初始化数据库
python init_mysql.py\n\
# TG发卡后台任务
#python app_tg.py >/dev/null 2>&1 &
echo '程序初始化完成'\n\
# ["gunicorn","-k", "gevent", "--bind", "0.0.0.0:8000", "--workers", "8", "app:app"]
# gunicorn -k gevent --bind 0.0.0.0:8000 --workers $(( 2 * `cat /proc/cpuinfo | grep 'core id' | wc -l` + 1 )) --log-level critical app:app
gunicorn -k gevent --bind 0.0.0.0:${PORT} --workers 4 app:app\n\
EOF


# # RUN sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'${DATABASE_URL/'postgres'/'postgresql+psycopg2'}'|g" /usr/src/app/service/api/db.py && \
# #     sed -i '$d' docker-entrypoint.sh && \
# #     # echo "gunicorn -k gevent --bind 0.0.0.0:${PORT} --workers 4 app:app" >> docker-entrypoint.sh && \
# #     echo "gunicorn -k gevent --bind 0.0.0.0:8000 --workers 4 app:app" >> docker-entrypoint.sh && \
# #     sed -i 's|8000|$PORT|g' docker-entrypoint.sh && \
# #     chmod +x docker-entrypoint.sh

# sed -i 'N;1i45' n.sh

# sed -i 'N;1i"sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`'|g" /usr/src/app/service/api/db.py"' n.sh


EXPOSE $PORT

ENTRYPOINT [ "/usr/src/app/docker-entrypoint.sh" ]

