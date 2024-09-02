#Keycloak  keycloak x

https://medium.com/@disa2aka/docker-deployments-for-keycloak-and-postgresql-e75707b155e5
https://stackoverflow.com/questions/49859066/keycloak-docker-https-required
https://stackoverflow.com/questions/78071458/keycloak-docker-compose    working
https://www.mastertheboss.com/keycloak/secure-keycloak-with-https/
https://medium.com/keycloak/running-keycloak-with-tls-self-signed-certificate-d8da3e10c544

https://www.amarjanica.com/generate-https-certificate-for-a-local-domain-or-localhost  #final working
https://letsencrypt.org/docs/certificates-for-localhost/
https://github.com/jsha/minica

sudo apt install libnss3-tools    #pki

#Admin
https://www.baeldung.com/spring-boot-keycloak

#SSL
https://certbot.eff.org/instructions?ws=apache&os=ubuntufocal

#Key Generation-----------
#keytool
# OpenSSL
#ssh-keygen
#Cryptography Libraries

#tutorials
https://www.youtube.com/watch?v=zyqWpFUPTnE
https://www.youtube.com/watch?v=35bflT_zxXA&list=PLRTM7OTAxy3OcmFEZeIcRgyYBjFR9yNyT
--

## DONT keep PASSWORD as similar to user ##


--
# docker compose has changed in ubuntu 24
docker compose -f docker-compose-keyCloak.yml up -d

http://localhost:8080/
https://localhost:8081/
https://0.0.0.0:8443
https://192.168.68.154:8443
https://keycloak.local:8443
http://keycloak.local
https://192.168.68.128:8443/admin/master/console/
https://192.168.68.128:8443/admin/quantum/console/
https://192.168.68.128:8443/admin/icici/console/
https://192.168.68.128:8443/admin/hdfc/console/


#keep something Other password beside similar to user
admin/Zaq12wsx


#management console
https://0.0.0.0:9000/

#-------------------installation-------------------------------------
#download keycloak  25.0.2

#sudo apt install openjdk-17-jdk
sudo update-alternatives --config java

#create certificate  

check openssl.md first section

#update certificate
sudo update-ca-certificates


#start postgres -docker  ##15
docker run -d --name postgres15 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:15 postgres
docker exec -it f77d5fda19eb bash
psql -U postgres

 

#default client psql
#install pgcli for interactive shell

create database keycloak;
create user admin with encrypted password 'Nji98uhb@1008';
grant all privileges on database keycloak to admin;
GRANT CONNECT ON DATABASE keycloak TO admin;
GRANT pg_read_all_data TO admin;
GRANT pg_write_all_data TO admin;

\c keycloak 
# You are now connected to database "keycloak" as user "postgres".
GRANT ALL ON SCHEMA public TO admin;

#.env file  set in HOME
------------------
POSTGRES_DB=keycloak
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=Nji98uhb@1008

#correct /conf/keycloak.conf
copy paste keycloak.conf file

#download postgres driver
https://jdbc.postgresql.org/download/
42.7.3
/home/hadoop/postgres/lib/<driver>
--permission
chmod 777 postgresql-42.7.3.jar

#copy postgres.jar into <keycloak-Home>/lib/lib/deployment

Set path in .bashrc
#postgres lib 
export POSTGRES_HOME=/home/ckumar/postgres
export CLASSPATH=$POSTGRES_HOME/lib:$CLASSPATH

####DEV 25.0.2  ---#ssl or HTTPS 

./bin/kc.sh start-dev --https-port=8081 --http-port=8080 --https-certificate-file=/home/ckumar/keycloak.crt --https-certificate-key-file=/home/ckumar/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008


#working with nginx Proxy
./bin/kc.sh start-dev  --http-port=8080 --https-certificate-file=/home/ckumar/keycloak.crt --https-certificate-key-file=/home/ckumar/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 

#################PROD    25.0.2
./bin/kc.sh build 
./bin/kc.sh show-config

./bin/kc.sh start --optimized


#### https ssl certificate
./bin/kc.sh start --https-port=8081 --http-port=8080 --https-certificate-file=/home/ckumar/keycloak.crt --https-certificate-key-file=/home/ckumar/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 --hostname-strict false --proxy-headers forwarded  --https-client-auth=none    #working

####nginx working 09-Aug-2024
sudo ./bin/kc.sh start --http-port=9090 --https-port=443 --https-certificate-file=/home/hadoop/keycloak.crt --https-certificate-key-file=/home/hadoop/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 --hostname-strict false --proxy-headers forwarded  --https-client-auth=none

sudo ./bin/kc.sh start --http-port=9090  --https-certificate-file=/home/hadoop/keycloak.crt --https-certificate-key-file=/home/hadoop/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 --hostname-strict false --proxy-headers forwarded  --https-client-auth=none
https://0.0.0.0:8443
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=Nji98uhb@1008







#keytool certificate

-- convert mycert.cer into public.crt using https://www.sslchecker.com/certdecoder

./bin/kc.sh start --http-port=8080 --https-port=8081 --https-certificate-file=/home/ckumar/public.pem --https-certificate-key-file=/home/ckumar/mykeystore.jks --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 --hostname-strict false --proxy-headers forwarded  --https-client-auth=none




#--https-client-auth=<none|request|required>

#commands
./bin/kc.sh export --dir /home/ckumar
./bin/kc.sh import
./bin/kc.sh start --import-realm --hostname-strict false    # will import from data/import directory


--------------------------
---------------------------------
#KeyCloak tutorial
1. create user admin and password
create group
2. Assign role to user

https://localhost:8081/admin
https://localhost:8081/admin/master/console/   #users to login



#themes
https://www.baeldung.com/spring-keycloak-custom-themes
./bin/kc.sh start --spi-theme-welcome-theme=custom-theme

#troubleshoot
Network response was not OK (ntp install)



#ubuntu
sudo apt --fix-broken install
sudo apt-get install ntp
sudo apt-get install --assume-yes ntpsec ntp   #working

################################################################
#Authorization and authentication ---------------------------------------- postman curl
https://192.168.68.150:8443/realms/QUANTUM/account
https://192.168.68.130:8081/realms/ICICI/account
https://192.168.68.130:8081/realms/HDFC/account

https://192.168.68.150:8443/realms/test/account

https://192.168.68.130:8081/realms/QUANTUM/protocol/openid-connect/token

curl --location 'https://localhost:8443/realms/master/realms/QUANTUM/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=admin-cli' \
--data-urlencode 'username=chandra' \
--data-urlencode 'password=Mko09ijn'

curl -k https://localhost:8081/content-i-really-really-trust


#postman
https://www.baeldung.com/postman-keycloak-endpoints

chandra- Mko09ijn

make a env - keycloak
-----------------
server- https://192.168.68.154:8443
realm-QUANTUM
jwtClient-jwtClient
jwtClientSecret-jwtClientSecret

#get
https://localhost:8443/realms/master
https://192.168.68.111:8443/realms/master

https://localhost:8081/auth/realms/master/.well-known/openid-configuration
https://localhost:8081/realms/master/protocol/openid-connect/auth
https://localhost:8081/realms/master/protocol/openid-connect/auth?response_type=code&client_id=jwtClient


https://localhost:8443/realms/master/protocol/openid-connect/auth

#JRE import for https
https://stackoverflow.com/questions/25951602/adding-an-ssl-certificate-to-jre-in-order-to-access-https-sites
https://confluence.atlassian.com/kb/how-to-import-a-public-ssl-certificate-into-a-jvm-867025849.html

#openssl
openssl s_client -connect localhost:443 -servername localhost < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > localhost.crt   #working
openssl s_client -connect localhost:443

#decode
openssl x509 -in certificate.crt -text -noout

#save in public.crt and edit file and keep only begin certificate to end.
openssl s_client -connect localhost:443 -servername localhost>public.crt


