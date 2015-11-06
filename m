From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Fake KEY_5 continuous keydown events with Logitech wireless
 keyboard on Kernel 4.2
Date: Fri, 6 Nov 2015 17:37:55 +0100
Message-ID: <CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
References: <20151106115053.487d81b7@recife.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33901 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161628AbbKFQh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Nov 2015 11:37:56 -0500
Received: by wmnn186 with SMTP id n186so46718968wmn.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2015 08:37:55 -0800 (PST)
In-Reply-To: <20151106115053.487d81b7@recife.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>

HI Mauro,

On Fri, Nov 6, 2015 at 2:50 PM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
> Hi Dmitry,
>
> Since I upgraded my desktop to Fedora 23 (with comes with Kernel 4.2.5), I'm
> noticing a weird bug... from time to time, it starts producing an endless
> sequence of KEY_5 events.
>
> I opened a bug at Fedora:
>         https://bugzilla.redhat.com/show_bug.cgi?id=1278818
>
> But I suspect it could be some Kernel bug. Do you know if some change
> between 4.1 and 4.2 might have triggered such bug?

I don't think any changes in 4.2 would trigger that. The only
hid-logitech-hidpp change in 4.2 is unrelated to this particular
keyboard and I don't think it could interfere with other devices than
the M560.

I also experienced such problems from time to time and always thought
it was either a firmware problem or a low battery issue. When
recharging my keyboard, the issue disappeared. Unfortunately, I was
never able to figure out which HID raw event triggered this kernel key
repeat (as you said, it's random).

Now that I think of it, I might have a reproducer here. When playing
with libratbag to configure the MX Master, I receive from time to time
some key events while no keys should be sent by the mouse. I suspect
that the HID parsing convert some internal protocol events into HID
keys and generate spurious keys. I'll check on this.

If you can manage to reproduce your issue more often (for me, this
happens once in a month or so), I'd be curious to check the HID raw
events coming out from the keyboard just before the bug, and what
triggers the bug.
I'd be glad if you could do a recording with hid-record (from
hid-replay[1]). Make sure that the logs do not contain sensitive
information:
You can parse the output of the raw events by using
./tools/parse_hid.py in the hid-replay repository. Recording at the
Unifying receiver level should give a bunch of HID reports
encapsulated in the DJ protocol so parse_hid will not be able to parse
them accurately. If you register the keyboard node, parse_hid.py
should accurately translate the raw events to a human description of
the report which should allow you to strip the sensitive data.

Nestor might have a different idea of where this key press comes from.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/
