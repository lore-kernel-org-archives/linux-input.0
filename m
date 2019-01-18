From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
Date: Fri, 18 Jan 2019 18:01:48 +0000
Message-ID: <20190118180148.GD6260@sirena.org.uk>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-9-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118134244.22253-9-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 02:42:39PM +0100, Bartosz Golaszewski wrote:

> Add regulator support for max77650. We support all four variants of this
> PMIC including non-linear voltage table for max77651 SBB1 rail.

Looks good, the ramping stuff might be a candidate for core (TBH I was
sure we'd got that implemented already but we don't seem to) but that
can be done later and the more complex one with non-linear steps does
feel like it might have to stay in the driver anyway.

A couple of small nits:

> +++ b/drivers/regulator/max77650-regulator.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Please make the entire header C++ style so it looks more intentional.

> +		for_each_child_of_node(dev->of_node, child) {
> +			if (!of_node_name_eq(child, rdesc->desc.name))
> +				continue;
> +
> +			init_data = of_get_regulator_init_data(dev, child,
> +							       &rdesc->desc);
> +			if (!init_data)
> +				return -ENOMEM;
> +
> +			config.of_node = child;
> +			config.init_data = init_data;
> +		}

You don't need to do this, the core will do it for you (it will actually
still do it even with the above, it'll only fall back to using
config->init_data if it's own lookup fails).

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCFIsACgkQJNaLcl1U
h9DaJQf9Ee2yWoCC92HHYenJAWkagKDlUOWo5MUoKpYE2BrcBcgKQAw3XMUz45Y9
eb1/I4MoT9vqo5JKBSHlTUKCH+HE4gTo433lFQW2y46e8qf6I6vt1abn/pScmrlI
7IudxGE9c4BJsIbAfvLI9rtLvfdOSxBUdjYMs3hMDnn0U4Oh4qc4q0lHkiYR/wSU
Mp+PnFpDxVAMzWNnao55zS1vkkELoMy++tO50+aGuFxLRIXHvCBf8LZ5LkAOZo9Q
gm3SDThdid8VaNnA/YlHiFRCdLsNrWDH9qfYoyVZ2XCNUW3cnXFmH8shroh0fBYy
nuJZQHDLj3lAl8LsLmRwwzG2KdQlFw==
=f48Z
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
