From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] Input: tsc2004/5 - switch to using generic device
 properties
Date: Sat, 11 Feb 2017 18:37:48 +0100
Message-ID: <20170211173748.ad6fsrjvkepfqu5e@earth>
References: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
 <20170211000623.33663-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fr6g5odnqkawtago"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdBKRh7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Feb 2017 12:37:59 -0500
Content-Disposition: inline
In-Reply-To: <20170211000623.33663-3-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org


--fr6g5odnqkawtago
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 10, 2017 at 04:06:23PM -0800, Dmitry Torokhov wrote:
> Instead of supporting legacy platform data (of which we have no mainline
> users) and OF-based properties, let's switch to generic device properties.
> This will still allow legacy boards to use the driver (by defining proper=
ty
> sets and attaching them to the drivers) and will simplify probe and make
> driver usable on ACPI-based systems as well.

Reviewed-By: Sebastian Reichel <sre@kernel.org>

FYI: The last & only platform data user of tsc2005 was N900, which was
removed in 9b7141d01a76 (ARM: OMAP2+: Drop legacy board file for n900).

-- Sebastian

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/tsc200x-core.c | 93 +++++++++++---------------=
------
>  include/linux/spi/tsc2005.h              | 34 ------------
>  2 files changed, 30 insertions(+), 97 deletions(-)
>  delete mode 100644 include/linux/spi/tsc2005.h
>=20
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/tou=
chscreen/tsc200x-core.c
> index 1c14a38e3748..88ea5e1b72ae 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -27,7 +27,6 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/of.h>
> -#include <linux/spi/tsc2005.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>
> @@ -114,7 +113,6 @@ struct tsc200x {
>  	struct regulator	*vio;
> =20
>  	struct gpio_desc	*reset_gpio;
> -	void			(*set_reset)(bool enable);
>  	int			(*tsc200x_cmd)(struct device *dev, u8 cmd);
>  	int			irq;
>  };
> @@ -227,12 +225,13 @@ static void tsc200x_stop_scan(struct tsc200x *ts)
>  	ts->tsc200x_cmd(ts->dev, TSC200X_CMD_STOP);
>  }
> =20
> -static void tsc200x_set_reset(struct tsc200x *ts, bool enable)
> +static void tsc200x_reset(struct tsc200x *ts)
>  {
> -	if (ts->reset_gpio)
> -		gpiod_set_value_cansleep(ts->reset_gpio, enable);
> -	else if (ts->set_reset)
> -		ts->set_reset(enable);
> +	if (ts->reset_gpio) {
> +		gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +		usleep_range(100, 500); /* only 10us required */
> +		gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +	}
>  }
> =20
>  /* must be called with ts->mutex held */
> @@ -253,7 +252,7 @@ static void __tsc200x_enable(struct tsc200x *ts)
>  {
>  	tsc200x_start_scan(ts);
> =20
> -	if (ts->esd_timeout && (ts->set_reset || ts->reset_gpio)) {
> +	if (ts->esd_timeout && ts->reset_gpio) {
>  		ts->last_valid_interrupt =3D jiffies;
>  		schedule_delayed_work(&ts->esd_work,
>  				round_jiffies_relative(
> @@ -310,9 +309,7 @@ static ssize_t tsc200x_selftest_show(struct device *d=
ev,
>  	}
> =20
>  	/* hardware reset */
> -	tsc200x_set_reset(ts, false);
> -	usleep_range(100, 500); /* only 10us required */
> -	tsc200x_set_reset(ts, true);
> +	tsc200x_reset(ts);
> =20
>  	if (!success)
>  		goto out;
> @@ -354,7 +351,7 @@ static umode_t tsc200x_attr_is_visible(struct kobject=
 *kobj,
>  	umode_t mode =3D attr->mode;
> =20
>  	if (attr =3D=3D &dev_attr_selftest.attr) {
> -		if (!ts->set_reset && !ts->reset_gpio)
> +		if (!ts->reset_gpio)
>  			mode =3D 0;
>  	}
> =20
> @@ -404,9 +401,7 @@ static void tsc200x_esd_work(struct work_struct *work)
> =20
>  	tsc200x_update_pen_state(ts, 0, 0, 0);
> =20
> -	tsc200x_set_reset(ts, false);
> -	usleep_range(100, 500); /* only 10us required */
> -	tsc200x_set_reset(ts, true);
> +	tsc200x_reset(ts);
> =20
>  	enable_irq(ts->irq);
>  	tsc200x_start_scan(ts);
> @@ -454,26 +449,12 @@ int tsc200x_probe(struct device *dev, int irq, cons=
t struct input_id *tsc_id,
>  		  struct regmap *regmap,
>  		  int (*tsc200x_cmd)(struct device *dev, u8 cmd))
>  {
> -	const struct tsc2005_platform_data *pdata =3D dev_get_platdata(dev);
> -	struct device_node *np =3D dev->of_node;
> -
>  	struct tsc200x *ts;
>  	struct input_dev *input_dev;
> -	unsigned int max_x =3D MAX_12BIT;
> -	unsigned int max_y =3D MAX_12BIT;
> -	unsigned int max_p =3D MAX_12BIT;
> -	unsigned int fudge_x =3D TSC200X_DEF_X_FUZZ;
> -	unsigned int fudge_y =3D TSC200X_DEF_Y_FUZZ;
> -	unsigned int fudge_p =3D TSC200X_DEF_P_FUZZ;
> -	unsigned int x_plate_ohm =3D TSC200X_DEF_RESISTOR;
> -	unsigned int esd_timeout;
> +	u32 x_plate_ohm;
> +	u32 esd_timeout;
>  	int error;
> =20
> -	if (!np && !pdata) {
> -		dev_err(dev, "no platform data\n");
> -		return -ENODEV;
> -	}
> -
>  	if (irq <=3D 0) {
>  		dev_err(dev, "no irq\n");
>  		return -ENODEV;
> @@ -487,23 +468,6 @@ int tsc200x_probe(struct device *dev, int irq, const=
 struct input_id *tsc_id,
>  		return -ENODEV;
>  	}
> =20
> -	if (pdata) {
> -		fudge_x	=3D pdata->ts_x_fudge;
> -		fudge_y	=3D pdata->ts_y_fudge;
> -		fudge_p	=3D pdata->ts_pressure_fudge;
> -		max_x	=3D pdata->ts_x_max;
> -		max_y	=3D pdata->ts_y_max;
> -		max_p	=3D pdata->ts_pressure_max;
> -		x_plate_ohm =3D pdata->ts_x_plate_ohm;
> -		esd_timeout =3D pdata->esd_timeout_ms;
> -	} else {
> -		x_plate_ohm =3D TSC200X_DEF_RESISTOR;
> -		of_property_read_u32(np, "ti,x-plate-ohms", &x_plate_ohm);
> -		esd_timeout =3D 0;
> -		of_property_read_u32(np, "ti,esd-recovery-timeout-ms",
> -								&esd_timeout);
> -	}
> -
>  	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>  	if (!ts)
>  		return -ENOMEM;
> @@ -517,8 +481,13 @@ int tsc200x_probe(struct device *dev, int irq, const=
 struct input_id *tsc_id,
>  	ts->idev =3D input_dev;
>  	ts->regmap =3D regmap;
>  	ts->tsc200x_cmd =3D tsc200x_cmd;
> -	ts->x_plate_ohm =3D x_plate_ohm;
> -	ts->esd_timeout =3D esd_timeout;
> +
> +	error =3D device_property_read_u32(dev, "ti,x-plate-ohms", &x_plate_ohm=
);
> +	ts->x_plate_ohm =3D error ? TSC200X_DEF_RESISTOR : x_plate_ohm;
> +
> +	error =3D device_property_read_u32(dev, "ti,esd-recovery-timeout-ms",
> +					 &esd_timeout);
> +	ts->esd_timeout =3D error ? 0 : esd_timeout;
> =20
>  	ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH=
);
>  	if (IS_ERR(ts->reset_gpio)) {
> @@ -534,9 +503,6 @@ int tsc200x_probe(struct device *dev, int irq, const =
struct input_id *tsc_id,
>  		return error;
>  	}
> =20
> -	if (!ts->reset_gpio && pdata)
> -		ts->set_reset =3D pdata->set_reset;
> -
>  	mutex_init(&ts->mutex);
> =20
>  	spin_lock_init(&ts->lock);
> @@ -559,22 +525,23 @@ int tsc200x_probe(struct device *dev, int irq, cons=
t struct input_id *tsc_id,
> =20
>  	input_dev->phys =3D ts->phys;
>  	input_dev->id =3D *tsc_id;
> -	input_dev->dev.parent =3D dev;
> -	input_dev->evbit[0] =3D BIT(EV_ABS) | BIT(EV_KEY);
> -	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
> -
> -	input_set_abs_params(input_dev, ABS_X, 0, max_x, fudge_x, 0);
> -	input_set_abs_params(input_dev, ABS_Y, 0, max_y, fudge_y, 0);
> -	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
> -
> -	if (np)
> -		touchscreen_parse_properties(input_dev, false, NULL);
> =20
>  	input_dev->open =3D tsc200x_open;
>  	input_dev->close =3D tsc200x_close;
> =20
>  	input_set_drvdata(input_dev, ts);
> =20
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
> +
> +	input_set_abs_params(input_dev, ABS_X,
> +			     0, MAX_12BIT, TSC200X_DEF_X_FUZZ, 0);
> +	input_set_abs_params(input_dev, ABS_Y,
> +			     0, MAX_12BIT, TSC200X_DEF_Y_FUZZ, 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE,
> +			     0, MAX_12BIT, TSC200X_DEF_P_FUZZ, 0);
> +
> +	touchscreen_parse_properties(input_dev, false, NULL);
> +
>  	/* Ensure the touchscreen is off */
>  	tsc200x_stop_scan(ts);
> =20
> diff --git a/include/linux/spi/tsc2005.h b/include/linux/spi/tsc2005.h
> deleted file mode 100644
> index 563b3b1799a8..000000000000
> --- a/include/linux/spi/tsc2005.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * This file is part of TSC2005 touchscreen driver
> - *
> - * Copyright (C) 2009-2010 Nokia Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - */
> -
> -#ifndef _LINUX_SPI_TSC2005_H
> -#define _LINUX_SPI_TSC2005_H
> -
> -#include <linux/types.h>
> -
> -struct tsc2005_platform_data {
> -	int		ts_pressure_max;
> -	int		ts_pressure_fudge;
> -	int		ts_x_max;
> -	int		ts_x_fudge;
> -	int		ts_y_max;
> -	int		ts_y_fudge;
> -	int		ts_x_plate_ohm;
> -	unsigned int	esd_timeout_ms;
> -	void		(*set_reset)(bool enable);
> -};
> -
> -#endif
> --=20
> 2.11.0.483.g087da7b7c-goog
>=20

--fr6g5odnqkawtago
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlifS+oACgkQ2O7X88g7
+pq1Wg/9FTGxlfGds6qlNqO8bVR5Q7z8+QGpInhmSnGP/sUZHaiHFniQGyh19AC1
hSGTBzUniibjg+k+R3zYHsNwzLWyUrXEJP12VCZLVZusWBrjjOncrrVLKZjLNuQV
wDW3HVuTeN8GH81Lennn2wiRDKcwHnw04+jCzOpgaWBgtyQ48BUhJibs3CQ6+YB5
A/oTTokdko20WDGKUS/YPTj4YC5TAd4YKG+3GfT1QaHHxKtGawVymnIH5vBbLKgj
PXwwl2IOgRipFeDPW4QJzO/pWmeJ5tfa3oQaMevnMUa5i+Mqbwgcln77Cub83mDD
BsMmn/J4HKSZ8mpncW/bNjwiH3NTU7Aw/Thc0UMb107J5094pYUnqzoYqAm8OuGy
a1ZsT1JVECHKab0i9o2yydN/iinBR+7ZP0ejKGNqyED/NG3UuIWYmaEYR2B+tReN
+q37HWvW9QMrvrxCVmNqpLYtcCpis0YZy3a3JCvxAgo4dbBQ/n7ZQw6UIHxAT/OH
ZuUAPHt/It7AJsnGHyIGkijBADIt3AcqxQqUCrbCWWh2SpUmetWKRPYcyMRusVjK
vdDm1ITImcyycXN2ubbC6Aau9eSpvfaCnItDuV/jvuUS4IsrSJPXQsGfyCes4Dog
DlKWtPJ/2Y8Jf2HZjKhrHghKukW2rWJ4mnJIQqEj8mHmm1OJZP0=
=smqF
-----END PGP SIGNATURE-----

--fr6g5odnqkawtago--
