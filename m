From: Scorza Gianmaria <scogiam95@gmail.com>
Subject: [PROBLEM]:Touchpad recognised as mouse FTE1000
Date: Wed, 30 Mar 2016 17:08:15 +0200
Message-ID: <CALmT65759x-xud241OmL3Kt4GdxkFNrBRCCi_U6SwhJ4+3z1aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36088 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbcC3PIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2016 11:08:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id 127so101346539wmu.1
        for <linux-input@vger.kernel.org>; Wed, 30 Mar 2016 08:08:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[1.] One line summary of the problem:
Touchpad recognised as mouse FTE1000

[2.] Full description of the problem/report:
In my Asus e200ha touchpad is recognized as mouse, only one click, no
two finger click and scrolling

giamma1295@Power-Netbook ~ $ xinput list
=E2=8E=A1 Virtual core pointer                     id=3D2 [master point=
er  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer               id=3D4 [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 PDEC3393:00 0B05:8585                   id=3D11 [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 FTE1000:00 0B05:0101                     id=3D12 =
[slave  pointer  (2)]
=E2=8E=A3 Virtual core keyboard                   id=3D3 [master keyboa=
rd (2)]
    =E2=86=B3 Virtual core XTEST keyboard             id=3D5 [slave  ke=
yboard (3)]
    =E2=86=B3 Power Button                             id=3D6 [slave  k=
eyboard (3)]
    =E2=86=B3 Video Bus                               id=3D7 [slave  ke=
yboard (3)]
    =E2=86=B3 Power Button                             id=3D8 [slave  k=
eyboard (3)]
    =E2=86=B3 Sleep Button                             id=3D9 [slave  k=
eyboard (3)]
    =E2=86=B3 USB2.0 VGA UVC WebCam                   id=3D10 [slave  k=
eyboard (3)]
    =E2=86=B3 Asus WMI hotkeys                         id=3D13 [slave  =
keyboard (3)]


[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):
giamma1295@Power-Netbook ~ $ cat /proc/version
Linux version 4.6.0-040600rc1-generic (kernel@tangerine) (gcc version
5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201603261930 SMP Sat Mar 26
23:32:43 UTC 2016


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)


[6.] A small shell script or example program which triggers the
     problem (if possible)
[X.] Other notes, patches, fixes, workarounds:

dmseg output:

giamma1295@Power-Netbook ~ $ dmesg |grep hid
[   13.059151] hidraw: raw HID events driver (C) Jiri Kosina
[   14.194465] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report
size:7 / ret_size:4
[   14.197745] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report
size:19 / ret_size:4
[   14.199844] hid-generic 0018:0B05:8585.0001: input,hidraw0: I2C HID
v1.00 Keyboard [PDEC3393:00 0B05:8585] on i2c-PDEC3393:00
[   14.219572] i2c_hid i2c-FTE1000:00: error in i2c_hid_init_report
size:633 / ret_size:7
[   14.223459] i2c_hid i2c-FTE1000:00: error in i2c_hid_init_report
size:131 / ret_size:7
[   14.224651] hid-generic 0018:0B05:0101.0002: input,hidraw1: I2C HID
v1.00 Mouse [FTE1000:00 0B05:0101] on i2c-FTE1000:00
[  135.737199] hid-generic 0003:0E8F:00FB.0003: input,hidraw2: USB HID
v1.10 Mouse [YSTEK USB Mouse] on usb-0000:00:14.0-4/input0
[  135.737359] usbcore: registered new interface driver usbhid
[  135.737368] usbhid: USB HID core driver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
