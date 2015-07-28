From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCH] Input: zforce - make the interrupt GPIO optional
Date: Tue, 28 Jul 2015 23:43:20 +0200
Message-ID: <2117458.kiOQbe0u2g@diego>
References: <1438072008-11769-1-git-send-email-dirk.behme@de.bosch.com> <20150728210621.GF19610@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57694 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbbG1VnY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 17:43:24 -0400
In-Reply-To: <20150728210621.GF19610@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

Hi,

it's nice to see that my driver seems to be used somewhere :-)


Am Dienstag, 28. Juli 2015, 14:06:21 schrieb Dmitry Torokhov:
> On Tue, Jul 28, 2015 at 10:26:48AM +0200, Dirk Behme wrote:
> > Add support for hardware which uses an I2C Serializer / Deserializer
> > (SerDes) to communicate with the zFroce touch driver. In this case the
> > SerDes will be configured as an interrupt controller and the zForce driver
> > will have no access to poll the GPIO line.
> > To support this, we add two dedicated new GPIOs in the device tree:
> > rst-gpio and int-gpio. With the int-gpio being optional, then.
> > 
> > To not break the existing device trees, the index based 'gpios' entries
> > are still supported, but marked as depreciated.
								^ typo deprecated

> > 
> > With this, if the interrupt GPIO is available, either via the old or new
> > device tree style, the while loop will read and handle the packets as long
> > as the GPIO indicates that the interrupt is asserted (existing, unchanged
> > driver behavior).
> > 
> > If the interrupt GPIO isn't available, i.e. not configured via the new
> > device tree style, we are falling back to one read per ISR invocation
> > (new behavior to support the SerDes).
> > 
> > Note that the gpiod functions help to handle the optional GPIO:
> > devm_gpiod_get_index_optional() will return NULL in case the interrupt
> > GPIO isn't available. And gpiod_get_value_cansleep() does cover this, too,
> > by returning 0 in this case.
> 
> Let's let Heiko take a look as well.
> 
> > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> > ---
> > 
> >  .../bindings/input/touchscreen/zforce_ts.txt       |  8 ++--
> >  drivers/input/touchscreen/zforce_ts.c              | 49
> >  +++++++++++++++++++++- 2 files changed, 52 insertions(+), 5 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt index
> > 80c37df..c6be925 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > 
> > @@ -4,12 +4,12 @@ Required properties:
> >  - compatible: must be "neonode,zforce"
> >  - reg: I2C address of the chip
> >  - interrupts: interrupt to which the chip is connected
> > 
> > -- gpios: gpios the chip is connected to
> > -  first one is the interrupt gpio and second one the reset gpio
> > +- rst-gpio: reset gpio the chip is connected to
> > 
> >  - x-size: horizontal resolution of touchscreen
> >  - y-size: vertical resolution of touchscreen
> > 
> >  Optional properties:
> > +- int-gpio : interrupt gpio the chip is connected to
> > 
> >  - vdd-supply: Regulator controlling the controller supply
> > 
> >  Example:
> > @@ -23,8 +23,8 @@ Example:
> >  			interrupts = <2 0>;
> >  			vdd-supply = <&reg_zforce_vdd>;
> > 
> > -			gpios = <&gpio5 6 0>, /* INT */
> > -				<&gpio5 9 0>; /* RST */
> > +			rst-gpio = <&gpio5 9 0>; /* RST */
> > +			int-gpio = <&gpio5 6 0>; /* INT, optional */

just today in #armlinux I read that it's always supposed to be "x-gpios" even 
if it's only one gpio being defined. The gpio core handles both but only the 
variant with "s" at the end is actually specified, see
Documentation/devicetree/bindings/gpio/gpio.txt

Also I think it's common to not use abbreviation in the devicetree. so it 
probably should be
				reset-gpios =
				irq-gpios =
				

> > 
> >  			x-size = <800>;
> >  			y-size = <600>;
> > 
> > diff --git a/drivers/input/touchscreen/zforce_ts.c
> > b/drivers/input/touchscreen/zforce_ts.c index edf01c3..bf1e944 100644
> > --- a/drivers/input/touchscreen/zforce_ts.c
> > +++ b/drivers/input/touchscreen/zforce_ts.c
> > @@ -494,6 +494,7 @@ static irqreturn_t zforce_irq_thread(int irq, void
> > *dev_id)> 
> >  	int ret;
> >  	u8 payload_buffer[FRAME_MAXSIZE];
> >  	u8 *payload;
> > 
> > +	int run = 1;
> > 
> >  	/*
> >  	
> >  	 * When still suspended, return.
> > 
> > @@ -510,7 +511,18 @@ static irqreturn_t zforce_irq_thread(int irq, void
> > *dev_id)> 
> >  	if (!ts->suspending && device_may_wakeup(&client->dev))
> >  	
> >  		pm_stay_awake(&client->dev);
> > 
> > -	while (gpiod_get_value_cansleep(ts->gpio_int)) {
> > +	while (run) {
> > +		/*
> > +		 * Exit the loop if either
> > +		 * - the optional interrupt GPIO isn't specified
> > +		 *   (there is only one packet read per ISR invocation, then)
> > +		 * or
> > +		 * - the GPIO isn't active any more
> > +		 *   (packet read until the level GPIO indicates that there is
> > +		 *    no IRQ any more)
> > +		 */
> > +		run = gpiod_get_value_cansleep(ts->gpio_int);
> > +

alteratively you could simply convert to a
	/* Run at least once, or as long as the interrupt gpio is active. */
	do {
		...
	} while(gpiod_get_value_cansleep(ts->gpio_int));

saving the additional variable run and a lot of lines, while still running at 
least once.


> > 
> >  		ret = zforce_read_packet(ts, payload_buffer);
> >  		if (ret < 0) {
> >  		
> >  			dev_err(&client->dev,
> > 
> > @@ -754,6 +766,40 @@ static int zforce_probe(struct i2c_client *client,
> > 
> >  	if (!ts)
> >  	
> >  		return -ENOMEM;
> > 
> > +	/*
> > +	 * The reset GPIO isn't optional, but we might get it
> > +	 * via the old style DT entries below, too. So it's
> > +	 * not an error if we don't get it here. Therefore use
> > +	 * devm_gpiod_get_optional() here.
> > +	 */

hmm, you shouldn't mix styles. I.e. the new binding is using reset- and irq-
gpios exclusively. And old devicetrees will use the old binding exclusively.
So if you don't find the reset-gpio here, you can jump to the legacy binding 
directly.


> > +	ts->gpio_rst = devm_gpiod_get_optional(&client->dev, "rst",
> > +					       GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ts->gpio_rst)) {
> > +		ret = PTR_ERR(ts->gpio_rst);
> > +		dev_err(&client->dev,
> > +			"failed to request reset GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ts->gpio_int = devm_gpiod_get_optional(&client->dev, "int", 
GPIOD_IN);
> > +	if (IS_ERR(ts->gpio_int)) {
> > +		ret = PTR_ERR(ts->gpio_int);
> > +		dev_err(&client->dev,
> > +			"failed to request interrupt GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Skip the old style GPIO if we have the new one */
> > +	if (ts->gpio_rst)
> > +		goto skip;

personally I would prefer to not introduce non-error-handling gotos. After you 
tried to get the reset gpio you can already decide which paradigm to use, so
could do something like:


	ts->gpio_rst = devm_gpiod_get_optional(&client->dev, "rst",
					       GPIOD_OUT_HIGH);
	if (IS_ERR(ts->gpio_rst)) {
		ret = PTR_ERR(ts->gpio_rst);
		dev_err(&client->dev,
			"failed to request reset GPIO: %d\n", ret);
		return ret;
	}

	if (ts->gpio_rst) {
		ts->gpio_int = devm_gpiod_get_optional(&client->dev, "int",
										GPIOD_IN);
		if (IS_ERR(ts->gpio_int)) {
			ret = PTR_ERR(ts->gpio_int);
			dev_err(&client->dev,
				"failed to request interrupt GPIO: %d\n", ret);
			return ret;
		}
	} else {
		/* Deprecated gpio handling for legacy binding */

		... old code ...
	}


But I guess this is a matter of style and up to what Dmitry prefers.


> > +
> > +	/*
> > +	 * Depreciated GPIO device tree handling for compatibility
			^ Deprecated


> > +	 * with existing device trees. For new device trees, don't
> > +	 * use it any more. Instead use rst-gpio and the optional
> > +	 * int-gpio above.
> > +	 */
> > +

you can skip the second sentence in the comment. People are supposed to read 
the binding docs and will thus only find the new binding there ;-)


> > 
> >  	/* INT GPIO */
> >  	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, 
GPIOD_IN);
> >  	if (IS_ERR(ts->gpio_int)) {
> > 
> > @@ -773,6 +819,7 @@ static int zforce_probe(struct i2c_client *client,
> > 
> >  		return ret;
> >  	
> >  	}
> > 
> > +skip:
> >  	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
> >  	if (IS_ERR(ts->reg_vdd)) {
> >  	
> >  		ret = PTR_ERR(ts->reg_vdd);


Heiko
