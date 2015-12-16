From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: Fake KEY_5 continuous keydown events with Logitech wireless
 keyboard on Kernel 4.2
Date: Wed, 16 Dec 2015 17:17:57 +0100
Message-ID: <CAM4jgCqJ0A3xpg2OGa-3Yd_APnHW9kObfO_dvS_ZO_Nb0gOdpA@mail.gmail.com>
References: <20151106115053.487d81b7@recife.lan>
	<CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37645 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbbLPQR6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 11:17:58 -0500
Received: by mail-ig0-f174.google.com with SMTP id to18so54699480igc.0
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 08:17:58 -0800 (PST)
In-Reply-To: <CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>

2015-11-06 17:37 GMT+01:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:
> I also experienced such problems from time to time and always thought
> it was either a firmware problem or a low battery issue. When
> recharging my keyboard, the issue disappeared. Unfortunately, I was
> never able to figure out which HID raw event triggered this kernel key
> repeat (as you said, it's random).
>
> Now that I think of it, I might have a reproducer here. When playing
> with libratbag to configure the MX Master, I receive from time to time
> some key events while no keys should be sent by the mouse. I suspect
> that the HID parsing convert some internal protocol events into HID
> keys and generate spurious keys. I'll check on this.
>
> If you can manage to reproduce your issue more often (for me, this
> happens once in a month or so), I'd be curious to check the HID raw
> events coming out from the keyboard just before the bug, and what
> triggers the bug.
> I'd be glad if you could do a recording with hid-record (from
> hid-replay[1]). Make sure that the logs do not contain sensitive
> information:

Hi Benjamin,

I think I got this bug while testing writing profiles to my Logitech
G500 (with Fedora 23, kernel 4.2.6, it uses hid-generic driver not the
hidpp or dj ones) except I got only one press/release pair for each
page I wrote. I was able to reproduce that several times in a row but
there was only the expected HID++ reports and hid-replay did not
reproduce the bug.

I am not sure what caused the events exactly, it happened around the
time I write the 0xa1 register for resetting the sequence number.
Then, I tried only writing the 0xa1 register, I got a lot of KEY_5
events. I was not able to reproduce anything after that.

An extract of the output of both evtest and hid-recorder running at
the same time:
E: 0.357976 7 10 00 82 a0 00 00 00
E: 0.359965 7 10 00 80 a1 00 00 00
Event: time 1450279569.586206, type 4 (EV_MSC), code 4 (MSC_SCAN),
value ffff8802
Event: time 1450279569.586206, type 1 (EV_KEY), code 6 (KEY_5), value 1
Event: time 1450279569.586206, -------------- SYN_REPORT ------------
Event: time 1450279569.588202, E: 0.361963 7 10 00 50 01 00 00 00
type 4 (EV_MSC), code 4 (MSC_SCAN), value ffff8802
Event: time 1450279569.588202, type 1 (EV_KEY), code 6 (KEY_5), value 0
Event: time 1450279569.588202, -------------- SYN_REPORT ------------
E: 0.364983 7 10 00 50 01 01 00 00
E: 0.367920 7 10 00 50 01 02 00 00
E: 0.370938 7 10 00 50 01 03 00 00
E: 0.374948 7 10 00 50 01 04 00 00
Note that there is a HID++ answer (the acknowledgment notification
from the first packet) in the middle of an evtest line.

Debug output from my program (unlike libratbag, I write pages directly
to flash 512 bytes at once):
...
[Debug] Setting long register 0xa0
[Debug] Parameters: 02 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00
[Debug] Setting short register 0xa1
[Debug] Parameters: 01 00 00
[Debug] Sending data packet 0
[Debug] (Data packet 01 04 00 00 00 02 00 00 00 ff 00 00 80 00 11 00
[Debug] Data packet 0 acknowledged
[Debug] Sending data packet 1
[Debug] Data packet 11 22 11 00 22 00 22 22 12 00 55 00 55 22 22 00
[Debug] Data packet 1 acknowledged
...
[Debug] Setting long register 0xa0
[Debug] Parameters: 02 00 00 00 00 00 05 00 00 00 00 00 00 00 00 00
[Debug] Setting short register 0xa1
[Debug] Parameters: 01 00 00
[Debug] Sending data packet 0
[Debug] Data packet 01 05 00 00 00 02 00 00 00 22 04 20 2b 21 2b 61
([Debug] Data packet 0 acknowledged
[Debug] Sending data packet 1
[Debug] Data packet 01 90 05 0a 00 20 2b 21 2b c0 45 05 06 23 04 ff
...
The parentheses in "(Data" or "([Debug]" are KEY_5 on my french AZERTY keyboard.

I hope this can help.
