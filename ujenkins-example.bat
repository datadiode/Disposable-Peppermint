:^
'''
@echo off
setlocal
cd /d %~dp0

REM set PASSWORD=3412033347562304856921396418054997
set MACHINES=%*
set VAGRANT_SHELL_ENV_CORNER_TEXT=[%%F %USERNAME%]

if defined PASSWORD (
    del files\bookworm\*.deb files\trixie\*.deb files\windows\*.exe 
    mkdir files\bookworm
    mkdir files\trixie
    mkdir files\windows
    py -x %0 example_project 4711
    if errorlevel 1 goto :eof
)

git init
git remote add origin https://github.com/datadiode/Disposable-PepperMiXy
git fetch origin

git checkout --track origin/2023 || git checkout 2023
if errorlevel 1 goto :eof

if "%MACHINES%" neq "%MACHINES:Sparky-7=%" (
    vagrant up Sparky-7
    vagrant halt Sparky-7
    "%VBOX_MSI_INSTALL_PATH%\VBoxManage" export Sparky-7 -o Sparky-7.ova
)
if "%MACHINES%" neq "%MACHINES:Peppermint-2023=%" (
    vagrant up Peppermint-2023
    vagrant halt Peppermint-2023
    "%VBOX_MSI_INSTALL_PATH%\VBoxManage" export Peppermint-2023 -o Peppermint-2023.ova
)

git checkout --track origin/2025 || git checkout 2025
if errorlevel 1 goto :eof

if "%MACHINES%" neq "%MACHINES:Sparky-8=%" (
    vagrant up Sparky-8
    vagrant halt Sparky-8
    "%VBOX_MSI_INSTALL_PATH%\VBoxManage" export Sparky-8 -o Sparky-8.ova
)
if "%MACHINES%" neq "%MACHINES:Peppermint-2025=%" (
    vagrant up Peppermint-2025
    vagrant halt Peppermint-2025
    "%VBOX_MSI_INSTALL_PATH%\VBoxManage" export Peppermint-2025 -o Peppermint-2025.ova
)

goto :eof
'''

import os
import sys
import json
import urllib3
from ujenkins import JenkinsClient

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

name = sys.argv[1]
build_id = sys.argv[2]

client = JenkinsClient('https://buildserver/jenkins', os.environ['USERNAME'], os.environ['PASSWORD'], verify=False)

# Download the build artifacts to be injected into the box
for artifact in client.builds.get_list_artifacts(name, build_id):

    path = artifact["path"]

    # Is it a Debian package?
    if path.endswith(".deb"):
        print(json.dumps(json.loads(json.dumps(artifact)), indent=4))
        blob = client.builds.get_artifact(name, build_id, path)
        path = path.replace("bin/bookworm/", "files/bookworm/")
        path = path.replace("bin/trixie/", "files/trixie/")
        with open(path, "wb") as file:
            file.write(blob)

    # Is it a Windows executable?
    if path.endswith(".exe"):
        print(json.dumps(json.loads(json.dumps(artifact)), indent=4))
        blob = client.builds.get_artifact(name, build_id, path)
        path = path.replace("bin/windows/", "files/windows/")
        with open(path, "wb") as file:
            file.write(blob)
