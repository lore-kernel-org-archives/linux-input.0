From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Spurious touchpad events with closed LID
Date: Mon, 26 Jun 2017 18:54:53 +0200
Message-ID: <201706261854.53970@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17233254.vItbM867X3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart17233254.vItbM867X3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

When I'm using dock with external input devices (keyboard + mouse) and=20
LID is closed, I'm getting spurious touchpad events and random mouse=20
clicks and movements.

It is because top part of LID is above touchpad and probably generates=20
touch pushes.

Year (or two?) when I had conversation with ALPS people I was told that=20
Windows driver is automatically turning touchpad off when ACPI LID close=20
event is received (and similarly turn touchpad on).

Maybe Linux should do similar thing? Random movement or touchpad clicks=20
is really annoying. But I'm not sure if kernel or userspace should do=20
this job... What do you think?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart17233254.vItbM867X3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllRPF0ACgkQi/DJPQPkQ1L9dwCguIy6ZrM5DsEpR4rZbpDxVsh3
bIwAnjICz1Tsty6GEch2pCFmGA9C1SWw
=EmvP
-----END PGP SIGNATURE-----

--nextPart17233254.vItbM867X3--
