Spring with keycloak
---------------
https://www.baeldung.com/spring-boot-keycloak#:~:text=Keycloak%20offers%20features%20such%20as,using%20the%20Spring%20Security%20OAuth2.

#vscode with spring
To install, launch VS Code and from the Extensions view (Ctrl+Shift+X), search for vscode-spring-initializr.

Once you have the extension installed, open the Command Palette (Ctrl+Shift+P) and type Spring Initializr to start generating a Maven or Gradle project and then follow the wizard.

Spring Initializr extension allows you to add dependencies after generating a new Spring Boot project.Navigate to your pom.xml file and right-click to select Add starters.

In addition to using F5 to run your application, there's the Spring Boot Dashboard extension, which lets you view and manage all available Spring Boot projects in your workspace as well as quickly start, stop, or debug your project.

https://localhost:8443/realms/test/account/

#steps

Create realm - quantum
create client- login-app
redirect URI- http://localhost:9090
              https://192.168.68.128:8443

create role: user
create user:test  Test@1234
client scope: click on roles->Include in token scope(ON)
              Mappers tab click on Realm Roles->Add to userinfo is On

Generating Access Tokens With Keycloak’s API
--------------------------------- postman


https://192.168.68.128:8443/realms/quantum/protocol/openid-connect/token

POST -x-www-form-urlencoded format:  Bulk 

client_id:login-app
username:test
password:Test@1234
grant_type:password

{
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJIcUI5QXhHWDJLZG5qQmxTQng1MHdScms4XzVCWXh4bURVdDRSSXJPTFFzIn0.eyJleHAiOjE3MjQzOTc0ODIsImlhdCI6MTcyNDM5NzE4MiwianRpIjoiZDk0ZmI2ZjYtNTI4MC00OTRkLWJiZDMtMDJhNWMwOGI5OGQ1IiwiaXNzIjoiaHR0cHM6Ly8xOTIuMTY4LjY4LjEyODo4NDQzL3JlYWxtcy9xdWFudHVtIiwiYXVkIjpbInJlYWxtLW1hbmFnZW1lbnQiLCJicm9rZXIiLCJhY2NvdW50Il0sInN1YiI6IjM2ZTc0YzE0LTg3OGYtNGZhMS1iMjI5LTg2NDFiODJiNmI1YiIsInR5cCI6IkJlYXJlciIsImF6cCI6ImxvZ2luLWFwcCIsInNpZCI6IjYxMjUwMGY2LTY5ZjItNDIwZi1iMzdlLTA3MTk5YzM0YTM2NiIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiaHR0cHM6Ly8xOTIuMTY4LjY4LjEyODo4NDQzIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwiZGVmYXVsdC1yb2xlcy1xdWFudHVtIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsicmVhbG0tbWFuYWdlbWVudCI6eyJyb2xlcyI6WyJpbXBlcnNvbmF0aW9uIiwiY3JlYXRlLWNsaWVudCJdfSwiYnJva2VyIjp7InJvbGVzIjpbInJlYWQtdG9rZW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWFwcGxpY2F0aW9ucyIsInZpZXctY29uc2VudCIsInZpZXctZ3JvdXBzIiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJkZWxldGUtYWNjb3VudCIsIm1hbmFnZS1jb25zZW50Iiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoidGVzdCB0ZXN0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoidGVzdCIsImdpdmVuX25hbWUiOiJ0ZXN0IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJjaGFuZHJhc2hla2hhci5rdW1hckBxbWFhc3RlY2guY29tIn0.qR2hgaiaf5UpNILN7mTIISL1sG6tUpYaECach6ycsDjizZZShzcPqIG2WuK-oiFNhb9opqdv-jpy-n6DYk1c-i7YrfqqJHceHRwwCs3UARZ0lMQ5BeuP7yAlWCbWkq1ecP32kmj8ymQFOOJelEh60jMMz7yAouHwFfeMiUN8vANKJZcByalGrNO8dHrwcgrgzDtzFkmGb5xQ-DJfoKrf0ugze6WtmgzVi_WE7ZxwAngy1oh4jV2E9HtAtT-UZofs460w9oqD6b2Z_WfgD2HmTwmuzhXFzyQwXJ4q92mY0D9hrGzLHoas_onef7gsxXOUf269t2lbtRmDBruXS5beUg",
    "expires_in": 300,
    "refresh_expires_in": 1800,
    "refresh_token": "eyJhbGciOiJIUzUxMiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIyZjU4OGU1Ni0yZGI0LTQ2M2QtYmNhNy0wZTZkZWNmZmEyYWQifQ.eyJleHAiOjE3MjQzOTg5ODIsImlhdCI6MTcyNDM5NzE4MiwianRpIjoiNTJiN2YzYzctZDBhZC00MjIzLThmOWItMmI2ODVlOWRiYWMyIiwiaXNzIjoiaHR0cHM6Ly8xOTIuMTY4LjY4LjEyODo4NDQzL3JlYWxtcy9xdWFudHVtIiwiYXVkIjoiaHR0cHM6Ly8xOTIuMTY4LjY4LjEyODo4NDQzL3JlYWxtcy9xdWFudHVtIiwic3ViIjoiMzZlNzRjMTQtODc4Zi00ZmExLWIyMjktODY0MWI4MmI2YjViIiwidHlwIjoiUmVmcmVzaCIsImF6cCI6ImxvZ2luLWFwcCIsInNpZCI6IjYxMjUwMGY2LTY5ZjItNDIwZi1iMzdlLTA3MTk5YzM0YTM2NiIsInNjb3BlIjoid2ViLW9yaWdpbnMgYWNyIHByb2ZpbGUgcm9sZXMgZW1haWwgYmFzaWMifQ.E0jgW2Tksul85M7jjfiX6wVrzl04uZaOwsbPNCELMmS1lNWFMUCzHJyMNVU1_Mowb9XfxzoFSTrmIRqoNEEFlQ",
    "token_type": "Bearer",
    "not-before-policy": 0,
    "session_state": "612500f6-69f2-420f-b37e-07199c34a366",
    "scope": "profile email"
}



