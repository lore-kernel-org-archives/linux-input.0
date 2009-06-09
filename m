From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Tue, 09 Jun 2009 23:26:51 +0200
Message-ID: <4A2ED39B.30100@gmail.com>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com> <49E4E7E1.7040109@gmail.com> <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:20614 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZFIV0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2009 17:26:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so101413fgg.17
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2009 14:26:53 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org, locoxella@gmail.com

On 04/14/2009 11:09 PM, Jiri Kosina wrote:
> On Tue, 14 Apr 2009, Jiri Slaby wrote:
> 
>>> I have an Apple bluetooth mouse (info below) and have noticed that the 
>>> horizontal scrolling is inverted. I've noticed some bug reports from 
>>> others getting the same behavior. I looked at drivers/hid/hid-apple.c 
>>> , and around line 444 I see that APPLE_INVERT_HWHEEL gets ORed in. I 
>>> tried to trace the origins of the code, but I lost track of it before 
>>> 8c19a515, where you moved Apple quirks to their own file. Is this 
>>> quirk definitely correct?
>>> Mouse's entry in /proc/bus/input/devices
>>> I: Bus=0005 Vendor=05ac Product=030c Version=0200
>>> I'm running Gentoo, vanilla 2.6.29 with no patches.
>> I have no idea whether the inversion is correct or not. Or where the
>> information comes from :).
>> It was added in
>> cb3fecc2f29056e89658e7eb371e7f9be66cda6d
>> by Jiri Kosina, maybe he may shed some light on it?
> 
> I created this patch based solely on a bugreport, I didn't physically own 
> the hardware at that time.
> 
> I think I have it somewhere. I will try to find it tomorrow or the day 
> after tomorrow and verify whether the quirk is really needed. Maybe the 
> original bug reporter messed up, or he had different hardware revision.

Any news here?

I think this is what you hit too, Andres?


Interesting part from the Andres' email follows:

I have an Apple Mighty Mouse. This is how it looks with 'cat
/proc/bus/input/devices'

I: Bus=0005 Vendor=05ac Product=030c Version=0200
N: Name="Mighty Mouse"

And the trackball on it has it x axis inverted.

Ive searched about this problem and found a Linux kernel mailing list
conversation where this error maybe had raised. A guy but a similar
mouse (also a mightymouse), but different ID (0x1000 instead of 0x030c),
was told to invert the x axis in order to have his 0x1000 mighty mouse
working with the wrong ID: 0x030c instead of adding a while new device.
Probably, inverting the trackball for the rest of us with the right id.

I will quote the mailing list post to you:

> As a newbie, I just saw your email in the source-file when I was looking
> into the sources of hid-apple.c to find my mighty mouse somewhere:
>
> /* Apple wireless Mighty Mouse */
> { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
> .driver_data = APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
>
> According to hid-ids.h, the ID 0x030c is a TDK mighty mouse. On my
> Alu-iMac (last year edition), it's a Apple's owned mighty mouse (vendor
> 0x05ac, ID 0x1000), which is not currently listed in hid-ids.h. My
> mighty mouse anyway runs o.k. with the "wrong" ID, but since the start
> withouth the mouse-wheel.
> It did not help when I changed the ID's accordingly. So my question is:
> Is there anything to be done in bluetooth driver area too to get this
> mighty mouse fully supported (some quirks needed)?
