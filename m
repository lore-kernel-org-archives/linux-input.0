From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/9] Input: sun4i-ts: Add thermal zone sensor support
Date: Fri, 9 Jan 2015 09:23:18 -0800
Message-ID: <20150109172318.GA39037@dtor-ws>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420798676-22856-2-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 09, 2015 at 06:17:48PM +0800, Chen-Yu Tsai wrote:
> The touchscreen controller has a temperature sensor embedded in the S=
oC,
> which already has hwmon support in the driver.
>=20
> Add DT thermal zone support so we can use it with cpufreq for thermal
> throttling.
>=20
> This also adds a comment stating that we do not know the actual formu=
la
> for calculating the temperature.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---


  CC [M]  drivers/input/touchscreen/sun4i-ts.o
drivers/input/touchscreen/sun4i-ts.c:208:15: error: variable
=E2=80=98sun4i_ts_tz_ops=E2=80=99 has initializer but incomplete type
 static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
               ^
drivers/input/touchscreen/sun4i-ts.c:209:2: error: unknown field
=E2=80=98get_temp=E2=80=99 specified in initializer
  .get_temp =3D get_temp,
  ^
drivers/input/touchscreen/sun4i-ts.c:209:2: warning: excess elements in
struct initializer [enabled by default]
drivers/input/touchscreen/sun4i-ts.c:209:2: warning: (near
initialization for =E2=80=98sun4i_ts_tz_ops=E2=80=99) [enabled by defau=
lt]
drivers/input/touchscreen/sun4i-ts.c: In function =E2=80=98sun4i_ts_pro=
be=E2=80=99:
drivers/input/touchscreen/sun4i-ts.c:331:8: warning: passing argument 4
of =E2=80=98thermal_zone_of_sensor_register=E2=80=99 from incompatible =
pointer type
[enabled by default]
        &sun4i_ts_tz_ops);
        ^
In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
include/linux/thermal.h:302:1: note: expected =E2=80=98int (*)(void *, =
long int
*)=E2=80=99 but argument is of type =E2=80=98struct thermal_zone_of_dev=
ice_ops *=E2=80=99
 thermal_zone_of_sensor_register(struct device *dev, int id,
 ^
drivers/input/touchscreen/sun4i-ts.c:331:8: error: too few arguments to
function =E2=80=98thermal_zone_of_sensor_register=E2=80=99
        &sun4i_ts_tz_ops);
        ^
In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
include/linux/thermal.h:302:1: note: declared here
 thermal_zone_of_sensor_register(struct device *dev, int id,
 ^
make[1]: *** [drivers/input/touchscreen/sun4i-ts.o] Error 1
make: *** [drivers/input/touchscreen/sun4i-ts.o] Error 2

>=20
> changes since v1:
>=20
>     - clean up thermal zone sensor when input device register fails
>     - unconditionally unregister thermal zone sensor on removal.
>       the unregister function checks the pointers passed in.
>     - add comment explaining the lack of documents for the temperatur=
e
>       calculation formula
>=20
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  2 +
>  drivers/input/touchscreen/sun4i-ts.c               | 47 ++++++++++++=
++++++++++
>  2 files changed, 49 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4=
i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
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
>   - allwinner,ts-attached: boolean indicating that an actual touchscr=
een is
> @@ -17,4 +18,5 @@ Example:
>  		reg =3D <0x01c25000 0x100>;
>  		interrupts =3D <29>;
>  		allwinner,ts-attached;
> +		#thermal-sensor-cells =3D <0>;
>  	};
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/tou=
chscreen/sun4i-ts.c
> index 28a06749ae42..aac49db0b09d 100644
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
> @@ -180,6 +182,33 @@ static void sun4i_ts_close(struct input_dev *dev=
)
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
> +static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
> +	.get_temp =3D get_temp,
> +};
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute=
 *devattr,
>  			 char *buf)
>  {
> @@ -189,6 +218,16 @@ static ssize_t show_temp(struct device *dev, str=
uct device_attribute *devattr,
>  	if (ts->temp_data =3D=3D -1)
>  		return -EAGAIN;
> =20
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
>  	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);

Why duplicate it here, instead of doing:

static int sun4i_get_temp(struct sun4i_ts_data *ts, int *temp)
{
	if (ts->temp_data =3D=3D -1)
		return -EAGAIN;

	/* comment */
	*temp =3D (ts->temp_data - 1447) * 100);

	return 0;
}

static int sun4i_tz_get_temp(void *data, long *temp)
{
	return sun4i_get_temp(data, temp);
}

static ssize_t sun4i_show_temp(...)
{
	error =3D sun4i_get_temp(ts, &temp);
	if (error)
		return error;

	return sprintf(buf, "%d\n", temp);
}

Also, thermal core seems to allow creating hwmon devices for thermal
zones, can we use this feature?

Thanks.

--=20
Dmitry
