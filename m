From: =?UTF-8?B?TWlyb3NsYXYgxaB1bGM=?= <miroslav.sulc@fordfrog.com>
Subject: Re: usb mouse razer taipan does not work with hid
Date: Tue, 06 Nov 2012 16:53:17 +0100
Message-ID: <5099326D.40305@fordfrog.com>
References: <5099216A.1000006@fordfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from thia.startnet.cz ([176.9.43.86]:53001 "EHLO mail.startnet.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab2KFPxT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Nov 2012 10:53:19 -0500
Received: from shaxer.fordfrog.com (unknown [78.110.211.180])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.startnet.cz (Postfix) with ESMTPSA id B216D91B
	for <linux-input@vger.kernel.org>; Tue,  6 Nov 2012 16:53:17 +0100 (CET)
In-Reply-To: <5099216A.1000006@fordfrog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

forgot to add that `lsof | grep event4` shows nothing.

miroslav

Dne 6.11.2012 15:40, Miroslav =C5=A0ulc napsal(a):
> hi,
>
> i have two mice in my system, both usb. one is "Microsoft=C2=AE 2.4GH=
z
> Transceiver v5.0" (that one works fine) and the other is "Razer Taipa=
n"
> (that one does not work). both mice are connected via usb hub in my d=
isplay.
>
> # uname -a
> Linux shaxer.fordfrog.com 3.6.6-gentoo #1 SMP PREEMPT Tue Nov 6 12:50=
:23
> CET 2012 x86_64 Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz GenuineIntel
> GNU/Linux
>
>
> dmesg output after boot:
> [ 2.357115] usb 2-1.6.4: new full-speed USB device number 7 using ehc=
i_hcd
> [ 2.430933] usb 2-1.6.4: device descriptor read/64, error -32
> [ 2.618225] usb 2-1.6.4: New USB device found, idVendor=3D1532, idPro=
duct=3D0034
> [ 2.618368] usb 2-1.6.4: New USB device strings: Mfr=3D1, Product=3D2=
,
> SerialNumber=3D0
> [ 2.618563] usb 2-1.6.4: Product: Razer Taipan
> [ 2.618680] usb 2-1.6.4: Manufacturer: Razer
> [ 3.020661] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.0/i=
nput/input4
> [ 3.021025] hid-generic 0003:1532:0034.0001: input,hidraw0: USB HID
> v1.11 Mouse [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input0
> [ 3.022561] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.1/i=
nput/input5
> [ 3.022854] hid-generic 0003:1532:0034.0002: input,hidraw1: USB HID
> v1.11 Keyboard [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input1
> [ 3.023251] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.2/i=
nput/input6
> [ 3.023636] hid-generic 0003:1532:0034.0003: input,hidraw2: USB HID
> v1.11 Keyboard [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input2
>
>
> dmesg output after unplugging and plugging the mouse again:
> [ 1391.995745] usb 2-1.6.4: new full-speed USB device number 10 using
> ehci_hcd
> [ 1392.082377] usb 2-1.6.4: New USB device found, idVendor=3D1532,
> idProduct=3D0034
> [ 1392.082394] usb 2-1.6.4: New USB device strings: Mfr=3D1, Product=3D=
2,
> SerialNumber=3D0
> [ 1392.082399] usb 2-1.6.4: Product: Razer Taipan
> [ 1392.082403] usb 2-1.6.4: Manufacturer: Razer
> [ 1392.083316] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.0/i=
nput/input23
> [ 1392.083711] hid-generic 0003:1532:0034.0007: input,hidraw0: USB HI=
D
> v1.11 Mouse [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input0
> [ 1392.085887] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.1/i=
nput/input24
> [ 1392.086136] hid-generic 0003:1532:0034.0008: input,hidraw1: USB HI=
D
> v1.11 Keyboard [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input1
> [ 1392.086951] input: Razer Razer Taipan as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4:1.2/i=
nput/input25
> [ 1392.100363] input: failed to attach handler kbd to device input25,
> error: -16
> [ 1392.100577] hid-generic 0003:1532:0034.0009: input,hidraw2: USB HI=
D
> v1.11 Keyboard [Razer Razer Taipan] on usb-0000:00:1d.0-1.6.4/input2
>
>
> /proc/bus/input/devices lists this:
>
> I: Bus=3D0003 Vendor=3D1532 Product=3D0034 Version=3D0111
> N: Name=3D"Razer Razer Taipan"
> P: Phys=3Dusb-0000:00:1d.0-1.6.4/input0
> S:
> Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6=
=2E4:1.0/input/input23
> U: Uniq=3D
> H: Handlers=3Dmouse0 event4
> B: PROP=3D0
> B: EV=3D17
> B: KEY=3D1f0000 0 0 0 0
> B: REL=3D103
> B: MSC=3D10
>
> I: Bus=3D0003 Vendor=3D1532 Product=3D0034 Version=3D0111
> N: Name=3D"Razer Razer Taipan"
> P: Phys=3Dusb-0000:00:1d.0-1.6.4/input1
> S:
> Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6=
=2E4:1.1/input/input24
> U: Uniq=3D
> H: Handlers=3Dsysrq kbd event5
> B: PROP=3D0
> B: EV=3D10001f
> B: KEY=3D4837fff072ff32d bf54444600000000 1 30c100b17c007 ffbf7bfad94=
1dfff
> febeffdfffefffff fffffffffffffffe
> B: REL=3D40
> B: ABS=3Dffffff0100000000
> B: MSC=3D10
>
> I: Bus=3D0003 Vendor=3D1532 Product=3D0034 Version=3D0111
> N: Name=3D"Razer Razer Taipan"
> P: Phys=3Dusb-0000:00:1d.0-1.6.4/input2
> S:
> Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6=
=2E4:1.2/input/input25
> U: Uniq=3D
> H: Handlers=3Dsysrq event6
> B: PROP=3D0
> B: EV=3D120013
> B: KEY=3D1000000000007 ff9f207ac14057ff febeffdfffefffff ffffffffffff=
fffe
> B: MSC=3D10
> B: LED=3D7
>
>
> reading from the event file fails:
>
> # LC_ALL=3DC cat /dev/input/event4
> cat: /dev/input/event4: Device or resource busy
>
>
> my kernel config: http://pastebin.com/1VNKetxz
> complete dmesg output: http://pastebin.com/NX3Z7c6W
>
>
> the mouse used to work in kernel 3.2.x but that used usb-generic modu=
le
> instead of hid-generic. i also tried kernel 3.4.11 but the mouse does
> not work there. the mouse works fine under windows and works in gui b=
ios
> too.
>
>
> can i help somehow to make this mouse work again in linux kernel?
>
>
> miroslav
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
