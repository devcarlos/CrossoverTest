# Jitensha

Jitensha is a Test Project for Crossover Application Process

#RELEASE 1.0
Updated Demo Project for CocoaPods and Fixes.

# 1. INSTALL AND CONFIGURE

1. Go to the `source/Jitensha` directory and install Cocoapods dependences
```
# cd source/Jitensha
# pod install
```

2. Open the `Jitensha.xcworkspace` project last Xcode version (7.3)
```
# open Jitensha.xcworkspace
```

3. Download the NodeJS application package and start a local server
```
# wget https://techtrial.s3.amazonaws.com/System/JitenshaBackEnd.zip
# unzip JitenshaBackEnd.zip
# cd JitenshaBackEnd
# npm install
# node server.js
```
4. If the server backend URL is not local go to the info.plist file on Xcode and update `API_BASE_URL` key with the correct URL
```
<key>API_BASE_URL</key>
<string>http://YOURSERVERHERE/api/v1/</string>
```

5. Build the Xcode project and start testing the Jitensha App `CRTL+R`

6. Build and Test the Xcode Unit Tests `CRTL+U`


# 2. ASSUMPTIONS

1. You are using the last Xcode version (7.3)
2. You have started a local or external NodeJS Server
3. You have installed the CocoaPods before Build the Xcode project

# 3. FEEDBACK

* You would be able to test the Jitensha project as long as the installations and assumptions are met.
