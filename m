From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 1/1] hid: Logitech G13 driver 0.0.2
Date: Wed, 23 Dec 2009 00:57:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912230056120.3755@pobox.suse.cz>
References: <200912220022.nBM0MMS8005004@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58386 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbZLVX5q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 18:57:46 -0500
In-Reply-To: <200912220022.nBM0MMS8005004@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, rvinyard@cs.nmsu.edu, dtor@mail.ru, oliver@neukum.org

On Mon, 21 Dec 2009, akpm@linux-foundation.org wrote:

> From: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
>=20
> This is a driver for the Logitech G13 gamepad, and contains three key
> parts.  In the USB reports the device identifies itself as a HID, and=
 as a
> result this driver is under the HID framework.
>=20
> There are two primary sub-components to this driver; an input device =
and a
> framebuffer device.
>=20
> Although identified as a HID, the device does not support standard HI=
D
> input messages.  As a result, a sub-input device is allocated and
> registered separately in g13_probe().  The raw events are monitored a=
nd
> key presses/joystick activity is reported through the input device af=
ter
> referencing an indexed keymap.
>=20
> Additionally, this device contains a 160x43 monochrome LCD display.  =
A
> registered framebuffer device manages this display.  The design of th=
is
> portion of the driver was based on the design of the hecubafb driver =
with
> deferred framebuffer I/O since there is no real memory to map.
>=20
> Signed-off-by: Rick L. Vinyard, Jr <rvinyard@cs.nmsu.edu>
> Cc: Oliver Neukum <oliver@neukum.org>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

The driver doesn't build for me. Seems like missing some=20
framebuffer-related include at a first glance.

Rick, care to fix that up please?

drivers/hid/hid-g13.c:121: error: field =A1fb_defio=A2 has incomplete t=
ype
drivers/hid/hid-g13.c:1207: error: variable =A1g13_fb_defio=A2 has init=
ializerbut incomplete type
drivers/hid/hid-g13.c:1208: error: unknown field =A1delay=A2 specified =
ininitializer
drivers/hid/hid-g13.c:1208: warning: excess elements in struct initiali=
zer
drivers/hid/hid-g13.c:1208: warning: (near initialization for =A1g13_fb=
_defio=A2)
drivers/hid/hid-g13.c:1209: error: unknown field =A1deferred_io=A2 spec=
ified in initializer
drivers/hid/hid-g13.c:1209: warning: excess elements in struct initiali=
zer
drivers/hid/hid-g13.c:1209: warning: (near initialization for =A1g13_fb=
_defio=A2)
drivers/hid/hid-g13.c: In function =A1g13_probe=A2:drivers/hid/hid-g13.=
c:1351: error: =A1struct fb_info=A2 has no member named =A1fbdefio=A2

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
