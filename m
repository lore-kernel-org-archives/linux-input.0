From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Wed, 29 Jan 2014 10:07:40 -0500
Message-ID: <CAN+gG=EOqfyOid8bDYH5GYCsOOqYysuUdusg5XOh6LtUMShd_g@mail.gmail.com>
References: <1674012.xCMptsh8XR@myon.chronox.de>
	<2093581.PZC0zrVCWg@myon.chronox.de>
	<CAN+gG=Ev=ebkx8Usa=BgXMYVMQekG-s2gwa5N2TQSw7hisMT_w@mail.gmail.com>
	<3981247.bRK36pG72j@tauon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59329 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaA2PHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 10:07:42 -0500
In-Reply-To: <3981247.bRK36pG72j@tauon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On Wed, Jan 29, 2014 at 9:59 AM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Mittwoch, 29. Januar 2014, 09:53:03 schrieb Benjamin Tissoires:
>
> Hi Benjamin,
>
>>On Fri, Jan 24, 2014 at 11:51 PM, Stephan Mueller <smueller@chronox.de>
> wrote:
>>> Am Samstag, 25. Januar 2014, 12:17:13 schrieb Mattia Dongili:
>>>
>>> Hi Mattia,
>>>
>>>> I'd try with the input subsystem and the synaptics_usb driver first
>>>> but it's just a wild guess. Your kernel log should give you more
>>>> hints about which driver is bound to the device and the sysfs tree
>>>> under
>>>> /sys/class/input/event*/device/* has all the capabilities and
>>>> identifiers.
>>>
>>> The following did not help:
>>>
>>> modprobe synaptics_usb
>>> cd /sys/bus/usb/drivers/usbhid
>>> echo -n "1-1.3:1.0" > unbind
>>> #now the mouse is without driver, does not move, and
>>> #/sys/class/input/event2/device/device is without driver
>>> cd /sys/bus/usb/drivers/synaptics_usb
>>> echo -n "1-1.3:1.0" > bind
>>> #error: no such device, mouse does not work, nothing in dmesg
>>> cd /sys/bus/usb/drivers/usbhid
>>> echo -n "1-1.3:1.0" > bind
>>> #mouse works again without middle button
>>
>>Hi Stephan,
>>
>>in this case, you definitively want to talk to HID (and input) folks.
>>Adding Jiri, the HID maintainer in the discussion.
>>
>>Your mouse does not seem to be handled properly by the hid subsystem
>>and needs quirks, or fix.
>>
>>Can you send us some hid-recorder[1] traces of your device? We should
>>then be able to check what's wrong and hopefully fix the problem.
>
> Thanks a lot for the helping hand. I will try your suggestion tonight
> and report back.
>
> But please allow me to point out that I have doubts that HID or input is
> at fault, because when sniffing on the USB bus with usbmon, I do *not*
> see any information transported when pressing the middle button.
> Therefore, I would suspect it is rather the base USB driver that somehow
> needs a quirk to access the mouse properly.
>

Oh, then in this case it may be that your device needs to be put in a
special mode, and the report descriptors will show us some hints on
how to do it (maybe).
I strongly doubt that USB is in fault here. I can not see any reasons
why the USB or underlying driver would select which packets are
transmitted.

What you can also do is setup a windows virtual machine, assign the
usb device to it, and sniff through usbmon or wireshark what packets
are emitted from/to the mouse. Then, we will duplicate this behavior
in the hid driver, and you would be good to go. Still, having the
reports descriptors (which are provided by hid-recorder, or in
/sys/kernel/debug/hid/DEVICE/rdesc, or in lsusb -vv when the usbhid
driver is not bound) would help us to understand the mouse firmware.

Cheers,
Benjamin
