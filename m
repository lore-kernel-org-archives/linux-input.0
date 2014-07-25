From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH v2 00/10] Input - wacom: conversion to HID driver,
 series 2
Date: Fri, 25 Jul 2014 20:26:16 +0100
Message-ID: <1406316376.12682.18.camel@fedora-lan>
References: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1406292140.2664.17.camel@fedora-lan>
	 <20140725125820.GA12268@mail.corp.redhat.com>
	 <1406295035.2664.43.camel@fedora-lan>
	 <20140725145400.GB12268@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aso-006-i450.relay.mailchannels.net ([23.91.64.131]:10451 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760793AbaGYT0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 15:26:24 -0400
In-Reply-To: <20140725145400.GB12268@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dnia 2014-07-25, pi=C4=85 o godzinie 10:54 -0400, Benjamin Tissoires pi=
sze:
> [..]
Hi Benjamin,
> =20
> > If I understand you correctly we cannot have the same entry point i=
n
> > sysfs for OLEDs unless we can tell userspace somehow if the tablet =
is
> > conected over USB or over bluetooth. The hardware of Intuos4 Wirele=
ss
> > over bluetooth allows only 1-bit images. The same hardware over USB
> > allows 4-bit images. Formatting of the images is also completely
>=20
> Holy crap! I missed that. I did not noticed the 1-bit vs 4-bits
> difference :(
>=20
> > different and it's not "plain". Check [1] for usb and exisitng
> > hid-wacom.c/wacom_scramble function for bluetooth.
>=20
> Maybe I overlooked it, but I thought that in case of USB, the scrambl=
ing
> is done in user space, and in case of BT, the same scrambling made in=
 the
> kernel. They looks very similar so I thought the user-space scramble =
for
> USB would have fit. However, the 4-bits/1-bits kills that assumption.

You're correct - USB requires scrambling in the user space, but
scrambling for USB is different than for BT. Example of USB scramble is
here: https://github.com/PrzemoF/i4oled/blob/master/src/i4oled.c#L401

> >=20
> > If we want to make it consistent single entry on kernel level we
> > probably have to implement image conversion in the kernel. The user=
 land
> > would always use 4-bit, plain formatted images and kernel driver wo=
uld
> > convert them to 4-bit, wacom usb format or 1-bit wacom bluetooth fo=
rmat
> > depending on how the tablet is connected.
> >=20
> > The downside of this approach is that the user land wouldn't have 1=
00%
> > control over 1-bit images for bluetooth as kernel would have to cre=
ate
> > them from 4-bit images.
>=20
> The USB interface is *very* simple:
> - if incoming data !=3D 1024 -> reject
> - forward everything to the device without in kernel treatment*
>=20
> How about just changing the expected size to 256 in case of a BT tabl=
et,
> and let the user-space scramble in both cases and forward proper raw
> data?
>=20
> This way, user space will still have control over 1-bit vs 4-bits, an=
d
> the changes required in the kernel will be small enough.
Sounds good to me. Bit more coding in gnome, but it's a small thing.

> My concern is that I'd like to have this series in 3.17 and I will no=
t
> have access to the hardware until next week :/
> Having all of the user-spaces breakages in the same kernel release wi=
ll
> I think simplify the user space work.
I agree.

P.S. Could you send me that set of 23 patches using git-send-email that
I should apply on top of linux-next? I got it from lkml, but there is
still something messed (fails on patch 09/23). Of course, if it's not a
problem for you :-)

--=20
Kind regards,
Przemo Firszt


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
