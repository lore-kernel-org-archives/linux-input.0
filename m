From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.13-rc2: usb mouse stopped working?
Date: Wed, 26 Jul 2017 13:03:29 +0200
Message-ID: <20170726110329.GA6033@amd>
References: <20170724200056.GA3997@amd>
 <alpine.LSU.2.20.1707242203510.4705@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55262 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdGZLDb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Jul 2017 07:03:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1707242203510.4705@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > In v4.9:
> >=20
> > [   87.064408] input: Logitech USB Optical Mouse as
> > /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1=
=2E1.1:1.0/0003:046D:C05A.0005/input/input18
> > [   87.065951] hid-generic 0003:046D:C05A.0005: input,hidraw0: USB HID
> > v1.11 Mouse [Logitech USB Optical Mouse] on
> > usb-0000:00:1d.0-1.1.1.1/input0
> > pavel@duo:~$
> >=20
> > v4.13-rc2:
> >=20
> > [   87.886810] usb 2-1.1.1.1: new low-speed USB device number 10 using =
ehci-pci
> > [   88.019543] usb 2-1.1.1.1: New USB device found, idVendor=3D046d, id=
Product=3Dc05a
> > [   88.019561] usb 2-1.1.1.1: New USB device strings: Mfr=3D1, Product=
=3D2, SerialNumber=3D0
> > [   88.019572] usb 2-1.1.1.1: Product: USB Optical Mouse
> > [   88.019581] usb 2-1.1.1.1: Manufacturer: Logitech
> > [   88.027276] input: Logitech USB Optical Mouse as /devices/pci0000:00=
/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1.1.1:1.0/0003:046D:C05A=
=2E0005/input/input18
> > [   88.027825] hid-generic 0003:046D:C05A.0005: input,hidraw1: USB HID
> > v1.11 Mouse [Logitech USB Optical Mouse] on
> > usb-0000:00:1d.0-1.1.1.1/input0
>=20
> ... this is most likely caused by e399396a6b0, and fix for that is queued=
=20
> in hid.git as cf601774c9f ("HID: usbhid: fix "always poll" quirk"); I'm=
=20
> planning to send it to Linus' tomorrow, but if you can double-check that=
=20
> it does fix your issue as well, that'd be appreciated.

I pulled newer git, and now it seems to work. Thanks! (Tested with
same mouse but different PC).
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll4dwEACgkQMOfwapXb+vJW6ACeN7QuCk9bywhghB/ob2w51EUb
EK8AniTny7eFeyhcgGdnlx1MwFcmtS8X
=FNAw
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
