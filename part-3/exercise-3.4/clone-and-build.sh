#!/bin/bash

# loading spinner
spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep -w $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# prompting
read -p "Enter the GitHub repository URL: " GITHUB_REPO_URL
read -p "Enter your Docker Hub username: " DOCKER_HUB_USERNAME
read -s -p "Enter your Docker Hub password: " DOCKER_HUB_TOKEN

read -p "Enter your Docker Hub repository name: " DOCKER_HUB_REPO
read -p "Enter the Docker image tag (e.g., latest): " IMAGE_TAG

# Step 1: Clone the GitHub repository
echo "Cloning GitHub repository from $GITHUB_REPO_URL..."
git clone $GITHUB_REPO_URL

# Extract repository name from URL
REPO_NAME=$(basename $GITHUB_REPO_URL .git)

# Navigate to the cloned repository directory
cd $REPO_NAME || { echo "Failed to change directory to $REPO_NAME"; exit 1; }

# Step 2: Build the Docker image with a loading indicator
echo "Building Docker image $DOCKER_HUB_USERNAME/$DOCKER_HUB_REPO:$IMAGE_TAG..."
docker build -t $DOCKER_HUB_USERNAME/$DOCKER_HUB_REPO:$IMAGE_TAG . &
BUILD_PID=$!


# Show spinner while building
spinner $BUILD_PID
wait $BUILD_PID  # Wait for the build process to complete

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Docker build failed!"
  exit 1
fi

IMAGE_NAME="$DOCKER_HUB_USERNAME/$DOCKER_HUB_REPO:$IMAGE_TAG"

# Step 3: Push the Docker image to Docker Hub
echo "Pushing Docker image to Docker Hub..."
docker push $DOCKER_HUB_USERNAME/$DOCKER_HUB_REPO:$IMAGE_TAG

# Completion message
echo "Docker image $DOCKER_HUB_USERNAME/$DOCKER_HUB_REPO:$IMAGE_TAG has been successfully pushed to Docker Hub!"

# Run the container
docker run -e DOCKER_USER=$DOCKER_HUB_USERNAME \
  -e DOCKER_PWD=$DOCKER_HUB_TOKEN \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name $DOCKER_HUB_REPO \
  $IMAGE_NAME