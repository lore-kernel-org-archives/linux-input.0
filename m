From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Thu, 23 Mar 2017 11:59:56 +0100
Message-ID: <20170323105956.GD26316@mail.corp.redhat.com>
References: <20170322083222.6632f066@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbdCWLAD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 07:00:03 -0400
Content-Disposition: inline
In-Reply-To: <20170322083222.6632f066@vento.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi,

On Mar 22 2017 or thereabouts, Mauro Carvalho Chehab wrote:
> Hi,
> 
> The MX Anywhere 2 mouse has a high-resolution wheel that allows sending
> wheel events together with mouse movements or in separate, via HID++.
> By default, it starts in low-resolution mode, reporting events via HID.
> 
> The documentation for it was recently added[1]:
> 	https://lekensteyn.nl/files/logitech/x2121_hires_wheel.pdf
> 
> [1] there's a small error at the documentation, though:
>     On page 5, at "[event0] wheelMovement() → resolution, periods, deltaV"
>     chapter, it says that the "periods" field can be up to 15, but it shows
>     only 3 bits for it table 9 "wheelMovement() report packet", placing
>     the high-resolution bit as bit 3.
> 
>     After investigating it in practice, the actual bit that changes when
>     the wheel is in high-resolution mode is bit 4. When bit = 1, the mouse
>     is using high-resolution; when 0, it is using low resolution.
> 
>     So, in summary, the correct information there at the table should be,
>     instead:
> 	- bits 0-3: periods
> 	- bit 4: resolution
> 
> There is a BZ for Solaar userspace application, opened in Aug, 2016
> requesting support for it:
> 	https://github.com/pwr/Solaar/issues/283
> 
> With the new documentation, released yesterday, I added support for it today,
> on a set of patches at:
> 	https://github.com/mchehab/Solaar/tree/mx_anywhere2-v3
> 
> With those patches, Solaar, in CLI, mode, shows the status of the
> high-res wheel:
> 
>         11: HIRES WHEEL            {2121}   
>             Multiplier: 8
>             Has invert
>               Normal wheel motion
>             Has ratchet switch
>               Free wheel mode
>             Low resolution mode
>             HID notification
> 
> And allows to toggle at the 3 possible switches:
> 	- Invert wheel movement;
> 	- Change to high-resolution mode - with makes the wheel to
> 	  scroll 8 times faster;
> 	- Select between HID or HID++ notifications.
> 
> It also generate an event when the ratchet button is clicked
> (changing from ratchet mode to freewheel). Solaar now handle those
> events using hiraw interface.
> 
> When the notification is set to HID mode, evdev properly
> generates Wheel events:
> 
> 1490181781.995144: event type EV_REL(0x02): REL_WHEEL (0x0002) value=-1
> 1490181781.995144: event type EV_SYN(0x00).
> 1490181782.211146: event type EV_REL(0x02): REL_WHEEL (0x0002) value=1
> 1490181782.211146: event type EV_SYN(0x00).
> 
> But it doesn't generate events when ratchet switch button is
> pressed.
> 
> When the notification is changed to HID++ mode, it also doesn't
> generate events.
> 
> I suspect that the right thing to do would be to add a handler for
> it, probably at:
> 
> 	drivers/hid/hid-logitech-hidpp.c

Yes, that would be the place. The M560 could be used as an example as it
requires also some commands to be sent at connect and needs to treat raw
incoming events.

> 
> On Solaar, with my patches, we can receive such messages via
> hidraw interface:
> 
> HID++ wheel movement event:
> 
> 	07:37:22,846    DEBUG [ReceiverListener:hidraw1] logitech_receiver.base: (13) => r[11 03 0B00 01FFFF00000000000000000000000000]
> 	07:37:22,847     INFO [ReceiverListener:hidraw1] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: res: 0 periods: 1 delta V:-1 
> 
> Ratchet event (generated on both HID and HID++ modes):
> 
> 	08:26:12,455    DEBUG [ReceiverListener:hidraw2] logitech_receiver.base: (13) => r[11 03 0B10 01000000000000000000000000000000]
> 	08:26:12,456     INFO [ReceiverListener:hidraw2] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: ratchet: 1

In hid-logitech-hidpp, you can simply parse the incoming raw events and
handle the events as they should (see wtp_raw_events for handling the
HID++ specifics related to a feature).

> 
> With regards to ratchet, it probably makes sense to query its state
> when the driver starts, as IMHO, it should work on a way similar to
> <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?

There is not. And that's where the problem goes a little bit beyond just
enabling the feature, we need to forward this info to userspace.

There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
a state, and we should be able to forward this state with such a new
event.

The thing I am more worried is how can we report the high-res wheel
events. I know Peter has a DB of wheel resolution, but in that case, we
can switch to high-res or not, so a static hwdb entry won't help.

> 
> As I never touched on those HID drivers, could someone either add support
> for it or shed some light about what would be the proper way to add support
> for it?

If we can agree on a proper evdev API for this (either using ABS event
or something else), then I should be able to implement this given that
the MX Master also exports the same feature. But really, the code should
not be that much of an issue given that everything is already in place
in hid-logitech-hidpp.c.

Cheers,
Benjamin

> 
> Thanks!
> Mauro
