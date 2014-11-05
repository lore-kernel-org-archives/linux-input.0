From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Wed, 5 Nov 2014 20:24:05 +0000
Message-ID: <20141105202405.GJ8509@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
 <CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
 <CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 12:02:49AM +0400, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:41 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:

> > The point is still the same: no unrelated code in drivers/mfd,
> > then either use IIO DAC as a middle layer or sink the DAC handling
> > into respective subdriver, i.e. push it into the backlight or
> > volume directly then.

> The problem is that the DAC is equally used by backlight and by sound
> device (WIP).
> What about true i2c device driver sitting in drivers/misc and exporting a regmap
> of 2 8-bit registers?

If it can just export registers that sounds like a MFD.  If it needs to
export functionality then like Linus says the IIO subsystem abstracts
DACs.

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWodkAAoJECTWi3JdVIfQmVgH/3rgog8tN2ChD8V1ivSlMvNt
BR0isnXota/g1iIVojeFIhBwN7UZ5ZniMjn0dV7LKpMO20yzKNKz7znanQqTps6e
hBfrJc+uD1sjIdPCZHD0exKJyRCe40xkCG24rGUev9e2Vsnk2YyD5I6jo/yGNb97
icM3wNV/kSYXH0Iq/LViQqdtDXbFmnjxgN/qv1hQJGNF8ceAQeSTdO/HeLsyrjW5
JbIqnxNmxAaVACQSlkfbxrbCIj9zVqmW8V2Tab31nG3Mz/7rGofOcNM8ytzf2osP
WoIfhvxmqLtRvjwf6tfK2feLyW+NwjQ3ZK0w6OxPC1QCwrg+LSMNP2wbRe9qfpw=
=sVTi
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
