From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: add driver for Pixcir Tango C series
 capacitive touchscreen
Date: Thu, 19 Sep 2013 09:12:40 -0700
Message-ID: <20130919161239.GB5731@core.coreip.homeip.net>
References: <1379579911-9763-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45867 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3ISQMp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Sep 2013 12:12:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so9844017pac.31
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 09:12:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379579911-9763-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, Lisai Wang <Lisai.Wang@csr.com>, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi Barry,

On Thu, Sep 19, 2013 at 04:38:31PM +0800, Barry Song wrote:
> From: Lisai Wang <Lisai.Wang@csr.com>
> 
> Pixcir Tango C series touchscreen support true multi-touch for 5 fingers. this
> patch adds a driver for it.
> 
> Signed-off-by: Lisai Wang <Lisai.Wang@csr.com>
> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/input/touchscreen/Kconfig            |   10 +
>  drivers/input/touchscreen/Makefile           |    1 +
>  drivers/input/touchscreen/pixcir_tangoc_ts.c |  242 ++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/pixcir_tangoc_ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e09ec67..2b80df6 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -919,4 +919,14 @@ config TOUCHSCREEN_TPS6507X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tps6507x_ts.
>  
> +config TOUCHSCREEN_TANGOC
> +	tristate "PIXCIR TANGOC touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you support PIXCIR TangoC touchscreen
> +	  controller
> +
> +	  If unsure, Say N.
> +	  To compile this driver as a module, choose M here.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f5216c1..ef73c06 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -75,3 +75,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_TANGOC)	+= pixcir_tangoc_ts.o
> diff --git a/drivers/input/touchscreen/pixcir_tangoc_ts.c b/drivers/input/touchscreen/pixcir_tangoc_ts.c
> new file mode 100644
> index 0000000..8274917
> --- /dev/null
> +++ b/drivers/input/touchscreen/pixcir_tangoc_ts.c
> @@ -0,0 +1,242 @@
> +/*
> +* Pixcir Tango C series 5 points touch controller Driver
> +*
> +* Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
> +*
> +* Licensed under GPLv2 or later.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +
> +#define TOUCHSCREEN_MINX 0
> +#define TOUCHSCREEN_MAXX 1024
> +#define TOUCHSCREEN_MINY 0
> +#define TOUCHSCREEN_MAXY 600
> +#define TOUCH_MAJOR_MAX 50
> +#define WIDTH_MAJOR_MAX 15
> +#define TRACKING_ID_MAX 5
> +
> +struct pixcir_ts_point_data {
> +	u16 posx;  /* x coordinate */
> +	u16 posy;  /* y coordinate */

Since this represents on-wire data you need to specify endianess (__le16?) and
then explicitly convert it to CPU endianess when you use the data.

> +	u8 id;    /* finger ID */
> +} __packed;
> +
> +struct pixcir_ts_touch_data {
> +	u16 touch_fingers;

This should be __le16 or __be16 as well.

> +	struct pixcir_ts_point_data point[5];
> +} __packed;
> +
> +struct pixcir_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	unsigned int touch_pin;
> +	struct pixcir_ts_touch_data touch_data;
> +};
> +
> +/*Report the touch position*/
> +static void  pixcir_ts_report_event(struct pixcir_ts_data *ts)
> +{
> +	int ret, i;
> +	int fingers;
> +	u8 addr;
> +
> +	addr = 0;
> +	ret = i2c_master_send(ts->client, &addr, sizeof(addr));
> +	if (ret != sizeof(addr)) {
> +		dev_err(&ts->client->dev,
> +				"pixcir_ts:Unable to reset pixcir_ts!\n");

Reset?

> +		return;
> +	}
> +
> +	ret = i2c_master_recv(ts->client, (char *)&ts->touch_data,
> +					sizeof(struct pixcir_ts_touch_data));
> +	if (ret != sizeof(struct pixcir_ts_touch_data)) {
> +		dev_err(&ts->client->dev,
> +				"pixcir_ts:Unable get the touch info\n");
> +		return;
> +	}

Do you need 2 transactions? Can you use i2c_transfer() here?

> +
> +	fingers = ts->touch_data.touch_fingers & 0x07;
> +	if (fingers > 0) {
> +		for (i = 0; i < fingers; i++) {
> +			/*Get the touch position*/
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +					ts->touch_data.point[i].posx);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +					ts->touch_data.point[i].posy);
> +
> +			input_report_key(ts->input_dev, ABS_MT_TRACKING_ID,
> +					ts->touch_data.point[i].id);
> +			input_report_abs(ts->input_dev,
> +					ABS_MT_TOUCH_MAJOR, TOUCH_MAJOR_MAX);
> +			input_report_abs(ts->input_dev,
> +					ABS_MT_WIDTH_MAJOR, WIDTH_MAJOR_MAX);
> +			input_mt_sync(ts->input_dev);

Any chance we could use the B flavor of MT protocol?

> +		}
> +	} else
> +		input_mt_sync(ts->input_dev);
> +
> +	input_sync(ts->input_dev);
> +}
> +
> +static irqreturn_t pixcir_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct pixcir_ts_data *ts = dev_id;
> +
> +	pixcir_ts_report_event(ts);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pixcir_ts_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(client->irq);
> +
> +	return 0;
> +}
> +
> +static int pixcir_ts_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(client->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
> +			pixcir_ts_suspend, pixcir_ts_resume);
> +#endif
> +
> +static int pixcir_ts_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct pixcir_ts_data *ts;
> +	struct input_dev *input_dev;
> +	struct device_node *np = client->dev.of_node;
> +	u8 tmp = 0;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->touch_pin = of_get_named_gpio(np, "touch-gpio", 0);
> +	if (!gpio_is_valid(ts->touch_pin)) {
> +		dev_err(&client->dev, "invalid touch_pin supplied\n");
> +		return -EINVAL;
> +	}
> +	client->irq = gpio_to_irq(ts->touch_pin);

This should be done by the code that sets up i2c client, this driver
should simply use client->irq, not set it up.

> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		ret = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	/* if the client exists, this i2c transfer should be ok */
> +	ret = i2c_master_send(ts->client, &tmp, 1);
> +	if (ret != 1)
> +		goto err_free_mem;
> +
> +	i2c_set_clientdata(client, ts);
> +	input_set_drvdata(input_dev, ts);
> +	input_dev->name = "tangoc-touchscreen";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +	set_bit(EV_SYN, input_dev->evbit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +	set_bit(ABS_MT_TOUCH_MAJOR, input_dev->absbit);
> +	set_bit(ABS_MT_WIDTH_MAJOR, input_dev->absbit);
> +	set_bit(ABS_MT_POSITION_X, input_dev->absbit);
> +	set_bit(ABS_MT_POSITION_Y, input_dev->absbit);
> +	set_bit(ABS_MT_TRACKING_ID, input_dev->absbit);
> +	set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> +			TOUCHSCREEN_MINX, TOUCHSCREEN_MAXX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> +			TOUCHSCREEN_MINY, TOUCHSCREEN_MAXY, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
> +			0, TOUCH_MAJOR_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR,
> +			0, WIDTH_MAJOR_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID,
> +			0, TRACKING_ID_MAX, 0, 0);
> +
> +	ret = devm_request_threaded_irq(&client->dev,
> +		client->irq,
> +		NULL, pixcir_ts_irq_handler,
> +		IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +		client->name, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "\nFailed to register interrupt\n");
> +		goto err_free_mem;
> +	}
> +
> +	ts->input_dev = input_dev;

You need to make this assignment earlier, otherwise, if somebody is
touching the screen you'll get a nice oops here.

> +	ret = input_register_device(ts->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to register %s input device\n",
> +			input_dev->name);
> +		goto err_free_mem;
> +	}
> +	device_init_wakeup(&client->dev, 1);
> +
> +	return 0;
> +
> +err_free_mem:
> +	input_free_device(input_dev);
> +	return ret;
> +}
> +
> +static int pixcir_ts_remove(struct i2c_client *client)
> +{
> +	struct pixcir_ts_data *ts = i2c_get_clientdata(client);
> +	device_init_wakeup(&client->dev, 0);
> +	input_unregister_device(ts->input_dev);

This is so going to bomb because input device disappears but IRQ is not
going to be unregistered till later. The easiest way would be to use
devm_input_allocate_device() and get rid of input_unregister_device()
altogether.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id pixcir_ts_id[] = {
> +	{ "tangoc-ts", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pixcir_ts_id);
> +
> +static struct i2c_driver pixcir_ts_driver = {
> +	.driver = {
> +		.name	= "tangoc-ts",
> +		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm	= &pixcir_dev_pm_ops,
> +#endif
> +	},
> +	.id_table	= pixcir_ts_id,
> +	.probe		= pixcir_ts_probe,
> +	.remove		= pixcir_ts_remove,
> +};
> +
> +module_i2c_driver(pixcir_ts_driver);
> +
> +MODULE_AUTHOR("Lisai Wang <Lisai.Wang@csr.com>, Guoying Zhang <Guoying.Zhang@csr.com>");
> +MODULE_DESCRIPTION("PIXCIR-TangoC 5 points touch controller Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.5.4
> 

Thanks.

-- 
Dmitry
