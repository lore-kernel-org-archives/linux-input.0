From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] drivers: tca8418: Change the interrupt type
Date: Wed, 9 Nov 2016 09:02:35 +0100
Message-ID: <20161109080235.v23y42bojnwcw6rk@lukather>
References: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
 <20161109000400.GA8719@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bwewk2qlvljjyhuw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161109000400.GA8719@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--bwewk2qlvljjyhuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Tue, Nov 08, 2016 at 04:04:00PM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 07, 2016 at 03:40:24PM +0100, Maxime Ripard wrote:
> > The TCA8418 interrupt has a level trigger, not a edge one.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Hmm, maybe we could rely on OF data for trigger type?

We might, even though the i2c core doesn't change the trigger type
when it retrieves the interrupt from the DT.

However, I'm a bit worried about the other probing mechanims (ACPI,
board files) that should be supported as well, and removing the
trigger type from the flags might break those. There's no board files
using it though in the tree, but I don't know about ACPI systems.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bwewk2qlvljjyhuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYItgSAAoJEBx+YmzsjxAg0WYP/0IPDf2a4RLPqwVrVco87XYJ
BQfQfsJwsSYoTJYKvH6G3Uy6XaSxvy+kRS2cbo2L8OahRpSgN6gjVZv7ilSyRjK9
s7nedjsAWo+zf07YYpvFpU0eUgtmAGhU7cQRE1hkS0XfJ7hXfCSuRlqfNIipoatl
YBvw8dtHat1aV78ZCxIHGdVzqXliA6bIkHS84smI7aNofzjac3qZVdCyFsRn84e4
adpnfaZaif+bCuNcjYzz5J6t8PYLqqNu9jGAiJXmXytkrk3gT8swonTyynGCMr24
rfEi61i3MRxTEBDVEdpOIZJ2aJ5Sdo/2p7LCLFh9CGhmpGaHCFfEDHMJkf8c9Y9g
fk5eYalmMeDShLaFuXS+SCXYcx22AsEL/75Rzq23o3La0dPawRWgd/NLA/nYwGY4
6HrlB3XIdXd68ZEsemIH4emNbqnANzit3pz8eh/Dy0fP6rEK8nItCXTnHb5jrEDu
aqoLlcwRUvwiSpEyGsklTTPPr+b7bnZyHjriPQi8CD90MyoMwHS9YIO6eYYf89QP
VycGEUPv/GuYbBWb8GGG4GFw/40R/c0/VVdWfq7q5EYZ2XQI0GCv5hPvJNUPv5xc
Lpj2DnxrFzaBgVBqnkLopbgSq0UVlXqTqjIB5edsobSs23S/ANysU029HWErd/9h
DMgAeqmIVV9WlDXIS3oQ
=23Zh
-----END PGP SIGNATURE-----

--bwewk2qlvljjyhuw--
