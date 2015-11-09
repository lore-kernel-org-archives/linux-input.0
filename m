From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Fake KEY_5 continuous keydown events with Logitech wireless
 keyboard on Kernel 4.2
Date: Mon, 9 Nov 2015 11:36:38 +0100
Message-ID: <CAN+gG=GTLcqR38CiYw73irrhkXNjyjL_v3aW6F-HTHJ3fAa=7w@mail.gmail.com>
References: <20151106115053.487d81b7@recife.lan>
	<CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
	<20151107152237.12018d2f@recife.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38716 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbKIKgl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 05:36:41 -0500
Received: by wicli17 with SMTP id li17so12560374wic.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 02:36:38 -0800 (PST)
In-Reply-To: <20151107152237.12018d2f@recife.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Sat, Nov 7, 2015 at 6:22 PM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
> Em Fri, 06 Nov 2015 17:37:55 +0100
> Benjamin Tissoires <benjamin.tissoires@gmail.com> escreveu:
>
>> HI Mauro,
>>
>> On Fri, Nov 6, 2015 at 2:50 PM, Mauro Carvalho Chehab
>> <mchehab@osg.samsung.com> wrote:
>> > Hi Dmitry,
>> >
>> > Since I upgraded my desktop to Fedora 23 (with comes with Kernel 4.2.5), I'm
>> > noticing a weird bug... from time to time, it starts producing an endless
>> > sequence of KEY_5 events.
>> >
>> > I opened a bug at Fedora:
>> >         https://bugzilla.redhat.com/show_bug.cgi?id=1278818
>> >
>> > But I suspect it could be some Kernel bug. Do you know if some change
>> > between 4.1 and 4.2 might have triggered such bug?
>>
>> I don't think any changes in 4.2 would trigger that. The only
>> hid-logitech-hidpp change in 4.2 is unrelated to this particular
>> keyboard and I don't think it could interfere with other devices than
>> the M560.
>>
>> I also experienced such problems from time to time and always thought
>> it was either a firmware problem or a low battery issue. When
>> recharging my keyboard, the issue disappeared. Unfortunately, I was
>> never able to figure out which HID raw event triggered this kernel key
>> repeat (as you said, it's random).
>>
>> Now that I think of it, I might have a reproducer here. When playing
>> with libratbag to configure the MX Master, I receive from time to time
>> some key events while no keys should be sent by the mouse. I suspect
>> that the HID parsing convert some internal protocol events into HID
>> keys and generate spurious keys. I'll check on this.
>>
>> If you can manage to reproduce your issue more often (for me, this
>> happens once in a month or so), I'd be curious to check the HID raw
>> events coming out from the keyboard just before the bug, and what
>> triggers the bug.
>> I'd be glad if you could do a recording with hid-record (from
>> hid-replay[1]). Make sure that the logs do not contain sensitive
>> information:
>> You can parse the output of the raw events by using
>> ./tools/parse_hid.py in the hid-replay repository. Recording at the
>> Unifying receiver level should give a bunch of HID reports
>> encapsulated in the DJ protocol so parse_hid will not be able to parse
>> them accurately. If you register the keyboard node, parse_hid.py
>> should accurately translate the raw events to a human description of
>> the report which should allow you to strip the sensitive data.
>
> Parsed hid for the keyboard for
>         /dev/hidraw2:   Logitech K520
> follows:

Thanks for the logs. I am somewhat puzzled by it:

>
>  68.090688 ReportID: 1 / LeftControl: 0 | LeftShift: 0 | LeftAlt: 0 | Left GUI: 0 | RightControl: 0 | RightShift: 0 | RightAlt: 0 | Right GUI: 0 |Keyboard [Return (ENTER), 00, 00, 00, 00, 00]
>  68.170687 ReportID: 1 / LeftControl: 0 | LeftShift: 0 | LeftAlt: 0 | Left GUI: 0 | RightControl: 0 | RightShift: 0 | RightAlt: 0 | Right GUI: 0 |Keyboard [00, 00, 00, 00, 00, 00]
> 177.191904 ReportID: 16 /Vendor Defined Page 1 [02, 81, 07, 07, 00, 00]

This is an answer from a query to the battery status (upower) -> the
battery is full

> 297.115254 ReportID: 16 /Vendor Defined Page 1 [02, 81, 07, 07, 00, 00]

ditto

> 367.914151 ReportID: 16 /Vendor Defined Page 1 [02, 41, 04, 71, 11, 20]

the device goes in suspend

> 367.916051 ReportID: 1 / LeftControl: 0 | LeftShift: 0 | LeftAlt: 0 | Left GUI: 0 | RightControl: 0 | RightShift: 0 | RightAlt: 0 | Right GUI: 0 |Keyboard [00, 00, 00, 00, 00, 00]
> 367.916062 ReportID: 3 /Consumer Devices [, ]
> 367.916067 ReportID: 4 /Generic Desktop [] | #

hid-logitech-dj releases all keys following a suspend

> 416.840646 ReportID: 16 /Vendor Defined Page 1 [02, 8f, 81, 07, 09, 00]

upower tries to read the battery status, and fails with error
HIDPP10_ERROR_CODE_RESOURCE_ERROR (device disconnected).

I suppose the fake KEY_5 started around here. Did you stripped out any
events here?

> 476.573316 ReportID: 16 /Vendor Defined Page 1 [02, 41, 04, b1, 11, 20]

The device gets reconnected by your key press.

> 476.577354 ReportID: 1 / LeftControl: 0 | LeftShift: 0 | LeftAlt: 0 | Left GUI: 0 | RightControl: 0 | RightShift: 0 | RightAlt: 0 | Right GUI: 0 |Keyboard [DELETE (Backspace), 00, 00, 00, 00, 00]
> 476.671297 ReportID: 1 / LeftControl: 0 | LeftShift: 0 | LeftAlt: 0 | Left GUI: 0 | RightControl: 0 | RightShift: 0 | RightAlt: 0 | Right GUI: 0 |Keyboard [00, 00, 00, 00, 00, 00]
>

DEL is pressed/released, which clears the map of currently pressed
keys and remove the auto-repeat on KEY_5...

> I used the DEL key to delete the sequence of "5" that appeared there.
>
> Please let me know if the above helps, of if I need to parse also the
> mouse events.

Given this, the keyboard doesn't seems to generate wrong events that
are interpreted by HID as a KEY_5 press without release.

I hope the mouse does not trigger a bug in the driver that makes the
keyboard driver to send spurious key presses... I'll try to look
deeper, but please give me an approximate time you observed the
autorepeat before hitting DEL (~60 secs, or less?).

Cheers,
Benjamin
