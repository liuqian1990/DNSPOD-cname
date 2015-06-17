#!/bin/sh
cname_value=`nslookup $1 | grep 'c*name' | awk '{print $5}'`
#for i in {$2..$3}
for((i=$2;i<=$3;i++))
do
sub_domain=s$i.wssb
echo $sub_domain
#record_id=`curl -X POST https://dnsapi.cn/Record.List -d 'login_email=注册邮箱&login_password=密码&format=json&domain_id=DNSPOD的域名ID&sub_domain='$sub_domain'  2>&- | jq .records | grep id |  sed 's/"id"://g' | sed 's/ //g' | sed 's/"//g' | sed 's/,//g'`
record_id=`curl -X POST https://dnsapi.cn/Record.List -d 'login_email=注册邮箱&login_password=密码&format=json&domain_id=DNSPOD的域名ID&sub_domain='$sub_domain''  2>&- | jq .records | grep id |  sed 's/\"id\"://g' | sed 's/ //g' | sed 's/\"//g' | sed 's/,//g'`
echo $record_id
curl -X POST https://dnsapi.cn/Record.Modify -d 'login_email=注册邮箱&login_password=注册邮箱t&format=json&domain_id＝DNSPOD的域名ID&record_id='$record_id'&sub_domain='$sub_domain'&value='$cname_value'&record_type=CNAME&record_line=默认'
echo hello
done
