#!/bin/bash

# One-key proxy
linux_os=("Debian" "Ubuntu" "CentOS" "Fedora")
linux_update=("apt update" "apt update" "yum -y update" "yum -y update")
linux_install=("apt -y install" "apt -y install" "yum -y install" "yum -y install")
n=0
for i in "${linux_os[@]}"; do
	if [ "$i" == "$(grep -i PRETTY_NAME /etc/os-release | cut -d \" -f2 | awk '{print $1}')" ]; then
		break
	else
		n=$((n+1))
	fi
done

# Check if unzip is installed
if ! type -P unzip >/dev/null; then
	${linux_update[$n]}
	${linux_install[$n]} unzip
fi

# Check if curl is installed
if ! type -P curl >/dev/null; then
	${linux_update[$n]}
	${linux_install[$n]} curl
fi

# Check if screen is installed
if ! type -P screen >/dev/null; then
	${linux_update[$n]}
	${linux_install[$n]} screen
fi

# Check if libdbus-1-3 is installed
libdbus=$(ldconfig -p | grep libdbus-1.so.3 | wc -l)
if [ "$libdbus" == 0 ]; then
	${linux_update[$n]}
	${linux_install[$n]} libdbus-1-3
fi

cfwarp() {
	unset temp
	if [ "$ips" == 4 ]; then
		n=0
		iplist=100
		while true; do
			temp[$n]=$(echo 162.159.192.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 162.159.193.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 162.159.195.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 188.114.96.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 188.114.97.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 188.114.98.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo 188.114.99.$((RANDOM%256)))
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
		done
		while true; do
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 162.159.192.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 162.159.193.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 162.159.195.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 188.114.96.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 188.114.97.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 188.114.98.$((RANDOM%256)))
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo 188.114.99.$((RANDOM%256)))
				n=$((n+1))
			fi
		done
	else
		n=0
		iplist=100
		while true; do
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2)))])
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2)))])
			n=$((n+1))
			if [ "$n" -ge "$iplist" ]; then
				break
			fi
		done
		while true; do
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2)))])
				n=$((n+1))
			fi
			if [ "$(echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u | wc -l)" -ge "$iplist" ]; then
				break
			else
				temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2))):$(printf '%x\n' $((RANDOM*2+$RANDOM%2)))])
				n=$((n+1))
			fi
		done
	fi
	echo "${temp[@]}" | sed -e 's/ /\n/g' | sort -u > ip.txt
	./warp
	endpoint=$(awk -F, 'NR==2 {print $1}' result.csv)
	clear
	rm -rf ip.txt result.csv
}


if [ ! -f "warp.zip" ]
then
	curl -L https://www.baipiao.eu.org/warp.zip -o warp.zip
fi
clear
echo 1.梭哈模式
echo 2.清空缓存
echo -e 0.退出脚本'\n'
read -p "请选择模式(默认1):" mode
if [ -z "$mode" ]
then
	mode=1
fi
if [ $mode == 1 ]
then
	read -p "请选择WARP SOCKS5 服务端口(默认30000):" port
	if [ -z "$port" ]
	then
		port=30000
	fi
	read -p "请选择WARP连接模式IPV4或者IPV6(输入4或6,默认4):" ips
	if [ -z "$ips" ]
	then
		ips=4
	fi
	if [ $ips != 4 ] && [ $ips != 6 ]
	then
		echo 请输入正确的WARP连接模式
		exit
	fi
	rm -rf gost warp warp-cli warp-svc warp.sh ip.txt result.csv
	unzip warp.zip
	chmod +x warp warp-svc warp-cli gost
	screen -S warp-status -X quit
	./warp-cli disconnect
	sleep 3
	screen -S warp-svc -X quit
	screen -dmS warp-svc ./warp-svc
	screen -S gost -X quit
	screen -dmS gost ./gost -L=:$port
	echo 等待WARP-SVC完全启动
	sleep 3
	yes | ./warp-cli status
	if [ $(yes | ./warp-cli status | grep "Registration Missing" | wc -l) == 1 ]
	then
		echo 注册WARP客户端
		./warp-cli register
		echo WARP客户端已注册
	else
		echo WARP客户端已注册
		./warp-cli disconnect
	fi
	./warp-cli set-mode warp
	cfwarp
	echo 设置WARP端点为 $endpoint
	./warp-cli set-custom-endpoint $endpoint
	echo 启动WARP连接
	./warp-cli connect
	echo 进入WARP网络状态监测
	sleep 5
	while true
	do
		meta=$(curl -s https://speed.cloudflare.com/meta --connect-timeout 2 --max-time 3 | awk -F\" '{print $18"_"$22}')
		iswarp=$(echo $meta | awk -F_ '{print $1}')
		if [ "$iswarp" != "Cloudflare" ]
		then
			echo "$(date +'%H:%M:%S') 端点 $endpoint 发生故障"
			cfwarp
			echo 设置WARP端点为 $endpoint
			./warp-cli set-custom-endpoint $endpoint
			sleep 5
			starttime=$(date +%s)
		else
			echo "$(date +'%H:%M:%S') 端点 $endpoint 状态正常 数据中心 $(echo $meta | awk -F_ '{print $2}')"
			break
		fi
	done
elif [ $mode == 2 ]
then
	screen -S warp-status -X quit
	./warp-cli disconnect
	sleep 3
	screen -S warp-svc -X quit
	screen -S gost -X quit
	rm -rf gost warp warp-cli warp-svc warp.zip warp.sh ip.txt result.csv
	exit
else
	echo 退出成功
	exit
fi

cat>warp.sh<<EOF
#!/bin/bash
ips=$ips

function cfwarp(){
unset temp
if [ \$ips == 4 ]
then
	n=0
	iplist=100
	while true
	do
		temp[\$n]=\$(echo 162.159.192.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 162.159.193.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 162.159.195.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 188.114.96.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 188.114.97.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 188.114.98.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo 188.114.99.\$((\$RANDOM%256)))
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 162.159.192.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 162.159.193.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 162.159.195.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 188.114.96.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi

		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 188.114.97.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi

		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 188.114.98.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi

		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo 188.114.99.\$((\$RANDOM%256)))
			n=\$[\$n+1]
		fi
	done
else
	n=0
	iplist=100
	while true
	do
		temp[\$n]=\$(echo [2606:4700:d0::\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2)))])
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
		temp[\$n]=\$(echo [2606:4700:d1::\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2)))])
		n=\$[\$n+1]
		if [ \$n -ge \$iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo [2606:4700:d0::\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2)))])
			n=\$[\$n+1]
		fi
		if [ \$(echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge \$iplist ]
		then
			break
		else
			temp[\$n]=\$(echo [2606:4700:d1::\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2))):\$(printf '%x\n' \$((\$RANDOM*2+\$RANDOM%2)))])
			n=\$[\$n+1]
		fi
	done
fi
echo \${temp[@]} | sed -e 's/ /\n/g' | sort -u>ip.txt
./warp
endpoint=\$(cat result.csv | grep ms | head -1 | awk -F, '{print \$1}')
clear
rm -rf ip.txt result.csv
}

endpoint=$endpoint
while true
do
	meta=\$(curl -s https://speed.cloudflare.com/meta --connect-timeout 2 --max-time 3 | awk -F\" '{print \$18"_"\$22}')
	iswarp=\$(echo \$meta | awk -F_ '{print \$1}')
	if [ "\$iswarp" != "Cloudflare" ]
	then
		echo "\$(date +'%H:%M:%S') 端点 \$endpoint 发生故障"
		./warp-cli disconnect
		cfwarp
		echo 设置WARP端点为 \$endpoint
		./warp-cli set-custom-endpoint \$endpoint
		./warp-cli connect
		sleep 5
		starttime=\$(date +%s)
	else
		echo "\$(date +'%H:%M:%S') 端点 \$endpoint 状态正常 数据中心 \$(echo \$meta | awk -F_ '{print \$2}')"
		sleep 5
	fi
done
EOF
screen -S warp-status -X quit >/dev/null 2>&1
screen -dmS warp-status bash warp.sh
