From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv5][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 08:51:50 +0200
Message-ID: <20131024085150.11a81974@ipc1.ka-ro>
References: <1382530220-27881-1-git-send-email-denis@eukrea.com>
	<52684B33.6040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:60446 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3JXGwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 02:52:10 -0400
In-Reply-To: <52684B33.6040109@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Denis Carikli <denis@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, Eric =?UTF-8?B?QsOpbmFyZA==?= <eric@eukrea.com>, linux-input@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi,

Rob Herring wrote:
> On 10/23/2013 07:10 AM, Denis Carikli wrote:
[...]
> > diff --git
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > new file mode 100644
> > index 0000000..fadd3f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.t=
xt
> > @@ -0,0 +1,44 @@
> > +* Texas Instruments tsc2007 touchscreen controller
> > +
> > +Required properties:
> > +- compatible: must be "ti,tsc2007".
> > +- reg: I2C address of the chip.
> > +- pinctrl-0: Should specify pin control groups used for this contr=
oller
> > +  (see pinctrl bindings[0]).
> > +- pinctrl-names: Should contain only one value - "default"
> > +  (see pinctrl bindings[0]).
>=20
> I'm confused why an i2c slave needs pinctl binding?
>=20
for the pendetect GPIO.

[...]
> > diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/to=
uchscreen/tsc2007.c
> > index 0b67ba4..0625fe1 100644
> > --- a/drivers/input/touchscreen/tsc2007.c
> > +++ b/drivers/input/touchscreen/tsc2007.c
> > @@ -26,6 +26,9 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/i2c.h>
> >  #include <linux/i2c/tsc2007.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> > =20
> >  #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
> >  #define TSC2007_MEASURE_AUX		(0x2 << 4)
> > @@ -74,7 +77,10 @@ struct tsc2007 {
> >  	u16			max_rt;
> >  	unsigned long		poll_delay;
> >  	unsigned long		poll_period;
> > +	int			fuzzy;
> > +	char			of;
> > =20
> > +	unsigned		gpio;
> >  	int			irq;
> > =20
> >  	wait_queue_head_t	wait;
[...]
> > @@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *i=
nput_dev)
> >  	tsc2007_stop(ts);
> >  }
> > =20
> > -static int tsc2007_probe(struct i2c_client *client,
> > -				   const struct i2c_device_id *id)
> > +#ifdef CONFIG_OF
> > +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2=
007 *ts,
> > +			    struct device_node *np)
> >  {
> > -	struct tsc2007 *ts;
> > -	struct tsc2007_platform_data *pdata =3D client->dev.platform_data=
;
> > -	struct input_dev *input_dev;
> > -	int err;
> > -
> > -	if (!pdata) {
> > -		dev_err(&client->dev, "platform data is required!\n");
> > +	int err =3D 0;
> > +	u32 val32;
> > +	u64 val64;
> > +
> > +	if (!of_property_read_u32(np, "max-rt", &val32))
> > +		ts->max_rt =3D val32;
> > +	else
> > +		ts->max_rt =3D MAX_12BIT;
>=20
> These functions don't overwrite the value if the property isn't prese=
nt.
> So you can set the values to the defaults and just pass the variable
> (i.e. ts->max_rt) to of_property_read_u32 directly.
>=20
Not quite. Since max_rt is an u16 you can't pass it to
of_property_read_u32(). And using of_property_read_u16() requires the
abominable DT notation: "/bits/ 16 <value>;"


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
