From: Denis Akiyakov <d.akiyakov@gmail.com>
Subject: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Sat, 18 Oct 2014 17:56:48 +0700
Message-ID: <54424770.9090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:50007 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaJRK5w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Oct 2014 06:57:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id b6so1839206lbj.17
        for <linux-input@vger.kernel.org>; Sat, 18 Oct 2014 03:57:51 -0700 (PDT)
Received: from sohaam.webstream ([212.164.231.32])
        by mx.google.com with ESMTPSA id i6sm1230219laf.47.2014.10.18.03.57.49
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Oct 2014 03:57:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm using FreeBSD 10.1 and FreeBSD use webcamd witch contain linux waco=
m=20
driver to provide wacom tablets support. More info here:=20
http://www.selasky.org/hans_petter/video4bsd/ or=20
http://www.freshports.org/multimedia/webcamd/

I've got latest version of webcamd and Wacom device CTH680, but device=20
isn't working correct.

dmesg:

ugen2.3: <Wacom Co.,Ltd.> at usbus2
ums0: <Wacom Co.,Ltd. Intuos PTM, class 0/0, rev 2.00/1.00, addr 3> on=20
usbus2
uhid2: <Wacom Co.,Ltd. Intuos PTM, class 0/0, rev 2.00/1.00, addr 3> on=
=20
usbus2
uhid3: <Wacom Co.,Ltd. Intuos PTM, class 0/0, rev 2.00/1.00, addr 3> on=
=20
usbus2


here are two outputs from webcamd:

first (/usr/local/sbin/webcamd -i 0 -d ugen2.3 -U webcamd -G webcamd -H=
):

: USB HID core driver
Linux video capture interface: v2.00
lirc_dev: IR Remote Control driver registered, major 14
IR NEC protocol handler initialized
IR RC5(x/sz) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR SANYO protocol handler initialized
IR LIRC bridge handler initialized
IR XMP protocol handler initialized
uvcvideo: Unable to create debugfs directory
USB Video Class driver (1.1.1)
cpia2: V4L-Driver for Vision CPiA2 based cameras v3.0.1
au0828 driver loaded
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tun=
er
pvrusb2: Debug mask is 31 (0x1f)
USBVision USB Video Device Driver for Linux : 0.9.11
em28xx: Registered (Em28xx v4l2 Extension) extension
em28xx: Registered (Em28xx dvb Extension) extension
Attached to ugen2.3[0]
DBG: 0003:056A:0303.0001: Kicking head 1 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 2 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 3 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 4 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 5 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 6 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 7 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 8 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 9 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 10 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 11 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 12 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 13 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 14 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 15 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 16 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 17 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 18 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 19 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 20 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 21 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

INFO: 0003:056A:0303.0001: =D0=9F=E2=94=82F: USB HID v1.10 Device [Waco=
m Co.,Ltd.=20
Intuos PTM] on usb-/dev/usb-/dev/usb/input0

Waiting for HAL USB device.
Creating /dev/input/event0

#------------------------------------------
second (/usr/local/sbin/webcamd -i 1 -d ugen2.3 -U webcamd -G webcamd -=
H):
#------------------------------------------

: USB HID core driver
Linux video capture interface: v2.00
lirc_dev: IR Remote Control driver registered, major 14
IR NEC protocol handler initialized
IR RC5(x/sz) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR SANYO protocol handler initialized
IR LIRC bridge handler initialized
IR XMP protocol handler initialized
uvcvideo: Unable to create debugfs directory
USB Video Class driver (1.1.1)
cpia2: V4L-Driver for Vision CPiA2 based cameras v3.0.1
au0828 driver loaded
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tun=
er
pvrusb2: Debug mask is 31 (0x1f)
USBVision USB Video Device Driver for Linux : 0.9.11
em28xx: Registered (Em28xx v4l2 Extension) extension
em28xx: Registered (Em28xx dvb Extension) extension
Attached to ugen2.3[1]
DBG: 0003:056A:0303.0001: Kicking head 1 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

DBG: 0003:056A:0303.0001: Kicking head 2 tail 0
ERR: 0003:056A:0303.0001: usb_submit_urb(ctrl) failed: -32

INFO: 0003:056A:0303.0001: =D0=9F=E2=94=82F: USB HID v1.10 Device [Waco=
m Co.,Ltd.=20
Intuos PTM] on usb-/dev/usb-/dev/usb/input1

Waiting for HAL USB device.
Creating /dev/input/event1
Creating /dev/input/event2
Creating /dev/input/js0


At the end, sometimes after few manipulations the touch by fingers=20
starts working. Pen never works.

Can anyone help to resolve this problem? If you need other logs, please=
 ask.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
