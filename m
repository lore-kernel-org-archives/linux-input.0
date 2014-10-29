From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: About Dell Inspiron 3442 touchpad
Date: Tue, 28 Oct 2014 23:00:44 -0200
Message-ID: <1414544444.169720.184461733.4C6DF47C@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41259 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbaJ2BAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 21:00:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 712E620BB2
	for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 21:00:44 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm trying to make a touchpad from a Dell Inspiron I14-3442 laptop work=
=2E

Some details:

- I'm using plain Slackware64 14.1, but raised the kernel to 3.16.3 for
tests

- xinput ignores the touchpad; it shows only a USB mouse/keyboard
adapter and the laptop's keyboard:

root@pace:/sys/bus/hid/devices# xinput
 Virtual core pointer                            id=3D2    [master poin=
ter
  (3)]
     Virtual core XTEST pointer                      id=3D4    [slave=20
     pointer  (2)]
     Generic USB K/B                                 id=3D12   [slave=20
     pointer  (2)]
  Virtual core keyboard                           id=3D3    [master
  keyboard (2)]
      Virtual core XTEST keyboard                     id=3D5    [slave=20
      keyboard (3)]
      Power Button                                    id=3D6    [slave=20
      keyboard (3)]
      Video Bus                                       id=3D7    [slave=20
      keyboard (3)]
      Power Button                                    id=3D9    [slave=20
      keyboard (3)]
      Sleep Button                                    id=3D10   [slave=20
      keyboard (3)]
      Integrated_Webcam_HD                            id=3D13   [slave=20
      keyboard (3)]
      AT Translated Set 2 keyboard                    id=3D14   [slave=20
      keyboard (3)]
      Dell WMI hotkeys                                id=3D15   [slave=20
      keyboard (3)]
      Video Bus                                       id=3D8    [slave=20
      keyboard (3)]
      Generic USB K/B                                 id=3D11   [slave=20
      keyboard (3)]

- it seems Ubuntu certified this machine (check
http://www.ubuntu.com/certification/hardware/201402-14674/components/),
but it assumes the touchpad is PS/2. I haven't found it as a PS/2 thing=
,
even loading psmouse.ko, or doing other tricks

- some articles lists some tips for making it work (like
http://askubuntu.com/questions/134627/how-do-i-get-the-touchpad-setting=
s-working-on-a-dell-xps-13-ultrabook,
or https://bugzilla.redhat.com/show_bug.cgi?id=3D1048314#c2), but I rea=
d
them carefully, made some tests, and they didn't work. One article says
I could blacklist i2c_hid or like in order to make the bring up the
touchpad in PS/2 mode, but I couldn't succeed doing so

- at Dell's site, it is offered a driver for Ubuntu 12.04, but it's
almost obsolete. It seems to be just merged into the kernel

- from Windows 8.1, which runs in the same machine (dual boot), I
concluded the proper way of making it work is to use HID over I2C. It
seems that there are two components loaded; one I2CHID, and a Synaptics
HID. This makes me hint it may be a Synaptics device

- it seems there are two I2C busses in the machine. One is related to
the Intel video graphics subsystem (i801). The other seems to be linked
to the touchpad (i2c_designware_platform). I'm not sure that latest kmo=
d
(i2c_designware_platform) is the right one to be used in this case, but
it appears to be working:

root@pace:/sys/bus/i2c/devices# ls -l /sys/bus/i2c/devices
total 0
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-0 ->
=2E./../../devices/pci0000:00/INT33C2:00/i2c-0
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-1 ->
=2E./../../devices/pci0000:00/INT33C3:00/i2c-1
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-2 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-2
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-3 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-3
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-4 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-4
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-5 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-5
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-6 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-6
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-7 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-7
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-8 ->
=2E./../../devices/pci0000:00/0000:00:02.0/i2c-8
lrwxrwxrwx 1 root root 0 Out 18 17:26 i2c-DLL0652:00 ->
=2E./../../devices/pci0000:00/INT33C3:00/i2c-1/i2c-DLL0652:00

root@pace:/sys/bus/i2c/devices# lsmod | grep i2c
i2c_hid                10682  0=20
hid                    94632  3 i2c_hid,hid_generic,usbhid
i2c_dev                 5739  0=20
i2c_designware_platform     3189  0=20
i2c_i801               13732  0=20
i2c_designware_core     6045  1 i2c_designware_platform
i2c_algo_bit            5351  1 i915
i2c_core               35216  11
drm,i915,i2c_i801,i2c_dev,i2c_hid,i2c_designware_platform,drm_kms_helpe=
r,i2c_algo_bit,v4l2_common,synaptics_i2c,videodev

- in the HID /sys directory, there are three devices. Two are related t=
o
a keyboard/mouse USB adapter. The third seems to be the linked to the
touchpad:

root@pace:/sys/bus/hid/devices# ls -l /sys/bus/hid/devices
total 0
lrwxrwxrwx 1 root root 0 Out 28 22:40 0003:13BA:0017.004F ->
=2E./../../devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.0/000=
3:13BA:0017.004F
lrwxrwxrwx 1 root root 0 Out 28 22:40 0003:13BA:0017.0050 ->
=2E./../../devices/pci0000:00/0000:00:1d.0/usb3/3-1/3-1.3/3-1.3:1.1/000=
3:13BA:0017.0050
lrwxrwxrwx 1 root root 0 Out 28 22:40 0018:06CB:2985.0052 ->
=2E./../../devices/pci0000:00/INT33C3:00/i2c-1/i2c-DLL0652:00/0018:06CB=
:2985.0052

- when I load the kernel module i2c-hid.ko (with debug=3D1), I read thi=
s
in dmesg:

[146172.568787] i2c_hid i2c-DLL0652:00: Fetching the HID descriptor
[146172.568791] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=3D20 00
[146172.574806] i2c_hid i2c-DLL0652:00: HID Descriptor: 1e 00 00 01 85
00 21 00 24 00 20 00 25 00 17 00 22 00 23 00 cb 06 85 29 00 00 00 00 00
00
[146172.574845] i2c_hid i2c-DLL0652:00: entering i2c_hid_parse
[146172.574847] i2c_hid i2c-DLL0652:00: i2c_hid_hwreset
[146172.574849] i2c_hid i2c-DLL0652:00: i2c_hid_set_power
[146172.574850] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=3D22 00 =
00
08
[146172.575436] i2c_hid i2c-DLL0652:00: resetting...
[146172.575442] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=3D22 00 =
00
01
[146172.576113] i2c_hid i2c-DLL0652:00: __i2c_hid_command: waiting...
[146172.577414] i2c_hid i2c-DLL0652:00: __i2c_hid_command: finished.
[146172.577417] i2c_hid i2c-DLL0652:00: asking HID report descriptor
[146172.577419] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=3D21 00
[146172.581072] i2c_hid i2c-DLL0652:00: Report Descriptor: 05 01 09 02
a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02
95 06 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 06 00
ff 09 01 a1 01 85 09 09 02 15 00 26
[146172.581126] i2c_hid i2c-DLL0652:00: i2c_hid_set_power
[146172.581129] i2c_hid i2c-DLL0652:00: __i2c_hid_command: cmd=3D22 00 =
01
08

I am aware this information probably is not sufficient to draw any
conclusions, but I'd appreciate to hear from someone who knows i2c_hid
in detail what steps I should take next. For me the last command timed
out or got stuck, but I haven't checked the code to see if it's the
case. Anyway, if it was a timeout case, it should have something logged
after the time expired.

I have some programming skills, and so if it's the case of applying any
patches, or recompiling the kernel or any subsystem to make tests, I'm
up to.

Many thanks,

Luiz Ramos
lramos dot prof at yahoo dot com dot br
S=C3=A3o Paulo - Brazil


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
