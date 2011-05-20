From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch: Add support for Lumio panels
Date: Fri, 20 May 2011 15:12:50 +0200
Message-ID: <BANLkTi=nyaVBhKB6bKLCqtykjMAaKfEt9A@mail.gmail.com>
References: <1305725244-5327-1-git-send-email-benjamin.tissoires@enac.fr>
	<87boyyo0gr.fsf@macbook.be.48ers.dk>
	<BANLkTikPXHswWQqQHqd8fegotqoZPLErsQ@mail.gmail.com>
	<87mxihd6kh.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1ETNMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2011 09:12:52 -0400
In-Reply-To: <87mxihd6kh.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

I'll see with the device maker if your device should work in
multitouch. Your new evtest does not report enough multitouch things,
which is weird.

Cheers,
Benjamin

On Fri, May 20, 2011 at 12:12, Peter Korsgaard <jacmet@sunsite.dk> wrot=
e:
>>>>>> "Benjamin" =3D=3D Benjamin Tissoires <benjamin.tissoires@enac.fr=
> writes:
>
> Hi,
>
> =A0Benjamin> your device presents Contact ID, Tip Switch, In Range an=
d
> =A0Benjamin> Confidence. =A0I would say that Win 7 would treat it as =
a
> =A0Benjamin> multitouch screen, so this might work with
> =A0Benjamin> hid-multitouch. Please note that's the first time I see =
a
> =A0Benjamin> report descriptor with only one touch reported for a
> =A0Benjamin> multitouch screen.
>
> =A0Benjamin> For the configuration, the device may emulate a mouse by
> =A0Benjamin> default, and hid-multitouch is able to switch to the
> =A0Benjamin> multitouch mode. You will loose the right click, but it =
can
> =A0Benjamin> be enabled in gnome at least (accessibility settings).
>
> =A0Benjamin> Can you just replace in hid-ids.h:
> =A0Benjamin> - #define USB_DEVICE_ID_CRYSTALTOUCH =A00x0006
> =A0Benjamin> + #define USB_DEVICE_ID_CRYSTALTOUCH =A00x0005
>
> =A0Benjamin> and see if it's working? =A0If you prefer, I can make a =
new
> =A0Benjamin> patch, but I'll need to know which kernel you are runnin=
g
> =A0Benjamin> (tree and branch). A 2.6.39 and above would be great.
>
> I'm on 2.6.39. The patch doesn't apply cleanly, but I've fixed it up
> manually (http://peter.korsgaard.com/lumio-2.6.29.patch).
>
> hid-multitouch does get loaded, and everything looks OK:
>
> usb 2-1.1: new full speed USB device number 4 using uhci_hcd
> hid-multitouch 0003:202E:0005.0008: hiddev0: USB HID v1.10 Device [LU=
MIO Inc LUMIO CrystalTouch ver 1.1C] on usb-0000:00:1d.0-1.1/input0
> input: LUMIO Inc LUMIO CrystalTouch ver 1.1C as /devices/pci0000:00/0=
000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.1/input/input18
> hid-multitouch 0003:202E:0005.0009: input: USB HID v1.11 Keyboard [LU=
MIO Inc LUMIO CrystalTouch ver 1.1C] on usb-0000:00:1d.0-1.1/input1
> input: LUMIO Inc LUMIO CrystalTouch ver 1.1C as /devices/pci0000:00/0=
000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.2/input/input19
> hid-multitouch 0003:202E:0005.000A: input: USB HID v1.11 Mouse [LUMIO=
 Inc LUMIO CrystalTouch ver 1.1C] on usb-0000:00:1d.0-1.1/input2
> input: LUMIO Inc LUMIO CrystalTouch ver 1.1C as /devices/pci0000:00/0=
000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.3/input/input20
> hid-multitouch 0003:202E:0005.000B: input: USB HID v1.11 Device [LUMI=
O Inc LUMIO CrystalTouch ver 1.1C] on usb-0000:00:1d.0-1.1/input3
>
> Evdev output is also different, but it doesn't seem to ever generate =
any
> events when I touch the screen.
>
> Before I had:
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input1
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.1/=
input/input28
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul sysrq kbd event16
> B: PROP=3D0
> B: EV=3D100013
> B: KEY=3De080ffdf01cfffff fffffffffffffffe
> B: MSC=3D10
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input2
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.2/=
input/input29
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul event17
> B: PROP=3D0
> B: EV=3D1f
> B: KEY=3D70000 0 0 0 0
> B: REL=3D200
> B: ABS=3D3
> B: MSC=3D10
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input3
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.3/=
input/input30
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul event18
> B: PROP=3D0
> B: EV=3D1b
> B: KEY=3D420 1 0 0 0 0
> B: ABS=3D10000000003
> B: MSC=3D10
>
> With event16 + event18 never generating any events, and event17 givin=
g:
>
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x202e product 0x5 version 0x111
> Input device name: "LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> Supported events:
> =A0Event type 0 (Sync)
> =A0Event type 1 (Key)
> =A0 =A0Event code 272 (LeftBtn)
> =A0 =A0Event code 273 (RightBtn)
> =A0 =A0Event code 274 (MiddleBtn)
> =A0Event type 2 (Relative)
> =A0 =A0Event code 9 (Misc)
> =A0Event type 3 (Absolute)
> =A0 =A0Event code 0 (X)
> =A0 =A0 =A0Value =A0 =A0650
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> =A0 =A0Event code 1 (Y)
> =A0 =A0 =A0Value =A0 3221
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> =A0Event type 4 (Misc)
> =A0 =A0Event code 4 (ScanCode)
> Testing ... (interrupt to exit)
> Event: time 1305882024.934011, type 4 (Misc), code 4 (ScanCode), valu=
e 90001
> Event: time 1305882024.934017, type 1 (Key), code 272 (LeftBtn), valu=
e 1
> Event: time 1305882024.934029, type 3 (Absolute), code 0 (X), value 2=
70
> Event: time 1305882024.934034, type 3 (Absolute), code 1 (Y), value 1=
513
> Event: time 1305882024.934039, type 2 (Relative), code 9 (Misc), valu=
e 1
> Event: time 1305882024.934043, -------------- Report Sync -----------=
-
> Event: time 1305882024.943019, type 2 (Relative), code 9 (Misc), valu=
e 1
> Event: time 1305882024.943025, -------------- Report Sync -----------=
-
> Event: time 1305882024.951998, type 3 (Absolute), code 0 (X), value 2=
75
> Event: time 1305882024.952006, type 3 (Absolute), code 1 (Y), value 1=
519
> Event: time 1305882024.952010, type 2 (Relative), code 9 (Misc), valu=
e 1
> Event: time 1305882024.952014, -------------- Report Sync -----------=
-
>
>
> Now with hid-multitouch I have:
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input1
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.1/=
input/input18
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul event16
> B: PROP=3D0
> B: EV=3D100003
> B: KEY=3D0
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input2
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.2/=
input/input19
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul event17
> B: PROP=3D0
> B: EV=3Db
> B: KEY=3D0
> B: ABS=3D60000000000003
>
> I: Bus=3D0003 Vendor=3D202e Product=3D0005 Version=3D0111
> N: Name=3D"LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> P: Phys=3Dusb-0000:00:1d.0-1.1/input3
> S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.3/=
input/input20
> U: Uniq=3D
> H: Handlers=3Dmac-button-emul event18
> B: PROP=3D0
> B: EV=3Db
> B: KEY=3D400 0 0 0 0 0
> B: ABS=3D60000000000003
>
> And event17:
>
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x202e product 0x5 version 0x111
> Input device name: "LUMIO Inc LUMIO CrystalTouch ver 1.1C"
> Supported events:
> =A0Event type 0 (Sync)
> =A0Event type 1 (Key)
> =A0Event type 3 (Absolute)
> =A0 =A0Event code 0 (X)
> =A0 =A0 =A0Value =A0 =A0 =A00
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> =A0 =A0Event code 1 (Y)
> =A0 =A0 =A0Value =A0 =A0 =A00
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> =A0 =A0Event code 53 (?)
> =A0 =A0 =A0Value =A0 =A0 =A00
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> =A0 =A0Event code 54 (?)
> =A0 =A0 =A0Value =A0 =A0 =A00
> =A0 =A0 =A0Min =A0 =A0 =A0 =A00
> =A0 =A0 =A0Max =A0 =A0 4095
> Testing ... (interrupt to exit)
> Event: time 1305886175.641112, -------------- Report Sync -----------=
-
>
> And then nothing. Any idea about how to progress?
>
> --
> Bye, Peter Korsgaard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
