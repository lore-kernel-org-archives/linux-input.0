From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 15/15] spi: add locomo SPI driver
Date: Tue, 28 Oct 2014 11:03:53 +0000
Message-ID: <20141028110353.GR18557@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-16-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LBS9LiS8wIv0ZHM"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414454528-24240-16-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--5LBS9LiS8wIv0ZHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 03:02:08AM +0300, Dmitry Eremin-Solenikov wrote:
> LoCoMo chip has a built-in simple SPI controller. On Sharp SL-5500 PDDAs
> it is connected to external MMC slot.

> +config SPI_LOCOMO
> +	tristate "Locomo SPI master"
> +	depends on MFD_LOCOMO
> +	select SPI_BITBANG

Rather than using SPI_BITBANG it'd be good for new drivers to convert to
using the core transfer_one() functionality which replaces most of what
the bitbang code is doing.  The bitbang functionality was misnamed for
most of the users and we're going to try to move most of the functionality
not actually related to bitbanging out of it.

> +	/* if (locomospi_carddetect()) { */
> +	r = readw(spidev->base + LOCOMO_SPIMD);
> +	r |= LOCOMO_SPIMD_XON;
> +	writew(r, spidev->base + LOCOMO_SPIMD);
> +
> +	r = readw(spidev->base + LOCOMO_SPIMD);
> +	r |= LOCOMO_SPIMD_XEN;
> +	writew(r, spidev->base + LOCOMO_SPIMD);
> +	/* } */

Either remove or implement the comments.

> +	r = readw(spidev->base + LOCOMO_SPICT);
> +	r |= LOCOMO_SPIMD_XEN; /* FIXME */
> +	writew(r, spidev->base + LOCOMO_SPICT);

FIXME?

> +	if (t)
> +		hz = t->speed_hz;
> +	if (!hz)
> +		hz = spi->max_speed_hz;

The core will ensure that the transfer always has a speed set in it.

> +static int locomo_spi_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct spi_master *master;
> +	struct locomospi_dev *spidev;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "LoCoO SPI Driver\n");

Remove this, it's not adding anything.

--5LBS9LiS8wIv0ZHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT3gYAAoJECTWi3JdVIfQMRUH/1ywHd6UOGA0VNyAiMVZYi+x
XlQspIiJGWfZFNWBuga40yvkX7JD1xGNSVzVAYkjowyN8iDKW9xrBhP+sRoANS8K
mvQ4NALGqU7dQW5/mFItbnCNcEWn3B65Y3fj3vlxQ4CGkQr3IoKG4wexl+pO3aju
584wwezeESMuNdOrPKIHjksY6/QAY35hPOooIaDW5H9t+9gHOMe/JToxbru+8liw
h0k52r2CkuXb5thCqAkeF45aBaNSXqbPZ0TMVnh0GvSQiGE9U62WWOJH8fvVG+5s
BW/2DUoHYtmpsf3kNDmD/gilT7+f4YjKKUw6tkBc6ewbkLe5wb1rSNM+JkiElcU=
=55Nr
-----END PGP SIGNATURE-----

--5LBS9LiS8wIv0ZHM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
