From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add TSC2003 touchscreen controller driver
Date: Tue, 28 Apr 2009 06:21:39 -0700
Message-ID: <200904280621.39529.dmitry.torokhov@gmail.com>
References: <1240328303-24115-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:11706 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbZD1NVq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2009 09:21:46 -0400
Received: by rv-out-0506.google.com with SMTP id f9so411184rvb.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2009 06:21:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1240328303-24115-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org

Hi Anatolij,

On Tue, Apr 21, 2009 at 05:38:23PM +0200, Anatolij Gustschin wrote:
> Supports TSC2003 on socrates board.
> 

Nice looking driver, just a few questions...

> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/input/touchscreen/Kconfig   |    5 +
>  drivers/input/touchscreen/Makefile  |    1 +
>  drivers/input/touchscreen/tsc2003.c |  442 +++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/tsc2003.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index b01fd61..defba17 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -366,6 +366,11 @@ config TOUCHSCREEN_WM97XX_ZYLONITE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zylonite-wm97xx.
>  
> +config TOUCHSCREEN_TSC2003
> +	tristate "TSC2003 touchscreen"

No dependencies whatsoever? I2C at least?

> +	help
> +	  Say Y here to support TSC2003 touchscreen controller.

Any more usage notes/comments?

> +

Can it be compiled as a module? What is module name?

>  config TOUCHSCREEN_USB_COMPOSITE
>  	tristate "USB Touchscreen Driver"
>  	depends on USB_ARCH_HAS_HCD
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 6700f7b..e965422 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
> +obj-$(CONFIG_TOUCHSCREEN_TSC2003)	+= tsc2003.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
>  obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
> diff --git a/drivers/input/touchscreen/tsc2003.c b/drivers/input/touchscreen/tsc2003.c
> new file mode 100644
> index 0000000..ff6f003
> --- /dev/null
> +++ b/drivers/input/touchscreen/tsc2003.c
> @@ -0,0 +1,442 @@
> +/*
> + * drivers/input/touchscreen/tsc2003.c
> + *
> + * Copyright (C) 2008 Anatolij Gustschin <agust@denx.de>
> + * DENX Software Engineering
> + *
> + * Parts of the code are taken from old tsc2003 driver
> + * Copyright (C) 2005 Bill Gatliff <bgat at billgatliff.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/workqueue.h>
> +
> +#if defined(CONFIG_SOCRATES)
> +#include <linux/of_platform.h>
> +#endif
> +
> +#define DRV_NAME	"tsc2003"
> +
> +enum tsc2003_pd {
> +	PD_POWERDOWN = 0,	/* penirq */
> +	PD_IREFOFF_ADCON = 1,	/* no penirq */
> +	PD_IREFON_ADCOFF = 2,	/* penirq */
> +	PD_IREFON_ADCON = 3,	/* no penirq */

Any change you could elaborate on these definitions so other people
could have a better idea? Also, do we need a type of just regular
defines will work as well?

> +	PD_PENIRQ_ARM = PD_IREFON_ADCOFF,
> +	PD_PENIRQ_DISARM = PD_IREFON_ADCON,
> +};
> +
> +enum tsc2003_m {
> +	M_12BIT = 0,
> +	M_8BIT = 1
> +};
> +
> +enum tsc2003_cmd {
> +	MEASURE_TEMP0 = 0,
> +	MEASURE_VBAT1 = 1,
> +	MEASURE_IN1 = 2,
> +	MEASURE_TEMP1 = 4,
> +	MEASURE_VBAT2 = 5,
> +	MEASURE_IN2 = 6,
> +	ACTIVATE_NX_DRIVERS = 8,
> +	ACTIVATE_NY_DRIVERS = 9,
> +	ACTIVATE_YNX_DRIVERS = 10,
> +	MEASURE_XPOS = 12,
> +	MEASURE_YPOS = 13,
> +	MEASURE_Z1POS = 14,
> +	MEASURE_Z2POS = 15
> +};
> +
> +#define TSC2003_CMD(cn, pdn, m)	(((cn) << 4) | ((pdn) << 2) | ((m) << 1))
> +
> +#define ADC_MAX	((1 << 12) - 1)
> +
> +struct tsc2003 {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct device *dev;
> +	struct workqueue_struct *ts_workq;
> +	struct delayed_work ts_reader;
> +	struct mutex mutex;

Usage?

> +	int (*pen_is_down)(void *);
> +	void __iomem *map_mem;
> +	void __iomem *erqsr;
> +	int pen_irq;
> +	int pen_irq_on;
> +	int pen_down;
> +	int poll_interval;
> +	int r_x_plate;
> +	enum tsc2003_pd pd;

This field does not seem to be actually used...

> +	enum tsc2003_m m;

Maybe use a bool instead of enum here?

> +};
> +
> +static int tsc2003_read(struct tsc2003 *d,
> +			enum tsc2003_cmd cmd,
> +			enum tsc2003_pd pd, int *val)
> +{
> +	unsigned char c;
> +	unsigned char buf[2];
> +	int ret;
> +
> +	c = TSC2003_CMD(cmd, pd, d->m);
> +	dev_dbg(d->dev, "%s-bit cmd 0x%x | ",
> +		d->m == M_12BIT ? "12" : "8", c);
> +
> +	ret = i2c_master_send(d->client, &c, 1);
> +	if (ret <= 0)
> +		goto err;
> +
> +	udelay(20);
> +
> +	ret = i2c_master_recv(d->client, buf, d->m == M_12BIT ? 2 : 1);
> +	if (ret <= 0)
> +		goto err;
> +
> +	if (val) {
> +		*val = buf[0];
> +		if (d->m == M_12BIT) {
> +			*val <<= 4;
> +			*val += (buf[1] >> 4);
> +			pr_debug("val = %d\n", *val);
> +		} else
> +			pr_debug("val = %d\n", (int)buf[0]);
> +	} else
> +		pr_debug("buf = %d\n", (int)buf[0]);
> +
> +	return 0;
> +err:
> +	dev_err(d->dev, "i2c transfer error %d\n", ret);
> +	if (!ret)
> +		ret = -EIO;
> +	return ret;
> +}
> +
> +static inline int tsc2003_get_xpos(struct tsc2003 *d,
> +				   enum tsc2003_pd pd, int *x)
> +{
> +	d->m = M_12BIT;
> +	return tsc2003_read(d, MEASURE_XPOS, pd, x);
> +}
> +
> +static inline int tsc2003_get_ypos(struct tsc2003 *d,
> +				   enum tsc2003_pd pd, int *y)
> +{
> +	d->m = M_12BIT;
> +	return tsc2003_read(d, MEASURE_YPOS, pd, y);
> +}
> +
> +static inline int tsc2003_get_z1(struct tsc2003 *d,
> +				 enum tsc2003_pd pd, int *z)
> +{
> +	d->m = M_8BIT;
> +	return tsc2003_read(d, MEASURE_Z1POS, pd, z);
> +}
> +
> +static inline int tsc2003_get_z2(struct tsc2003 *d,
> +				 enum tsc2003_pd pd, int *z)
> +{
> +	d->m = M_8BIT;
> +	return tsc2003_read(d, MEASURE_Z2POS, pd, z);
> +}
> +
> +static inline int tsc2003_get_vbat1(struct tsc2003 *d,
> +				    enum tsc2003_pd pd, int *t)
> +{
> +	return tsc2003_read(d, MEASURE_VBAT1, pd, t);
> +}
> +
> +static inline int tsc2003_powerdown(struct tsc2003 *d)
> +{
> +	return tsc2003_read(d, MEASURE_IN1, PD_POWERDOWN, 0);
> +}
> +
> +#if defined(CONFIG_SOCRATES)
> +/* board specific routines for pending pen irq check */
> +#define ERQSR_EINT8_MASK	0x00800000
> +#define FRR_OFFSET		0x00001000
> +#define FRR_ERQSR_OFFSET	0x00000308
> +static int socrates_pen_is_down(void *data)
> +{
> +	struct tsc2003 *d = data;
> +
> +	return !(in_be32(d->erqsr) & ERQSR_EINT8_MASK);
> +}
> +
> +static int socrates_setup_pen_irq(struct tsc2003 *d)
> +{
> +	struct device_node *np;
> +	struct resource r;
> +
> +	np = of_find_node_by_type(NULL, "open-pic");
> +	if (!np) {
> +		dev_err(d->dev, "Can't get open-pic node\n");
> +		goto err;
> +	}
> +	if (of_address_to_resource(np, 0, &r)) {
> +		dev_err(d->dev, "Can't get mpic base\n");
> +		of_node_put(np);
> +		goto err;
> +	}
> +	of_node_put(np);
> +
> +	/*
> +	 * Remap page with Ext. IRQ Summary Register ERQSR.
> +	 * Page aligned, so remap one page from FRR base.
> +	 */
> +	d->map_mem = ioremap(r.start + FRR_OFFSET, 0x1000);
> +	if (d->map_mem == NULL) {
> +		dev_err(d->dev,
> +			"Can't remap mpic reg. block\n");
> +		goto err;
> +	}
> +	d->pen_is_down = socrates_pen_is_down;
> +	d->erqsr = d->map_mem + FRR_ERQSR_OFFSET;
> +	return 0;
> +err:
> +	d->pen_irq = 0;
> +	return -EINVAL;
> +}

There is no way to hide the above in platform code, is there?

> +#endif
> +
> +irqreturn_t tsc2003_pen_irq(int irq, void *dev_id)
> +{
> +	struct tsc2003 *d = dev_id;
> +
> +	dev_dbg(d->dev, "tsc2003 irq, %lu\n", jiffies);
> +
> +	disable_irq_nosync(d->pen_irq);
> +	d->pen_irq_on = 0;
> +
> +	queue_delayed_work(d->ts_workq, &d->ts_reader, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void tsc2003_ts_sample(struct work_struct *work)
> +{
> +	struct tsc2003 *d = container_of(work, struct tsc2003, ts_reader.work);
> +	unsigned int x = 0, y, z1 = 0, z2 = 0, p = 0;
> +
> +	/* Sample only if irq is pending or if polling */
> +	if ((d->pen_is_down && d->pen_is_down(d)) ||
> +	    !d->pen_irq) {
> +		dev_dbg(d->dev, "sample, %lu\n", jiffies);
> +		tsc2003_get_xpos(d, PD_PENIRQ_DISARM, &x);
> +		tsc2003_get_ypos(d, PD_PENIRQ_DISARM, &y);
> +		tsc2003_get_z1(d, PD_PENIRQ_DISARM, &z1);
> +		tsc2003_get_z2(d, PD_PENIRQ_DISARM, &z2);
> +
> +		if (x && (z1 > 5) && (z2 < 250)) {
> +			p = z2;
> +			p -= z1;
> +			p *= x;
> +			p *= d->r_x_plate;
> +			p /= z1;
> +			p = p >> 8;
> +		}
> +	}
> +	if (p) {
> +		dev_dbg(d->dev, "DOWN\n");
> +		dev_dbg(d->dev, "x %d, y %d, z1 %d, z2 %d, p %d\n",
> +			x, y, z1, z2, p);
> +		if (!d->pen_down) {
> +			input_report_key(d->input, BTN_TOUCH, 1);
> +			d->pen_down = 1;
> +			d->poll_interval = HZ / 2;
> +		}
> +		input_report_abs(d->input, ABS_X, x);
> +		input_report_abs(d->input, ABS_Y, y);
> +		input_report_abs(d->input, ABS_PRESSURE, p);
> +		input_sync(d->input);
> +	} else {
> +		dev_dbg(d->dev, "UP\n");
> +		if (d->pen_down) {
> +			d->pen_down = 0;
> +			input_report_key(d->input, BTN_TOUCH, 0);
> +			input_report_abs(d->input, ABS_PRESSURE, 0);
> +			input_sync(d->input);
> +		}
> +		if (d->pen_irq && !d->pen_irq_on) {
> +			tsc2003_get_vbat1(d, PD_PENIRQ_ARM, 0);

What does PD_PENIRQARM_DO? Do you need to issue it when you open the
device?

> +			d->pen_irq_on = 1;
> +			enable_irq(d->pen_irq);

Should you enable IRQ before issuing PD_PENIRQ_ARM by any chance?

> +		}
> +		if (!d->pen_irq && d->poll_interval < HZ / 2)
> +			d->poll_interval += 5;
> +	}
> +	if (d->pen_down || !d->pen_irq) {
> +		dev_dbg(d->dev, "queued\n");
> +		queue_delayed_work(d->ts_workq, &d->ts_reader,
> +				   d->pen_down ? 2 : d->poll_interval);
> +	}
> +}
> +
> +static int tsc2003_input_open(struct input_dev *dev)
> +{
> +	struct tsc2003 *d = input_get_drvdata(dev);
> +
> +	d->ts_workq = create_singlethread_workqueue(DRV_NAME);
> +	if (d->ts_workq == NULL) {
> +		dev_err(d->dev, "Failed to create workqueue\n");
> +		return -EINVAL;
> +	}

Do we really need a separate work queue? You don't seem to request any
elevated priority or scheduling mode for it and unless reading from the
device takes long time keventd should suffice...

> +
> +	INIT_DELAYED_WORK(&d->ts_reader, tsc2003_ts_sample);
> +
> +	if (request_irq(d->pen_irq, tsc2003_pen_irq,
> +			IRQF_SAMPLE_RANDOM, DRV_NAME, d)) {
> +		dev_err(d->dev, "Can't register pen irq\n");
> +		d->pen_irq = 0;

I would not do that here... It does not look like you can disable the
device and keep it in low-power mode until somebody starts using it.
What happens if nobody opens the device for a while and somebody
touches it so it starts generating interrupts? I think you should
request IRQ right in tsc2003_probe and just make sure you don't keep
polling unless the device is opened.

> +	}
> +	if (!d->pen_irq) {
> +		dev_info(d->dev, "polling\n");
> +		d->poll_interval = HZ / 10;
> +		queue_delayed_work(d->ts_workq, &d->ts_reader,
> +				   d->poll_interval);
> +	}
> +	return 0;
> +}
> +
> +static void tsc2003_input_close(struct input_dev *dev)
> +{
> +	struct tsc2003 *d = input_get_drvdata(dev);
> +
> +	free_irq(d->pen_irq, d);
> +	d->pen_down = 0;
> +	d->pen_irq_on = 0;
> +	cancel_delayed_work_sync(&d->ts_reader);
> +	destroy_workqueue(d->ts_workq);
> +	return;

No for empty returns.

> +}
> +
> +static int __devinit tsc2003_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct input_dev *idev;
> +	struct tsc2003 *d;
> +	int err;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> +		dev_err(&adapter->dev, "doesn't support full I2C\n");
> +		err = -EIO;
> +		goto exit;
> +	}
> +
> +	d = kzalloc(sizeof(struct tsc2003), GFP_KERNEL);
> +	idev = input_allocate_device();
> +	if (!d || !idev) {
> +		err = -ENOMEM;
> +		goto free_mem;
> +	}
> +
> +	d->client = client;
> +	d->dev = &client->dev;
> +	d->input = idev;
> +	d->pen_irq = client->irq;
> +	d->pd = PD_PENIRQ_DISARM;
> +	d->m = M_8BIT;
> +	d->r_x_plate = 747;
> +	i2c_set_clientdata(client, d);
> +
> +	/* try a command, get an ack */
> +	err = tsc2003_powerdown(d);
> +	if (err < 0) {
> +		dev_err(d->dev, "Can't read device 0x%x\n",
> +			client->addr);
> +		goto free_mem;
> +	}
> +
> +	idev->name = "TSC2003 TouchScreen";
> +	idev->phys = DRV_NAME;

Why don't we do something like:

	snprintf(d->phys, sizeof(d->phys), "%s/input0", dev_name(&d->dev));
	idev->phys = d->phys;

instead? Also, let's set bus type for the input device to BUS_I2C.

> +	idev->dev.parent = &client->dev;
> +	idev->open = tsc2003_input_open;
> +	idev->close = tsc2003_input_close;
> +	input_set_drvdata(idev, d);
> +
> +	set_bit(EV_ABS, idev->evbit);
> +	set_bit(EV_KEY, idev->evbit);
> +	set_bit(BTN_TOUCH, idev->keybit);
> +	input_set_abs_params(idev, ABS_X, 0, ADC_MAX, 0, 0);
> +	input_set_abs_params(idev, ABS_Y, 0, ADC_MAX, 0, 0);
> +	input_set_abs_params(idev, ABS_PRESSURE, 0, 14000, 0, 0);
> +
> +	err = input_register_device(idev);
> +	if (err)
> +		goto free_mem;
> +
> +#if defined(CONFIG_SOCRATES)
> +	if (socrates_setup_pen_irq(d))
> +		dev_info(d->dev, "use polling\n");
> +#endif
> +
> +	return 0;
> +
> +free_mem:
> +	input_free_device(idev);
> +	kfree(d);
> +exit:
> +	return err;
> +}
> +
> +static int __devexit tsc2003_remove(struct i2c_client *client)
> +{
> +	struct tsc2003 *d = i2c_get_clientdata(client);
> +
> +	if (d->map_mem)
> +		iounmap(d->map_mem);
> +
> +	input_unregister_device(d->input);
> +	input_free_device(d->input);

Don't call input_free_device() after input_unregister_device(),
unregister is enough.

> +	i2c_set_clientdata(client, 0);
> +	kfree(d);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id tsc2003_id[] = {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tsc2003_id);
> +
> +static struct i2c_driver tsc2003_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe		= tsc2003_probe,
> +	.remove		= __devexit_p(tsc2003_remove),
> +	.id_table	= tsc2003_id,
> +};
> +
> +static int __init tsc2003_init(void)
> +{
> +	return i2c_add_driver(&tsc2003_driver);
> +}
> +
> +static void __exit tsc2003_exit(void)
> +{
> +	i2c_del_driver(&tsc2003_driver);
> +}
> +
> +module_init(tsc2003_init);
> +module_exit(tsc2003_exit);
> +
> +MODULE_DESCRIPTION("TSC2003 touchscreen controller driver");
> +MODULE_LICENSE("GPL");

MOUDULE_AUTHOR? It is not mandatory but why don't you add yourself?

-- 
Dmitry

-- 
Dmitry
