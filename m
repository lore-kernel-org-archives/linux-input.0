From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] input: zforce: add regulator handling
Date: Fri, 23 May 2014 09:51:43 +0200
Message-ID: <6176359.OyJRL3GZkq@phil>
References: <2587208.XYbbI8xJiH@phil> <60795928.lIAcBxC0Ao@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38212 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaEWHsY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 May 2014 03:48:24 -0400
In-Reply-To: <60795928.lIAcBxC0Ao@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

Hi Dmitry,

Am Dienstag, 22. April 2014, 21:19:57 schrieb Heiko St=FCbner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
>=20
> It's possible that the controller has an individually switchable powe=
r
> supply. Therefore add support to control a supplying regulator.
>=20
> As this is not always the case, the regulator is requested as optiona=
l.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

ping?


Thanks
Heiko

> ---
>  .../bindings/input/touchscreen/zforce_ts.txt       |  4 +++
>  drivers/input/touchscreen/zforce_ts.c              | 30
> ++++++++++++++++++++++ 2 files changed, 34 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt i=
ndex
> 2faf1f1..80c37df 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt
> @@ -9,6 +9,9 @@ Required properties:
>  - x-size: horizontal resolution of touchscreen
>  - y-size: vertical resolution of touchscreen
>=20
> +Optional properties:
> +- vdd-supply: Regulator controlling the controller supply
> +
>  Example:
>=20
>  	i2c@00000000 {
> @@ -18,6 +21,7 @@ Example:
>  			compatible =3D "neonode,zforce";
>  			reg =3D <0x50>;
>  			interrupts =3D <2 0>;
> +			vdd-supply =3D <&reg_zforce_vdd>;
>=20
>  			gpios =3D <&gpio5 6 0>, /* INT */
>  				<&gpio5 9 0>; /* RST */
> diff --git a/drivers/input/touchscreen/zforce_ts.c
> b/drivers/input/touchscreen/zforce_ts.c index 01d30ce..39ca962 100644
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
>=20
> @@ -117,6 +119,8 @@ struct zforce_ts {
>  	const struct zforce_ts_platdata *pdata;
>  	char			phys[32];
>=20
> +	struct regulator	*reg_vdd;
> +
>  	bool			suspending;
>  	bool			suspended;
>  	bool			boot_complete;
> @@ -690,6 +694,11 @@ static void zforce_reset(void *data)
>  	struct zforce_ts *ts =3D data;
>=20
>  	gpio_set_value(ts->pdata->gpio_rst, 0);
> +
> +	udelay(10);
> +
> +	if (!IS_ERR(ts->reg_vdd))
> +		regulator_disable(ts->reg_vdd);
>  }
>=20
>  static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev=
)
> @@ -765,10 +774,31 @@ static int zforce_probe(struct i2c_client *clie=
nt,
>  		return ret;
>  	}
>=20
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

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
