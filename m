From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce - make the interrupt GPIO optional
Date: Wed, 29 Jul 2015 10:53:04 -0700
Message-ID: <20150729175304.GD23178@dtor-ws>
References: <1438072008-11769-1-git-send-email-dirk.behme@de.bosch.com>
 <20150728210621.GF19610@dtor-ws>
 <2117458.kiOQbe0u2g@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33024 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbbG2RxJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 13:53:09 -0400
Received: by pdbnt7 with SMTP id nt7so9644274pdb.0
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2015 10:53:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2117458.kiOQbe0u2g@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On Tue, Jul 28, 2015 at 11:43:20PM +0200, Heiko St=FCbner wrote:
> Hi,
>=20
> it's nice to see that my driver seems to be used somewhere :-)
>=20
>=20
> Am Dienstag, 28. Juli 2015, 14:06:21 schrieb Dmitry Torokhov:
> > On Tue, Jul 28, 2015 at 10:26:48AM +0200, Dirk Behme wrote:
> > > Add support for hardware which uses an I2C Serializer / Deseriali=
zer
> > > (SerDes) to communicate with the zFroce touch driver. In this cas=
e the
> > > SerDes will be configured as an interrupt controller and the zFor=
ce driver
> > > will have no access to poll the GPIO line.
> > > To support this, we add two dedicated new GPIOs in the device tre=
e:
> > > rst-gpio and int-gpio. With the int-gpio being optional, then.
> > >=20
> > > To not break the existing device trees, the index based 'gpios' e=
ntries
> > > are still supported, but marked as depreciated.
> 								^ typo deprecated
>=20
> > >=20
> > > With this, if the interrupt GPIO is available, either via the old=
 or new
> > > device tree style, the while loop will read and handle the packet=
s as long
> > > as the GPIO indicates that the interrupt is asserted (existing, u=
nchanged
> > > driver behavior).
> > >=20
> > > If the interrupt GPIO isn't available, i.e. not configured via th=
e new
> > > device tree style, we are falling back to one read per ISR invoca=
tion
> > > (new behavior to support the SerDes).
> > >=20
> > > Note that the gpiod functions help to handle the optional GPIO:
> > > devm_gpiod_get_index_optional() will return NULL in case the inte=
rrupt
> > > GPIO isn't available. And gpiod_get_value_cansleep() does cover t=
his, too,
> > > by returning 0 in this case.
> >=20
> > Let's let Heiko take a look as well.
> >=20
> > > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> > > ---
> > >=20
> > >  .../bindings/input/touchscreen/zforce_ts.txt       |  8 ++--
> > >  drivers/input/touchscreen/zforce_ts.c              | 49
> > >  +++++++++++++++++++++- 2 files changed, 52 insertions(+), 5 dele=
tions(-)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt
> > > b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.t=
xt index
> > > 80c37df..c6be925 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_=
ts.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_=
ts.txt
> > >=20
> > > @@ -4,12 +4,12 @@ Required properties:
> > >  - compatible: must be "neonode,zforce"
> > >  - reg: I2C address of the chip
> > >  - interrupts: interrupt to which the chip is connected
> > >=20
> > > -- gpios: gpios the chip is connected to
> > > -  first one is the interrupt gpio and second one the reset gpio
> > > +- rst-gpio: reset gpio the chip is connected to
> > >=20
> > >  - x-size: horizontal resolution of touchscreen
> > >  - y-size: vertical resolution of touchscreen
> > >=20
> > >  Optional properties:
> > > +- int-gpio : interrupt gpio the chip is connected to
> > >=20
> > >  - vdd-supply: Regulator controlling the controller supply
> > >=20
> > >  Example:
> > > @@ -23,8 +23,8 @@ Example:
> > >  			interrupts =3D <2 0>;
> > >  			vdd-supply =3D <&reg_zforce_vdd>;
> > >=20
> > > -			gpios =3D <&gpio5 6 0>, /* INT */
> > > -				<&gpio5 9 0>; /* RST */
> > > +			rst-gpio =3D <&gpio5 9 0>; /* RST */
> > > +			int-gpio =3D <&gpio5 6 0>; /* INT, optional */
>=20
> just today in #armlinux I read that it's always supposed to be "x-gpi=
os" even=20
> if it's only one gpio being defined. The gpio core handles both but o=
nly the=20
> variant with "s" at the end is actually specified, see
> Documentation/devicetree/bindings/gpio/gpio.txt
>=20
> Also I think it's common to not use abbreviation in the devicetree. s=
o it=20
> probably should be
> 				reset-gpios =3D
> 				irq-gpios =3D

Agree.

> 			=09
>=20
> > >=20
> > >  			x-size =3D <800>;
> > >  			y-size =3D <600>;
> > >=20
> > > diff --git a/drivers/input/touchscreen/zforce_ts.c
> > > b/drivers/input/touchscreen/zforce_ts.c index edf01c3..bf1e944 10=
0644
> > > --- a/drivers/input/touchscreen/zforce_ts.c
> > > +++ b/drivers/input/touchscreen/zforce_ts.c
> > > @@ -494,6 +494,7 @@ static irqreturn_t zforce_irq_thread(int irq,=
 void
> > > *dev_id)>=20
> > >  	int ret;
> > >  	u8 payload_buffer[FRAME_MAXSIZE];
> > >  	u8 *payload;
> > >=20
> > > +	int run =3D 1;
> > >=20
> > >  	/*
> > >  =09
> > >  	 * When still suspended, return.
> > >=20
> > > @@ -510,7 +511,18 @@ static irqreturn_t zforce_irq_thread(int irq=
, void
> > > *dev_id)>=20
> > >  	if (!ts->suspending && device_may_wakeup(&client->dev))
> > >  =09
> > >  		pm_stay_awake(&client->dev);
> > >=20
> > > -	while (gpiod_get_value_cansleep(ts->gpio_int)) {
> > > +	while (run) {
> > > +		/*
> > > +		 * Exit the loop if either
> > > +		 * - the optional interrupt GPIO isn't specified
> > > +		 *   (there is only one packet read per ISR invocation, then)
> > > +		 * or
> > > +		 * - the GPIO isn't active any more
> > > +		 *   (packet read until the level GPIO indicates that there is
> > > +		 *    no IRQ any more)
> > > +		 */
> > > +		run =3D gpiod_get_value_cansleep(ts->gpio_int);
> > > +
>=20
> alteratively you could simply convert to a
> 	/* Run at least once, or as long as the interrupt gpio is active. */
> 	do {
> 		...
> 	} while(gpiod_get_value_cansleep(ts->gpio_int));
>=20
> saving the additional variable run and a lot of lines, while still ru=
nning at=20
> least once.

But I think that means that we'll try to read even if gpio is not activ=
e
anymore on the first iteration. So maybe we need to factor out the body
and do:

	if (!ts->gpio_int)
		zforce_report_data(...)
	else
		while (gpiod_get_value_cansleep(ts->gpio_int))
			zforce_report_data(...);

Or we could install 2 different interrupt handlers, depending on the
presence of interrupt gpio.

>=20
>=20
> > >=20
> > >  		ret =3D zforce_read_packet(ts, payload_buffer);
> > >  		if (ret < 0) {
> > >  	=09
> > >  			dev_err(&client->dev,
> > >=20
> > > @@ -754,6 +766,40 @@ static int zforce_probe(struct i2c_client *c=
lient,
> > >=20
> > >  	if (!ts)
> > >  =09
> > >  		return -ENOMEM;
> > >=20
> > > +	/*
> > > +	 * The reset GPIO isn't optional, but we might get it
> > > +	 * via the old style DT entries below, too. So it's
> > > +	 * not an error if we don't get it here. Therefore use
> > > +	 * devm_gpiod_get_optional() here.
> > > +	 */
>=20
> hmm, you shouldn't mix styles. I.e. the new binding is using reset- a=
nd irq-
> gpios exclusively. And old devicetrees will use the old binding exclu=
sively.
> So if you don't find the reset-gpio here, you can jump to the legacy =
binding=20
> directly.
>=20
>=20
> > > +	ts->gpio_rst =3D devm_gpiod_get_optional(&client->dev, "rst",
> > > +					       GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(ts->gpio_rst)) {
> > > +		ret =3D PTR_ERR(ts->gpio_rst);
> > > +		dev_err(&client->dev,
> > > +			"failed to request reset GPIO: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ts->gpio_int =3D devm_gpiod_get_optional(&client->dev, "int",=20
> GPIOD_IN);
> > > +	if (IS_ERR(ts->gpio_int)) {
> > > +		ret =3D PTR_ERR(ts->gpio_int);
> > > +		dev_err(&client->dev,
> > > +			"failed to request interrupt GPIO: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* Skip the old style GPIO if we have the new one */
> > > +	if (ts->gpio_rst)
> > > +		goto skip;
>=20
> personally I would prefer to not introduce non-error-handling gotos. =
After you=20
> tried to get the reset gpio you can already decide which paradigm to =
use, so
> could do something like:
>=20
>=20
> 	ts->gpio_rst =3D devm_gpiod_get_optional(&client->dev, "rst",
> 					       GPIOD_OUT_HIGH);
> 	if (IS_ERR(ts->gpio_rst)) {
> 		ret =3D PTR_ERR(ts->gpio_rst);
> 		dev_err(&client->dev,
> 			"failed to request reset GPIO: %d\n", ret);
> 		return ret;
> 	}
>=20
> 	if (ts->gpio_rst) {
> 		ts->gpio_int =3D devm_gpiod_get_optional(&client->dev, "int",
> 										GPIOD_IN);
> 		if (IS_ERR(ts->gpio_int)) {
> 			ret =3D PTR_ERR(ts->gpio_int);
> 			dev_err(&client->dev,
> 				"failed to request interrupt GPIO: %d\n", ret);
> 			return ret;
> 		}
> 	} else {
> 		/* Deprecated gpio handling for legacy binding */
>=20
> 		... old code ...
> 	}
>=20
>=20
> But I guess this is a matter of style and up to what Dmitry prefers.

Yes, I'd prefer this too, although I can see why Dirk used label as it
reduces the size of the patch considerably.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
