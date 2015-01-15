From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 13:53:22 +0100
Message-ID: <20150115125321.GD2549@katana>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20141218082151.GA1038@katana>
 <1492007.8cQN1myWLD@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492007.8cQN1myWLD@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>
List-Id: linux-input@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2014 at 02:49:28PM +0200, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Thursday 18 December 2014 09:21:51 Wolfram Sang wrote:
> > On Thu, Dec 18, 2014 at 04:15:23AM +0200, Laurent Pinchart wrote:
> > > The I2C subsystem can match devices without explicit OF support based=
 on
> > > the part of their compatible property after the comma. However, this
> > > mechanism uses the first compatible value only. For adxl34x OF device
> > > nodes the compatible property should list the more specific
> > > "adi,adxl345" or "adi,adxl346" value first and the "adi,adxl34x"
> > > fallback value second. This prevents the device node from being match=
ed
> > > with the adxl34x driver.
> > >=20
> > > Fix this by adding an OF match table with an "adi,adxl34x" compatible
> > > entry.
> > >=20
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >=20
> > >  drivers/input/misc/adxl34x-i2c.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > Another option would have been to add "adxl325" and "adxl326" entries=
 to
> > > the adxl34x_id I2C match table, but it would have had the drawback of
> > > requiring a driver update for every new device.
> >=20
> > AFAIK this is even required for compatible entries, to be as specific as
> > possible. I think this makes sense. With platform_ids, we already had
> > the problem that pca954x was too generic and was used for both GPIO
> > extenders and I2C muxers (IIRC).
>=20
> There are three compatible strings defined for the ADXL345 and ADXL346 in=
=20
> Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",=
=20
> "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for t=
he=20
> first two I don't see a need to add the specific compatible strings to th=
e=20
> driver for now. If a new totally incompatible chip named ADXL347 comes ou=
t we=20
> will need a new driver which won't be allowed to use the "adi,adxl34x"=20
> compatible string.

Been there, got bitten. We only found out too late, because one driver
was in i2c and the other in GPIO (or LED even?), both using "953x" :(

> An option would be to remove "adi,adxl34x" from=20
> Documentation/devicetree/bindings/i2c/trivial-devices.txt, in which case =
the=20
> driver should match explicitly on "adi,adxl345" and "adi,adxl346". That m=
ight=20
> clash with the DT ABI stability requirements though.

I do prefer this:

1) add specific compatible values to the driver. We do those updates for
new devices all the time
2) also add "34x" as a compatible but mark it as deprecateed
3) delete "34x" from trivial devices

Everyone OK with that?

Thanks,

   Wolfram


--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt7hBAAoJEBQN5MwUoCm2Y70P/2KEeSgh/g/k18jpKglp33rI
m8e0U09JbX2uqFCkRrY6y+pjjYFwgID6ldeDwyf8ZV+CuyD1UYbE73WHdk3Gb0VK
LhQqupWpCFmjCW2xs53385gsw1abtYRC99qM+3cPmlb4jmZfD9vLDMiatG1lJ0KL
Bdf5teTbee2LxzyMAgRuO12dYTfRcp2HkzVgxn5wV9QEyHsceW7+WAh89jWJtoH+
Gj5/HSe+PzbGP643BoOx3p/GSSSKlbsZ1OytRk9YhmQnoUCR0f/YnXjVEeP8kvQ9
qXWehZwYXJDSgkLwLBTwKJWZmG1BzCkrZYLgosjHD/P0wP8IXEMMwW5GyR9xEa7k
FF0xI+Zp2HLGY6kSMaD+/0jglwsI+lbkeo6GbYinc5JFDhMXuUrMJ/KPUR+VQnGL
K5jDb2rlY56OYJ1vg4cDQLyX5Jj7tr9iFh+5vLBPH7Uy6tj+Z/1lJSZxYMbchrhh
Zr8I7mLTRnvjCVEn6ebwR1nlACNtDLdHL+FyDnXQ89Dv/SkyG7oFSqym5Q2+Jl6G
f5aVzLb0QILKRG1wlXIqSs2B5zHEnTO0kBjSZZ/VrcNMi8Be3L8cf/JSJxhsrV59
LZbEiraaaB4f+RAyVfHhADkvURiXoSBpsYGmgyUBSf7S0Jf+4tN1XkVxtgOs0IpS
++ojwwLw+xEcXhSCRt1Q
=utdP
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
