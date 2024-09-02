https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-22-04

#install Apache
sudo apt install apache2
sudo ufw allow "Apache Full"
sudo a2enmod ssl
sudo systemctl restart apache2
cd /etc/apache2/sites-available/

sudo cp 000-default.conf quantum.conf
sudo gedit quantum.conf

sudo a2ensite quantum.conf
service apache2 reload
https://certbot.eff.org/instructions?ws=apache&os=ubuntufocal


dscacheutil -flushcache

###################################################### Not working
#Generate a Private Key
openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048

#Certificate Signing Request
openssl req -new -key private.key -out request.csr

# Self-Signed Certificate
openssl x509 -req -days 365 -in request.csr -signkey private.key -out certificate.crt


#Combine the Private Key and Certificate
cat private.key certificate.crt > self_signed_certificate.pem

#Trust the Certificate
sudo cp certificate.crt /usr/local/share/ca-certificates/
OR
sudo cp certificate.crt /etc/ssl/certs/

#update certificate
sudo update-ca-certificates
#########################################################

sudo apt update
sudo apt install nginx

sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/nginx/dhparam.pem 2048

sudo gedit /etc/nginx/snippets/self-signed.conf
--Add below lines
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

sudo gedit /etc/nginx/snippets/ssl-params.conf
--Add below lines
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
ssl_ecdh_curve secp384r1;
ssl_session_timeout 10m;
ssl_session_cache shared:SSL:10m;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";

sudo gedit /etc/nginx/sites-available/keycloak
--Add below lines

server {
    listen 80;
    server_name localhost;  # Replace with your domain or localhost

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name localhost;  # Replace with your domain or localhost

    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;

    location / {
        proxy_pass http://localhost:8080;  # Keycloak default port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}


sudo ln -s /etc/nginx/sites-available/keycloak /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

#Step 5: Configure Keycloak for HTTPS (if needed)
Update Keycloak’s configuration to be aware of the HTTPS setup, especially if you’re using the proxy-address-forwarding option:
Edit the standalone.xml or standalone-ha.xml configuration file located in the keycloak/standalone/configuration directory:

<http-listener name="default" socket-binding="http" redirect-socket="https" proxy-address-forwarding="true"/>
<https-listener name="https" socket-binding="https" security-realm="UndertowRealm"/>

sudo systemctl restart keycloak




#ssl or HTTPS
#DEV 25.0.2
./bin/kc.sh start-dev  --http-port=8080 --https-certificate-file=/home/ckumar/keycloak.crt --https-certificate-key-file=/home/ckumar/keycloak.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008

./bin/kc.sh start-dev  --http-port=8080 --https-certificate-file=/etc/ssl/certs/nginx-selfsigned.crt --https-certificate-key-file=/etc/ssl/private/nginx-selfsigned.key --db postgres --db-url-host localhost --db-username admin --db-password Nji98uhb@1008     --not working


openssl req -x509 -out keycloak.crt -keyout keycloak.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")


https://letsencrypt.org/docs/certificates-for-localhost/
network.stricttransportsecurity.preloadlist
https://stackoverflow.com/questions/65101097/how-to-get-ssl-certificate-to-work-with-localhost-on-firefox



Here’re the List of Top 12 Cheap SSL Certificate Providers

Below are the cheap SSL certificate providers that are trusted all over the world:

    CheapSSLsecurity – A Cheapest SSL Certificate Reseller
    Comodo – Leading Brand of the Industry With Aggressive Pricing
    Sectigo – Trusted by Globally Leading Brands
    DigiCert – World’s Leading Provider of SSL/TLS Certificate
    GeoTrust – The First CA to Utilize DV (Domain Validated) SSL/TLS Certificate Method
    Thawte – Expert of SSL/TLS Certificate With Robust Authentication Process
    RapidSSL – Leading Provider of Domain Validated SSL/TLS Certificate
    SSL.com – The Publicly Trusted CA Expanding the Encryption Boundaries
    Network Solutions – One Giant Spinning Threads of SSL/TLS Certificate
    GoDaddy – Along With Web Hosting Integration of SSL/TLS Certificate Like a Spin
    GlobalSign – Impeccable SSL Security With Top-Notch Customer Support
    Entrust – One of the Slick SSL/TLS Certificate Provider



