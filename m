From: zitev <zitev@freemail.hu>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Wed, 01 Feb 2012 20:33:19 +0100
Message-ID: <4F29937F.1050304@freemail.hu>
References: <4D55AE81.3030805@freemail.hu> <20120126002100.GA4495@burratino> <4F21C49D.2010906@freemail.hu> <20120126213939.GA5179@burratino> <4F230A1A.7080508@freemail.hu> <20120128071223.GA27331@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail00k.mail.t-online.hu ([84.2.227.137]:45480 "EHLO
	mail00k.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab2BATjz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2012 14:39:55 -0500
In-Reply-To: <20120128071223.GA27331@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz

i attached the detail of syslog:

"Feb  1 20:26:40 player kernel: [ 1247.275287] usb 1-1.1: new high-spee=
d=20
USB device number 6 using ehci_hcd
=46eb  1 20:26:40 player kernel: [ 1247.444488] usb 1-1.1: New USB devi=
ce=20
found, idVendor=3D05e3, idProduct=3D0608
=46eb  1 20:26:40 player kernel: [ 1247.520511] usb 1-1.1: New USB devi=
ce=20
strings: Mfr=3D0, Product=3D1, SerialNumber=3D0
=46eb  1 20:26:40 player kernel: [ 1247.596369] usb 1-1.1: Product: USB=
2.0 Hub
=46eb  1 20:26:40 player kernel: [ 1247.672160] hub 1-1.1:1.0: USB hub =
found
=46eb  1 20:26:40 player kernel: [ 1247.736605] hub 1-1.1:1.0: 4 ports=20
detected
=46eb  1 20:26:41 player kernel: [ 1248.074036] usb 1-1.1.2: new=20
full-speed USB device number 7 using ehci_hcd
=46eb  1 20:26:41 player kernel: [ 1248.240627] usb 1-1.1.2: New USB=20
device found, idVendor=3D1044, idProduct=3D7a02
=46eb  1 20:26:41 player kernel: [ 1248.314881] usb 1-1.1.2: New USB=20
device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
=46eb  1 20:26:41 player mtp-probe: checking bus 1, device 7:=20
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1.2"
=46eb  1 20:26:41 player kernel: [ 1248.391648] generic-usb: probe of=20
0003:1044:7A02.0006 failed with error -22
=46eb  1 20:26:41 player kernel: [ 1248.459226] input: HID 1044:7a02 as=
=20
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/inp=
ut/input7
=46eb  1 20:26:41 player kernel: [ 1248.523851] generic-usb=20
0003:1044:7A02.0007: input,hiddev0,hidraw0: USB HID v1.11 Mouse [HID=20
1044:7a02] on usb-0000:00:1a.0-1.1.2/input1
=46eb  1 20:26:41 player kernel: [ 1248.592068] generic-usb=20
0003:1044:7A02.0008: input,hidraw1: USB HID v1.11 Device [HID 1044:7a02=
]=20
on usb-0000:00:1a.0-1.1.2/input2
=46eb  1 20:26:41 player mtp-probe: bus: 1, device: 7 was not an MTP de=
vice
=46eb  1 20:26:41 player kernel: [ 1248.729040] usb 1-1.1.4: new low-sp=
eed=20
USB device number 8 using ehci_hcd
=46eb  1 20:26:42 player kernel: [ 1248.917065] usb 1-1.1.4: New USB=20
device found, idVendor=3D060b, idProduct=3D2270
=46eb  1 20:26:42 player kernel: [ 1248.990757] usb 1-1.1.4: New USB=20
device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
=46eb  1 20:26:42 player kernel: [ 1249.063713] usb 1-1.1.4: Product: U=
SB=20
Keyboard
=46eb  1 20:26:42 player kernel: [ 1249.136990] usb 1-1.1.4: Manufactur=
er: KB
=46eb  1 20:26:42 player kernel: [ 1249.219263] input: KB USB Keyboard =
as=20
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/inp=
ut/input8
=46eb  1 20:26:42 player kernel: [ 1249.293903] generic-usb=20
0003:060B:2270.0009: input,hidraw2: USB HID v1.10 Keyboard [KB USB=20
Keyboard] on usb-0000:00:1a.0-1.1.4/input0
=46eb  1 20:26:42 player kernel: [ 1249.380643] generic-usb: probe of=20
0003:060B:2270.000A failed with error -22
=46eb  1 20:26:42 player mtp-probe: checking bus 1, device 8:=20
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1.4"
=46eb  1 20:26:42 player mtp-probe: bus: 1, device: 8 was not an MTP de=
vice"

2012-01-28 08:12 keltez=E9ssel, Jonathan Nieder =EDrta:
> zitev wrote:
>
>> I attached the lsusb output!
> Perfect, thanks.
>
>> Bus 001 Device 004: ID 1044:7a02 Chu Yuen Enterprise Co., Ltd
> [...]
>>      bNumInterfaces          3
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              2 KB
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              3 Mouse
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              4 K8100 Interface
> Can you set up usbmon and get a trace of e.g., pressing, holding,
> then releasing the "a" key?  See Documentation/usb/usbmon.txt
> in the Linux source or the doc directory of the linux-doc-3.2
> package for details.
>
> It works roughly like this:
>
> 1. Mount debugfs and load the usbmon module:
>
>    mount -t debugfs debugfs /sys/kernel/debug
>    modprobe usbmon
>
> 2. Start tracing:
>
>    {
>      sleep 1; # one second of quiet
>      cat /sys/kernel/debug/usb/usbmon/1u>/tmp/mon.out&
>      sleep 20; # twenty seconds or so to run the test
>      kill $!; # and then stop collecting data
>    }
>
> 3. Somehow summarize the output.  If it is fairly small, an
> attachment is fine; otherwise, excerpts and maybe a link to a
> copy that can be downloaded online might work.
>
> Hope that helps,
> Jonathan
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
