From: Andrew Duggan <andrew.duggan@gmail.com>
Subject: Re: Synaptics touchpad reset issue
Date: Fri, 27 Nov 2015 12:02:06 -0800
Message-ID: <CAE7eX3+KPk+i-1r1R-MpvWPV5q6ASYAJfhrVpzNNV87Yw9bjZA@mail.gmail.com>
References: <20151123094336.GC11291@toimisto-tuomas-07.toimisto.opinsys.fi>
	<CAE7eX3JTaBFutMua6PqTLV90joHd9+V=1migsB9HOcWUubDnaw@mail.gmail.com>
	<20151126151202.GA30383@toimisto-tuomas-07.toimisto.opinsys.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33224 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbK0UCH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 15:02:07 -0500
Received: by iouu10 with SMTP id u10so124248398iou.0
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2015 12:02:06 -0800 (PST)
In-Reply-To: <20151126151202.GA30383@toimisto-tuomas-07.toimisto.opinsys.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?VHVvbWFzIFLDpHPDpG5lbg==?= <tuomasjjrasanen@opinsys.fi>
Cc: linux-input <linux-input@vger.kernel.org>, Josep Pujadas-Jubany <jpujades@gmail.com>, Tobias Naumann <tobias-naumann@gmx.net>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?B?VHVvbWFzIFLDpHPDpG5lbg==?= <tuomasjjrasanen@tjjr.fi>

On Thu, Nov 26, 2015 at 7:12 AM, Tuomas R=C3=A4s=C3=A4nen
<tuomasjjrasanen@opinsys.fi> wrote:
> On Wed, Nov 25, 2015 at 05:15:44PM -0800, Andrew Duggan wrote:
>> Hi Tuomas,
>>
>
> Hi Andrew and thanks for the reply,
>
>> It looks like some other people have reported similar issues with th=
is
>> particular touchpad module. I think there might be a hardware issue
>> with some touchpads with the board/product id of 2991. Since this
>> maybe a hardware issue there might not be a fix, but there might be =
a
>> work around. This touchpad has a HID/I2C interface in addition to th=
e
>> PS/2 interface.
>>
>
> Yes, I agree it's definitely a hardware issue. I'm just trying gather=
 up
> all bits and pieces to make an ugly but simple workaround:
>
>  1. detect a malfunction by observing pressure values (just a simple =
threshold heuristic)
>  2. reset the device when it's malfunctioning
>
>> You should see a line in dmesg which looks something like this:
>> hid-multitouch 0018:06CB:2991.0001: input,hidraw0: <UNKNOWN> HID v1.=
00
>> Mouse [SYN1B7F:00 06CB:2991] on
>>
>
> Yes, I just had to visit BIOS and set the touchpad operation mode to
> "advanced".

Interesting, I thought it would be enabled by default.

>
>> If you download and build rmihidtool
>> (https://github.com/aduggan/rmi4utils), you can manually reset the
>> touchpad and hopefully return it to a working state. The Fn+F7 on
>> Windows is probably doing something similar by either cutting power =
to
>> the touchpad or forcing a reset.
>>
>> Running this command will reset the touchpad:
>> $ sudo rmihidtool -e /dev/hidraw0
>>
>
> Seems to work as expected.
>
>> If the touchpad stops working completely then you may need to rebind
>> the driver so that the touchpad is put back into PTP mode:
>> $ sudo rmihidtool -b /dev/hidraw0
>>
>
> Yes, rebind was required after a reset.
>
>> >
>> > To me it seems like the touchpad somehow recalibrates itself and b=
ecomes
>> > highly sensitive and begins to emits touch events even when there'=
s no
>> > one touching it. The sensitiveness can be observed by looking at M=
T_ABS
>> > values: in normal conditions maximum values are around 120, but in
>> > confused state they are around 190.
>> >
>>
>> Do you mean EV_ABS?
>
> I actually meant ABS_MT_PRESSURE.
>
>> I'm not quite sure which values would have a
>> normal max of around 120.
>
> ABS_MT_PRESSURE values when synaptics PS/2 driver is managing the
> device.
>
>> Generally, these types of situations where
>> false contacts are being reported are hard to distinguish in the
>> firmware or driver from real contacts. Even if you notice a specific
>> pattern on your particular system it might manifest itself different=
ly
>> on other systems.
>>
>
> Yes, but here I'm trying to come up with an ugly workaround for this
> specific device model. I guess it's quite safe to assume that all
> devices with identical hardware generate sufficiently similar values,
> no?
>

Touchpads can be influenced by environmental factors so its not always
safe to assume that problems will manifest themselves in the same way
even when the hardware is the same. However, pressure values of 190 do
seem to be outside the values which we usually report. Doing a reset
on large pressure values reported by this particular touchpad could be
a reasonable workaround.

> All in all, reseting the device via hidraw turned out to fix the
> malfunction reliably. Thanks!!
>
> But.
>
> When the device is in HID/I2C mode, ABS_MT_PRESSURE events are not
> available via the input device because hid-multitouch does not emit t=
hem
> probably because device's report descriptor is missing
> HID_DG_TIPPRESSURE usage? Otherwise it would have been mapped to
> ABS_MT_PRESSURE, according to hid-multitouch.c.
>
> On the other hand, in PS/2 mode, synaptics psmouse delivers pressure
> events, but I don't know how to reset the device.
>

Unfortunately, there isn't a way to send the reset command via the
PS/2 interface.

> Perhaps I'll check raw HID reports if they contain pressure values, b=
ut
> if they don't, I'm probably going to give up working around the probl=
em.
>

No, we don't report pressure in the HID reports in PTP mode. There is
a way to get the pressure data if you run it in RMI mode. I'm working
on a driver which would support this touchpad running in RMI mode so
when that driver is ready we could add something that does a reset in
there.

> One additional, probably silly, question though: because Fn+F7 always
> fixes the problem under the hood, is it handled by the hardware or by
> the kernel?
>

I think Fn+F7 is disabling the touchpad in the bios. I'm not an expert
on how this works, but I would assume that the ACPI commands are
telling the bios to do that. If the bios may be cutting power to the
touchpad which would get it out of that state.

Andrew

> I decompiled DSDT and looked for methods of the device (TPD8), but
> didn't see anything interesting, other than _DSM, which is probably a
> standard ACPI method, Device Specific Method?. So I was wondering if =
it's
> possible to reset the touchpad using some special ACPI method?
>
> --
> Tuomas
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
