From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out of I2C realm
Date: Mon, 14 Aug 2017 10:25:40 +0200
Message-ID: <20170814082540.g3w3aur2nwuf5s6h@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
 <20170523071727.tw6vblpnevihqgqk@dell>
 <20170813133418.e7lftrmry3gu3dcc@ninjato>
 <20170814064336.secnn77amfjgbltw@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l42lrog343rsfn2u"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814064336.secnn77amfjgbltw@dell>
Sender: linux-i2c-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org


--l42lrog343rsfn2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 07:43:36AM +0100, Lee Jones wrote:
> On Sun, 13 Aug 2017, Wolfram Sang wrote:
>=20
> > On Tue, May 23, 2017 at 08:17:27AM +0100, Lee Jones wrote:
> > > On Mon, 22 May 2017, Wolfram Sang wrote:
> > >=20
> > > > include/linux/i2c is not for client devices. Move the header file t=
o a
> > > > more appropriate location.
> > > >=20
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > >  drivers/input/misc/dm355evm_keys.c        | 2 +-
> > >=20
> > > >  drivers/mfd/dm355evm_msp.c                | 2 +-
> > >=20
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Does that mean it will be in 4.14? Or is something else needed?
>=20
> Can this patch be applied on its own, or does it have dependencies?

These patches are self-contained; they only move an include file from A
to B.


--l42lrog343rsfn2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRXoQACgkQFA3kzBSg
KbY0qA//ZeC2kaNfHB4JD4f+qJc3moP6Ba4+WG2IzQuP2Hrl3eN1qus229sicq9r
UZXE2RdWVSKi4F9uvnjtN4nr5E/TITcIOODa55AXD4Ia1eZMUtL9YG91i3W82xtR
azChlDZUA0ITFJ3KffBZKn/vmSHkunZ0TWR7QR1wRwcSjvcAcMWy57jc+WhcPYY3
7YyAjZWteGIXkcbZIEkh1wrZwWOWL3NL6/v+X9Fj5SGMaqkhrXUDIOK7hQVAuVTF
Gx4N1Aj0gfRIm5TRYwev5jYQ08aZ9mEkv0tel2Ava35qSZ9cIlrbtnMzvNxggXQB
nN6z+pfq9aROoRSTheSC1rgJk3ZKtdrWRZ2DUzEm2SWSCu8Yb+DlxWSteNz67i/v
Mx742hm9sdyjN67Vt7bsiGw+5azpleFr5Z2agzrTonPTSqGP+qdBEEHD4atno15W
iUGFpiyfERgn4fbelhpLZZ5w806FyYfp+yj+tVFNe6TNW74FZa5lxEgmELVaW9ia
WAd403lW4FCsyENGXUqGtKRZH+Tz8p5Q1eqebBeekC5FjPF/yFELhm1mvMu2CcLF
maMOLc4ba/ydtPYn1BMXqYb0PK2Qo/fJ7DBRzeFCO0VZGpGuyEqgGZc98ZAkQehB
L4CKGreuSL71MBRhxzgvq+rC2womxL9ke5ZVHh2wNCslmqmA+t8=
=gGaZ
-----END PGP SIGNATURE-----

--l42lrog343rsfn2u--
