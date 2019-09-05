#! /bin/sh
cd ${VENDORS}
if [ ! -e "init.lock" ]
then
	cd ${VENDORS}
	sed -i "s/DIY-PORT/"${PORT}"/g" ${VENDORS}/config.json
	sed -i "s/DIY-AC/"${ADMIN_EMAIL}"/g" ${VENDORS}/config.json
	sed -i "s/DIY-DB-SERVER/"${DB_SERVER}"/g" ${VENDORS}/config.json
	sed -i "s/DIY-DB-NAME/"${DB_NAME}"/g" ${VENDORS}/config.json
	sed -i "s/DIY-DB-PORT/"${DB_PORT}"/g" ${VENDORS}/config.json
	cp ${VENDORS}/config.json ${HOME}
	cp ${VENDORS}/config.json ${HOME}/../
	# sed -i "s/DIY-PORT/3000/g" config.json
	# sed -i "s/DIY-AC/me@jinfeijie.cn/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-SERVER/mongo/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-NAME/yapi/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-PORT/27017/g" ${VENDORS}/config.json
	# yapi install -v 1.5.6
	yarn install-server
	touch init.lock
fi

cd ${VENDORS}
# 先判断有没有CMD指定路径
if [ $1 ]
then
	node $i
else
	node server/app.js
fi
