From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [Patch v2][ 15/37] Input: tsc2007: Add device tree support.
Date: Fri, 18 Oct 2013 10:36:11 +0200
Message-ID: <20131018103611.4c6baabb@ipc1.ka-ro>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
	<1382022155-21954-16-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:61797 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3JRIgu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Oct 2013 04:36:50 -0400
In-Reply-To: <1382022155-21954-16-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Eric =?UTF-8?B?QsOpbmFyZA==?= <eric@eukrea.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Denis Carikli <denis@eukrea.com> wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2=
007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.t=
xt
> new file mode 100644
> index 0000000..d67b33f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> @@ -0,0 +1,44 @@
> +* Texas Instruments tsc2007 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "ti,tsc2007".
> +- reg: I2C address of the chip.
> +- pinctrl-0: Should specify pin control groups used for this control=
ler
> +  (see pinctrl bindings[0]).
> +- pinctrl-names: Should contain only one value - "default"
> +  (see pinctrl bindings[0]).
> +- interrupt-parent: the phandle for the interrupt controller
> +  (see interrupt binding[1]).
> +- interrupts: interrupt to which the chip is connected
> +  (see interrupt binding[1]).
> +- x-plate-ohms: X-plate resistance in ohms.
> +
There is already a property 'ti,x-plate-ohms' (used for ads7846).
Should this be used here too instead of inventing a new one?

[...]
> @@ -175,10 +192,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, vo=
id *handle)
> =20
>  		/* pen is down, continue with the measurement */
>  		tsc2007_read_values(ts, &tc);
> -
>  		rt =3D tsc2007_calculate_pressure(ts, &tc);
> =20
> -		if (rt =3D=3D 0 && !ts->get_pendown_state) {
> +		if ((ts->of && rt =3D=3D 0 && ts->gpio < 0) ||
=2E.. && !gpio_is_valid(ts->gpio)) ||
for consistency?

> @@ -273,34 +294,64 @@ static void tsc2007_close(struct input_dev *inp=
ut_dev)
>  	tsc2007_stop(ts);
>  }
> =20
> -static int tsc2007_probe(struct i2c_client *client,
> -				   const struct i2c_device_id *id)
> +#ifdef CONFIG_OF
> +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc200=
7 *ts,
> +			    struct device_node *np)
>  {
> -	struct tsc2007 *ts;
> -	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
> -	struct input_dev *input_dev;
> -	int err;
> -
> -	if (!pdata) {
> -		dev_err(&client->dev, "platform data is required!\n");
> +	int err =3D 0;
> +	u32 val32;
> +	u64 val64;
> +
> +	if (!of_property_read_u32(np, "max-rt", &val32))
> +		ts->max_rt =3D val32;
> +	else
> +		ts->max_rt =3D MAX_12BIT;
> +
> +	if (!of_property_read_u32(np, "fuzzy", &val32))
> +		ts->fuzzy =3D val32;
> +
> +	if (!of_property_read_u64(np, "poll-period", &val64))
> +		ts->poll_period =3D val64;
> +	else
> +		ts->poll_period =3D 1;
> +
> +	if (!of_property_read_u32(np, "x-plate-ohms", &val32)) {
> +		ts->x_plate_ohms =3D val32;
> +	} else {
> +		dev_err(&client->dev,
> +			"x-plate-ohms is not set up in the devicetree."
> +			" (err %d).", err);
>
It's a bad habit to split messages like this, since it makes it harder
to grep the kernel source for a message in a logfile.

>  		return -EINVAL;
>  	}
> =20
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> -		return -EIO;
> +	ts->gpio =3D of_get_gpio(np, 0);
> +	if (!gpio_is_valid(ts->gpio))
> +		dev_err(&client->dev, "GPIO not found "
> +			"(of_get_gpio returned %d)\n", ts->gpio);
> =20
dito (at least you should be consistent putting the space either in the
end of the first line or in the beginning of the next line!)

[...]
> @@ -309,13 +360,59 @@ static int tsc2007_probe(struct i2c_client *cli=
ent,
>  	ts->poll_period       =3D pdata->poll_period ? : 1;
>  	ts->get_pendown_state =3D pdata->get_pendown_state;
>  	ts->clear_penirq      =3D pdata->clear_penirq;
> +	ts->fuzzy             =3D pdata->fuzzy;
> =20
>  	if (pdata->x_plate_ohms =3D=3D 0) {
>  		dev_err(&client->dev, "x_plate_ohms is not set up in platform data=
");
> -		err =3D -EINVAL;
> +		return -EINVAL;
> +	}
> +
> +	/* Used to detect if it is probed trough the device tree,
> +	 * in order to be able to use that information in the IRQ handler.
> +	 */
> +	ts->of =3D 0;
> +
> +	return 0;
> +}
> +
> +static int tsc2007_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device_node *np =3D client->dev.of_node;
> +	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
> +	struct tsc2007 *ts;
> +	struct input_dev *input_dev;
> +	int err =3D 0;
> +
> +	ts =3D kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
>
devm_kzalloc()?

> @@ -389,10 +494,19 @@ static const struct i2c_device_id tsc2007_idtab=
le[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id tsc2007_of_match[] =3D {
> +	{ .compatible =3D "ti,tsc2007" },
> +	{ /* sentinel */ },
>
the redundant comma after the last entry in a struct initializer is
useful to ease adding more entries lateron. Since the empty entry
always has to be the last one, the comma doesn't make any sense here.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
