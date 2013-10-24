From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv5][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 09:46:16 +0200
Message-ID: <20131024074615.GC9403@ulmo.nvidia.com>
References: <1382530220-27881-1-git-send-email-denis@eukrea.com>
 <52684B33.6040109@gmail.com>
 <20131024085150.11a81974@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:44404 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3JXHqV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 03:46:21 -0400
Content-Disposition: inline
In-Reply-To: <20131024085150.11a81974@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Rob Herring <robherring2@gmail.com>, Denis Carikli <denis@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-input@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 08:51:50AM +0200, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Rob Herring wrote:
> > On 10/23/2013 07:10 AM, Denis Carikli wrote:
> [...]
> > > diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > new file mode 100644
> > > index 0000000..fadd3f6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > @@ -0,0 +1,44 @@
> > > +* Texas Instruments tsc2007 touchscreen controller
> > > +
> > > +Required properties:
> > > +- compatible: must be "ti,tsc2007".
> > > +- reg: I2C address of the chip.
> > > +- pinctrl-0: Should specify pin control groups used for this control=
ler
> > > +  (see pinctrl bindings[0]).
> > > +- pinctrl-names: Should contain only one value - "default"
> > > +  (see pinctrl bindings[0]).
> >=20
> > I'm confused why an i2c slave needs pinctl binding?
> >=20
> for the pendetect GPIO.

Shouldn't that be done transparently to users of the GPIO API? I was
under the impression that gpio_request() would set everything up (or
return an error if unable to do so) so that the GPIO can be used,
including any required pinmuxing.

> [...]
> > > diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touc=
hscreen/tsc2007.c
> > > index 0b67ba4..0625fe1 100644
> > > --- a/drivers/input/touchscreen/tsc2007.c
> > > +++ b/drivers/input/touchscreen/tsc2007.c
> > > @@ -26,6 +26,9 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/i2c/tsc2007.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_gpio.h>
> > > =20
> > >  #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
> > >  #define TSC2007_MEASURE_AUX		(0x2 << 4)
> > > @@ -74,7 +77,10 @@ struct tsc2007 {
> > >  	u16			max_rt;
> > >  	unsigned long		poll_delay;
> > >  	unsigned long		poll_period;
> > > +	int			fuzzy;
> > > +	char			of;
> > > =20
> > > +	unsigned		gpio;
> > >  	int			irq;
> > > =20
> > >  	wait_queue_head_t	wait;
> [...]
> > > @@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *inp=
ut_dev)
> > >  	tsc2007_stop(ts);
> > >  }
> > > =20
> > > -static int tsc2007_probe(struct i2c_client *client,
> > > -				   const struct i2c_device_id *id)
> > > +#ifdef CONFIG_OF
> > > +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc200=
7 *ts,
> > > +			    struct device_node *np)
> > >  {
> > > -	struct tsc2007 *ts;
> > > -	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
> > > -	struct input_dev *input_dev;
> > > -	int err;
> > > -
> > > -	if (!pdata) {
> > > -		dev_err(&client->dev, "platform data is required!\n");
> > > +	int err =3D 0;
> > > +	u32 val32;
> > > +	u64 val64;
> > > +
> > > +	if (!of_property_read_u32(np, "max-rt", &val32))
> > > +		ts->max_rt =3D val32;
> > > +	else
> > > +		ts->max_rt =3D MAX_12BIT;
> >=20
> > These functions don't overwrite the value if the property isn't present.
> > So you can set the values to the defaults and just pass the variable
> > (i.e. ts->max_rt) to of_property_read_u32 directly.
> >=20
> Not quite. Since max_rt is an u16 you can't pass it to
> of_property_read_u32(). And using of_property_read_u16() requires the
> abominable DT notation: "/bits/ 16 <value>;"

In that case perhaps you need to check that whatever u32 value you read
=66rom DT is actually in the expected range before assigning to u16?

Thierry

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaNBHAAoJEN0jrNd/PrOhytkP/2lInXs5z+1aybOuSYoysWHc
V3/6/inO4EtsI63GSDL8r6kXvn+hRVqhXeRL7ED0NxTg5M3A2QMy6uFwn4HSxDOV
1WoKnw/AJN/+lboD6pwvHrBt/fLXgz8ZoeGzkl1DR5y1cSZhU9cQbGnbLPyVTHKv
ur0OjdEwCA2ZYvCqAOqUN+v2zT0eqmwFCobl7+S/kRcRXl5F0YfYSjgDjOZX0Dob
Puq8CphF9eReRTi3w2KLPjcUTEan97drieWvaLIvNXqYvvu+zVZnN1c2lEMrEyBI
2U6QGHt3wx5NWW5aNyEDDnYl/TBFf+6omkdE5TTVQgvTly+lDKsDUfBAQNS2Zw4D
B5y9/Pa6mIkBjw+gw47E3lCXfqXNDw0tFE858Vt2RXXNX6w9gamIq9D87x6tS3vU
UcxSOL1cqB4jLIqe9Kig7/8F6J6BMuo1s3oUHProdB3Z897aFzZdEDzHdDEDXO/y
vncHczfVQNLOGIjx7OnqDXSUzgLUSFD6Exh4Z/EqdIT40HMrOdVfdvZ9ViHBx3+d
SmH0G3ESdcU2yCpZt7InP3kkPgJKv/t66aGU8trE932VTXjMN4AS+AyN7T7Q5qOR
KXXM/TXL35ew1g7dOa48pPHCRWdf4rE5RRtbHRqxK7p7j0ClzrEosCGULJ3N6jZ6
HwOVUZYWMtWraxfkMYOk
=zlNm
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
