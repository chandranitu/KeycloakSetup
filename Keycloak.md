#Keycloak

https://medium.com/@disa2aka/docker-deployments-for-keycloak-and-postgresql-e75707b155e5
https://stackoverflow.com/questions/49859066/keycloak-docker-https-required
https://stackoverflow.com/questions/78071458/keycloak-docker-compose    working
https://www.mastertheboss.com/keycloak/secure-keycloak-with-https/
https://medium.com/keycloak/running-keycloak-with-tls-self-signed-certificate-d8da3e10c544

#keytool
# keycloak x

#tutorials
https://www.youtube.com/watch?v=zyqWpFUPTnE
https://www.youtube.com/watch?v=35bflT_zxXA&list=PLRTM7OTAxy3OcmFEZeIcRgyYBjFR9yNyT
--

## DONT keep PASSWORD as similar to user ##


--
# docker compose has changed in ubuntu 24
docker compose -f docker-compose-keyCloak.yml up -d

https://192.168.6http8.130:8081/
http://localhost:8080/

#keep something Other password beside similar to user
admin/Zaq12wsx



#-------------------
#download keycloak  25.0.2


#create certificate
openssl req -newkey rsa:2048 -nodes \
  -keyout keycloak-server.key.pem -x509 -days 365 -out keycloak-server.crt.pem
 

#start postgres -docker  ##15
docker run -d --name postgres15 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:15 postgres
docker exec -it 240e12e247a2 bash
psql -U postgres

 

#default client psql
#install pgcli for interactive

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


#download postgres driver
https://jdbc.postgresql.org/download/
42.7.3
/home/ckumar/postgres/lib/<driver>
--permission
chmod 777 postgresql-42.7.3.jar

#copy postgres.jar into <keycloak-Home>/lib/lib/deployment

#.bashrc 
export POSTGRES_HOME=/home/ckumar/postgres
export CLASSPATH=$POSTGRES_HOME/lib:$CLASSPATH

#ssl or HTTPS
#DEV 25.0.2
./bin/kc.sh start-dev --https-port=8081 --https-certificate-file=/home/ckumar/keycloak-server.crt.pem --https-certificate-key-file=/home/ckumar/keycloak-server.key.pem --db postgres --db-url-host localhost --db-username admin --db-password Admin@1234

./bin/kc.sh start-dev --https-port=8081 --http-port=8080 --https-certificate-file=/home/ckumar/keycloak-server.crt.pem --https-certificate-key-file=/home/ckumar/keycloak-server.key.pem --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008

#prod 25.0.2
./bin/kc.sh build 
./bin/kc.sh start --optimized
./bin/kc.sh show-config

./bin/kc.sh start --https-port=8081 --http-port=8080 --https-certificate-file=/home/ckumar/keycloak-server.crt.pem --https-certificate-key-file=/home/ckumar/keycloak-server.key.pem --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008 --hostname-strict false --proxy-headers forwarded  --https-client-auth=none

#prod 23.0.7
./bin/kc.sh start --https-port=8081 --http-port=8080 --https-certificate-file=/home/ckumar/keycloak-server.crt.pem --https-certificate-key-file=/home/ckumar/keycloak-server.key.pem --db postgres --db-url-host 127.0.0.1 --db-username admin --db-password Nji98uhb@1008 --hostname-strict false  --https-client-auth=none

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

#postman

https://localhost:8081

#themes
https://www.baeldung.com/spring-keycloak-custom-themes
./bin/kc.sh start --spi-theme-welcome-theme=custom-theme

#troubleshoot
Network response was not OK (ntp install)



#ubuntu
sudo apt --fix-broken install
sudo apt-get install ntp
sudo apt-get install --assume-yes ntpsec ntp   #working



