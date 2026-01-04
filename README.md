[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

# Disposable-PepperMiXy

This project contains a vagrant file that spins up a Peppermint or MX or Sparky virtual machine (using Virtual Box) with a ready-to-go dual-bitness wine prefix, alongside with customizable modifications.
For evolutionary reasons, the referenced base images tend to be localized to Spanish or German. To provide a consistent outcome, the provisioning will localize the vagrant account back to English.

## Prerequisites

You'll need to have the following ready before you can use this:

- [VirtualBox](https://www.virtualbox.org/) installed and working
- [Vagrant 2.x](https://www.vagrantup.com/) installed and working 

## Installing

- Clone this repo
- Navigate to the directory, open Vagrantfile in your favorite editor to review/customize settings
- Optionally add proprietary payloads through `scripts/setup.pp`, `scripts/setup-user.pp`
- From a command shell, start the VM.  The first time this runs will take some time doing provisioning.

```
vagrant up
```

- Vagrant will download the base Peppermint box, configure the VM in virtualbox, run provisioning scripts.  The first time this runs this can take some time but should not require any interaction.

- Login, change the root password as per your security requirements and use Peppermint!

```
vagrant ssh
```

## Usage
You can use your VM headless or open the virtualbox gui and attach to the running VM to login with a graphical UI.  X11 forwarding is an option in the Vagrantfile for headless usage, easier if your host is linux.

The VM names understood by the Vagrantfile are:  
`Peppermint`, `Peppermint-2025`, `MX`, `MX-25`, `Sparky`, `Sparky-8`  
The version-specific names help distinguish VMs created from different branches of this repository, but are otherwise equivalent to the version-neutral names.  
Multiple alike machines can be identified through an optional dot suffix (or several ones).  
Omitting the name causes the Vagrantfile to produce a Peppermint box with a version-neutral name.

Common VM lifecycle
```
#start vm
vagrant up [ Peppermint[-2025] | MX[-25] | Sparky[-8] ]

#login
vagrant ssh [ Peppermint[-2025] | MX[-25] | Sparky[-8] ]

#stop the vm
vagrant halt [ Peppermint[-2025] | MX[-25] | Sparky[-8] ]

#when you want to start with a clean install
vagrant destroy [ Peppermint[-2025] | MX[-25] | Sparky[-8] ]
vagrant up [ Peppermint[-2025] | MX[-25] | Sparky[-8] ]
```

## Contributing

Please fork and create an issue describing the changes to be merged.

## Authors

* **Steve Mcilwain** - *Initial work* - [stevemcilwain](https://github.com/stevemcilwain)

See also the list of [contributors](https://github.com/stevemcilwain/Disposable-Kali/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
