# nodejs-mobile-cordova-builder
Build nodejs-mobile-cordova Application in Docker.

# Requirements
* Docker

# Installed dependencies
- Ubuntu@18.04
- NodeJS@10.13.0
- npm@latest
- Cordova@8.1.2
- sdkmanager
- Android 26
- Android Platform Tools
- Android Build Tools 28.0.3
- Android NDK r12b
- make;3.6.4111459

# How to
## Build Dockerfile
```
docker build . -t nodejs-mobile-cordova
```

## Run Builder Container
```
docker run -it --name nodejs-mobile-cordova -v $PWD/src/:/root/src/ nodejs-mobile-cordova
```

## Build Cordova App
```
# Add android for cordova
cordova platform add android

# Add nodejs-mobile-cordova
cordova plugin add nodejs-mobile-cordova
```

### edit local.properties
add `local.preperties` file directly under the cordova folder.

```
ndk.dir=/usr/local/ndk
sdk.dir=/usr/local/android-sdk-linux
```
