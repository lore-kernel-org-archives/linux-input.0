From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from	Arnaud
	Patard.
Date: Thu, 19 Nov 2009 11:34:40 +0000
Message-ID: <4B052D50.2070002@simtec.co.uk>
References: <20091118232939.201290297@fluff.org.uk>	<20091118232948.063635416@fluff.org.uk>
	<20091119025930.GA20172@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091119025930.GA20172@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Ben,
> =

> On Wed, Nov 18, 2009 at 11:29:40PM +0000, Ben Dooks wrote:
>> From: Arnaud Patard <arnaud.patard@rtp-net.org>
>>
>> S3C24XX touchscreen driver, originally written by Arnaud Patard and
>> other contributors. This driver is the version from the Simtec Electroni=
cs
>> tree, and as such is the best place to start and thus proposed to be
>> merged into the linux input system.
>>
> =

> Thank you for the patch. First thing first - do we have an agreement
> from all Samsung folks and other interested parties that _this_ is the
> driver? Because it's like 3rd implementation that came across...

I belive this is the best of the current driver bases, and hopefully
after this round of tidying will definitely be the best.

>> The driver has had substantial testing as well as a number of tidying
>> up passes done by Ben Dooks, as noted:
>>
>> - added kernel-doc comments to most of the routines
>> - removed old code from pre adc framework days
>> - updated device probe code to use platform id list matching
>> - cleaned up debug, since printk() now has timestamp feature
>> - ensure code uses dev_() reporting macros where necessary
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
>> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>>
>> ---
>>  drivers/input/touchscreen/Kconfig      |   18 +
>>  drivers/input/touchscreen/Makefile     |    1 =

>>  drivers/input/touchscreen/s3c2410_ts.c |  464 +++++++++++++++++++++++++=
++++++++
>>  3 files changed, 483 insertions(+)
>>
>>
>> Index: b/drivers/input/touchscreen/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/input/touchscreen/Kconfig	2009-11-09 22:28:23.000000000 +0=
000
>> +++ b/drivers/input/touchscreen/Kconfig	2009-11-10 10:38:44.000000000 +0=
000
>> @@ -133,6 +133,24 @@ config TOUCHSCREEN_FUJITSU
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called fujitsu-ts.
>>  =

>> +config TOUCHSCREEN_S3C2410
>> +	tristate "Samsung S3C2410 touchscreen input driver"
>> +	depends on ARCH_S3C2410 && INPUT && INPUT_TOUCHSCREEN
> =

> INPUT && INPUT_TOUCHSCREEN are superfluous.

ok, removed

>> +	select SERIO

removed

> I don't think you need SERIO
> =

>> +	help
>> +	  Say Y here if you have the s3c2410 touchscreen.
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called s3c2410_ts.
>> +
>> +config TOUCHSCREEN_S3C2410_DEBUG
>> +	boolean "Samsung S3C2410 touchscreen debug messages"
>> +	depends on TOUCHSCREEN_S3C2410
>> +	help
>> +	  Select this if you want debug messages
> =

> Where is this used?

thought it was used to define DEBUG in the driver, will look
at removing this.

>> +
>>  config TOUCHSCREEN_GUNZE
>>  	tristate "Gunze AHL-51S touchscreen"
>>  	select SERIO
>> Index: b/drivers/input/touchscreen/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/input/touchscreen/Makefile	2009-11-09 22:28:23.000000000 +=
0000
>> +++ b/drivers/input/touchscreen/Makefile	2009-11-10 10:38:44.000000000 +=
0000
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+=3D jorn
>>  obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+=3D htcpen.o
>>  obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+=3D usbtouchscreen.o
>>  obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
>> +obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+=3D touchit213.o
>>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+=3D touchright.o
>>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+=3D touchwin.o
>> Index: b/drivers/input/touchscreen/s3c2410_ts.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ b/drivers/input/touchscreen/s3c2410_ts.c	2009-11-10 10:47:38.0000000=
00 +0000
>> @@ -0,0 +1,464 @@
>> +/* drivers/input/touchscreen/s3c2410_ts.c
>> + *
>> + * Samsung S3C24XX touchscreen driver
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the term of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
>> + *
>> + * Copyright 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
>> + * Copyright 2008 Ben Dooks <ben-linux@fluff.org>
>> + * Copyright 2009 Simtec Electronics <linux@simtec.co.uk>
>> + *
>> + * Additional work by Herbert P=F6tzl <herbert@13thfloor.at> and
>> + * Harald Welte <laforge@openmoko.org>
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/gpio.h>
>> +#include <linux/input.h>
>> +#include <linux/init.h>
>> +#include <linux/serio.h>
> =

> No serio in sight.

thanks, removed.

>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +
>> +#include <plat/adc.h>
>> +#include <plat/regs-adc.h>
>> +
>> +#include <mach/regs-gpio.h>
>> +#include <mach/ts.h>
>> +
>> +/* For ts.dev.id.version */
>> +#define S3C2410TSVERSION	0x0101
>> +
>> +#define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_=
PST(0))
>> +
>> +#define INT_DOWN	(0)
>> +#define INT_UP		(1 << 8)
>> +
>> +#define WAIT4INT	(S3C2410_ADCTSC_YM_SEN | \
>> +			 S3C2410_ADCTSC_YP_SEN | \
>> +			 S3C2410_ADCTSC_XP_SEN | \
>> +			 S3C2410_ADCTSC_XY_PST(3))
>> +
>> +#define AUTOPST		(S3C2410_ADCTSC_YM_SEN | \
>> +			 S3C2410_ADCTSC_YP_SEN | \
>> +			 S3C2410_ADCTSC_XP_SEN | \
>> +			 S3C2410_ADCTSC_AUTO_PST | \
>> +			 S3C2410_ADCTSC_XY_PST(0))
>> +
>> +#define DEBUG_LVL    KERN_DEBUG
> =

> Don't seem to be used.

thanks, removed.

>> +
>> +static char *s3c2410ts_name =3D "s3c2410 TouchScreen";
>> +
>> +/* Per-touchscreen data. */
>> +
>> +/**
>> + * struct s3c2410ts - driver touchscreen state.
>> + * @client: The ADC client we registered with the core driver.
>> + * @dev: The device we are bound to.
>> + * @input: The input device we registered with the input subsystem.
>> + * @clock: The clock for the adc.
>> + * @io: Pointer to the IO base.
>> + * @xp: The accumulated X position data.
>> + * @yp: The accumulated Y position data.
>> + * @irq_tc: The interrupt number for pen up/down interrupt
>> + * @count: The number of samples collected.
>> + * @shift: The log2 of the maximum count to read in one go.
>> + */
> =

> These sructures are driver-internal and so don't need to be kernel-doc-ed.
> Same goes for the driver-private functions.

I like having the documentation, and I would much prefer to leave it
in as useful.

>> +struct s3c2410ts {
>> +	struct s3c_adc_client *client;
>> +	struct device *dev;
>> +	struct input_dev *input;
>> +	struct clk *clock;
>> +	void __iomem *io;
>> +	unsigned long xp;
>> +	unsigned long yp;
>> +	int irq_tc;
>> +	int count;
>> +	int shift;
>> +};
>> +
>> +static struct s3c2410ts ts;
>> +
>> +/**
>> + * s3c2410_ts_connect - configure gpio for s3c2410 systems
>> + *
>> + * Configure the GPIO for the S3C2410 system, where we have external FE=
Ts
>> + * connected to the device (later systems such as the S3C2440 integrate
>> + * these into the device).
>> +*/
>> +static inline void s3c2410_ts_connect(void)
>> +{
>> +	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
>> +	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
>> +	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
>> +	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> =

> No gpiolib? Also, should it be in the driver or maybe in the platform
> code?

gpiolib doesn't deal with pin function configuration past input
or output. All these gpios need to be in their special-function
mode.

If people really object, this can be removed and the machine
support files changed.

>> +}
>> +
>> +/**
>> + * get_down - return the down state of the pen
>> + * @data0: The data read from ADCDAT0 register.
>> + * @data1: The data read from ADCDAT1 register.
>> + *
>> + * Return non-zero if both readings show that the pen is down.
>> + */
>> +static inline int get_down(unsigned long data0, unsigned long data1)
> =

> bool?

thanks, fixed.

>> +{
>> +	/* returns true if both data values show stylus down */
>> +	return (!(data0 & S3C2410_ADCDAT0_UPDOWN) &&
>> +		!(data1 & S3C2410_ADCDAT0_UPDOWN));
>> +}
>> +
>> +static void touch_timer_fire(unsigned long data)
>> +{
>> +	unsigned long data0;
>> +	unsigned long data1;
>> +	int down;
> =

> bool?

thanks, fixed.

>> +
>> +	data0 =3D readl(ts.io + S3C2410_ADCDAT0);
>> +	data1 =3D readl(ts.io + S3C2410_ADCDAT1);
>> +
>> +	down =3D get_down(data0, data1);
>> +
>> +	if (ts.count =3D=3D (1<<ts.shift)) {
> =

> Syyle: x << y

thanks, fixed.

>> +		ts.xp >>=3D ts.shift;
>> +		ts.yp >>=3D ts.shift;
>> +
>> +		dev_dbg(ts.dev, "%s: X=3D%lu, Y=3D%lu, count=3D%d\n",
>> +			__func__, ts.xp, ts.yp, ts.count);
>> +
>> +		input_report_abs(ts.input, ABS_X, ts.xp);
>> +		input_report_abs(ts.input, ABS_Y, ts.yp);
>> +
>> +		input_report_key(ts.input, BTN_TOUCH, 1);
>> +		input_report_abs(ts.input, ABS_PRESSURE, 1);
> =

> No fake pressure events please, BTN_TOUCH should be enough.

I'd have to check, IIRC tslib needs these to function properly.

>> +		input_sync(ts.input);
>> +
>> +		ts.xp =3D 0;
>> +		ts.yp =3D 0;
>> +		ts.count =3D 0;
>> +	}
>> +
>> +	if (down) {
>> +		s3c_adc_start(ts.client, 0, 1 << ts.shift);
>> +	} else {
>> +		ts.count =3D 0;
>> +
>> +		input_report_key(ts.input, BTN_TOUCH, 0);
>> +		input_report_abs(ts.input, ABS_PRESSURE, 0);
>> +		input_sync(ts.input);
>> +
>> +		writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
>> +	}
>> +}
>> +
>> +static struct timer_list touch_timer =3D TIMER_INITIALIZER(touch_timer_=
fire, 0, 0);
> =

> static DEFINE_TIMER(...);

ok, thanks.

>> +
>> +/**
>> + * stylus_irq - touchscreen stylus event interrupt
>> + * @irq: The interrupt number
>> + * @dev_id: The device ID.
>> + *
>> + * Called when the IRQ_TC is fired for a pen up or down event.
>> + */
>> +static irqreturn_t stylus_irq(int irq, void *dev_id)
>> +{
>> +	unsigned long data0;
>> +	unsigned long data1;
>> +	int down;
>> +
>> +	data0 =3D readl(ts.io + S3C2410_ADCDAT0);
>> +	data1 =3D readl(ts.io + S3C2410_ADCDAT1);
>> +
>> +	down =3D get_down(data0, data1);
>> +
>> +	/* TODO we should never get an interrupt with down set while
>> +	 * the timer is running, but maybe we ought to verify that the
>> +	 * timer isn't running anyways. */
>> +
>> +	if (down)
>> +		s3c_adc_start(ts.client, 0, 1 << ts.shift);
>> +	else
>> +		dev_info(ts.dev, "%s: count=3D%d\n", __func__, ts.count);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * s3c24xx_ts_conversion - ADC conversion callback
>> + * @client: The client that was registered with the ADC core.
>> + * @data0: The reading from ADCDAT0.
>> + * @data1: The reading from ADCDAT1.
>> + * @left: The number of samples left.
>> + *
>> + * Called when a conversion has finished.
>> + */
>> +static void s3c24xx_ts_conversion(struct s3c_adc_client *client,
>> +				  unsigned data0, unsigned data1,
>> +				  unsigned *left)
>> +{
>> +	dev_dbg(ts.dev, "%s: %d,%d\n", __func__, data0, data1);
>> +
>> +	ts.xp +=3D data0;
>> +	ts.yp +=3D data1;
>> +
>> +	ts.count++;
>> +
>> +	/* From tests, it seems that it is unlikely to get a pen-up
>> +	 * event during the conversion process which means we can
>> +	 * ignore any pen-up events with less than the requisite
>> +	 * count done.
>> +	 *
>> +	 * In several thousand conversions, no pen-ups where detected
>> +	 * before count completed.
>> +	 */
>> +}
>> +
>> +/**
>> + * s3c24xx_ts_select - ADC selection callback.
>> + * @client: The client that was registered with the ADC core.
>> + * @select: The reason for select.
>> + *
>> + * Called when the ADC core selects (or deslects) us as a client.
>> + */
>> +static void s3c24xx_ts_select(struct s3c_adc_client *client, unsigned s=
elect)
>> +{
>> +	if (select) {
>> +		writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST,
>> +		       ts.io + S3C2410_ADCTSC);
>> +	} else {
>> +		mod_timer(&touch_timer, jiffies+1);
>> +		writel(WAIT4INT | INT_UP, ts.io + S3C2410_ADCTSC);
>> +	}
>> +}
>> +
>> +/**
>> + * s3c2410ts_probe - device core probe entry point
>> + * @pdev: The device we are being bound to.
>> + *
>> + * Initialise, find and allocate any resources we need to run and then
>> + * register with the ADC and input systems.
>> + */
>> +static int __init s3c2410ts_probe(struct platform_device *pdev)
> =

> __devinit or switch to platform_driver_probe().

thanks, fixed.

>> +{
>> +	struct s3c2410_ts_mach_info *info;
>> +	struct device *dev =3D &pdev->dev;
>> +	struct input_dev *input_dev;
>> +	struct resource *res;
>> +	int ret =3D -EINVAL;
> =

> Can we call it "error" (since that's what you use it for).

Is it really necessary to change this?

>> +
>> +	/* Initialise input stuff */
>> +	memset(&ts, 0, sizeof(struct s3c2410ts));
>> +
>> +	ts.dev =3D dev;
>> +
>> +	info =3D pdev->dev.platform_data;
>> +	if (!info) {
>> +		dev_err(dev, "no platform data, cannot attach\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "initialising touchscreen\n");
>> +
>> +	ts.clock =3D clk_get(dev, "adc");
>> +	if (IS_ERR(ts.clock)) {
>> +		dev_err(dev, "cannot get adc clock source\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	clk_enable(ts.clock);
>> +	dev_dbg(dev, "got and enabled clocks\n");
>> +
>> +	ts.irq_tc =3D ret =3D platform_get_irq(pdev, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "no resource for interrupt\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "no resource for registers\n");
>> +		ret =3D -ENOENT;
>> +		goto err_clk;
>> +	}
>> +
> =

> request_mem_region() here?

I'll check if it possible for both the adc and this driver
to claim this region.

>> +	ts.io =3D ioremap(res->start, resource_size(res));
>> +	if (ts.io =3D=3D NULL) {
>> +		dev_err(dev, "cannot map registers\n");
>> +		ret =3D -ENOMEM;
>> +		goto err_clk;
>> +	}
>> +
>> +	/* Configure the touchscreen external FETs on the S3C2410 */
>> +	if (!platform_get_device_id(pdev)->driver_data)
>> +		s3c2410_ts_connect();
>> +
>> +	ts.client =3D s3c_adc_register(pdev, s3c24xx_ts_select,
>> +				     s3c24xx_ts_conversion, 1);
>> +	if (IS_ERR(ts.client)) {
>> +		dev_err(dev, "failed to register adc client\n");
>> +		ret =3D PTR_ERR(ts.client);
>> +		goto err_iomap;
>> +	}
>> +
>> +	/* Initialise registers */
>> +	if ((info->delay & 0xffff) > 0)
>> +		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
>> +
>> +	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
>> +
>> +	input_dev =3D input_allocate_device();
>> +	if (!input_dev) {
>> +		dev_err(dev, "Unable to allocate the input device !!\n");
>> +		ret =3D -ENOMEM;
>> +		goto err_iomap;
>> +	}
>> +
>> +	ts.input =3D input_dev;
>> +	ts.input->evbit[0] =3D BIT_MASK(EV_SYN) | BIT_MASK(EV_KEY) | BIT_MASK(=
EV_ABS);
> =

> No need setting EV_SYN explicitely.

ok, fixed.

>> +	ts.input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
>> +	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
>> +	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
>> +	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
> =

> Drop ABS_PRESSURE.

ok, see above.

>> +
>> +	ts.input->name =3D s3c2410ts_name;
>> +	ts.input->id.bustype =3D BUS_HOST;
>> +	ts.input->id.vendor =3D 0xDEAD;
>> +	ts.input->id.product =3D 0xBEEF;
>> +	ts.input->id.version =3D S3C2410TSVERSION;
>> +
>> +	ts.shift =3D info->oversampling_shift;
>> +
>> +	if (request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
>> +			"s3c2410_ts_pen", ts.input)) {
>> +		dev_err(dev, "cannot get TC interrupt\n");
>> +		ret =3D -EIO;
> =

> Don't mangle what request_irq returned.

ok, fixed.


>> +		goto err_inputdev;
>> +	}
>> +
>> +	dev_info(dev, "driver attached, registering input device\n");
>> +
>> +	/* All went ok, so register to the input system */
>> +	ret =3D input_register_device(ts.input);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to register input device\n");
>> +		ret =3D -EIO;
>> +		goto err_tcirq;
>> +	}
>> +
>> +	return 0;
>> +
>> + err_tcirq:
>> +	free_irq(ts.irq_tc, ts.input);
> =

> del_timer_sync().

added.

>> + err_inputdev:
>> +	input_unregister_device(ts.input);
>> + err_iomap:
>> +	iounmap(ts.io);
>> + err_clk:
>> +	clk_put(ts.clock);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * s3c2410ts_remove - device core removal entry point
>> + * @pdev: The device we are being removed from.
>> + *
>> + * Free up our state ready to be removed.
>> + */
>> +static int s3c2410ts_remove(struct platform_device *pdev)
>> +{
>> +	free_irq(ts.irq_tc, ts.input);
> =

> del_timer_sync().

added, thanks.

>> +
>> +	clk_disable(ts.clock);
>> +	clk_put(ts.clock);
>> +
>> +	input_unregister_device(ts.input);
>> +	iounmap(ts.io);
> =

> release_mem_region()

see above.

>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int s3c2410ts_suspend(struct platform_device *pdev, pm_message_t=
 state)
>> +{
>> +	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
>> +	disable_irq(ts.irq_tc);
>> +	clk_disable(ts.clock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int s3c2410ts_resume(struct platform_device *pdev)
>> +{
>> +	struct s3c2410_ts_mach_info *info =3D pdev->dev.platform_data;
>> +
>> +	clk_enable(ts.clock);
>> +
>> +	/* Initialise registers */
>> +	if ((info->delay & 0xffff) > 0)
>> +		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
>> +
>> +	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
>> +
>> +	return 0;
>> +}
>> +
>> +#else
>> +#define s3c2410ts_suspend NULL
>> +#define s3c2410ts_resume  NULL
>> +#endif
>> +
>> +static struct platform_device_id s3cts_driver_ids[] =3D {
>> +	{ "s3c2410-ts", 0 },
>> +	{ "s3c2440-ts", 1 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
>> +
>> +static struct platform_driver s3c_ts_driver =3D {
>> +	.driver         =3D {
>> +		.name   =3D "s3c24xx-ts",
>> +		.owner  =3D THIS_MODULE,
>> +	},
>> +	.id_table	=3D s3cts_driver_ids,
>> +	.probe		=3D s3c2410ts_probe,
>> +	.remove		=3D s3c2410ts_remove,
> =

> __devexit_p()
> =

>> +	.suspend	=3D s3c2410ts_suspend,
>> +	.resume		=3D s3c2410ts_resume,
> =

> Switch to pm_ops.

ok, will do. may as well remove the #ifdef CONFIG_PM
for such small amount of code too.

>> +};
>> +
>> +static int __init s3c2410ts_init(void)
>> +{
>> +	return platform_driver_register(&s3c_ts_driver);
>> +}
>> +
>> +static void __exit s3c2410ts_exit(void)
>> +{
>> +	platform_driver_unregister(&s3c_ts_driver);
>> +}
>> +
>> +module_init(s3c2410ts_init);
>> +module_exit(s3c2410ts_exit);
>> +
>> +MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, "
>> +	      "Ben Dooks <ben@simtec.co.uk>, "
>> +	      "Simtec Electronics <linux@simtec.co.uk>");
>> +MODULE_DESCRIPTION("S3C24XX Touchscreen driver");
>> +MODULE_LICENSE("GPL v2");
>>
> =

> Thanks!

I'll try and work on the to-do items and do another round
of testing before the weekend.
