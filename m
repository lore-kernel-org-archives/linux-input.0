From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out of I2C realm
Date: Sun, 13 Aug 2017 15:34:18 +0200
Message-ID: <20170813133418.e7lftrmry3gu3dcc@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
 <20170523071727.tw6vblpnevihqgqk@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="un6k3vgsvoq72qro"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523071727.tw6vblpnevihqgqk@dell>
Sender: linux-i2c-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org


--un6k3vgsvoq72qro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 08:17:27AM +0100, Lee Jones wrote:
> On Mon, 22 May 2017, Wolfram Sang wrote:
>=20
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  drivers/input/misc/dm355evm_keys.c        | 2 +-
>=20
> >  drivers/mfd/dm355evm_msp.c                | 2 +-
>=20
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Does that mean it will be in 4.14? Or is something else needed?


--un6k3vgsvoq72qro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQVVYACgkQFA3kzBSg
KbZ0oBAAlK6567iwHZe47KAUT0HDedGV2VrGemijtXs5kk+ZiYeVuY7elKB892nS
U5FQa5k9sGqPh2wSWDHRmo2QN8kYUGgnaRKzmcanSfwdASHM0OdxU2fY5eeoF/Vd
9IByhr2Bi56SpjTTMwO1yFXEWLjW7v10ep3zB9uFtmj5Gn7TID65uNHc6d/l+70K
voE0oEuDZYTT0pxLL/MqoKnacyydsWfjoDalx0fKBlm3VM4nrzmt9N0sOFTNrWH4
IQ8r9bpsxSTnAumH+/G6SyDS81HYl9uka9Sv0vo3tdMcGt38qt0f/+9R68GlzTak
845iFfJTwzmCPwUWuubQBC+2lkYlY3nksNMMa9vKySpg8crHcEDq0Y+FmvGjklyX
0LrTTu3YYUNrMHxkLjcivG5hHkUi8FTyPtDm49dmny5Sumi/EW7luzsbsZl1oeH5
W5l8KfI9xXY6E74lDI1593XUWFAjAMfUPoRU9h3wwWsW1SdSUzSJm7fgwam0p9aA
FDECXVoYjZX8ZtdKWod9j46nb6JEfwGdiT35Yl2VabK7ymZgkv1tfOZ4jdoVDkh5
Y8tT7njVC5IYaRUrq1NsgaAfVE9ky/kUwNu7cP3zQiE8u59tDqm0PiDEnwROxzXZ
natDDw6vZUKrC4/PM3D2TgZyeey9jsNoMARVhyxlPLgeDxzKu4E=
=Z922
-----END PGP SIGNATURE-----

--un6k3vgsvoq72qro--
