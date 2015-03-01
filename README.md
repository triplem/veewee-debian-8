# Debian Jessie Template for Veewee

This template creates a Debian Jessie Box from the latest weekly found on
http://cdimage.debian.org.

This template is based on the work of [mdirik](https://github.com/mdirik/veewee-templates).

Since I am using ArchLinux on my work laptop, the description is based on ArchLinux
as the host system.

Furthermore we are using VirtualBox as the provider, since I did not found an easy
way to get the network running for KVM. Because I do need a KVM Image to export
to netcup (my provider), the generated image is in a later step converted to an
KVM Image using qemu.

This image will create a user "phreevpn" on the constructed box with the password
"phreevpn". After finishing the construction of the image, you will receive detailed
instructions from veewee on how to login via ssh to this machine.

We do provide two image templates, one for i386 and another one for amd64:

* debian-jessie-i386-netboot
* debian-jessie-amd64-netboot

## Generate Image

I found a great and easy to use tool, to generate the image: [Veewee](https://github.com/jedi4ever/veewee)

### Install requirements and veewee

[Requirements](https://github.com/jedi4ever/veewee/blob/master/doc/requirements.md)

```
$ sudo pacman -S libxml2 libxslt zlib
$ gem install veewee
```

### Run Veewee

Create the image:

```
$ ~/.gem/ruby/2.2.0/bin/veewee vbox build 'debian-jessie-amd64-netboot'
```

Start the image:

```
$ ~/.gem/ruby/2.2.0/bin/veewee vbox up 'debian-jessie-amd64-netboot'
```

Halt the image:

```
$ ~/.gem/ruby/2.2.0/bin/veewee vbox halt 'debian-jessie-amd64-netboot'
```

Delete the image:

```
$ ~/.gem/ruby/2.2.0/bin/veewee vbox destroy 'debian-jessie-amd64-netboot'
```

### Convert Image to KVM

This is basically an easy conversion from vdi to qcow2 (the format of KVM and qemu).

There are several ways, one is to convert vdi to raw and then raw to qcow2. Also
netcups support raw images as well, I did prefer to convert the image directly to
qcow2 to save some disk space. For a detailed description see the [randomhacks](http://www.randomhacks.co.uk/how-to-convert-virtualbox-vdi-to-kvm-qcow2/) page.

## KVM (not working for me...)

https://github.com/jedi4ever/veewee/blob/master/doc/kvm.md

```
$ sudo pacman -S libvirt qemu dnsmasq bridge-utils ebtables openbsd-netcat
$ gem install ruby-libvirt
```


### create storage pool

```
$ cat > /tmp/pool.xml << EOF
<pool type="dir">
  <name>virtimages</name>
  <target>
    <path>/var/lib/libvirt/images</path>
    <format type='qcow2'/>
  </target>
</pool>
EOF
$ virsh pool-create /tmp/pool.xml
```

```
sudo vim /etc/libvirt/qemu.conf
```

change 'group = "kvm" to "wheel"'


