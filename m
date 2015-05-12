From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 10/17] i2c: add locomo i2c driver
Date: Tue, 12 May 2015 21:28:38 +0200
Message-ID: <20150512192837.GF4449@schokonusskuchen.bad>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-11-git-send-email-dbaryshkov@gmail.com>
 <20150512192413.GE4449@schokonusskuchen.bad>
 <CALT56yNHvJ1Swj2pp2JrBaJBensSP703JXQKfvivFrJOYf85QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALT56yNHvJ1Swj2pp2JrBaJBensSP703JXQKfvivFrJOYf85QA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kern>
List-Id: linux-input@vger.kernel.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 10:27:07PM +0300, Dmitry Eremin-Solenikov wrote:
> 2015-05-12 22:24 GMT+03:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Tue, Apr 28, 2015 at 02:55:47AM +0300, Dmitry Eremin-Solenikov wrote:
> >> LoCoMo chip contains a tiny i2c controller destined to control
> >> M62332 DAC. Provide a separate I2C driver for this cell.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >
> > Thanks for the submission!
> >
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/mfd/locomo.h>
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/i2c-algo-bit.h>
> >
> > To avoid duplicates, I prefer the includes to be sorted. No need to
> > resend because of that, though.
> >
> > Kudos for brushing up old code! Do you want the drivers go via the
> > subsystem trees? Or is there a dependency so it should go in via some
> > other tree in one go?
>=20
> There is a header dependency -- <linux/mfd/locomo.h> is a new header.
> I'd prefer for these patches to go in via one of MFD, arm-soc or ARM trees
> as a whole series (if that would be ok with respective maintainers).

Fine with me.

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>


--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJVUlRlAAoJEBQN5MwUoCm2ej0P+IIGAwD/rcSrFWlH3MXKff0v
qacZgD25svWNP+S4hrW42/x4lksQmhegWBUj10lhQ1UlVoY6JwByMQRUGz3rsf5J
j6/L6Edo8IXopbrWmtXjG4YiFMAIAmRWFV7LP2dcfP/3MXOWtAlzGnLsyA2hpUk0
dDSET2fTSuBxYW0C5jKk2yaE6mF14jebYBV83MuzG7bHBklQwdoXu2rk19XPE+Yw
p/SB7Yk5luWIVtekfGDRdEeDac8Z7nf3ZuJdOCpXcaPLZoCeFoPxSgDLE2vjsIME
EEBFJu2F+dF0oVdvPsIflhCeu1o6ba7iOLB3f4rpNMJZw4UsxphvT7uoSYCwwhH+
naU47orc6X9a4yG50wxla/3nRAcrc6rPu5rUhFCNrUWibAzZJix8iMl2OHPEazHC
i8X7QC0RLXdrSHw1YWgIdYsUDtqtWoF5gGkEnCkkxw4fGQYCaJzmJfsoxIii/+ol
HgZlMN+Xwr5l0zykm0T4sfgnNdRriAQwAGv+f3i+6hT3uTj9iDzjY5AWNjE50l8H
zSTGhNkNByPVare/obIT273YmA4pldZJ/xOin5fAtSsgTBraBzb6+NOi5pqkJCkb
Wdvj4Dd+V+GcKQYYIaA1K/pJ06m4Pr1aZ7a8DOiE/aMBJ6nrKeY5k5ZcBMKx4wfm
HjbVrK3h4R/rQE5p9I0=
=2XV8
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
