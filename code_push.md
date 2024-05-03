<h2>Shorebird Workspace</h2>

[Document Shorebird](https://docs.shorebird.dev/)

<h2>Install the Shorebird CLI</h2>
  Mac/linux: <br/> 

    curl --proto '=https' --tlsv1.2 https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh -sSf | bash

if shorebird command do not install > add path ~/.shorebird/bin into file ~/.zshrc <br/>

  Windows: <br/>

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser # Needed to execute remote scripts
    iwr -UseBasicParsing 'https://raw.githubusercontent.com/shorebirdtech/install/main/install.ps1'|iex

<h2>Login Shorebird</h2>

  command: <br/>

    shorebird login

choose authenticator and login

## App flutter
<h2>init shorebird in app</h2>

  open terminal in app and run: <br/> 

   shorebird init


<h2>release new version on server shorebird</h2>

update release version in file pubspec.yaml in project

  command: <br/>

    shorebird release [platform] --flutter-version=[version_flutter]

upload new version to app store to public this release


  install to test:<br/>
  
    shorebird preview

select release version to install in device

<h2>push new update to server</h2>

  command:

    shorebird patch [platform] --release-version [version_release]

### flutter module

<h2>Init</h2>

  Open terminal in module flutter and run command:</br>
   
    shorebird init

<h2>Android setting</h2>

  create release: <br/>

    shorebird release aar --release-version  [version_release] --flutter-version=[version_flutter]
    
*** The release-version parameter needs to match the version of the Android app that uses this module (i.e., versionName+versionCode from the app's app/build.gradle file).

Embed the Flutter module Android app <br/>

  build.gradle <br/>

    repositories {
        google()
        mavenCentral()
         maven {
            // This is a relative path from this settings.gradle file to the
            // my_flutter_module/build/host/outputs/repo directory.
            url '../my_flutter_module/release'
        }
        maven {
            //url 'https://storage.googleapis.com/download.flutter.io'
            url 'https://download.shorebird.dev/download.flutter.io'
       }
    }
   <br/>

    dependencies {
    // ...
     releaseImplementation 'com.example.my_flutter_module:flutter_release:1.0'
    // ...
    }

  push new update: <br/>
    
    shorebird patch aar --release-version [version_release]

<h2>IOS setting</h2>

  create release: <br/>

    shorebird release ios-framework --release-version [version_release] --flutter-version=[version_flutter]

Embed the Flutter module IOS app <br/>

  add flutter module into app: <br/>
  
  ![plot](./assets/code_push/embed_flutter_module_into_project_ios.png)

  Embed & Sign: <br/>
  ![plot](./assets/code_push/embed_sign.png)

  push new update: <br/>
    
    shorebird patch ios-framework --release-version [version_release]