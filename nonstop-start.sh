#!/bin/bash

if [ $UID -ne 0 ] ;then echo "管理者権限で実行してください(sudo等)" ; exit ;fi

if [ ! -f /usr/local/bin/openfortivpn ];then
	( cd /tmp && \
	git clone https://github.com/adrienverge/openfortivpn && \
	cd openfortivpn && \
	aclocal && autoconf && automake --add-missing && \
	./configure && make && make install && \
	cd ../ && \
	rm -rf openfortivpn )
fi

if [ ! -f ./config ];then
	echo -n "ユーザー名(例:17sh_001) > "
	read name

	echo $name > config
	echo "ユーザー名を保存しました。次回から入力を省略します。"
fi

echo "以下にワンタイムパスワードを入力してください。"
echo "終了したいときは Ctrl-C を入力してください。"
openfortivpn 127.0.0.1:443 -u `cat ./config`
