From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06: Add DT support
Date: Mon, 13 Jan 2014 13:44:41 +0000
Message-ID: <20140113134441.GD1273@e106331-lin.cambridge.arm.com>
References: <1389608224-9975-1-git-send-email-LW@KARO-electronics.de>
 <1389608224-9975-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389608224-9975-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Silvio F <silvio.fricke@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 13, 2014 at 10:17:04AM +0000, Lothar Wa=C3=9Fmann wrote:
> This patch allows the edt-ft5x06 multitouch panel driver to be
> configured via DT.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |   31 ++++
>  drivers/input/touchscreen/edt-ft5x06.c             |  145 ++++++++++=
+++++----
>  2 files changed, 145 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/edt-ft5x06.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-=
ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft=
5x06.txt
> new file mode 100644
> index 0000000..629dbdd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.=
txt
> @@ -0,0 +1,31 @@
> +* EDT FT5x06 Multiple Touch Controller
> +
> +Required properties:
> +- compatible: must be "edt,ft5x06"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +
> +Optional properties:
> +- reset-gpios:  the gpio pin to be used for resetting the controller
> +- wakeup-gpios: the gpio pin to be used for waking up the controller
> +
> +  The following properties provide default values for the
> +  corresponding parameters configurable via sysfs
> +  (see Documentation/input/edt-ft5x06.txt)

The sysfs interface shouldn't matter for the binding, it's a Linux
detail. There's no reason for it to be mentioned in the binding.

> +- threshold: allows setting the "click"-threshold in the range from =
20 to 80.
> +- gain: sensitivity (0..31) (lower value -> higher sensitivity)
> +- offset: edge compensation (0..31)
> +- report_rate: report rate (3..14)

s/_/-/ on property names please. Also, it may make sense to prefix thes=
e
as they're rather generic sounding names.

Could you elaborate on these a litle please? What units are each of
these in? Why does it make sense to have them in the dt?

> +
> +Example:
> +
> +	edt_ft5x06@38 {
> +		compatible =3D "edt,ft5x06";
> +		reg =3D <0x38>;
> +		interrupt-parent =3D <&gpio2>;
> +		interrupts =3D <5 0>;
> +		wakeup-gpios =3D <&gpio1 9 0>;
> +		reset-gpios =3D <&gpio2 6 1>;
> +		wakeup-gpios =3D <&gpio4 9 0>;
> +	};

One of those wakeup-gpios properties should go.

[...]

> +#define EDT_GET_PROP(name, reg) {					\
> +	const u32 *prop =3D of_get_property(np, #name, NULL);		\
> +	if (prop)							\
> +		edt_ft5x06_register_write(tsdata, reg, be32_to_cpu(*prop)); \
> +}

Use of_property_read_u32, which does endianness conversion and property
length checking (which you're not doing). Sparse _will_ complain here
because you've not maintained the __be32 annotation.

> +static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
> +					struct edt_ft5x06_ts_data *tsdata)
> +{
> +	EDT_GET_PROP(threshold, WORK_REGISTER_THRESHOLD);
> +	EDT_GET_PROP(gain, WORK_REGISTER_GAIN);
> +	EDT_GET_PROP(offset, WORK_REGISTER_OFFSET);
> +	EDT_GET_PROP(report_rate, WORK_REGISTER_REPORT_RATE);

These should probably have sanity checks given you've described valid
ranges in the documentation.

[...]

> +static int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> +				struct edt_ft5x06_ts_data *tsdata)
> +{
> +	int ret;
> +	struct device_node *np =3D dev->of_node;
> +	enum of_gpio_flags gpio_flags;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	/*
> +	 * irq_pin is not needed for DT setup.
> +	 * irq is associated via 'interrupts' property in DT
> +	 */
> +	tsdata->irq_pin =3D -EINVAL;
> +
> +	ret =3D of_get_named_gpio_flags(np, "reset-gpios", 0, &gpio_flags);
> +	tsdata->reset_pin =3D ret;
> +
> +	ret =3D of_get_named_gpio_flags(np, "wake-gpios", 0, &gpio_flags);
> +	tsdata->wake_pin =3D ret;

Shouldn't that be "wakeup-gpios"?

Do you not need the value of flags? I'm not that familiar with the GPIO
subsystem, and it feels odd to rtequest the flags and throw them away.

Thanks,
Mark.
