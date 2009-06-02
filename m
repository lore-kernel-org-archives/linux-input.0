From: Maximi89 <maximi89@gmail.com>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard)
	stopped functioning in kernels >= 2.6.28
Date: Mon, 1 Jun 2009 23:44:47 -0400
Message-ID: <680426130906012044r6a499989ub196936a409e437c@mail.gmail.com>
References: <bug-13411-10286@http.bugzilla.kernel.org/>
	 <20090601202509.87f57ef9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:64752 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbZFBDor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2009 23:44:47 -0400
In-Reply-To: <20090601202509.87f57ef9.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bugzilla.kernel.org@starbase12.cjb.net

hi, is possible because this is not on usbtutils?
i was looking the usbutils, but only this:
1130  Tenx Technology, Inc.
	f211  audio headset

  idVendor           0x1130 Tenx Technology, Inc.
  idProduct          0x0001

can be possible that?


i found this, maybe can help you.
http://lkml.org/lkml/2009/2/10/434

2009/6/1, Andrew Morton <akpm@linux-foundation.org>:
>
> (switched to email.  Please respond via emailed reply-to-all, not via=
 the
> bugzilla web interface).
>
> On Sun, 31 May 2009 12:21:58 GMT bugzilla-daemon@bugzilla.kernel.org =
wrote:
>
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D13411
>>
>>            Summary: Barscanner (USB HID Keyboard) stopped functionin=
g in
>>                     kernels >=3D 2.6.28
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: >=3D 2.6.28
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: Input Devices
>>         AssignedTo: drivers_input-devices@kernel-bugs.osdl.org
>>         ReportedBy: bugzilla.kernel.org@starbase12.cjb.net
>>         Regression: Yes
>
> Does anyone want to claim this regression?  USB, HID or Input??
>
> Thanks.
>
>>
>> Created an attachment (id=3D21656)
>>  --> (http://bugzilla.kernel.org/attachment.cgi?id=3D21656)
>> Additional information (lsusb, lspci, ioports, iomem, kernel configs=
)
>>
>> My K__nig CMP-BARSCAN 10 (being reported as ID 1130:0001 Tenx Techno=
logy,
>> Inc.)
>> stopped working in kernels upwards from 2.6.28. I'm running a Gentoo
>> 64-bits
>> system.
>>
>> The device is still being detected, however, no input-node is being
>> created.
>> Dmesg reports (under a 2.6.28 kernel):
>>
>> usb 6-2: new low speed USB device using uhci_hcd and address 2
>> usb 6-2: configuration #1 chosen from 1 choice
>> usb 6-2: New USB device found, idVendor=3D1130, idProduct=3D0001
>> usb 6-2: New USB device strings: Mfr=3D0, Product=3D2, SerialNumber=3D=
0
>> usb 62: Product: USB-TMU
>>
>>
>> Under 2.6.27.24 it does work as expected. Dmesg reports:
>>
>> usb 6-2: new low speed USB device using uhci_hcd and address 2
>> usb 6-2: configuration #1 chosen from 1 choice
>> input: USB-TMU as /class/input/input6
>> input: USB HID v1.10 Keyboard [USB-TMU] on usb-0000:00:1d.0-2
>> usb 6-2: New USB device found, idVendor=3D1130, idProduct=3D0001
>> usb 6-2: New USB device strings: Mfr=3D0, Product=3D2, SerialNumber=3D=
0
>> usb 6-2: Product: USB-TMU
>>
>>
>> Trying several kernels, I can conclude the following:
>>
>> 2.6.25-Gentoo-r9     --> Works
>> 2.6.27-Gentoo-r8     --> Works
>> 2.6.28-Gentoo-r5     --> Broken
>>
>> 2.6.27.10 (Vanilla)  --> Works
>> 2.6.27.24 (Vanilla)  --> Works
>> 2.6.28 (Vanilla)     --> Broken
>> 2.6.28.9 (Vanilla)   --> Broken
>> 2.6.29.4 (Vanilla)   --> Broken
>> 2.6.30 RC7 (Vanilla) --> Broken
>>
>>
>> Additional information is attached in the attached text file, contai=
ning:
>> * lsusb -vv output
>> * Kernel 2.6.27 configuration
>> * Kernel 2.6.29 configuration
>> * /proc/ioports
>> * /proc/iomem
>> * lspci -vvv
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Maximiliano Augusto Casta=F1=F3n Araneda
Santiago, Chile
Linux user # 394821
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
