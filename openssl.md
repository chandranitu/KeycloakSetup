https://www.amarjanica.com/generate-https-certificate-for-a-local-domain-or-localhost

# Do changes in below file
/etc/hosts
127.0.0.1 localhost keycloak.local

#key generation
openssl req -x509 -out keycloak.crt -keyout keycloak.key -newkey rsa:2048 -nodes -sha256  -new -subj "/C=GB/CN=keycloak.local" \
                  -addext "subjectAltName = DNS:keycloak.local, DNS:localhost" \
                  -addext "certificatePolicies = 1.2.3.4" 

sudo chmod 644 keycloak.crt
sudo chown root:root keycloak.crt

sudo chmod 600 keycloak.key
sudo chown root:ssl-cert keycloak.key

sudo cp keycloak.crt /etc/ssl/certs/keycloak.crt
sudo cp keycloak.key /etc/ssl/private/keycloak.key

#install nginx
sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo ufw enable
sudo ufw allow OpenSSH

Create a config in /etc/sites-available and add a symlink to /etc/sites-enabled.
sudo mkdir -p /var/www/keycloak/html
sudo chown -R hadoop:hadoop /var/www/keycloak/html
sudo chmod -R 755 /var/www/keycloak

gedit /var/www/keycloak/html/index.html
<html>    <head>        <title>Welcome to keycloak!</title>    </head>    <body>        <h1>Success!  keycloak is working!</h1>    </body></html>

sudo gedit /etc/nginx/sites-available/keycloak
#paste nginx content

sudo ln -s /etc/nginx/sites-available/keycloak /etc/nginx/sites-enabled/  #optional

sudo gedit /etc/nginx/nginx.conf

sudo nginx -t
sudo systemctl daemon-reload
sudo systemctl restart nginx

sudo ufw allow 443/tcp
sudo ufw allow 8443/tcp
sudo ufw reload
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

Go to Chrome->Settings->Privacy and Security->Manage Certificates->Authorities->Find /etc/ssl/keycloak.crt and click to add it.

Go to Firefox->Settings->Privacy and Security->scroll down to Certificates->View Certificates->Authorities->import /etc/ssl/keycloak.crt .




Reload https://keycloak.local, no more warnings!


---------------------

openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

sudo cp localhost.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
ls /etc/ssl/certs/ | grep localhost

sudo keytool -importcert -file /home/ckumar/localhost.crt -keystore /etc/ssl/certs/java/cacerts -alias mykey

keytool error: java.io.IOException: Keystore was tampered with, or password was incorrect

certutil -A -n "My Cert" -t "CT,C,C" -i /home/ckumar/localhost.crt -d sql:$HOME/.pki/nssdb



----------------------

# Generate CA private key and self-signed certificate
openssl genpkey -algorithm RSA -out ca_key.pem -aes256
Enter PEM pass phrase:quantum

openssl req -x509 -new -key ca_key.pem -out ca_cert.pem -days 365 -subj "/C=IN/ST=AP/L=HYD/O=quantum/OU=dev/CN=localhost"
Enter pass phrase for ca_key.pem

# Generate server private key
openssl genpkey -algorithm RSA -out server_key.pem -aes256
Enter PEM pass phrase

# Generate CSR
openssl req -new -key server_key.pem -out server.csr -subj "/C=IN/ST=AP/L=HYD/O=quantum/OU=dev/CN=localhost"

# Sign the CSR with the CA certificate
openssl x509 -req -in server.csr -CA ca_cert.pem -CAkey ca_key.pem -CAcreateserial -out server_cert.pem -days 365 -sha256

# Verify the signed certificate
openssl verify -CAfile ca_cert.pem server_cert.pem
