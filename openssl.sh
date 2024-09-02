#!/bin/bash

# Step 1: Generate CA private key and self-signed certificate
openssl genpkey -algorithm RSA -out ca_key.pem -aes256
openssl req -x509 -new -key ca_key.pem -out ca_cert.pem -days 365 -subj "/C=IN/ST=AP/L=HYD/O=quantum/OU=dev/CN=localhost"

# Step 2: Generate server private key
openssl genpkey -algorithm RSA -out server_key.pem -aes256

# Step 3: Generate CSR
openssl req -new -key server_key.pem -out server.csr -subj "/C=IN/ST=AP/L=HYD/O=quantum/OU=dev/CN=localhost"

# Step 4: Sign the CSR with the CA certificate
openssl x509 -req -in server.csr -CA ca_cert.pem -CAkey ca_key.pem -CAcreateserial -out server_cert.pem -days 365 -sha256

# Step 5: Verify the signed certificate
openssl verify -CAfile ca_cert.pem server_cert.pem

