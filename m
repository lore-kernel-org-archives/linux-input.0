From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Thu, 23 Mar 2017 14:29:00 -0300
Message-ID: <20170323142900.185da144@vento.lan>
References: <20170322083222.6632f066@vento.lan>
        <20170323105956.GD26316@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53606
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932166AbdCWR3O (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 13:29:14 -0400
In-Reply-To: <20170323105956.GD26316@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

Em Thu, 23 Mar 2017 11:59:56 +0100
Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:

> Hi,
> 
> On Mar 22 2017 or thereabouts, Mauro Carvalho Chehab wrote:
> > Hi,
> > 
> > The MX Anywhere 2 mouse has a high-resolution wheel that allows sending
> > wheel events together with mouse movements or in separate, via HID++.
> > By default, it starts in low-resolution mode, reporting events via HID.
> > 
> > The documentation for it was recently added[1]:
> > 	https://lekensteyn.nl/files/logitech/x2121_hires_wheel.pdf
> > 
> > [1] there's a small error at the documentation, though:
> >     On page 5, at "[event0] wheelMovement() → resolution, periods, deltaV"
> >     chapter, it says that the "periods" field can be up to 15, but it shows
> >     only 3 bits for it table 9 "wheelMovement() report packet", placing
> >     the high-resolution bit as bit 3.
> > 
> >     After investigating it in practice, the actual bit that changes when
> >     the wheel is in high-resolution mode is bit 4. When bit = 1, the mouse
> >     is using high-resolution; when 0, it is using low resolution.
> > 
> >     So, in summary, the correct information there at the table should be,
> >     instead:
> > 	- bits 0-3: periods
> > 	- bit 4: resolution

Btw, the documentation there at:
	https://lekensteyn.nl/files/logitech/x2121_hires_wheel.pdf

got updated to fix the above errata.

> > 
> > There is a BZ for Solaar userspace application, opened in Aug, 2016
> > requesting support for it:
> > 	https://github.com/pwr/Solaar/issues/283
> > 
> > With the new documentation, released yesterday, I added support for it today,
> > on a set of patches at:
> > 	https://github.com/mchehab/Solaar/tree/mx_anywhere2-v3
> > 
> > With those patches, Solaar, in CLI, mode, shows the status of the
> > high-res wheel:
> > 
> >         11: HIRES WHEEL            {2121}   
> >             Multiplier: 8
> >             Has invert
> >               Normal wheel motion
> >             Has ratchet switch
> >               Free wheel mode
> >             Low resolution mode
> >             HID notification
> > 
> > And allows to toggle at the 3 possible switches:
> > 	- Invert wheel movement;
> > 	- Change to high-resolution mode - with makes the wheel to
> > 	  scroll 8 times faster;
> > 	- Select between HID or HID++ notifications.
> > 
> > It also generate an event when the ratchet button is clicked
> > (changing from ratchet mode to freewheel). Solaar now handle those
> > events using hiraw interface.
> > 
> > When the notification is set to HID mode, evdev properly
> > generates Wheel events:
> > 
> > 1490181781.995144: event type EV_REL(0x02): REL_WHEEL (0x0002) value=-1
> > 1490181781.995144: event type EV_SYN(0x00).
> > 1490181782.211146: event type EV_REL(0x02): REL_WHEEL (0x0002) value=1
> > 1490181782.211146: event type EV_SYN(0x00).
> > 
> > But it doesn't generate events when ratchet switch button is
> > pressed.
> > 
> > When the notification is changed to HID++ mode, it also doesn't
> > generate events.
> > 
> > I suspect that the right thing to do would be to add a handler for
> > it, probably at:
> > 
> > 	drivers/hid/hid-logitech-hidpp.c  
> 
> Yes, that would be the place. The M560 could be used as an example as it
> requires also some commands to be sent at connect and needs to treat raw
> incoming events.

Ok.

> > 
> > On Solaar, with my patches, we can receive such messages via
> > hidraw interface:
> > 
> > HID++ wheel movement event:
> > 
> > 	07:37:22,846    DEBUG [ReceiverListener:hidraw1] logitech_receiver.base: (13) => r[11 03 0B00 01FFFF00000000000000000000000000]
> > 	07:37:22,847     INFO [ReceiverListener:hidraw1] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: res: 0 periods: 1 delta V:-1 
> > 
> > Ratchet event (generated on both HID and HID++ modes):
> > 
> > 	08:26:12,455    DEBUG [ReceiverListener:hidraw2] logitech_receiver.base: (13) => r[11 03 0B10 01000000000000000000000000000000]
> > 	08:26:12,456     INFO [ReceiverListener:hidraw2] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: ratchet: 1  
> 
> In hid-logitech-hidpp, you can simply parse the incoming raw events and
> handle the events as they should (see wtp_raw_events for handling the
> HID++ specifics related to a feature).

Ok. Seems simple enough. The events start with REPORT_ID_HIDPP_LONG (0x11):

That's what I captured from usbmon driver, on high-res mode:

000025675 ms 000042 ms (241974 us EP=83, Dev=68) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
000025917 ms 000242 ms (215972 us EP=83, Dev=68) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
000026133 ms 000216 ms (281975 us EP=83, Dev=68) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00

and this is on Low-res mode:

000030905 ms 000000 ms (017904 us EP=83, Dev=68) >>> 11 03 0b 2d 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000030923 ms 000018 ms (596012 us EP=83, Dev=68) >>> 11 03 0b 00 01 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
000031519 ms 000596 ms (512004 us EP=83, Dev=68) >>> 11 03 0b 00 01 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
000032031 ms 000512 ms (211972 us EP=83, Dev=68) >>> 11 03 0b 00 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
000032243 ms 000212 ms (261975 us EP=83, Dev=68) >>> 11 03 0b 00 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00

If I understood it right, it will need to check if it is a MX2, for example
by adding a quirk for it, and if feature_index is 0x0b, parse the
events at wtp_raw_event(), something like:

...
	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_MX2)
		return mx2_raw_event(hdev, data, size);
...

Sounds easy enough.

> > With regards to ratchet, it probably makes sense to query its state
> > when the driver starts, as IMHO, it should work on a way similar to
> > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?  
> 
> There is not. And that's where the problem goes a little bit beyond just
> enabling the feature, we need to forward this info to userspace.
> 
> There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> a state, and we should be able to forward this state with such a new
> event.
> 
> The thing I am more worried is how can we report the high-res wheel
> events. I know Peter has a DB of wheel resolution, but in that case, we
> can switch to high-res or not, so a static hwdb entry won't help.

Yes. In the case of high-res, there are actually two ways for those
events to arrive:

In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
isn't any events reporting if the mode changed, nor the event with
gets wheel axes movement tell if the mouse is in low or high res.

So, in HID mode, identifying if the wheel is in low or high res
is not direct.

When the device is in HID+ mode, the resolution mode comes together with
axes changes. So, it should be possible to define a different event
for high-res wheel.

E. g. if the event reports high-res, it would be generating:
EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
it will keep generating EV_REL / REL_WHEEL.

This way, Peter's code (libinput, I guess?) could handle it without
requiring any DB for the devices that allow switching the mode.

Another alternative would be to have a EV_SWITCH SW_HIRES event that
would signal if the driver detects that the resolution switched.
IMHO, this would be more generic, but would work on HID mode only
if the driver would have some sort of check if the user commanded a
resolution change, or do periodic polls.

> > 
> > As I never touched on those HID drivers, could someone either add support
> > for it or shed some light about what would be the proper way to add support
> > for it?  
> 
> If we can agree on a proper evdev API for this (either using ABS event
> or something else),

Using ABS event could work, but seems odd ;)

> then I should be able to implement this given that
> the MX Master also exports the same feature.

Ah! good to know!

> But really, the code should
> not be that much of an issue given that everything is already in place
> in hid-logitech-hidpp.c.

Yeah, it seems that the changes aren't hard.

Thanks,
Mauro
