From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Fri, 27 Feb 2015 09:16:44 -0500
Message-ID: <CAN+gG=F=aGvK85zpAHKSeaHrNtytsuiDBUDPWx1MkrBq3DyU6w@mail.gmail.com>
References: <54C85FB5.9050404@simon-woerner.de>
	<1422492195-11492-1-git-send-email-linux@simon-woerner.de>
	<alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>
	<54E3F287.3040900@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34909 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbB0OQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 09:16:45 -0500
Received: by qcyl6 with SMTP id l6so14040930qcy.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2015 06:16:45 -0800 (PST)
In-Reply-To: <54E3F287.3040900@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Florian Echtler <floe@butterbrot.org>
Cc: Jiri Kosina <jkosina@suse.cz>, =?UTF-8?Q?Simon_W=C3=B6rner?= <linux@simon-woerner.de>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>, =?UTF-8?Q?Simon_W=C3=B6rner?= <mail@simon-woerner.de>

[adding Florian to the thread, he is also affected by this]

On Tue, Feb 17, 2015 at 9:01 PM, Andrew Duggan <aduggan@synaptics.com> =
wrote:
> On 02/17/2015 04:30 AM, Jiri Kosina wrote:
>>
>> On Thu, 29 Jan 2015, linux@simon-woerner.de wrote:
>>
>>> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>>>
>>> HID: Add driver for acer keybard with broken rdesc
>>
>> Hi Simon,
>>
>> to make sure proper device <-> driver binding is performed, you also=
 have
>> to add device ID to the hid_have_special_driver[] array.
>>

To the cost of an error in the kernel log, the proper binding will be
done even if if there is no entry in hid_have_special_driver :)

See Florian's log:
[    3.153892] hid-generic 0003:06CB:2991.0003: usage index exceeded
[    3.153896] hid-generic 0003:06CB:2991.0003: item 0 2 2 2 parsing fa=
iled
[    3.153921] hid-generic: probe of 0003:06CB:2991.0003 failed with er=
ror -22

So hid-generic will fail to bind the device, so normally hid-acer
should bind it, fix the report descriptor and the keyboard should be
working.

Not very clean, but it should work :)

> I have been meaning to respond to this patch. Unfortunately, simply a=
dding
> this driver to the hid_have_special_driver[] list will prevent
> hid-multitouch from binding to the touchpad which shares the same vid=
 and
> pid. My suggestion would be to create a new scan_flag for GD_KEYBOARD=
 and to
> add to the code in hid_scan_collection() which scans the GENDESK usag=
es.
> Similar to the code which is searching for HID_GD_POINTER. Then in
> hid_scan_report() we could assign a group for this driver based on th=
e pid
> and the GD_KEYBOARD scan flag in the vendor handling code.

This could work, but that means that the list of special quirks after
the parsing is going to explode :(

Plus we have to be sure that the scan_report doesn't fail or we will
not be able to tag the device correctly.

>
> I can help out with implementing this part of the patch if there aren=
't any
> other suggestions. Adding a new group and more code to the hid_scan_r=
eport()
> vendor handling code is definately not ideal. But, I am not sure of a=
 better
> way of binding different sub drivers to devices with the same vid and=
 pid.
>
> An alternative would be to have hid-rmi handle all Synaptics touchpad=
s, even
> the ones which currently use hid-multitouch. Then the keyboard report
> descriptor fixup could just be handled in hid-rmi. Accessing the fing=
er data
> via rmi mode would also have the benefit of being able to report even=
ts
> which are currently not supported by the PTP collection (ie ABS_MT_PR=
ESSURE,
> ABS_MT_TOUCH_MAJOR/MINOR). The touchpads which currently use hid-mult=
itouch
> report finger data a little differently then the ones currently using
> hid-rmi so there is some work which would need to be done to add supp=
ort for
> them in hid-rmi.
>

I am not sure we want to do that. Because we don't want hid-rmi to fix
all crappy keyboards around when the OEM reuses the synaptics PID.

Maybe a better way of handling such situation is to provide a generic
mechanism to overwrite/patch the report descriptor so that we could
get rid of the drivers which just fix the report descriptor.
I have on a branch a version where I look into /lib/firmware/hid if
there is a matching device and a matching report descriptor. Then, I
read this firmware dynamically and patch the report descriptor.
This however requires that the hid modules are not included directly
in the kernel, or the /lib/firmware dir is not available and the
device doesn't bind.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
