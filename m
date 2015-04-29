From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/17] spi: add locomo SPI driver
Date: Wed, 29 Apr 2015 12:27:19 +0100
Message-ID: <20150429112719.GK22845@sirena.org.uk>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-10-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZocEfSc9YMy2wkfC"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430178954-11138-10-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org


--ZocEfSc9YMy2wkfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 02:55:46AM +0300, Dmitry Eremin-Solenikov wrote:

> +static int locomospi_reg_open(struct locomospi_dev *spidev)
> +{

> +static int locomospi_reg_release(struct locomospi_dev *spidev)
> +{

These are a bit weird - as far as I can tell they're just doing some
init done on probe and release?  I think I'd expect to see them either
inlined there or done as part of the PM operations too (including
runtime ones).

> +	for (j = 0; j < wait; j++) {
> +		regmap_read(spidev->regmap, LOCOMO_SPIST, &r);
> +		if (r & LOCOMO_SPI_RFW)
> +			break;
> +	}
> +	if (j == wait)
> +		dev_err(&spi->dev, "rfw timeout\n");

But we don't return an error if we time out?

> +static int locomo_spi_setup_transfer(struct spi_device *spi,
> +		struct spi_transfer *t)
> +{
> +	struct locomospi_dev *spidev;
> +	u32 hz = 0;
> +
> +	if (t)
> +		hz = t->speed_hz;
> +	if (!hz)
> +		hz = spi->max_speed_hz;

The core will set a speed on every transfer for you.

> +	if (!tx && !rx && t->len)
> +		return -EINVAL;

Put this in the core if it's needed.

> +static int locomo_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct locomospi_dev *spidev = spi_master_get_devdata(master);
> +
> +	return locomospi_reg_release(spidev);

We're doing this release before we free the master which is potentially
racy - but do we even need to do it at all?

--ZocEfSc9YMy2wkfC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQMAWAAoJECTWi3JdVIfQMFAH/3nUrvEBcxp8jyhAVn5jjqJu
pplMhi3HD0iiwiHljAMoUDBtIyi/5kCOMOV9H5wR9A5sUbHf/7LXAPABZ3QwfZIq
pK8OIRHvPpfTqsn2GESDUEXsxrs0QrAekLdCAEscyVbqrTihQVZebSBQGTSvFdxu
r/CoSnAFP5lk8GAMI5l19FMqv7UKPRalLweTLdg64L5Q7zLHSe1n0PamnXyE110r
dz8YwL3bD4PML52wBsZhwrYJRQArpP5fCr3HAqo2G+445NFstSptTT9CLsflcq9o
V3vryHNdYxOY10ugsfdd/NOBhnucEuuEYiZ9IrtFQzhykmC6B/t+tcliLDT7I7U=
=zqXc
-----END PGP SIGNATURE-----

--ZocEfSc9YMy2wkfC--
