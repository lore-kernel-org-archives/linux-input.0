From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO
 interface
Date: Tue, 28 Oct 2014 14:58:50 +0000
Message-ID: <20141028145850.GU18557@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8gjvNdKnYEg0NgYj"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414454528-24240-12-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--8gjvNdKnYEg0NgYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
> Since LoCoMo driver has been converted to provide proper gpiolib
> interface, make poodle ASoC platform driver use gpiolib API.

Please use subject lines matching the style for the subsystem.

> +	ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
> +	if (ret) {
> +		dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
> +				ret);
> +		return ret;
> +	}

I sense a need for devm_gpio_request_array() here.  Otherwise this looks
fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
so no need to block on this.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

with at least the subject line fixed.

--8gjvNdKnYEg0NgYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT68pAAoJECTWi3JdVIfQYyYH+QGeymd7BRFPtelbajCPw7hF
pZtjJ8IMNDHVFq7cb6nHCJDADtnjFr4H3wn4O/C7hjbVpFomxDExEiGZri2z97CZ
8XR1cFMTwDhZ9+5Vy4xZLQXjK3fHMB7VW7NvED34HiBNuPXlcXfH+4+opgN4WACS
a5kCtgAOdwgZzkDQcn34bIMzHnKoLxu4EzJ4IBegj3BKwLbDidTsdqzR9hIEnrA9
Itqct65aE2A1LG+wdwwSB6wttnUWuYviq5sY/W9LBa+g3w++6dkdeB5PRtD6Iatw
TCf7R9XJBYlu7T86V1XdB38ln7qc1KHYi16HHKeRwZPnuFWVFxuFH5J2hF9G5Ls=
=vsEb
-----END PGP SIGNATURE-----

--8gjvNdKnYEg0NgYj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
