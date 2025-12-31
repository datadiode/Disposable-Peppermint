# Disposable Peppermint Linux                                                                                                                       
# Repo: https://github.com/datadiode/Disposable-Peppermint
# PA: https://github.com/stevemcilwain/Disposable-Kali
# Copyright (c) Steve Mcilwain et al.
# SPDX-License-Identifier: MIT
############################################################

# -*- mode: ruby -*-
# vi: set ft=ruby :

# capture the vagrant command passed in as first argument
VAGRANT_COMMAND = ARGV[0]

############################################################
# VM and Guest Settings - Review and Customize
############################################################

# BOX_PATH:  the name or full url of the base box to use
BOX_PATH = "datadiode/Peppermint-2025"

# BOX_UPDATE: set to true to check for base box updates 
BOX_UPDATE = false

# VM_NAME: set the name of the virtual machine and host name
VM_NAME = "peppermint-2025"

# VM_MEMORY: specify the amount of memory to allocate to the VM
#VM_MEMORY = "8192"
VM_MEMORY = "4096"
#VM_MEMORY = "2048"

# VM_CPUS: specify the number of CPU cores to allocate to the VM
VM_CPUS = "2"

# VM_SHARED_FOLDER_ENABLE: set to false to disable the shared folder between host and guest
VM_SHARED_FOLDER_ENABLE = false
VM_SHARED_FOLDER_HOST_PATH = "d:/shared"
VM_SHARED_FOLDER_GUEST_PATH = "/mnt/shared"

# SWAP_ADD: if enabled, will add the amount of SWAP_ADD_GB to current swap space
#           which is usually 2GB for the Kali base box
SWAP_ADD = false
SWAP_ADD_GB = 4

# SSH_INSERT_KEY: if enabled, will replace the insecure bootstrapping key
SSH_INSERT_KEY = false

# SHELL_ENV: environment to pass to shell provisioners
SHELL_ENV =
{
    # The display number to use for creating a virtual display
    "DISPLAY" => ":10",
    # The winetricks verbs to apply to the wine prefix
    "WINETRICKS_VERBS" => "vcrun2019 win10"
}

############################################################
# DO NOT ALTER BELOW HERE
############################################################

# If no propriatary payloads are provided, create empty ones
FileUtils.touch 'scripts/setup.pp'
FileUtils.touch 'scripts/setup-user.pp'

# Configure with API version 2
Vagrant.configure("2") do |config|

  config.vm.define "peppermint", primary: true do |peppermint|

    peppermint.vm.box = BOX_PATH
    peppermint.vm.box_check_update = BOX_UPDATE
    peppermint.vm.hostname = VM_NAME
    peppermint.ssh.forward_agent = true
    peppermint.ssh.forward_x11 = true
    peppermint.ssh.insert_key = SSH_INSERT_KEY
    peppermint.vm.synced_folder '.', '/vagrant', disabled: true

    if Vagrant.has_plugin?("vagrant-vbguest")
      peppermint.vbguest.auto_update = false
      peppermint.vbguest.no_remote = true
    end

    # this allows "vagrant up" to work normally using the vagrant user
    # but if "vagrant ssh", then the root user will be used
    if VAGRANT_COMMAND == "ssh" 
      peppermint.ssh.username = "root"
    end

    #virtual box specific settings

    peppermint.vm.provider :virtualbox do |vbox|
      vbox.gui = true
      vbox.name = VM_NAME
      vbox.memory = VM_MEMORY
      vbox.cpus = VM_CPUS
    end

    if VM_SHARED_FOLDER_ENABLE
      peppermint.vm.synced_folder VM_SHARED_FOLDER_HOST_PATH, VM_SHARED_FOLDER_GUEST_PATH, create: true, owner: "root", group: "root", automount: true
    end

    # Inject files

    peppermint.vm.provision "file", source: "files", destination: "files"

    # Execute Provisioning Scripts
      
    peppermint.vm.provision "shell", keep_color: true, name: "sshd_allow_root.sh", path: "scripts/sshd_allow_root.sh"

    if SWAP_ADD
      peppermint.vm.provision "shell", keep_color: true, name: "swap_add.sh", path: "scripts/swap_add.sh", args: SWAP_ADD_GB
    end

    peppermint.vm.provision "shell", keep_color: true, env: SHELL_ENV, name: "setup.sh", path: "scripts/setup.sh"
    peppermint.vm.provision "shell", keep_color: true, env: SHELL_ENV, name: "setup.pp", path: "scripts/setup.pp"

    peppermint.vm.provision "shell", keep_color: true, env: SHELL_ENV, name: "setup-user.sh", path: "scripts/setup-user.sh", privileged: false
    peppermint.vm.provision "shell", keep_color: true, env: SHELL_ENV, name: "setup-user.pp", path: "scripts/setup-user.pp", privileged: false

    peppermint.vm.provision "shell", reboot: true

    peppermint.vm.post_up_message = $msg

  end

end

$msg = <<MSG

-------------------------------------------------------------
Disposable Peppermint is hopefully up and running :)
-------------------------------------------------------------
\n

MSG
