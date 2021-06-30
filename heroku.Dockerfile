FROM baiyuetribe/kamifaka:latest
LABEL 维护者="佰阅 2894049053@qq.com"

# 备选数据库Sqlite \Mysql \ PostgreSQL
ENV DB_TYPE='PostgreSQL'

# WORKDIR /usr/src/app

# COPY docker-entrypoint.sh docker-entrypoint.sh
# RUN sed -i "s|'sqlite:///'+os.path.join(SQL_PATH,'kamifaka.db')|'`echo $DATABASE_URL | sed 's/postgres/postgresql\+psycopg2/'`'|g" /usr/src/app/service/api/db.py    # 成功
# RUN 
# RUN chmod +x docker-entrypoint.sh
# 删除第十行，然后第九行写入内容
RUN sed -i "s|\'postgresql+psycopg2://\${DB_USER}:\${DB_PASSWORD}@\${DB_HOST}:\${DB_PORT}/\${DB_DATABASE}\'|\`echo \$DATABASE_URL \| sed \'s/postgres/postgresql\\\+psycopg2/\'\`|g" docker-entrypoint.sh && \
    sed -i '$d' docker-entrypoint.sh && \
    echo "gunicorn -k gevent --bind 0.0.0.0:\${PORT} --workers 4 app:app" >> docker-entrypoint.sh


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

