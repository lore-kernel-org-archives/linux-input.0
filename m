From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC] Wiimote userspace interface
Date: Sat, 30 Jul 2011 18:34:37 +0200
Message-ID: <CANq1E4S3VY_xxzcjuJDHJc57VPb_uiFrx1B3wR9Xnw5ddx6HJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63349 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab1G3Qeh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 12:34:37 -0400
Received: by vxh35 with SMTP id 35so3326719vxh.19
        for <linux-input@vger.kernel.org>; Sat, 30 Jul 2011 09:34:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>, Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

As Oliver pointed out my proposed wiimote userspace interface isn't
exactly the best way to go so I wanted to discuss possible interfaces
first.

The following data is reported by the wiimote to userspace:
 - Button data
 - 3D accelerometer data (1x)
 - 2D pointing data through IR cam (4x)

By motion+ extension:
 - 3D gyro/rotation data (1x)

By nunchuck extension:
 - 2D analog stick data (1x)
 - additional buttons
 - 3D accelerometer data (1x)

By classic controller extension:
 - additional buttons
 - 2D analog stick (2x)

To be extended with further wiimote extensions

Obviously this is way too much data for a single interface. Its 23
ABS_ values (4x IR cam!). I could report them through one interface
but I had to use my own ABS_ values which are not in input.h since
there aren't enough predefined values.

Additionally, the driver is capable of disabling the accelerometers,
IR cam, gyro etc. on the remote device to save energy (a *lot* of
energy). So I really want to enable these devices only if userspace
uses them.


Interface #1:
Everything is reported through one input device and there are sysfs
attributes which control the peripherals of the wiimote. Eg., writing
1 to "accelerometer" enables the accelerometer. Writing 0 disables it.
Same for IR cam, gyro, extensions etc.
This makes it easy for userspace applications because they only need
to open one input device and can control the available resources.
However, if multiple applications use the interface, then one
application may disable the accelerometer, even though another app
still uses it. I can't use reference counting here.

Interface #2:
Every peripheral uses its own input device. One for buttons, one for
accelerometer, 4 input devices for the IR cam (or maybe 1 devices that
contains all 4 IR cam values?) and so on.
I could use the ->open()/close() callbacks to keep track of the users
of each input device and disable the peripheral if there is no user.
This would avoid userspace conflicts with the resource, but would make
it quite difficult for userspace to manage all those input devices. If
an app only wants the accelerometer data, which input device would it
have to open? If it opens all of them and closes the ones that it
doesn't need again, then the driver would have to initialize _all_
peripherals and disable them again just to allow the userspace app to
find the right input device.
Or is there a way to help userspace find the right input device?
Renaming the input device to "Nintendo Wii Remote - Accelerometer" and
userspace should read /sys/bus/hid/..<wiimote>../inputXY/name before
opening the input device? Still, this would mean at least 4 input
interfaces for each connected wiimote. If IR data is not combined,
then 7 input interfaces.

Interface #3:
One single input interface with all data. Userspace needs to send some
magic value to the device to enable peripherals. For instance EV_MSC +
MSC_RAW + MAGIC_VALUE_1 to enable accelerometer and EV_MSC + MSC_RAW +
MAGIC_VALUE_2 to disable accelerometer.
If an app closes the input device, the driver automatically decrements
the refcount on the still open peripherals for that user.
This would allow to reduce the number of input device. I could still
split them into one input device for wiimote and one for each active
extension so there would be at most 3 input devices. However, this
sounds to me like using a cdev + ioctl() approach but with a nice
cover so nobody notices it.
Though, userspace programming would be very easy with this interface.
A helper library could be implemented in quite few steps.

Interface #4:
Character device with ioctls... Well I tried to avoid that.
Obvious advantages: Simple reference counting of applications through
->open/close() callbacks. Peripherals can be enabled/disabled through
ioctls. All data can be streamed through the file using a custom
packet structure. Disadvantages: its a cdev with ioctls...

Interface #5:
Any more ideas?


There is also the other side. Sending data to the wiimote. 4 LEDs can
be set, the rumble motor can be enabled/disabled and audio data can be
streamed. I think my current approach to use sysfs attributes for the
LEDs and RUMBLE motor is ok? I can't figure out any better way here.
Reference-counting doesn't make sense. If multiple devices use them,
then they will always have conflicts, however, it still works.
Audio streaming is not yet implemented, but I think I could register
an alsa device so this needs not to be discussed here.


Currently I think Interface #2 would be the best way but I don't want
to spend time implementing that if you tell me it isn't acceptable.
Any comments on this are appreciated.


Regards
David
