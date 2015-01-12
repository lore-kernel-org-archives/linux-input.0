From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/9] Input: sun4i-ts: Add thermal zone sensor support
Date: Mon, 12 Jan 2015 08:08:05 -0400
Message-ID: <20150112120803.GB24190@developer>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421037249-28461-2-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 12:34:01PM +0800, Chen-Yu Tsai wrote:
> The touchscreen controller has a temperature sensor embedded in the SoC,
> which already has hwmon support in the driver.
>=20
> Add DT thermal zone support so we can use it with cpufreq for thermal
> throttling.
>=20
> This also adds a comment stating that we do not know the actual formula
> for calculating the temperature.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>=20
> changes since v2:
>=20
>     - Use common function for temperature calculation
>=20
> changes since v1:
>=20
>     - clean up thermal zone sensor when input device register fails
>     - unconditionally unregister thermal zone sensor on removal.
>       the unregister function checks the pointers passed in.
>     - add comment explaining the lack of documents for the temperature
>       calculation formula
>=20
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  2 +
>  drivers/input/touchscreen/sun4i-ts.c               | 54 ++++++++++++++++=
++++--
>  2 files changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.tx=
t b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> index aef57791f40b..a8405bab6c00 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - compatible: "allwinner,sun4i-a10-ts"
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
> =20
>  Optional properties:
>   - allwinner,ts-attached: boolean indicating that an actual touchscreen =
is
> @@ -17,4 +18,5 @@ Example:
>  		reg =3D <0x01c25000 0x100>;
>  		interrupts =3D <29>;
>  		allwinner,ts-attached;
> +		#thermal-sensor-cells =3D <0>;
>  	};
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchsc=
reen/sun4i-ts.c
> index 28a06749ae42..5851aa0bd78b 100644
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
> @@ -180,16 +182,48 @@ static void sun4i_ts_close(struct input_dev *dev)
>  	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>  }
> =20
> +static int get_temp(const struct sun4i_ts_data *ts, long *temp)
> +{
> +	/* No temp_data until the first irq */
> +	if (ts->temp_data =3D=3D -1)
> +		return -EAGAIN;
> +
> +	/*
> +	 * The user manuals do not contain the formula for calculating
> +	 * the temperature. The formula used here is from the AXP209,
> +	 * which is designed by X-Powers, an affiliate of Allwinner:
> +	 *
> +	 *     temperature =3D -144.7 + (value * 0.1)
> +	 *
> +	 * This should be replaced with the correct one if such information
> +	 * becomes available.
> +	 */
> +	*temp =3D (ts->temp_data - 1447) * 100;
> +
> +	return 0;
> +}
> +
> +static int get_tz_temp(void *data, long *temp)
> +{
> +	return get_temp(data, temp);
> +}
> +
> +static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
> +	.get_temp =3D get_tz_temp,
> +};
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute *de=
vattr,
>  			 char *buf)
>  {
>  	struct sun4i_ts_data *ts =3D dev_get_drvdata(dev);
> +	long temp;
> +	int ret;
> =20
> -	/* No temp_data until the first irq */
> -	if (ts->temp_data =3D=3D -1)
> -		return -EAGAIN;
> +	ret =3D get_temp(ts, &temp);
> +	if (ret)
> +		return ret;
> =20
> -	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);
> +	return sprintf(buf, "%ld\n", temp);
>  }
> =20
>  static ssize_t show_temp_label(struct device *dev,
> @@ -283,17 +317,27 @@ static int sun4i_ts_probe(struct platform_device *p=
dev)
>  	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
>  	       ts->base + TP_CTRL1);
> =20
> +	/*
> +	 * The thermal core does not register hwmon devices for DT-based
> +	 * thermal zone sensors, such as this one.
> +	 */
>  	hwmon =3D devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
>  						       ts, sun4i_ts_groups);
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
>  		error =3D input_register_device(ts->input);
>  		if (error) {
>  			writel(0, ts->base + TP_INT_FIFOC);
> +			thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
>  			return error;
>  		}
>  	}
> @@ -310,6 +354,8 @@ static int sun4i_ts_remove(struct platform_device *pd=
ev)
>  	if (ts->input)
>  		input_unregister_device(ts->input);
> =20
> +	thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
> +
>  	/* Deactivate all IRQs */
>  	writel(0, ts->base + TP_INT_FIFOC);
> =20
> --=20
> 2.1.4
>=20

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs7kFAAoJEMLUO4d9pOJWjGIH/3TEu+IstATHJKifto5gOVpz
kmIzP4nNMKd3Fxi0ujUbJ/lFd0Nh+KNcBD3J9f2ZI4fN/CI6SumUXgN1QrWs48Ej
MSSoI9HVC2AnI4FYZyUC5TNb+Q4PJAHueeyOSSRNs5z2OF49vHBqLshKnyrQ41BL
ybs9HXcLFqewJS90uAdFgosMGMHskV2LdnHXpvKzB7fbF42vnb0JkfbjiFagGHUl
VQ6r4L/tiTPZmddIU8xt0WNmzLU557+PhkgM4qsTpS7WbVv0tOIqFwmKzRzjkfkK
/VhRhdSt8Szci4HAqCxY+Lg8znaGuf7IKJZwXWIf8Iod+4U9xp/BUi/A2VMZwNQ=
=4OLd
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
