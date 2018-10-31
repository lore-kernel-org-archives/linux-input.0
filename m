From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Wed, 31 Oct 2018 13:29:19 +0100
Message-ID: <20181031122919.GA15074@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <20181030235430.GF30863@us.netrek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181030235430.GF30863@us.netrek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Cameron <quozl@laptop.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > But I don't get kernel messages during boot:
> >=20
> > OLPC 1B1, 512 MiB memory...
> > OpenFirmware Q4C02 EC Frimware 0.3.02
> >=20
> > Type any key to interrupt...
> > (but keys do not interrupt anything, ouch).
> > Warning... partition type is 0xb...
> > Boot device: /usb/disk:\boot\olpc.fth Arguments:
> > Boot device ....
> > Warning... partition type is 0xb...
>=20
> That firmware has problems with USB drives.  Please upgrade to Q4D38.
> Quickest tested method is http://wiki.laptop.org/go/Upgrading_firmware

Let me try that... Upgrading firmware said "USB drive" so I placed
bootfw.zip on usb drive. It did quite a show, but I believe it said
that my firmware is up to date?

It all ended with "activation lease not found" message. Let me retry?
Same result.

Let me try "upgrading firmware" with SD card. It seems to work with SD
card. Holding down both "yes" and "no" keys during boot results in
more useful messages... good. I have now updated firmware, and it even
fixed my previous boot problem. Good.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvZoB8ACgkQMOfwapXb+vIpwQCfWH+L06L+O7eJ1zs+wXKhuo3Y
Y0cAoLRDSdd0TA/ttWF7HfBB4K/daRe+
=hlkl
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
