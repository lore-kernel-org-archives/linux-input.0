From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH v2 00/10] Input - wacom: conversion to HID driver,
 series 2
Date: Sat, 26 Jul 2014 12:55:48 +0100
Message-ID: <1406375748.2611.0.camel@fedora-lan>
References: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1406326412.4674.22.camel@fedora-lan>
	 <20140725231509.GA2279@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140725231509.GA2279@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Dnia 2014-07-25, pi=C4=85 o godzinie 19:15 -0400, Benjamin Tissoires pi=
sze:
> [..]
Hi Bejnamin,
> > I don't remember for sure, but I think the range of brightness migh=
t be different
> > over usb and over bluetooth.
>=20
> Maybe you can try setting the sysfs file "buttons_luminance" with the
> value 8 to check if this will solve the bug.
No, that doesn't make any difference.
=20
> The bug might also be linked to the slight difference while setting u=
p
> the transfer of the image (WAC_CMD_ICON_START) with the value of buf[=
1]
> set to 1 in USB, while it was 0 on bluetooth.
>=20
> The weird thing is that I remembered having set the OLED (though
> scrambled) with these patches applied. I guess the scrambling was due=
 to
> the 4-bit vs 1-bit. But I definitively had some results.
I spotted something:
hid-wacom:c (before modifications)
#define WAC_CMD_ICON_TRANSFER       0x26

wacom_sys.c: (after modifications)
#define WAC_CMD_ICON_XFER       0x23

Changing it fixes the problem. Patches to follow soon.
--=20
Kind regards,
Przemo Firszt
