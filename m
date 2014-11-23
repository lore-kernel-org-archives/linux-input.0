From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Reported key not released
Date: Sun, 23 Nov 2014 14:13:30 +0100
Message-ID: <201411231413.30076@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart83341510.2YOpPu8pN0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:45786 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaKWNNd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Nov 2014 08:13:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Darren Hart <dvhart@infradead.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Alex Hung <alex.hung@canonical.com>

--nextPart83341510.2YOpPu8pN0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

my laptop (Dell Latitude E6440) has HW switch which for disabling=20
some radio devices (bluetooth, wifi, 3g; list of devices can be=20
configured in BIOS).

When I enable or disable this switch it correctly enable or=20
disable devices (and also hard rfkill status is set correctly).

But problem is that switch generate key press event on i8042=20
keyboard controller without release event. See output:

$ sudo input-events 4
/dev/input/event4
   bustype : BUS_I8042
   vendor  : 0x1
   product : 0x1
   version : 43841
   name    : "AT Translated Set 2 keyboard"
   phys    : "isa0060/serio0/input0"
   bits ev : EV_SYN EV_KEY EV_MSC EV_LED EV_REP

waiting for events
=2E..
(here I enabled switch)
14:04:07.047897: EV_MSC MSC_SCAN 136
14:04:07.047897: EV_KEY KEY_UNKNOWN (0xf0) pressed
14:04:07.047897: EV_SYN code=3D0 value=3D0
(and after that my terminal emulator start writing dummy chars)
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@1

(here I disabled switch)
14:04:08.730526: EV_MSC MSC_SCAN 136
14:04:08.730526: EV_KEY KEY_UNKNOWN (0xf0) pressed
14:04:08.730526: EV_SYN code=3D0 value=3D0

So I think that above chars were written because there was no=20
release event.

I have two questions:

1) Should kernel for this special switch key emit also release=20
event? And if yes, how to do that if keyboard controller do not=20
do that?

2) It is possible to remap KEY_UNKNOWN to something meaningful?=20
Or it should be KEY_UNKNOWN iff BIOS already handle hard rfkill=20
state?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart83341510.2YOpPu8pN0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRx3XoACgkQi/DJPQPkQ1JraACeLbo0/0sRnLmdGN1vZTncDkgW
r5oAoKi0k7REtwA1r4SC+5YDjiEScCoo
=B0qj
-----END PGP SIGNATURE-----

--nextPart83341510.2YOpPu8pN0--
