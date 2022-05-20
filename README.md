# Flutter Run Cat

<img src="https://user-images.githubusercontent.com/54878755/168307289-a311194e-e531-4502-914a-5aa80ae37b3a.gif" width=100%>

#### It's only for **linux**, System Monitor with `run cat` written by `Flutter`.

## Installation

```
sudo wget -qO- https://raw.githubusercontent.com/yoehwan/flutter_run_cat/main/install.sh | bash

```
### Build Binery

#### Requirement 

* flutter [linux](https://docs.flutter.dev/get-started/install/linux)
* appIndicator
    
```
 # for flutter-linux
 sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev

 # for appIndicator
 sudo apt install libappindicator3-dev gir1.2-appindicator3-0.1
```
#### build
```
 git clone https://github.com/yoehwan/flutter_run_cat.git
 cd flutter_run_cat
 flutter build linux
```


## Future Work
* Tray
    * Chart View 
* General
    * Runner - Hide Runner
    * ~~StartUp - Auto Launch~~
    * StartUp - Check Update 
* System Info (Running Here..)
    *  Show Menubar
    *  ~~Cpu~~
    *  ~~Memory~~
    *  ~~Bettery~~
    *  ~~HDD~~
    *  Ethernet & WIFI
* About
    * More Info
    * Update System
* Registration (Add Custom Image)

more more...more...

## Licenses
**MIT**
