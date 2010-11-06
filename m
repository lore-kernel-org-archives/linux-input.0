From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: Re: Touchpad toggle mess
Date: Sat, 6 Nov 2010 11:30:31 -0400
Message-ID: <20101106153031.GA2215@piware.de>
References: <1288915209.5418.72.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1288915209.5418.72.camel@novo.hadess.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bastien,

Bastien Nocera [2010-11-05  0:00 +0000]:
> The patches in https://bugs.freedesktop.org/show_bug.cgi?id=3D31300
> implement this for the kernel, and for X.org.
>=20
> Then we have the problem that udev's keymaps seem to use different
> function keys depending on the hardware [1], when X.org (because of the
> limitations of XKB) standardised on F22 for "XF86TouchpadToggle".

Thanks for bringing this up, indeed there's some cleanup in order
here.

> So we'll need to standardise on the keys used. I selected F21 for
> XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
> See the patch in:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D31333
>=20
> The remaining fixes would need to be in udev's keymaps, to set hardware
> handled keys to F22 and F23, and software ones to F21. Patch is attached
> for that.

Indeed the maps which don't currently use f22 should be fixed,
regardless of what happens in X/kernel/userspace. My main concern is
that F22 has acted as touchpad toggle key for years (many of those
were imported from hal-info originally), so if we change everything to
f21 now without updating userspace (things like gnome-settings-daemon)
in lockstep, then we break existing functionality.=20

It would look slightly weird, but perhaps it might be better to keep
using F22 for toggling, and F1->on, F23->off?

Thanks,

Martin
--=20
Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCAAGBQJM1XSUAAoJEPmIJawmtHuffbQQAIiFH1uYsbcEAlmcBnW5/OZj
51PjWEa8eghNb78KCsxJfbIY8Js0Y89c0tvIK/LkT97tRbdwz+rtuI/hHJkH0N3z
o2WCjuzw7g5gyBDbRBkYOhUrKIy9JWxO8xZ7UKgBlIT8xUV+9pY2uopSUzrpWXYp
oEAQSjnE6p5VfZXeXvLc5jo5uyv0hq9EwTJLcCOrXiEHspzef2biE25NVyP5F9md
OCFranrfONSDOtMioXYmcXYGlBuFJzUelufz9gDvOEpw6g9muUMtYspYbR3WCpCr
4Cpv0ois0jloc6KOxJfnvvayhLY3hiIyLSGjKzXQr3bUecwajRoUPVtcI0hBvkGx
6Rv5bOoEQVU8Dncni3ou1LhK96dR4fnpuZ57A9OLNVooe2u5LxE5Va9o8njFq6h1
mflLR3KhMkgx+LBJu4RHo7Uf/+RCJJ6fKyc8klKBcVv12SUZZb/gSZetv9xTOncV
KTlVk395s0pfpHcUE9O9SwQ+KiYWDOv+ojIg/BCIJY1URGNm6+ReOBbaS9jDBETd
ebGcqGwur6a6HI0/ATOULRtrvPa/7yRLA6e9egDkiAWE9yNY4e0VrsKauxz3SwH4
jIBqp5PRthPf2C0ER7CqDboXqwrvZ/KUi4GrQP+BHXFDlTOOdKiuYVdBFxJYXTUi
amuxsYiONkw+XBFQ4jWe
=b+l/
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
