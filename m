From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: Fake KEY_5 continuous keydown events with Logitech wireless
 keyboard on Kernel 4.2
Date: Fri, 6 Nov 2015 16:08:34 -0200
Message-ID: <20151106160834.398d77c0@recife.lan>
References: <20151106115053.487d81b7@recife.lan>
	<CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:39602 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbbKFSIj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Nov 2015 13:08:39 -0500
In-Reply-To: <CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>

Em Fri, 06 Nov 2015 17:37:55 +0100
Benjamin Tissoires <benjamin.tissoires@gmail.com> escreveu:

> HI Mauro,
> 
> On Fri, Nov 6, 2015 at 2:50 PM, Mauro Carvalho Chehab
> <mchehab@osg.samsung.com> wrote:
> > Hi Dmitry,
> >
> > Since I upgraded my desktop to Fedora 23 (with comes with Kernel 4.2.5), I'm
> > noticing a weird bug... from time to time, it starts producing an endless
> > sequence of KEY_5 events.
> >
> > I opened a bug at Fedora:
> >         https://bugzilla.redhat.com/show_bug.cgi?id=1278818
> >
> > But I suspect it could be some Kernel bug. Do you know if some change
> > between 4.1 and 4.2 might have triggered such bug?
> 
> I don't think any changes in 4.2 would trigger that. The only
> hid-logitech-hidpp change in 4.2 is unrelated to this particular
> keyboard and I don't think it could interfere with other devices than
> the M560.
> 
> I also experienced such problems from time to time and always thought
> it was either a firmware problem or a low battery issue. When
> recharging my keyboard, the issue disappeared. Unfortunately, I was
> never able to figure out which HID raw event triggered this kernel key
> repeat (as you said, it's random).

At least mate-power-statistics tell that the battery level is OK
(It is showing 90% of power for the Keyboard, and 55% for the mouse).
I'm using non-rechargeable alcaline batteries. So, I guess this is not
a battery issue. Also, it would be quite a coincidence that the battery
level would drop some threshold level at the same day I upgraded to
Fedora 23.

This could be a firmware issue, though. Do you know what's the firmware
used by this keyboard? I can try to use an older version and see if the
bug stops hitting.

> Now that I think of it, I might have a reproducer here. When playing
> with libratbag to configure the MX Master, I receive from time to time
> some key events while no keys should be sent by the mouse. I suspect
> that the HID parsing convert some internal protocol events into HID
> keys and generate spurious keys. I'll check on this.

That could be an explanation. Yeah, I suspect that the events may be
coming mainly from the mouse, as clicking at the mouse button to switch
from one window to another sometimes seem to be triggering the bug.
Perhaps having the mouse battery at half life (55%) may be making the
event more likely to happen.

> If you can manage to reproduce your issue more often (for me, this
> happens once in a month or so), I'd be curious to check the HID raw
> events coming out from the keyboard just before the bug, and what
> triggers the bug.

Here, it is happening several times during the day. Just today, the
bug happened maybe 4 or 5 times already, with is kind of nasty.

> I'd be glad if you could do a recording with hid-record (from
> hid-replay[1]). Make sure that the logs do not contain sensitive
> information:
> You can parse the output of the raw events by using
> ./tools/parse_hid.py in the hid-replay repository. Recording at the
> Unifying receiver level should give a bunch of HID reports
> encapsulated in the DJ protocol so parse_hid will not be able to parse
> them accurately. If you register the keyboard node, parse_hid.py
> should accurately translate the raw events to a human description of
> the report which should allow you to strip the sensitive data.

Ok, I'll do it, and send the results once I hit the bug again.

> 
> Nestor might have a different idea of where this key press comes from.
> 
> Cheers,
> Benjamin
> 
> [1] http://bentiss.github.io/hid-replay-docs/

Regards,
Mauro
