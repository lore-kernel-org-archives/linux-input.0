From: Pavel Machek <pavel@ucw.cz>
Subject: v4.13-rc2: usb mouse stopped working?
Date: Mon, 24 Jul 2017 22:00:56 +0200
Message-ID: <20170724200056.GA3997@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35259 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdGXUA6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 16:00:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>
Cc: jikos@kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On thinkpad x220, USB mouse stopped working in v4.13-rc2. v4.12 was
ok, iirc.

Now, USB mouse is so common hw that I may have something wrong in my
config...? But I did not change anything there.

In v4.9:

[   87.064408] input: Logitech USB Optical Mouse as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1.1.1=
:1.0/0003:046D:C05A.0005/input/input18
[   87.065951] hid-generic 0003:046D:C05A.0005: input,hidraw0: USB HID
v1.11 Mouse [Logitech USB Optical Mouse] on
usb-0000:00:1d.0-1.1.1.1/input0
pavel@duo:~$

v4.13-rc2:

[   87.886810] usb 2-1.1.1.1: new low-speed USB device number 10 using ehci=
-pci
[   88.019543] usb 2-1.1.1.1: New USB device found, idVendor=3D046d, idProd=
uct=3Dc05a
[   88.019561] usb 2-1.1.1.1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[   88.019572] usb 2-1.1.1.1: Product: USB Optical Mouse
[   88.019581] usb 2-1.1.1.1: Manufacturer: Logitech
[   88.027276] input: Logitech USB Optical Mouse as /devices/pci0000:00/000=
0:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1.1.1:1.0/0003:046D:C05A.000=
5/input/input18
[   88.027825] hid-generic 0003:046D:C05A.0005: input,hidraw1: USB HID
v1.11 Mouse [Logitech USB Optical Mouse] on
usb-0000:00:1d.0-1.1.1.1/input0
=2E..

Any ideas?

Did something change in Kconfig and I answered wrong?

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2UfgACgkQMOfwapXb+vJtzACfdrnOKPw70idQZS86eX3BgAN/
+rEAn0pyCjL2O/cVrtlFzelwyaVP3rA4
=rdt6
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
