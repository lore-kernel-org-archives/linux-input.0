From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 03/17] Input: sun4i-ts: Add thermal zone sensor support
Date: Tue, 6 Jan 2015 11:24:28 -0400
Message-ID: <20150106152425.GA6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-4-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:41879 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbbAFPZZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 10:25:25 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-4-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Chen-Yu,


On Tue, Jan 06, 2015 at 10:35:13AM +0800, Chen-Yu Tsai wrote:
> The touchscreen controller has a temperature sensor embedded in the SoC,
> which already has hwmon support in the driver.
>=20
> Add DT thermal zone support so we can use it with cpufreq for thermal
> throttling.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  1 +
>  drivers/input/touchscreen/sun4i-ts.c               | 27 ++++++++++++++++=
++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.tx=
t b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> index aef57791f40b..7f1110adbd24 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - compatible: "allwinner,sun4i-a10-ts"
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
> =20

You may want to update your Example section too, below.
Example:

	rtp: rtp@01c25000 {
		compatible =3D "allwinner,sun4i-a10-ts";
		reg =3D <0x01c25000 0x100>;
		interrupts =3D <29>;
		allwinner,ts-attached;
		#thermal-sensor-cells =3D <0>;
	};


>  Optional properties:
>   - allwinner,ts-attached: boolean indicating that an actual touchscreen =
is
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchsc=
reen/sun4i-ts.c
> index 28a06749ae42..b6e9043446d6 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -34,6 +34,7 @@
> =20
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
> +#include <linux/thermal.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> @@ -107,6 +108,7 @@
>  struct sun4i_ts_data {
>  	struct device *dev;
>  	struct input_dev *input;
> +	struct thermal_zone_device *tz;
>  	void __iomem *base;
>  	unsigned int irq;
>  	bool ignore_fifo_data;
> @@ -180,6 +182,23 @@ static void sun4i_ts_close(struct input_dev *dev)
>  	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>  }
> =20
> +static int get_temp(void *data, long *temp)
> +{
> +	struct sun4i_ts_data *ts =3D data;
> +
> +	/* No temp_data until the first irq */
> +	if (ts->temp_data =3D=3D -1)
> +		return -EAGAIN;
> +
> +	*temp =3D (ts->temp_data - 1447) * 100;
> +

Care to explain the formula in a simple comment?

> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
> +	.get_temp =3D get_temp,
> +};
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute *de=
vattr,
>  			 char *buf)
>  {
> @@ -288,6 +307,11 @@ static int sun4i_ts_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(hwmon))
>  		return PTR_ERR(hwmon);
> =20
> +	ts->tz =3D thermal_zone_of_sensor_register(ts->dev, 0, ts,
> +						 &sun4i_ts_tz_ops);
> +	if (IS_ERR(ts->tz))
> +		ts->tz =3D NULL;
> +
>  	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> =20
>  	if (ts_attached) {

here.. if input_register_device fails, you will keep an orphan thermal zone
registered in your system:

		error =3D input_register_device(ts->input);
		if (error) {
			writel(0, ts->base + TP_INT_FIFOC);
			return error;
		}
		...


> @@ -310,6 +334,9 @@ static int sun4i_ts_remove(struct platform_device *pd=
ev)
>  	if (ts->input)
>  		input_unregister_device(ts->input);
> =20
> +	if (ts->tz)
> +		thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
> +
>  	/* Deactivate all IRQs */
>  	writel(0, ts->base + TP_INT_FIFOC);
> =20
> --=20
> 2.1.4
>=20

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/4hAAoJEMLUO4d9pOJWpvYH/i9gXbl2AqfwK/ITQL1jxC2D
ko9ycv0NoWRE2o/SvpYLakYnkA7FIyFWl1jszZKPaYA/vuxp2u/u2v0pCxg+gVai
vUYFHzblHfETuzvSaddy+ufBPv/4VJk31fNGYncqEsRHUITKhY4pKYr9U5wQtSTc
C2AJJYK5aqUTB840mjKtHAnKipA1+Q9Vkz47eYVAuy/8zoFVkXnycwHVcu9goNMU
K4K+uFwBMSN6AP4QMwncnGGFvcu4l7fZTPH7IV50ChfGbYSvV30By28FAa2n4Euv
mTcY21qPUEAAntg45zX2c6xrk54db//vVnCyQWntNazGUFMqgUOajCHGqmgGsCk=
=GYdh
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
