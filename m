From: Gus Power <gus@energizedwork.com>
Subject: [usbtouchscreen] Beijing Irtouchsystems Optical Touchscreen Support
Date: Fri, 09 Dec 2011 08:09:19 +0000
Message-ID: <1323418159.3403.203.camel@localhost>
Reply-To: gus@energizedwork.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from honeysuckle.london.02.net ([87.194.255.144]:33467 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab1LIIOx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2011 03:14:53 -0500
Received: from mail02.energizedwork.com (188.220.58.228) by honeysuckle.london.02.net (8.5.140)
        id 4E79D80C02B4FEF1 for linux-input@vger.kernel.org; Fri, 9 Dec 2011 08:09:23 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm currently trying to get a Beijing IRTOUCHSYSTEMS Optical Touchscree=
n
to work with the usbtouchscreen kernel module (currently testing with
3.0.6).

I see that the existing module recognises a different screen from the
same vendor (Vendor 6615) so I quickly patched the module (added an
entry to recognise product version 0c20) in an attempt to use the same
routines for this screen. The device was then detected by the module an=
d
an input device created accordingly. Unfortunately it doesn't appear to
receive any events from the screen :(

I'm looking for any advice that can help me get further, whether it's
things to try, info to read or people to talk to.

This is what the device appears like in /proc/bus/input/devices:
Code:

I: Bus=3D0003 Vendor=3D6615 Product=3D0c20 Version=3D0646
N: Name=3D"Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen"
P: Phys=3Dusb-0000:00:1d.1-1/input0
S: Sysfs=3D/devices/pci0000:00/0000:00:1d.1/usb6/6-1/6-1:1.0/input/inpu=
t20
U: Uniq=3D
H: Handlers=3Dmouse2 event9
B: PROP=3D0
B: EV=3Db
B: KEY=3D400 0 0 0 0 0
B: ABS=3D3


The xorg log looks like this:
Code:

[200790.465] (II) config/udev: Adding input device Beijing
IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen (/dev/input/mouse2)
[200790.465] (II) No input driver/identifier specified (ignoring)
[200790.466] (II) config/udev: Adding input device Beijing
IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen (/dev/input/event9)
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
Applying InputClass "evdev touchscreen catchall"
[200790.466] (II) Using input driver 'evdev' for 'Beijing IRTOUCHSYSTEM=
S
Co.,LtD Optical TouchScreen'
[200790.466] (II) Loading /usr/lib64/xorg/modules/input/evdev_drv.so
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
always reports core events
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
Device: "/dev/input/event9"
[200790.466] (--) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
=46ound absolute axes
[200790.466] (--) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
=46ound x and y absolute axes
[200790.466] (--) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
=46ound absolute touchscreen
[200790.466] (II) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
Configuring as touchscreen
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
YAxisMapping: buttons 4 and 5
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 20=
0
[200790.466] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1d.1/usb6/6-1/6-1:1.0/input/input=
20/event9"
[200790.466] (II) XINPUT: Adding extended input device "Beijing
IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen" (type: TOUCHSCREEN)
[200790.466] (II) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
initialized for absolute axes.
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
(accel) keeping acceleration scheme 1
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
(accel) acceleration profile 0
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
(accel) acceleration factor: 2.000
[200790.466] (**) Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen:
(accel) acceleration threshold: 4


xinput --list shows:
Code:

=E2=8E=A1 Virtual core pointer                       id=3D2   [master p=
ointer
(3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                 id=3D4=
   [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3 Broadcom Corp                              id=3D1=
1   [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3 PS/2 Mouse                                 id=3D1=
3   [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS GlidePoint                   id=3D1=
4   [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3 Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScree=
n   id=3D9   [slave
pointer  (2)]
=E2=8E=A3 Virtual core keyboard                      id=3D3   [master k=
eyboard
(2)]
    =E2=86=B3 Virtual core XTEST keyboard                id=3D5   [slav=
e  keyboard
(3)]
    =E2=86=B3 Power Button                               id=3D6   [slav=
e  keyboard
(3)]
    =E2=86=B3 Sleep Button                               id=3D7   [slav=
e  keyboard
(3)]
    =E2=86=B3 Broadcom Corp                              id=3D10   [sla=
ve
keyboard (3)]
    =E2=86=B3 AT Translated Set 2 keyboard               id=3D12   [sla=
ve
keyboard (3)]
    =E2=86=B3 Laptop Integrated Webcam                   id=3D8   [slav=
e  keyboard
(3)]


and the details for the device is (xinput --list 9):
Code:

Beijing IRTOUCHSYSTEMS Co.,LtD Optical TouchScreen   id=3D9   [slave
pointer  (2)]
   Reporting 3 classes:
      Class originated from: 9
      Buttons supported: 5
      Button labels: Button Unknown Button Unknown Button Unknown Butto=
n
Wheel Up Button Wheel Down
      Button state:
      Class originated from: 9
      Detail for Valuator 0:
        Label: Abs X
        Range: 0.000000 - 4095.000000
        Resolution: 10000 units/m
        Mode: absolute
        Current value: 256.000000
      Class originated from: 9
      Detail for Valuator 1:
        Label: Abs Y
        Range: 0.000000 - 4095.000000
        Resolution: 10000 units/m
        Mode: absolute
        Current value: 257.000000


Incidentally xinput --test 9 gives no output when the screen is touched=
,
and there is no output when cat'ing the input device files :(

Again, any advice that can help me get further, whether it's things to
try, info to read or people to talk to would be much appreciated,

Gus.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
