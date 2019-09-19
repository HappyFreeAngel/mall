#设置私钥和keystore密码都是123456
rm -rf /tmp/ca
mkdir /tmp/ca
#制作RootCA证书
openssl req -newkey rsa:2048 -keyout /tmp/ca/myCA.key -passout pass:123456 -out /tmp/ca/myCA.csr -subj "/CN=My Test CA/O=Hand/C=CN"
openssl x509 -signkey /tmp/ca/myCA.key -passin pass:123456 -req -days 36500 -in /tmp/ca/myCA.csr -out /tmp/ca/myCA.cer -extensions v3_ca

#自签名Server证书
openssl req -newkey rsa:2048 -keyout server.key -passout pass:123456 -out server.csr -subj "/CN=minisrvr.local"
openssl x509 -req -in server.csr -out server.cer -CAkey /tmp/ca/myCA.key -passin pass:123456 -CA /tmp/ca/myCA.cer -days 3650 -CAcreateserial -CAserial server.serial

#合并证书链,导出为.p12证书
cat server.cer /tmp/ca/myCA.cer > client.cer
openssl pkcs12 -export -in client.cer -inkey server.key -passin pass:123456 -out keystore.p12 -name "My Server" -password pass:123456

#生成jks证书
keytool -importkeystore -v -srckeystore keystore.p12 -srcstoretype pkcs12 -srcstorepass 123456 \
-destkeystore keystore.jks -deststoretype jks -deststorepass 123456

#加入信任CA到keystore
#keytool -import -alias "My CA" -file /tmp/ca/myCA.cer -keystore keystore.jks
keytool -trustcacerts \
-keystore keystore.jks \
-storepass 123456 \
-noprompt \
-importcert -alias "My CA" \
-file /tmp/ca/myCA.cer

keytool -importkeystore -srckeystore keystore.jks -destkeystore keystore.jks -deststoretype pkcs12

#查看jks文件、cer文件
keytool -list -v -keystore keystore.jks
keytool -printcert -v -file client.cer