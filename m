From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: zforce: add regulator handling
Date: Mon, 21 Jul 2014 10:42:08 -0700
Message-ID: <20140721174208.GA34322@core.coreip.homeip.net>
References: <2587208.XYbbI8xJiH@phil>
 <2184295.fEH4OJRW3F@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39432 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbaGURmN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 13:42:13 -0400
Content-Disposition: inline
In-Reply-To: <2184295.fEH4OJRW3F@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

On Mon, Jul 21, 2014 at 05:20:11PM +0200, Heiko St=FCbner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
>=20
> It's possible that the controller has an individually switchable powe=
r supply.
> Therefore add support to control a supplying regulator.
>=20
> As this is not always the case, the regulator is requested as optiona=
l.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Applied (with minimal edits to avoid repeated IS_ERR/PTR_ERR), thank
you.

> ---
>  .../bindings/input/touchscreen/zforce_ts.txt       |  4 +++
>  drivers/input/touchscreen/zforce_ts.c              | 30 ++++++++++++=
++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zfor=
ce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_=
ts.txt
> index 2faf1f1..80c37df 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt
> @@ -9,6 +9,9 @@ Required properties:
>  - x-size: horizontal resolution of touchscreen
>  - y-size: vertical resolution of touchscreen
> =20
> +Optional properties:
> +- vdd-supply: Regulator controlling the controller supply
> +
>  Example:
> =20
>  	i2c@00000000 {
> @@ -18,6 +21,7 @@ Example:
>  			compatible =3D "neonode,zforce";
>  			reg =3D <0x50>;
>  			interrupts =3D <2 0>;
> +			vdd-supply =3D <&reg_zforce_vdd>;
> =20
>  			gpios =3D <&gpio5 6 0>, /* INT */
>  				<&gpio5 9 0>; /* RST */
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/to=
uchscreen/zforce_ts.c
> index 01d30ce..39ca962 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -29,6 +29,8 @@
>  #include <linux/sysfs.h>
>  #include <linux/input/mt.h>
>  #include <linux/platform_data/zforce_ts.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> =20
> @@ -117,6 +119,8 @@ struct zforce_ts {
>  	const struct zforce_ts_platdata *pdata;
>  	char			phys[32];
> =20
> +	struct regulator	*reg_vdd;
> +
>  	bool			suspending;
>  	bool			suspended;
>  	bool			boot_complete;
> @@ -690,6 +694,11 @@ static void zforce_reset(void *data)
>  	struct zforce_ts *ts =3D data;
> =20
>  	gpio_set_value(ts->pdata->gpio_rst, 0);
> +
> +	udelay(10);
> +
> +	if (!IS_ERR(ts->reg_vdd))
> +		regulator_disable(ts->reg_vdd);
>  }
> =20
>  static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev=
)
> @@ -765,10 +774,31 @@ static int zforce_probe(struct i2c_client *clie=
nt,
>  		return ret;
>  	}
> =20
> +	ts->reg_vdd =3D devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(ts->reg_vdd) && PTR_ERR(ts->reg_vdd) =3D=3D -EPROBE_DEFE=
R)
> +		return PTR_ERR(ts->reg_vdd);
> +
> +	if (!IS_ERR(ts->reg_vdd)) {
> +		ret =3D regulator_enable(ts->reg_vdd);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * according to datasheet add 100us grace time after regular
> +		 * regulator enable delay.
> +		 */
> +		udelay(100);
> +	}
> +
>  	ret =3D devm_add_action(&client->dev, zforce_reset, ts);
>  	if (ret) {
>  		dev_err(&client->dev, "failed to register reset action, %d\n",
>  			ret);
> +
> +		/* hereafter the regulator will be disabled by the action */
> +		if (!IS_ERR(ts->reg_vdd))
> +			regulator_disable(ts->reg_vdd);
> +
>  		return ret;
>  	}
> =20
> --=20
> 1.9.0
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
