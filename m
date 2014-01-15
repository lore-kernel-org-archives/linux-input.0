From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06: Add DT support
Date: Wed, 15 Jan 2014 09:46:43 +0900
Message-ID: <000401cf118b$42ba5db0$c82f1910$%han@samsung.com>
References: <1389608224-9975-1-git-send-email-LW@KARO-electronics.de>
 <1389608224-9975-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1389608224-9975-2-git-send-email-LW@KARO-electronics.de>
Content-language: ko
Sender: linux-doc-owner@vger.kernel.org
To: =?utf-8?Q?'Lothar_Wa=C3=9Fmann'?= <LW@KARO-electronics.de>
Cc: linux-input@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Ian Campbell' <ijc+devicetree@hellion.org.uk>, 'Kumar Gala' <galak@codeaurora.org>, 'Rob Landley' <rob@landley.net>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Grant Likely' <grant.likely@linaro.org>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Jonathan Cameron' <jic23@kernel.org>, 'Shawn Guo' <shawn.guo@linaro.org>, 'Silvio F' <silvio.fricke@gmail.com>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>, 'Fugang Duan' <B38611@freescale.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Simon Budig' <simon.budig@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

On Monday, January 13, 2014 7:17 PM, Lothar Wa=C3=9Fmann wrote:
>=20
> This patch allows the edt-ft5x06 multitouch panel driver to be
> configured via DT.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>

(+cc Simon Budig)

This 'edt-ft5x06' driver was made by Simon Budig.
Please, add him to CC list.

Also, I added some comments. :-)

> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |   31 ++++
>  drivers/input/touchscreen/edt-ft5x06.c             |  145 ++++++++++=
+++++----
>  2 files changed, 145 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/edt-ft5x06.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-=
ft5x06.txt
> b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
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
> +- threshold: allows setting the "click"-threshold in the range from =
20 to 80.
> +- gain: sensitivity (0..31) (lower value -> higher sensitivity)
> +- offset: edge compensation (0..31)
> +- report_rate: report rate (3..14)

s/report_rate/report-rate

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
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/t=
ouchscreen/edt-ft5x06.c
> index af0d68b..02dce42 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -33,6 +33,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
> +#include <linux/of_gpio.h>
>  #include <linux/input/mt.h>
>  #include <linux/input/edt-ft5x06.h>
>=20
> @@ -65,6 +66,10 @@ struct edt_ft5x06_ts_data {
>  	u16 num_x;
>  	u16 num_y;
>=20
> +	int reset_pin;
> +	int irq_pin;
> +	int wake_pin;
> +
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *debug_dir;
>  	u8 *raw_buffer;
> @@ -617,24 +622,37 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x0=
6_ts_data *tsdata)
>=20
>=20
>  static int edt_ft5x06_ts_reset(struct i2c_client *client,
> -					 int reset_pin)
> +			struct edt_ft5x06_ts_data *tsdata)
>  {
>  	int error;
>=20
> -	if (gpio_is_valid(reset_pin)) {
> +	if (gpio_is_valid(tsdata->wake_pin)) {
> +		error =3D gpio_request_one(tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
> +					 "edt-ft5x06 wake");

Please use devm_gpio_request_one(), because it makes the code
simpler.

> +		if (error) {
> +			dev_err(&client->dev,
> +				"Failed to request GPIO %d as wake pin, error %d\n",
> +				tsdata->wake_pin, error);
> +			return error;
> +		}
> +
> +		mdelay(5);
> +		gpio_set_value(tsdata->wake_pin, 1);
> +	}
> +	if (gpio_is_valid(tsdata->reset_pin)) {
>  		/* this pulls reset down, enabling the low active reset */
> -		error =3D gpio_request_one(reset_pin, GPIOF_OUT_INIT_LOW,
> +		error =3D gpio_request_one(tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
>  					 "edt-ft5x06 reset");

Please use devm_gpio_request_one() too.

>  		if (error) {
>  			dev_err(&client->dev,
>  				"Failed to request GPIO %d as reset pin, error %d\n",
> -				reset_pin, error);
> +				tsdata->reset_pin, error);
>  			return error;
>  		}
>=20
> -		mdelay(50);
> -		gpio_set_value(reset_pin, 1);
> -		mdelay(100);
> +		mdelay(5);
> +		gpio_set_value(tsdata->reset_pin, 1);
> +		mdelay(300);
>  	}
>=20
>  	return 0;
> @@ -674,6 +692,21 @@ static int edt_ft5x06_ts_identify(struct i2c_cli=
ent *client,
>  	    pdata->name <=3D edt_ft5x06_attr_##name.limit_high)		\
>  		edt_ft5x06_register_write(tsdata, reg, pdata->name)
>=20
> +#define EDT_GET_PROP(name, reg) {					\
> +	const u32 *prop =3D of_get_property(np, #name, NULL);		\
> +	if (prop)							\
> +		edt_ft5x06_register_write(tsdata, reg, be32_to_cpu(*prop)); \
> +}
> +
> +static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
> +					struct edt_ft5x06_ts_data *tsdata)
> +{
> +	EDT_GET_PROP(threshold, WORK_REGISTER_THRESHOLD);
> +	EDT_GET_PROP(gain, WORK_REGISTER_GAIN);
> +	EDT_GET_PROP(offset, WORK_REGISTER_OFFSET);
> +	EDT_GET_PROP(report_rate, WORK_REGISTER_REPORT_RATE);
> +}
> +
>  static void
>  edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
>  			   const struct edt_ft5x06_platform_data *pdata)
> @@ -701,6 +734,39 @@ edt_ft5x06_ts_get_parameters(struct edt_ft5x06_t=
s_data *tsdata)
>  	tsdata->num_y =3D edt_ft5x06_register_read(tsdata, WORK_REGISTER_NU=
M_Y);
>  }
>=20
> +#ifdef CONFIG_OF
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

This code looks awkward.
There are two ways, please choose one of them.

1. Check the return value

	ret =3D of_get_named_gpio_flags(np, "reset-gpios", 0, &gpio_flags);
	if (ret < 0) {
		dev_err(dev, "reset-gpios pin is not provided.\n");
		return ret;
	}
	tsdata->reset_pin =3D ret;

2. No check the return value, passing it directly

	tsdata->reset_pin =3D of_get_named_gpio_flags(np, "reset-gpios", 0, &g=
pio_flags);


> +
> +	ret =3D of_get_named_gpio_flags(np, "wake-gpios", 0, &gpio_flags);

According to the Documentation 'edt-ft5x06.txt',
'wakeup-gpios' is used, instead of 'wake-gpios'.
What is the right name?

> +	tsdata->wake_pin =3D ret;
> +
> +	return 0;
> +}
> +#else
> +static inline int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> +					struct edt_ft5x06_i2c_ts_data *tsdata)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  					 const struct i2c_device_id *id)
>  {
> @@ -713,30 +779,43 @@ static int edt_ft5x06_ts_probe(struct i2c_clien=
t *client,
>=20
>  	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
>=20
> +	tsdata =3D devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
> +	if (!tsdata) {
> +		dev_err(&client->dev, "failed to allocate driver data.\n");
> +		return -ENOMEM;
> +	}
> +
>  	if (!pdata) {
> -		dev_err(&client->dev, "no platform data?\n");
> -		return -EINVAL;
> +		error =3D edt_ft5x06_i2c_ts_probe_dt(&client->dev, tsdata);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"DT probe failed and no platform data present\n");
> +			return error;
> +		}
> +	} else {
> +		tsdata->reset_pin =3D pdata->reset_pin;
> +		tsdata->irq_pin =3D pdata->irq_pin;
> +		tsdata->wake_pin =3D -EINVAL;
>  	}
>=20
> -	error =3D edt_ft5x06_ts_reset(client, pdata->reset_pin);
> +	error =3D edt_ft5x06_ts_reset(client, tsdata);
>  	if (error)
>  		return error;
>=20
> -	if (gpio_is_valid(pdata->irq_pin)) {
> -		error =3D gpio_request_one(pdata->irq_pin,
> +	if (gpio_is_valid(tsdata->irq_pin)) {
> +		error =3D gpio_request_one(tsdata->irq_pin,
>  					 GPIOF_IN, "edt-ft5x06 irq");

Please use devm_gpio_request_one() too.

>  		if (error) {
>  			dev_err(&client->dev,
>  				"Failed to request GPIO %d, error %d\n",
> -				pdata->irq_pin, error);
> +				tsdata->irq_pin, error);
>  			return error;
>  		}
>  	}
>=20
> -	tsdata =3D kzalloc(sizeof(*tsdata), GFP_KERNEL);
>  	input =3D input_allocate_device();
> -	if (!tsdata || !input) {
> -		dev_err(&client->dev, "failed to allocate driver data.\n");
> +	if (!input) {
> +		dev_err(&client->dev, "failed to allocate input device.\n");
>  		error =3D -ENOMEM;
>  		goto err_free_mem;
>  	}
> @@ -752,7 +831,11 @@ static int edt_ft5x06_ts_probe(struct i2c_client=
 *client,
>  		goto err_free_mem;
>  	}
>=20
> -	edt_ft5x06_ts_get_defaults(tsdata, pdata);
> +	if (!pdata)
> +		edt_ft5x06_ts_get_dt_defaults(client->dev.of_node, tsdata);
> +	else
> +		edt_ft5x06_ts_get_defaults(tsdata, pdata);
> +
>  	edt_ft5x06_ts_get_parameters(tsdata);
>=20
>  	dev_dbg(&client->dev,
> @@ -802,8 +885,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
>  	device_init_wakeup(&client->dev, 1);
>=20
>  	dev_dbg(&client->dev,
> -		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
> -		pdata->irq_pin, pdata->reset_pin);
> +		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
> +		client->irq, tsdata->wake_pin, tsdata->reset_pin);
>=20
>  	return 0;
>=20
> @@ -813,18 +896,18 @@ err_free_irq:
>  	free_irq(client->irq, tsdata);
>  err_free_mem:
>  	input_free_device(input);
> -	kfree(tsdata);
> -
> -	if (gpio_is_valid(pdata->irq_pin))
> -		gpio_free(pdata->irq_pin);
> +	if (gpio_is_valid(tsdata->irq_pin))
> +		gpio_free(tsdata->irq_pin);
> +	if (gpio_is_valid(tsdata->reset_pin))
> +		gpio_free(tsdata->reset_pin);
> +	if (gpio_is_valid(tsdata->wake_pin))
> +		gpio_free(tsdata->wake_pin);

If you use devm_gpio_request_one(), these gpio_free()s are not
necessary.

>=20
>  	return error;
>  }
>=20
>  static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  {
> -	const struct edt_ft5x06_platform_data *pdata =3D
> -						dev_get_platdata(&client->dev);
>  	struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
>=20
>  	edt_ft5x06_ts_teardown_debugfs(tsdata);
> @@ -833,12 +916,12 @@ static int edt_ft5x06_ts_remove(struct i2c_clie=
nt *client)
>  	free_irq(client->irq, tsdata);
>  	input_unregister_device(tsdata->input);
>=20
> -	if (gpio_is_valid(pdata->irq_pin))
> -		gpio_free(pdata->irq_pin);
> -	if (gpio_is_valid(pdata->reset_pin))
> -		gpio_free(pdata->reset_pin);
> -
> -	kfree(tsdata);
> +	if (gpio_is_valid(tsdata->irq_pin))
> +		gpio_free(tsdata->irq_pin);
> +	if (gpio_is_valid(tsdata->reset_pin))
> +		gpio_free(tsdata->reset_pin);
> +	if (gpio_is_valid(tsdata->wake_pin))
> +		gpio_free(tsdata->wake_pin);

If you use devm_gpio_request_one(), these gpio_free()s are not
necessary.

Best regards,
Jingoo Han

