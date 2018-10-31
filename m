From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Wed, 31 Oct 2018 13:46:09 +0100
Message-ID: <20181031124609.GA18100@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
 <20181031033746.GF8698@us.netrek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181031033746.GF8698@us.netrek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Cameron <quozl@laptop.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > https://github.com/hackerspace/olpc-xo175-buildroot/releases
> >=20
> > Here's a SD card image that works for me. The topmost commit in the
> > same repository is the build configuration that was used to generate
> > it:
> >=20
> > https://github.com/hackerspace/olpc-xo175-buildroot/commit/71783d599.pa=
tch
> >=20
> > Note it is only going to boot off the SD card, because the root=3D
> > argument is hardwired in the devicetree. Sorry about that -- I built
> > the image before I noticed you're booting off an USB stick and I don't
> > have the resources to regenerate the image at the moment.
>=20
> Your image does boot for me - after changing features on
> filesystem.
>=20
> 	http://dev.laptop.org/~quozl/y/1gHh5m.txt (dmesg)
>=20
> dumpe2fs of your image filesystem features; has_journal ext_attr
> resize_inode dir_index filetype flex_bg sparse_super large_file
> huge_file dir_nlink extra_isize metadata_csum, and flags;
> signed_directory_hash.
>=20
> dumpe2fs of my image filesystem features; has_journal ext_attr
> resize_inode dir_index filetype extent flex_bg sparse_super uninit_bg
> dir_nlink extra_isize, and flags; unsigned_directory_hash.
>=20
> Our OLPC OS builder uses "mkfs.ext4 -O dir_index,^huge_file", from
> e2fsprogs 1.42.5.
>=20
> I'll look at the microSD card errors; by trying another one.

Success, too... after re-doing the filesystem with local mkfs.

One thing I noticed: olpc-battery/voltage_max_design is lower than
voltage normally reported by voltage_now.

I'll play with it some more

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvZpBEACgkQMOfwapXb+vLY3gCguJBhkyJe+LYcAwtJ8cG8aki1
fukAnR4nEpnSiT8zFDKrrGvH04c9SfzX
=8caI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
