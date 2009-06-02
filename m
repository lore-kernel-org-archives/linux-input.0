From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard)  
  stopped functioning in kernels >= 2.6.28
Date: Tue, 02 Jun 2009 12:29:40 +0300
Message-ID: <4A24F104.6010503@teltonika.lt>
References: <bug-13411-10286@http.bugzilla.kernel.org/>	 <20090601202509.87f57ef9.akpm@linux-foundation.org> <680426130906012044r6a499989ub196936a409e437c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 81-7-68-229.static.zebra.lt ([81.7.68.229]:35844 "EHLO
	teltonika.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755301AbZFBKUS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Jun 2009 06:20:18 -0400
In-Reply-To: <680426130906012044r6a499989ub196936a409e437c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maximi89 <maximi89@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bugzilla.kernel.org@starbase12.cjb.net

Maximi89 wrote:
> hi, is possible because this is not on usbtutils?
> i was looking the usbutils, but only this:
> 1130  Tenx Technology, Inc.
> 	f211  audio headset
> 
>   idVendor           0x1130 Tenx Technology, Inc.
>   idProduct          0x0001
> 
> can be possible that?
> 
> 
> i found this, maybe can help you.
> http://lkml.org/lkml/2009/2/10/434

Yes, this device is defined in hid_ignore_list[] (drivers/hid/hid-core.c)
 
> 2009/6/1, Andrew Morton <akpm@linux-foundation.org>:
>> (switched to email.  Please respond via emailed reply-to-all, not via the
>> bugzilla web interface).
>>
>> On Sun, 31 May 2009 12:21:58 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=13411
>>>
>>>            Summary: Barscanner (USB HID Keyboard) stopped functioning in
>>>                     kernels >= 2.6.28
>>>            Product: Drivers
>>>            Version: 2.5
>>>     Kernel Version: >= 2.6.28
>>>           Platform: All
>>>         OS/Version: Linux
>>>               Tree: Mainline
>>>             Status: NEW
>>>           Severity: normal
>>>           Priority: P1
>>>          Component: Input Devices
>>>         AssignedTo: drivers_input-devices@kernel-bugs.osdl.org
>>>         ReportedBy: bugzilla.kernel.org@starbase12.cjb.net
>>>         Regression: Yes
>> Does anyone want to claim this regression?  USB, HID or Input??
>>
>> Thanks.
>>
>>> Created an attachment (id=21656)
>>>  --> (http://bugzilla.kernel.org/attachment.cgi?id=21656)
>>> Additional information (lsusb, lspci, ioports, iomem, kernel configs)
>>>
>>> My K__nig CMP-BARSCAN 10 (being reported as ID 1130:0001 Tenx Technology,
>>> Inc.)
>>> stopped working in kernels upwards from 2.6.28. I'm running a Gentoo
>>> 64-bits
>>> system.
>>>
>>> The device is still being detected, however, no input-node is being
>>> created.
>>> Dmesg reports (under a 2.6.28 kernel):
>>>
>>> usb 6-2: new low speed USB device using uhci_hcd and address 2
>>> usb 6-2: configuration #1 chosen from 1 choice
>>> usb 6-2: New USB device found, idVendor=1130, idProduct=0001
>>> usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>>> usb 62: Product: USB-TMU
>>>
>>>
>>> Under 2.6.27.24 it does work as expected. Dmesg reports:
>>>
>>> usb 6-2: new low speed USB device using uhci_hcd and address 2
>>> usb 6-2: configuration #1 chosen from 1 choice
>>> input: USB-TMU as /class/input/input6
>>> input: USB HID v1.10 Keyboard [USB-TMU] on usb-0000:00:1d.0-2
>>> usb 6-2: New USB device found, idVendor=1130, idProduct=0001
>>> usb 6-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>>> usb 6-2: Product: USB-TMU
>>>
>>>
>>> Trying several kernels, I can conclude the following:
>>>
>>> 2.6.25-Gentoo-r9     --> Works
>>> 2.6.27-Gentoo-r8     --> Works
>>> 2.6.28-Gentoo-r5     --> Broken
>>>
>>> 2.6.27.10 (Vanilla)  --> Works
>>> 2.6.27.24 (Vanilla)  --> Works
>>> 2.6.28 (Vanilla)     --> Broken
>>> 2.6.28.9 (Vanilla)   --> Broken
>>> 2.6.29.4 (Vanilla)   --> Broken
>>> 2.6.30 RC7 (Vanilla) --> Broken
>>>
>>>
>>> Additional information is attached in the attached text file, containing:
>>> * lsusb -vv output
>>> * Kernel 2.6.27 configuration
>>> * Kernel 2.6.29 configuration
>>> * /proc/ioports
>>> * /proc/iomem
>>> * lspci -vvv
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 

