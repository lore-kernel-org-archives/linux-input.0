From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
Date: Fri, 18 Jan 2019 18:36:53 +0000
Message-ID: <20190118183653.GE6260@sirena.org.uk>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-9-brgl@bgdev.pl>
 <20190118180148.GD6260@sirena.org.uk>
 <CAMpxmJX8OmnDtOhQjWi9edX-4pHu1daKiDkRdNAVw-PZsz9UXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJX8OmnDtOhQjWi9edX-4pHu1daKiDkRdNAVw-PZsz9UXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 07:13:38PM +0100, Bartosz Golaszewski wrote:
> pt., 18 sty 2019 o 19:01 Mark Brown <broonie@kernel.org> napisa=C5=82(a):

> > > +++ b/drivers/regulator/max77650-regulator.c
> > > @@ -0,0 +1,537 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2018 BayLibre SAS
> > > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> > Please make the entire header C++ style so it looks more intentional.

> Seems like there are more files in the kernel source using the mixed
> comment style for the SPDX identifier and I also prefer it over C++
> only. Would you mind if it stayed that way?

I'd prefer to change.

> > You don't need to do this, the core will do it for you (it will actually
> > still do it even with the above, it'll only fall back to using
> > config->init_data if it's own lookup fails).

> I added this loop specifically because the core would not pick up the
> init data from DT. What did I miss (some specific variable to assign)?
> I just noticed some other drivers do the same and thought it's the
> right thing to do.

You should set regulators_node and of_match, see regulator_of_get_init_node=
().

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCHMQACgkQJNaLcl1U
h9DXBwf8DBxtp6P6ln8aUsZTEj9e2Ti+0cszf0ukaKXrny3tYAfY8PiUE/iYvr3E
1xb8upkWmq7kT7QO8bm/PbeDdClAIKlfI9aUoWyLo1HkHkj0F4VMUjDMy6mTbsl6
cijuEtr67FxzE+pak6KQOvqhKhh/tp2DMQFZD30dbDhSX3p8cMsM5YTqmlIO1q4t
p0Md4tGBiMAvtcI2suzwxkteeTVogqx00qMv6FdUGmupnQZ3y+PldPNpMmRY6ck2
xajDLGrBuvWCLesasIimDKVxmo2VRIYQ+fBqL1zPSJ0roZL1gknOfgmTOPyCwkYs
SzRytR1wQyrsQzW0TzFtxFhHHBuNKQ==
=LpDs
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
