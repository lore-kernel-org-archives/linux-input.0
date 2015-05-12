From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 10/17] i2c: add locomo i2c driver
Date: Tue, 12 May 2015 21:24:13 +0200
Message-ID: <20150512192413.GE4449@schokonusskuchen.bad>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2015 at 02:55:47AM +0300, Dmitry Eremin-Solenikov wrote:
> LoCoMo chip contains a tiny i2c controller destined to control
> M62332 DAC. Provide a separate I2C driver for this cell.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Thanks for the submission!

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/locomo.h>
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>

To avoid duplicates, I prefer the includes to be sorted. No need to
resend because of that, though.

Kudos for brushing up old code! Do you want the drivers go via the
subsystem trees? Or is there a dependency so it should go in via some
other tree in one go?


--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUlNdAAoJEBQN5MwUoCm2RBAP/3YILVpXkyvZZVX0QJlKN1DI
Vvfli1Bm956MZwfV7ORSoWzthYmRSgsCZ/Q0i+97Y8M2sIpNWWQI00fFm6viiaf0
zlDq8JZFeAyDQG6BIfsOeWqnIY0RSVoZ5a11PFGnge+knkn1Zj/HADMYZKwWfPgx
qH/HXrPeZ79ewHzXmGPEmkGUBbtJYZi2VVprlYy85HY6yYPZ36/fS9tPNpCMz1vH
9uXzpyY1DqGjqoi0pTR7+PhlRpBWsXB75B35A8hvfujPDAMFaCkVkFzD/OzW25ac
Cu/NCRum6bCkVb6l5oz13sClc/5+OWUePH887TKgrZO4CFNH9jschbgqTb3utDLG
CnvXRzXBI+XCH35szRZpgWm2DZvbUZXCEvEyVHU39eiCpKL6qh9VKsqwMtHldirf
tDKKYW5Yo4io2QNedMbsBRFl60bajLBYxtmZhiTZKj8BBmaFa+Hi8rb+hdL5j0yV
Kl8VrW6zlJhAbYzNahRdQJ786JkJX6acr8J2Itx8vlMx7PDIdyhRFqJQa1Z636Hl
93sXW55dZtkOcrj+iHiT6047Az4AhzLr+WP8B8fxC4v0rC/1FXVdqjADduhu5LKU
i/TwixNqO32RV0pPjx1bQbZS1pmgk6nuIIsj9jue07wD64+F1xJcKfMZtrTZd3zL
4jm4gFJaJQ2D9kc0D7gd
=PJWG
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
