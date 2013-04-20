From: gmail <alex.osima@gmail.com>
Subject: Evdev like userspace/kernelspace communication system for char devices
Date: Sat, 20 Apr 2013 22:25:05 +0200
Message-ID: <0D5B3086-17C7-4795-B0FF-788FF21C7C40@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:59256 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3DTUZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Apr 2013 16:25:08 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so2449011wie.6
        for <linux-input@vger.kernel.org>; Sat, 20 Apr 2013 13:25:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hyau@DOMAIN.HIDDEN

Hello everyone, my name is  Alessandro Osima and I'm a computer science=
 student at Universit=E0 degli Studi di Milano, Italy (second year, equ=
ivalent to bachelor). I would be very interested to participate in this=
 year Google Summer of Code and I'm developing the concept of an applic=
ation with the  beagleboard open source organisation (http://beagleboar=
d.org/).=20

The project aims to build a new kernel space interface for char device =
communication with userspace throughout files representing all kinds of=
 character devices located into the /dev directory.

This project was initially focused on offering a simple iio drivers deb=
ug interface with userspace but thanks to the advice by my would-be men=
tor Hunyue Yau, I turned to build a more robust and general interface.
=46or this reason I started to look at evdev as a possible replacement.
The problem with evdev is that it's heavily entangled with the input su=
bsystem, especially in the initialisation  and removal phases. Furtherm=
ore adding iio specific stuff to evedev would likely transform it into =
a poorly engineered subsystem.
Therefore I agreed with Hunyue to create an entirely new module (let's =
call it nevdev) free from all the dependencies which evdev has with the=
 input subsystem.=20
The basic approach woud be the same as evdev, that is creating files in=
 /dev, so that userspace can easily communicate with them throughout fi=
le i/o.=20
While evedev directly handles file operations with input devices, nevde=
v would redirect all file operations on the subsystems that registered =
the devices. This way it could interact with any kind of character devi=
ce.


=46or example let's say that  iio needs a new userspace interface for i=
t's VCNL 4000 drivers. =20
What iio does is asking nevdev  for a new file in it's /dev/nevdev dire=
ctory and passing it's own file_operations structure. Nevdev then creat=
es and registers a new file in /dev/nevdev (named for example nevdev0) =
and every time userspace reads or writes to it  nevdev receives the cal=
lbacks and calls the functions previously registered by iio.

In other words every subsystem, not only iio or input_core can implemen=
t its own events and ioctls calls offering a really abstract interface.

=46ollowing is an overview of the api possibly exposed by nevdev.

Like a lot of other kernel subsystems nevdev will expose the usual regi=
ster/unregister functions=20

-int nevdev_register_interface(nevdev_handle * interface, struct device=
 * dev)

-void nevdev_unregister interface(nevdev_handle * interface)

the nevdev_handle is a structure containing some nevdev related stuff l=
ike a spinlock a cdev and a device structure,  the drivers will have to=
 register two things, a file_operations structure and their device_core=
 device structure.

-struct nevdev_handle* nevdev_allocate_struct(struct  file_operations *=
 fops)

this function will allocate nevdev_handle and place fops inside it.

Internally nevdev will have a list of nevdev_handle corresponding to al=
l the registered devices. Every time a new device is registered with  i=
nt nevdev_register_interface(nevdev_handle * interface) nevdev will:

1:create a new device_core struct device using dev (the second argument=
 in nevdev_register_interface) as a parent and a nevdev global device c=
lass as the device class, this way all the newly registered devices wil=
l stay in /sys/class/nevdev ready to be exported to /dev/nevdev by udev
2:create a new cdev character device and link it with the fops file_ope=
rations struct passed in nevdev_allocate_device.
3:register both with input_core, the hotplug event resulting from this =
will be intercepted by udev thanks to simple script and new nodes will =
be created in /dev/nevdev.

This approach is very similar to the one evdev currently use.


I believe nevdev will have its own dinamically allocated major number w=
ith all the minors corresponding to every newly registered device.
Every time a file_operations syscall arrives it will be first intercept=
ed by nevdev and then sent to the selected device via the registered fi=
le_operations struct. This is done in case we need to do some housekeep=
ing (like when we receive an open() or release() call) and because nevd=
ev will offer some global ioctls events for subsystem wide informations=
=2E

Nevdev will of course reside in its own separate kernel module.

I would kindly ask your opinions about this proposal and would be very =
grateful for any comments and suggestion.

Thank you for reading this post, please to not hesitate to ask for any =
clarification.

Regards,
Alessandro Osima.




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
