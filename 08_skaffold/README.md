# README
Demonstrates how to configure skaffold to work with kind

[skaffold.dev](https://skaffold.dev/)  
  
Working with [local-cluster](https://skaffold.dev/docs/environment/local-cluster/)  

## Install Skaffold
Ensure that skaffold is installed 
```sh
brew install skaffold
```

## Build and Test Locally
Build and test the image
```sh
docker build -t test .        
docker run -it --rm --name test test 
docker stop test
```

## Prepare skaffold 
```sh
# Create a deployment then call init
skaffold init        
```

```sh

skaffold dev 
```