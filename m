From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: Re: Touchpad toggle mess
Date: Sat, 6 Nov 2010 12:33:39 -0400
Message-ID: <20101106163339.GE2215@piware.de>
References: <1288915209.5418.72.camel@novo.hadess.net>
 <20101106153031.GA2215@piware.de>
 <1289059101.5418.93.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1289059101.5418.93.camel@novo.hadess.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bastien,

Bastien Nocera [2010-11-06 15:58 +0000]:
> No, for about a year:
> http://cgit.freedesktop.org/xkeyboard-config/commit/?id=3D1d05eda8dfc706d=
6450cab5883120e0d5e1100c0

Ah, right, I missed that it didn't actually work all the way up to the
session, only at the evdev level.

> You don't need to update gnome-settings-daemon. gnome-settings-daemon
> doesn't see F21, F22 or F23, it'll see XF86TouchpadOn, etc.

Ah, ok.

So, that makes a lot of sense then, I committed your patch with a
little more verbiage in the changelog. It would be nice if we could
get the X.org counterpart in as well, so that the udev keymaps and
X.org don't run out of sync.

Thank you!

Martin
--=20
Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCAAGBQJM1YNjAAoJEPmIJawmtHufjT8P/A7mooZIGDMaZJN8HQcZKs5U
HCldDFuqGuzTCT6OpIumyYd3YcCdtzQLHtUjeOydPAX0R7dI6c+pWcLX8x9/lJ1d
SiX7PS4557ew6QlxD+fo2p1o68DYUpr1u/qq/WG+hVPFSOFi01sLMZyaiQnbDP+p
02MDfGZxK7k9eVGMTYItrC+ogjYgmuecwnWESfQFkf8IZ04sy/JjabW9cGW/hdg1
uJyYqn2aHSSa7oBenb0EFH0VZ/L4xkYJKMTMCuPcg6LpRGWYfWwcQl+uQ+sEei2D
33VL2HHFJ85adjRG7rTYpKzwM8iccZ0bdXhrFrKBE1IeB2pdbRzcbb5QzkQQe79V
e6sXuS+kTdT8j4yCTE8Sles16t/nX173c/noM3vj8N69+CeiSIX4lhHl2yxTNFak
8BIR8OA2sW87rBQFD8nGrM7mhWq8lQ7uFSRL89jWEAgyqcomyZ7V54V54LyoNkeF
EwSaXvXpF4SnHmoiTccKePsTQwyNL1kNke1n8W5/5UhGfv+tRPR39x1nUDlwg5xI
ooKL8LZdkd/qrhlVNjLLv3O+OMoea40VhAgiFlFGrb2lgNKhfEwTDdwmO1AT4SPC
p7/MG+dqQBucCtbzR0vr/+tvApKMZRkzm3lYxxzfWu8FHYs/Q1QWPplx9/VdLCG6
/3j7rR+WFYlidL9HnSrC
=a/6j
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
