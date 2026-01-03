[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

# Disposable-PepperMiX

This project contains a vagrant file that spins up a Peppermint or MX virtual machine (using Virtual Box) with a ready-to-go dual-bitness wine prefix, alongside with customizable modifications.
For evolutionary reasons, the referenced base images tend to be localized to Spanish or German. To provide a consistent outcome, the provisioning will localize the vagrant account back to English.

## Prerequisites

You'll need to have the following ready before you can use this:

- [VirtualBox](https://www.virtualbox.org/) installed and working
- [Vagrant 2.x](https://www.vagrantup.com/) installed and working 

## Installing

- Clone this repo
- Navigate to the directory, open Vagrantfile in your favorite editor to review/customize settings
- Optionally add proprietary payloads through `scripts/setup.pp`, `scripts/setup-user.pp`
- To change the keyboard layout, your `scripts/setup.pp` could do like so, where `de` is an exemplary choice which may or may not suit your needs:

```
crudini --set /etc/lightdm/lightdm.conf "Seat:*" display-setup-script "setxkbmap de"
```

- Two more such commands in `scripts/setup.pp` would let you bypass the login prompt:

```
crudini --set /etc/lightdm/lightdm.conf "Seat:*" autologin-user vagrant
crudini --set /etc/lightdm/lightdm.conf "Seat:*" autologin-user-timeout 0
```

- To keep the screen unlocked during idleness, your `scripts/setup-user.pp` should include this:

```
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true -n -t bool
```

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
You can use your VM headless or open the virtualbox gui and attach to the running vm to login with a graphical UI.  X11 forwarding is an option in the Vagrantfile for headless usage, easier if your host is linux.

Common VM lifecycle
```
#start vm
vagrant up

#login
vagrant ssh

#stop the vm
vagrant halt

#when you want to start with a clean install
vagrant destroy
vagrant up
```

## Contributing

Please fork and create an issue describing the changes to be merged.

## Authors

* **Steve Mcilwain** - *Initial work* - [stevemcilwain](https://github.com/stevemcilwain)

See also the list of [contributors](https://github.com/stevemcilwain/Disposable-Kali/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
