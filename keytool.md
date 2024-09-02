#keytool #JRE import for https
https://stackoverflow.com/questions/25951602/adding-an-ssl-certificate-to-jre-in-order-to-access-https-sites
https://confluence.atlassian.com/kb/how-to-import-a-public-ssl-certificate-into-a-jvm-867025849.html


#keygeneration
keytool -genkeypair -alias mykey -keyalg RSA -keysize 2048 -keystore mykeystore.jks -validity 365
pass- key1234

#format default jks
keytool -genkeypair -alias mykey -keyalg RSA -keysize 2048 -keystore mykeystore.p12 -storetype PKCS12 -validity 365

#Verify the Key Pair and Certificate:
keytool -list -keystore mykeystore.jks

#view certificate details
keytool -v -list -alias mykey -keystore mykeystore.jks

#Exporting the Certificate
keytool -exportcert -alias mykey -file mycert.cer -keystore mykeystore.jks


#Importing a Certificate
keytool -importcert -alias mykey -file mycert.cer -keystore mykeystore.jks


#practice for keycloak #keytool

#working oracle java17
sudo keytool -import -trustcacerts -keystore /usr/lib/jvm/jdk-17.0.11/lib/security/cacerts -storepass changeit -noprompt -alias mykey -file /home/ckumar/keycloak.crt 

#update certificate
sudo update-ca-certificates
#openjdk 17 working
sudo keytool -import -trustcacerts -keystore /usr/lib/jvm/java-17-openjdk-amd64/lib/security/cacerts -storepass changeit -noprompt -alias mykey1 -file /home/ckumar/localhost.crt  


sudo keytool -delete -alias mykey -keystore /usr/lib/jvm/jdk-17.0.11/lib/security/cacerts
 
openssl s_client -connect localhost:443 -servername localhost>public1.crt

keytool -exportcert -alias mykey -file public1.cer -keystore mykeystore.jks 
keytool -importcert -file public1.crt -alias mykey -keystore mykeystore.jks


keytool -delete -alias <server_name> -keystore <JAVA_HOME>/lib/security/cacerts
 
  keytool -genkey -alias myKey -keystore store.jks

  keytool -delete -alias localhost -keystore /usr/lib/jvm/jdk-17.0.11/lib/security/cacerts
  passwd- changeit
  
  keytool -list -storepass changeit
  keytool -v -list -keystore /path/to/keystore

cp /home/ckumar/keycloak.key /usr/lib/jvm/jdk-17.0.11/lib/security

keytool -import -keystore /home/ckumar/keycloak.key -file /home/ckumar/keycloak.crt

openssl x509 -in /usr/lib/jvm/jdk-17.0.11/lib/security/cacerts -text -noout
cat /usr/lib/jvm/jdk-17.0.11/lib/security/cacerts 


