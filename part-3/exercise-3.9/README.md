took a long while to solve this, always had problem exec /app/server not found. But fixed it by adding in the RUN line :

CGO_ENABLED=0 GOOS=linux
