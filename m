From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Support for Logitech MX Anywhere 2
Date: Wed, 22 Mar 2017 08:32:22 -0300
Message-ID: <20170322083222.6632f066@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48377
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751374AbdCVLcb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 07:32:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

The MX Anywhere 2 mouse has a high-resolution wheel that allows sending
wheel events together with mouse movements or in separate, via HID++.
By default, it starts in low-resolution mode, reporting events via HID.

The documentation for it was recently added[1]:
	https://lekensteyn.nl/files/logitech/x2121_hires_wheel.pdf

[1] there's a small error at the documentation, though:
    On page 5, at "[event0] wheelMovement() → resolution, periods, deltaV"
    chapter, it says that the "periods" field can be up to 15, but it shows
    only 3 bits for it table 9 "wheelMovement() report packet", placing
    the high-resolution bit as bit 3.

    After investigating it in practice, the actual bit that changes when
    the wheel is in high-resolution mode is bit 4. When bit = 1, the mouse
    is using high-resolution; when 0, it is using low resolution.

    So, in summary, the correct information there at the table should be,
    instead:
	- bits 0-3: periods
	- bit 4: resolution

There is a BZ for Solaar userspace application, opened in Aug, 2016
requesting support for it:
	https://github.com/pwr/Solaar/issues/283

With the new documentation, released yesterday, I added support for it today,
on a set of patches at:
	https://github.com/mchehab/Solaar/tree/mx_anywhere2-v3

With those patches, Solaar, in CLI, mode, shows the status of the
high-res wheel:

        11: HIRES WHEEL            {2121}   
            Multiplier: 8
            Has invert
              Normal wheel motion
            Has ratchet switch
              Free wheel mode
            Low resolution mode
            HID notification

And allows to toggle at the 3 possible switches:
	- Invert wheel movement;
	- Change to high-resolution mode - with makes the wheel to
	  scroll 8 times faster;
	- Select between HID or HID++ notifications.

It also generate an event when the ratchet button is clicked
(changing from ratchet mode to freewheel). Solaar now handle those
events using hiraw interface.

When the notification is set to HID mode, evdev properly
generates Wheel events:

1490181781.995144: event type EV_REL(0x02): REL_WHEEL (0x0002) value=-1
1490181781.995144: event type EV_SYN(0x00).
1490181782.211146: event type EV_REL(0x02): REL_WHEEL (0x0002) value=1
1490181782.211146: event type EV_SYN(0x00).

But it doesn't generate events when ratchet switch button is
pressed.

When the notification is changed to HID++ mode, it also doesn't
generate events.

I suspect that the right thing to do would be to add a handler for
it, probably at:

	drivers/hid/hid-logitech-hidpp.c

On Solaar, with my patches, we can receive such messages via
hidraw interface:

HID++ wheel movement event:

	07:37:22,846    DEBUG [ReceiverListener:hidraw1] logitech_receiver.base: (13) => r[11 03 0B00 01FFFF00000000000000000000000000]
	07:37:22,847     INFO [ReceiverListener:hidraw1] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: res: 0 periods: 1 delta V:-1 

Ratchet event (generated on both HID and HID++ modes):

	08:26:12,455    DEBUG [ReceiverListener:hidraw2] logitech_receiver.base: (13) => r[11 03 0B10 01000000000000000000000000000000]
	08:26:12,456     INFO [ReceiverListener:hidraw2] logitech_receiver.notifications: <PairedDevice(3,404A,Anywhere MX 2)>: WHEEL: ratchet: 1

With regards to ratchet, it probably makes sense to query its state
when the driver starts, as IMHO, it should work on a way similar to
<CAPS LOCK>. Btw, are there any event already defined for ratchet mode?

As I never touched on those HID drivers, could someone either add support
for it or shed some light about what would be the proper way to add support
for it?

Thanks!
Mauro
