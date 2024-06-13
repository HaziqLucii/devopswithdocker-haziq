what I did was:

- create new Dockerfile to create new image based on the example-backend, to change the ENV REQUEST_ORIGIN to fix the CORS error.

- then i changed the backend service in the image, to the new image I created based on the new Dockerfile in the docker-compose.yaml.
