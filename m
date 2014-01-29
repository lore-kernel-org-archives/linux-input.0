From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Wed, 29 Jan 2014 09:53:03 -0500
Message-ID: <CAN+gG=Ev=ebkx8Usa=BgXMYVMQekG-s2gwa5N2TQSw7hisMT_w@mail.gmail.com>
References: <1674012.xCMptsh8XR@myon.chronox.de>
	<20140125031713.GA30047@taihen.jp>
	<2093581.PZC0zrVCWg@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:58651 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaA2OxF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 09:53:05 -0500
In-Reply-To: <2093581.PZC0zrVCWg@myon.chronox.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On Fri, Jan 24, 2014 at 11:51 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Samstag, 25. Januar 2014, 12:17:13 schrieb Mattia Dongili:
>
> Hi Mattia,
>
>>
>> I'd try with the input subsystem and the synaptics_usb driver first but
>> it's just a wild guess. Your kernel log should give you more hints about
>> which driver is bound to the device and the sysfs tree under
>> /sys/class/input/event*/device/* has all the capabilities and
>> identifiers.
>
> The following did not help:
>
> modprobe synaptics_usb
> cd /sys/bus/usb/drivers/usbhid
> echo -n "1-1.3:1.0" > unbind
> #now the mouse is without driver, does not move, and
> #/sys/class/input/event2/device/device is without driver
> cd /sys/bus/usb/drivers/synaptics_usb
> echo -n "1-1.3:1.0" > bind
> #error: no such device, mouse does not work, nothing in dmesg
> cd /sys/bus/usb/drivers/usbhid
> echo -n "1-1.3:1.0" > bind
> #mouse works again without middle button
>

Hi Stephan,

in this case, you definitively want to talk to HID (and input) folks.
Adding Jiri, the HID maintainer in the discussion.

Your mouse does not seem to be handled properly by the hid subsystem
and needs quirks, or fix.

Can you send us some hid-recorder[1] traces of your device? We should
then be able to check what's wrong and hopefully fix the problem.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/
