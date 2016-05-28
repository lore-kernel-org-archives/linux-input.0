From: Ben Gamari <ben@smart-cactus.org>
Subject: Should touchsticks really be relative input devices?
Date: Sat, 28 May 2016 13:31:30 +0200
Message-ID: <87inxyo1v1.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56279 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcE1Lbk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 07:31:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org
Cc: xorg@lists.freedesktop.org

--=-=-=
Content-Type: text/plain


Hello input people,

Recently I've been bringing up the touchstick hardware in the Dell
Latitude E7470 and have noticed that the existing drivers for this sort
of input device typically expose EV_REL events. Unfortunately,
it seems that exposing the hardware in this way leads to some rather
unfortunate hacks. Namely, you find things like this in the Alps driver,

    /*
    * The x and y values tend to be quite large, and when used
    * alone the trackstick is difficult to use. Scale them down
    * to compensate.
    */
    x /= 8;
    y /= 8;

    input_report_rel(dev, REL_X, x);
    input_report_rel(dev, REL_Y, -y);

Seeing this made me think back to experiences with touchsticks in
previous Dell laptops, which require an annoyingly high force to begin
movement. This is presumably due to the fact that the bottom few bits of
resolution are being needlessly thrown away.

Unfortunately, it doesn't seem that relative devices currently have much
choice but to scale their input space; it seems there is no way for a
device to expose its "range" to user mode (as you might do with
input_set_abs_params in the case of an absolute device).

Honestly, it's not even clear to me that touchstick devices should
produce relative events. It seems like they are somewhere between a
touchpad and mouse. Like a mouse, there is no absolute mapping between
points in the input device space and the work space. However, like a
touchpad the input space is bounded.

Perhaps these devices should instead produce absolute events and be
marked with INPUT_PROP_POINTING_STICK so that user land code can produce
the expected relative behavior normalized to the range of the device.
Has this been considered in the past?

Alternatively, perhaps relative devices ought to also be able to expose
their range.

Regardless of what happens, it would be great if some guidance for
touchsticks could be added to the "Guidelines" section of the kernel's
Documentation/input/event-codes.txt.

Cheers,

Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSYGSAAoJEHPt6ejPuu8Bbi8H/RpAJSAZOM0l4cj240r2zpdX
mEx4XxBXExeWqMq19Er/jy+qtD6LqQbugpGE8hH1m2kKRzGXRkofRxN2ZH3G12M+
khIg+MatP3B/L3IJqlqnCOI2NeO4vAVo+rZ2nWB/eQcNuwvtZFxgstX4Zjwviypw
C0xULriFZZtmcov0cr/y690rf6RQMdMrGjNGs+kUCEnWbHW3qV/qVfBNhPk8q61s
SqKPr6upZwO2fiDL6OqLnFNSQ9TSsDAS5w9SmmbliYd/C+GzzYOLrVoa1+4hwm6k
Qy3GY0V6zR2mhRThLWVkQgdRSmfC5NpnHB4XR5D46K5wM3eUOED24DZmUxQ5MvQ=
=Eo8B
-----END PGP SIGNATURE-----
--=-=-=--
