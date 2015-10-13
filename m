From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Tue, 13 Oct 2015 08:54:12 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17385 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbbJMIy3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 04:54:29 -0400
In-Reply-To: <20151013070824.GA22304@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 13 October, 2015 10:08
> To: Tirdea, Irina
> Cc: Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
> 
> On Tue, Oct 13, 2015 at 06:38:23AM +0000, Tirdea, Irina wrote:
> >
> >
> > > -----Original Message-----
> > > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > > Sent: 12 October, 2015 19:48
> > > To: Tirdea, Irina
> > > Cc: Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
> > >
> > > On Mon, Oct 12, 2015 at 06:24:30PM +0300, Irina Tirdea wrote:
> > > > After power on, it is recommended that the driver resets the device.
> > > > The reset procedure timing is described in the datasheet and is used
> > > > at device init (before writing device configuration) and
> > > > for power management. It is a sequence of setting the interrupt
> > > > and reset pins high/low at specific timing intervals. This procedure
> > > > also includes setting the slave address to the one specified in the
> > > > ACPI/device tree.
> > > >
> > > > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > > > driver gt9xx.c for Android (publicly available in Android kernel
> > > > trees for various devices).
> > > >
> > > > For reset the driver needs to control the interrupt and
> > > > reset gpio pins (configured through ACPI/device tree). For devices
> > > > that do not have the gpio pins properly declared, the functionality
> > > > depending on these pins will not be available, but the device can still
> > > > be used with basic functionality.
> > > >
> > > > For both device tree and ACPI, the interrupt gpio pin configuration is
> > > > read from the "irq-gpio" property and the reset pin configuration is
> > > > read from the "reset-gpio" property. For ACPI 5.1, named properties
> > > > can be specified using the _DSD section. This functionality will not be
> > > > available for devices that use indexed gpio pins declared in the _CRS
> > > > section (we need to provide backward compatibility with devices
> > > > that do not support using the interrupt gpio pin as output).
> > > >
> > > > For ACPI, the pins can be specified using ACPI 5.1:
> > > > Device (STAC)
> > > > {
> > > >     Name (_HID, "GDIX1001")
> > > >     ...
> > > >
> > > >     Method (_CRS, 0, Serialized)
> > > >     {
> > > >         Name (RBUF, ResourceTemplate ()
> > > >         {
> > > >             I2cSerialBus (0x0014, ControllerInitiated, 0x00061A80,
> > > >                 AddressingMode7Bit, "\\I2C0",
> > > >                 0x00, ResourceConsumer, ,
> > > >                 )
> > > >
> > > >             GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
> > > >                 "\\I2C0", 0x00, ResourceConsumer, ,
> > > >                  )
> > > >                  {   // Pin list
> > > >                      0
> > > >                  }
> > > >
> > > >             GpioIo (Exclusive, PullDown, 0x0000, 0x0000,
> > > >                 IoRestrictionOutputOnly, "\\I2C0", 0x00,
> > > >                 ResourceConsumer, ,
> > > >                 )
> > > >                 {
> > > >                      1
> > > >                 }
> > > >         })
> > > >         Return (RBUF)
> > > >     }
> > > >
> > > >     Name (_DSD,  Package ()
> > > >     {
> > > >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > >         Package ()
> > > >         {
> > > >             Package (2) {"irq-gpio", Package() {^STAC, 0, 0, 0 }},
> > > >             Package (2) {"reset-gpio", Package() {^STAC, 1, 0, 0 }},
> > > >             ...
> > > >         }
> > > >     }
> > > >
> > > > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > > Acked-by: Bastien Nocera <hadess@hadess.net>
> > > > Tested-by: Bastien Nocera <hadess@hadess.net>
> > > > Tested-by: Aleksei Mamlin <mamlinav@gmail.com>
> > > > ---
> > > >  .../bindings/input/touchscreen/goodix.txt          |   5 +
> > > >  drivers/input/touchscreen/Kconfig                  |   1 +
> > > >  drivers/input/touchscreen/goodix.c                 | 101 +++++++++++++++++++++
> > > >  3 files changed, 107 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > index 8ba98ee..7137881 100644
> > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > @@ -12,6 +12,8 @@ Required properties:
> > > >   - reg			: I2C address of the chip. Should be 0x5d or 0x14
> > > >   - interrupt-parent	: Interrupt controller to which the chip is connected
> > > >   - interrupts		: Interrupt to which the chip is connected
> > > > + - irq-gpio		: GPIO pin used for IRQ
> > > > + - reset-gpio		: GPIO pin used for reset
> > > >
> > > >  Example:
> > > >
> > > > @@ -23,6 +25,9 @@ Example:
> > > >  			reg = <0x5d>;
> > > >  			interrupt-parent = <&gpio>;
> > > >  			interrupts = <0 0>;
> > > > +
> > > > +			irq-gpio = <&gpio1 0 0>;
> > > > +			reset-gpio = <&gpio1 1 0>;
> > > >  		};
> > > >
> > > >  		/* ... */
> > > > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > > > index 771d95c..76f5a9d 100644
> > > > --- a/drivers/input/touchscreen/Kconfig
> > > > +++ b/drivers/input/touchscreen/Kconfig
> > > > @@ -324,6 +324,7 @@ config TOUCHSCREEN_FUJITSU
> > > >  config TOUCHSCREEN_GOODIX
> > > >  	tristate "Goodix I2C touchscreen"
> > > >  	depends on I2C
> > > > +	depends on GPIOLIB
> > > >  	help
> > > >  	  Say Y here if you have the Goodix touchscreen (such as one
> > > >  	  installed in Onda v975w tablets) connected to your
> > > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > > > index 56d0330..87304ac 100644
> > > > --- a/drivers/input/touchscreen/goodix.c
> > > > +++ b/drivers/input/touchscreen/goodix.c
> > > > @@ -16,6 +16,7 @@
> > > >
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/dmi.h>
> > > > +#include <linux/gpio.h>
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/input.h>
> > > >  #include <linux/input/mt.h>
> > > > @@ -37,8 +38,13 @@ struct goodix_ts_data {
> > > >  	unsigned int int_trigger_type;
> > > >  	bool rotated_screen;
> > > >  	int cfg_len;
> > > > +	struct gpio_desc *gpiod_int;
> > > > +	struct gpio_desc *gpiod_rst;
> > > >  };
> > > >
> > > > +#define GOODIX_GPIO_INT_NAME		"irq"
> > > > +#define GOODIX_GPIO_RST_NAME		"reset"
> > > > +
> > > >  #define GOODIX_MAX_HEIGHT		4096
> > > >  #define GOODIX_MAX_WIDTH		4096
> > > >  #define GOODIX_INT_TRIGGER		1
> > > > @@ -237,6 +243,88 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> > > >  	return IRQ_HANDLED;
> > > >  }
> > > >
> > > > +static int goodix_int_sync(struct goodix_ts_data *ts)
> > > > +{
> > > > +	int error;
> > > > +
> > > > +	error = gpiod_direction_output(ts->gpiod_int, 0);
> > > > +	if (error)
> > > > +		return error;
> > > > +	msleep(50);				/* T5: 50ms */
> > > > +
> > > > +	return gpiod_direction_input(ts->gpiod_int);
> > > > +}
> > > > +
> > > > +/**
> > > > + * goodix_reset - Reset device during power on
> > > > + *
> > > > + * @ts: goodix_ts_data pointer
> > > > + */
> > > > +static int goodix_reset(struct goodix_ts_data *ts)
> > > > +{
> > > > +	int error;
> > > > +
> > > > +	/* begin select I2C slave addr */
> > > > +	error = gpiod_direction_output(ts->gpiod_rst, 0);
> > > > +	if (error)
> > > > +		return error;
> > > > +	msleep(20);				/* T2: > 10ms */
> > > > +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> > > > +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> > > > +	if (error)
> > > > +		return error;
> > > > +	usleep_range(100, 2000);		/* T3: > 100us */
> > > > +	error = gpiod_direction_output(ts->gpiod_rst, 1);
> > > > +	if (error)
> > > > +		return error;
> > > > +	usleep_range(6000, 10000);		/* T4: > 5ms */
> > > > +	/* end select I2C slave addr */
> > > > +	error = gpiod_direction_input(ts->gpiod_rst);
> > > > +	if (error)
> > > > +		return error;
> > > > +	return goodix_int_sync(ts);
> > > > +}
> > > > +
> > > > +/**
> > > > + * goodix_get_gpio_config - Get GPIO config from ACPI/DT
> > > > + *
> > > > + * @ts: goodix_ts_data pointer
> > > > + */
> > > > +static int goodix_get_gpio_config(struct goodix_ts_data *ts)
> > > > +{
> > > > +	int error;
> > > > +	struct device *dev;
> > > > +	struct gpio_desc *gpiod;
> > > > +
> > > > +	if (!ts->client)
> > > > +		return -EINVAL;
> > > > +	dev = &ts->client->dev;
> > > > +
> > > > +	/* Get the interrupt GPIO pin number */
> > > > +	gpiod = devm_gpiod_get(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
> > >
> > > Why isn't this devm_gpiod_get_optional()? Then you would not need to
> > > clobber the return value down in goodix_ts_probe().
> > >
> >
> > I did not use devm_gpiod_get_optional() in order to ignore more errors
> > than -ENOENT. This is needed because the ACPI gpio core will fall back
> > to indexed gpios if named gpios are not found. In the common case of
> > having 2 indexed gpio pins declared in the ACPI table, the first
> > devm_gpiod_get() will successfully get indexed gpio pin 0 and the
> > second devm_gpiod_get() will try to get the same gpio pin 0 and return
> > -EBUSY. Considering this, I thought it is better to just ignore all errors in
> > order not to break any platforms currently using this driver.
> 
> This seems like issue with ACPI gpio lookup implementation. If I am
> requesting named gpio and it is not present then I definitely do not
> need to be returned some random gpio. Doing so breaks all other drivers
> that use several names to retrieve GPIOs. We basically can't trust GPIO
> API on ACPI systems.
> 

I'm not sure there is a way to avoid fall back to indexed gpios when requesting
named gpios.
Adding Mika to this thread as he might help answer this.

> I can see why we wanted to provide unnamed gpios even in presence of
> con_id, but it does not work when using several names. I wonder if
> acpi_find_gpio will have to keep track of state (requested names) and
> stop falling back to unnamed gpios if more than one con_id was suppolied
> for the same object.
> 

For devices that need to support more than one named gpio, the driver has
to declare an acpi_gpio_mapping structure (that maps names to indexed gpios)
and register it with acpi_dev_add_driver_gpios [1].

I have actually implemented this in v7 of this patchset [2], before finding
out that the platforms Bastien was testing with do not support writing to the
interrupt pin. In order to avoid adding exceptions to the driver through dmi
quirks, the gpio dependent functionality is available only to devices that
declare named gpios.

Thanks,
Irina

[1] http://lxr.free-electrons.com/source/Documentation/acpi/gpio-properties.txt
[2] https://lkml.org/lkml/2015/10/8/222

> Thanks.
> 
> --
> Dmitry
