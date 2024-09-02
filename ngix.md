upstream keycloak {
    server 192.168.29.150:9090;
}

server {
    listen 443 ssl http2;
    server_name keycloak.local;
    ssl_certificate      /etc/ssl/certs/keycloak.crt;
    ssl_certificate_key  /etc/ssl/private/keycloak.key;
    ssl_ciphers          HIGH:!aNULL:!MD5;
    ssl_protocols        TLSv1 TLSv1.1 TLSv1.2;
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_pass http://keycloak.local;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}


server {
    listen 80;
    listen [::]:80;
    server_name  keycloak.local;

    return 301 https://keycloak.local$request_uri;
}
