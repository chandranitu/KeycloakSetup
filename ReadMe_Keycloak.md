#keycloak

docker pull jboss/keycloak
docker run -d -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak

http://localhost:8080/auth/






