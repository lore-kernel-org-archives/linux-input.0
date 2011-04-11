From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] input: add mpr121 capacitive touchkey driver
Date: Tue, 12 Apr 2011 01:20:11 +0200
Message-ID: <20110411232010.GC3579@lovely.krouter>
References: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50593 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1DKXUR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Apr 2011 19:20:17 -0400
Received: by fxm17 with SMTP id 17so3925930fxm.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 16:20:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiejing Zhang <kzjeef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>

Hi Zhang,

 this is just a superficial review of your driver.

thanks,
 Christoph

On Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
> From: Zhang Jiejing <jiejing.zhang@freescale.com>
> 
> This touchkey driver is based on Freescale mpr121 capacitive
> touch sensor controller.
> 
> It can support up to 12 keys, it use i2c interface.

typo

> 
> The product infomation(data sheet, application notes) can
> be found under this link:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPR121
> 
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> ---
>  drivers/input/keyboard/Kconfig  |   12 ++
>  drivers/input/keyboard/Makefile |    1 +
>  drivers/input/keyboard/mpr121.c |  301 +++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/mpr.h         |   64 ++++++++
>  4 files changed, 378 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/mpr121.c
>  create mode 100644 include/linux/i2c/mpr.h
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index b16bed0..0666e1e 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -520,6 +520,18 @@ config KEYBOARD_XTKBD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called xtkbd.
>  
> +config KEYBOARD_MPR121
> +	tristate "Freescale MPR121 Touchkey Driver"
> +	depends on I2C
> +	help
> +	  Say Y here if you have the  touchkey Freescale mpr121 capacitive

typo: two spaces

> +	  touch sensor controller in your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here
> +endif
> +
>  config KEYBOARD_W90P910
>  	tristate "W90P910 Matrix Keypad support"
>  	depends on ARCH_W90X900

- add: "To compile this driver as a module, choose M here: the
  module will be called mpr121."
- "endif" is wrong here, it breaks 'make config'
- maybe a more alphabetic approach in this list of drivers would
  be nice

> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 878e6c2..b110ca8 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -47,4 +47,5 @@ obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
>  obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
>  obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
>  obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
> +obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121.o
>  obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o

for better examination, please mind alphabetic order

> diff --git a/drivers/input/keyboard/mpr121.c b/drivers/input/keyboard/mpr121.c
> new file mode 100644
> index 0000000..ee149a8
> --- /dev/null
> +++ b/drivers/input/keyboard/mpr121.c
> @@ -0,0 +1,301 @@
> +/*
> + * Touchkey driver for Freescale MPR121 Controllor
> + *
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + * Author: Zhang Jiejing <jiejing.zhang@freescale.com>
> + *
> + * Based on mcs_touchkey.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/mpr.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/irq.h>

do not use irq.h directly

> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/bitops.h>
> +
> +struct mpr121_touchkey_data {
> +	struct i2c_client	*client;
> +	struct input_dev	*input_dev;
> +	unsigned int		key_val;
> +	int			statusbits;
> +	int			keycount;
> +	u16			keycodes[MPR121_MAX_KEY_COUNT];
> +};
> +
> +struct mpr121_init_register {
> +	int addr;
> +	u8 val;
> +};
> +
> +static struct mpr121_init_register init_reg_table[] = {
> +	{MHD_RISING_ADDR,	0x1},
> +	{NHD_RISING_ADDR,	0x1},
> +	{MHD_FALLING_ADDR,	0x1},
> +	{NHD_FALLING_ADDR,	0x1},
> +	{NCL_FALLING_ADDR,	0xff},
> +	{FDL_FALLING_ADDR,	0x02},
> +	{FILTER_CONF_ADDR,	0x04},
> +	{AFE_CONF_ADDR,		0x0b},
> +	{AUTO_CONFIG_CTRL_ADDR, 0x0b},
> +};
> +
> +static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
> +{
> +	struct mpr121_touchkey_data *data = dev_id;
> +	struct i2c_client *client = data->client;
> +	struct input_dev *input = data->input_dev;
> +	unsigned int key_num, pressed;
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
> +	if (reg < 0) {
> +		dev_err(&client->dev, "i2c read error [%d]\n", reg);
> +		goto out;
> +	}
> +
> +	reg <<= 8;
> +	reg |= i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_0_ADDR);
> +	if (reg < 0) {
> +		dev_err(&client->dev, "i2c read error [%d]\n", reg);
> +		goto out;
> +	}
> +
> +	reg &= TOUCH_STATUS_MASK;
> +	/* use old press bit to figure out which bit changed */
> +	key_num = ffs(reg ^ data->statusbits) - 1;
> +	/* use the bit check the press status */

typo

> +	pressed = (reg & (1 << (key_num))) >> key_num;
> +	data->statusbits = reg;
> +	data->key_val = data->keycodes[key_num];
> +
> +	input_event(input, EV_MSC, MSC_SCAN, data->key_val);
> +	input_report_key(input, data->key_val, pressed);
> +	input_sync(input);
> +
> +	dev_dbg(&client->dev, "key %d %d %s\n", key_num, data->key_val,
> +		pressed ? "pressed" : "released");
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static int mpr121_phys_init(struct mpr121_platform_data *pdata,
> +			    struct mpr121_touchkey_data *data,
> +			    struct i2c_client *client)
> +{
> +	struct mpr121_init_register *reg;
> +	unsigned char usl, lsl, tl;
> +	int i, t, vdd, ret;
> +
> +	/* setup touch/release threshold for ele0-ele11 */
> +	for (i = 0; i <= MPR121_MAX_KEY_COUNT; i++) {
> +		t = ELE0_TOUCH_THRESHOLD_ADDR + (i * 2);
> +		ret = i2c_smbus_write_byte_data(client, t, TOUCH_THRESHOLD);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +		ret = i2c_smbus_write_byte_data(client, t + 1,
> +						RELEASE_THRESHOLD);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +	}
> +	/* setup init register */
> +	for (i = 0; i < ARRAY_SIZE(init_reg_table); i++) {
> +		reg = &init_reg_table[i];
> +		ret = i2c_smbus_write_byte_data(client, reg->addr, reg->val);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +	}
> +	/* setup auto-register by vdd,the formula please ref: AN3889
> +	 * These register *must* set acrodding your VDD voltage supply
> +	 * to the chip*/

typo

> +	vdd = pdata->vdd_uv / 1000;
> +	usl = ((vdd - 700) * 256) / vdd;
> +	lsl = (usl * 65) / 100;
> +	tl = (usl * 90) / 100;
> +	ret = i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL_ADDR, usl);
> +	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_LSL_ADDR, lsl);
> +	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL_ADDR, tl);
> +	ret |= i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
> +					data->keycount);
> +	if (ret != 0)
> +		goto err_i2c_write;
> +
> +	dev_info(&client->dev, "mpr121: config as enable %x of electrode.\n",

typo ?

> +		 data->keycount);
> +
> +	return 0;
> +
> +err_i2c_write:
> +	dev_err(&client->dev, "i2c write error: %d\n", ret);
> +	return ret;
> +}
> +
> +static int __devinit mpr_touchkey_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	struct mpr121_platform_data *pdata;
> +	struct mpr121_touchkey_data *data;
> +	struct input_dev *input_dev;
> +	int error;
> +	int i;
> +
> +	pdata = client->dev.platform_data;
> +	if (!pdata) {
> +		dev_err(&client->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "The irq number should not be zero\n");
> +		return -EINVAL;
> +	}
> +
> +	data = kzalloc(sizeof(struct mpr121_touchkey_data), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!data || !input_dev) {
> +		dev_err(&client->dev, "Falied to allocate memory\n");
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	data->client = client;
> +	data->input_dev = input_dev;
> +	data->keycount = pdata->keycount;
> +
> +	if (data->keycount > MPR121_MAX_KEY_COUNT) {
> +		dev_err(&client->dev, "Too many key defined\n");

typo

> +		error = -EINVAL;
> +		goto err_free_mem;
> +	}
> +
> +	error = mpr121_phys_init(pdata, data, client);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to init register\n");
> +		goto err_free_mem;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +
> +	input_dev->name = "FSL MPR121 Touchkey";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_dev->keycode = pdata->matrix;
> +	input_dev->keycodesize = sizeof(pdata->matrix[0]);
> +	input_dev->keycodemax = data->keycount;
> +
> +	for (i = 0; i < input_dev->keycodemax; i++) {
> +		__set_bit(pdata->matrix[i], input_dev->keybit);
> +		data->keycodes[i] = pdata->matrix[i];
> +	}
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(input_dev, data);
> +
> +	error = request_threaded_irq(client->irq, NULL,
> +				     mpr_touchkey_interrupt,
> +				     IRQF_TRIGGER_FALLING,
> +				     client->dev.driver->name, data);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_mem;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error)
> +		goto err_free_irq;
> +	i2c_set_clientdata(client, data);
> +	device_init_wakeup(&client->dev, pdata->wakeup);
> +	dev_info(&client->dev, "Mpr121 touch keyboard init success.\n");
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(client->irq, data);
> +err_free_mem:
> +	input_free_device(input_dev);
> +	kfree(data);
> +	return error;
> +}
> +
> +static int __devexit mpr_touchkey_remove(struct i2c_client *client)
> +{
> +	struct mpr121_touchkey_data *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mpr_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(client->irq);
> +
> +	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
> +
> +	return 0;
> +}
> +
> +static int mpr_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mpr121_touchkey_data *data = i2c_get_clientdata(client);
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(client->irq);
> +
> +	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, data->keycount);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct i2c_device_id mpr121_id[] = {
> +	{"mpr121_touchkey", 0},
> +	{ }
> +};
> +
> +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
> +
> +static struct i2c_driver mpr_touchkey_driver = {
> +	.driver = {
> +		.name	= "mpr121",
> +		.owner	= THIS_MODULE,
> +		.pm	= &mpr121_touchkey_pm_ops,

I would add a ifdef CONFIG_PM_SLEEP

> +	},
> +	.id_table	= mpr121_id,
> +	.probe		= mpr_touchkey_probe,
> +	.remove		= __devexit_p(mpr_touchkey_remove),
> +};
> +
> +static int __init mpr_touchkey_init(void)
> +{
> +	return i2c_add_driver(&mpr_touchkey_driver);
> +}
> +
> +static void __exit mpr_touchkey_exit(void)
> +{
> +	i2c_del_driver(&mpr_touchkey_driver);
> +}
> +
> +module_init(mpr_touchkey_init);
> +module_exit(mpr_touchkey_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
> +MODULE_DESCRIPTION("Touch Key driver for FSL MPR121 Chip");
> diff --git a/include/linux/i2c/mpr.h b/include/linux/i2c/mpr.h
> new file mode 100644
> index 0000000..52d6e33
> --- /dev/null
> +++ b/include/linux/i2c/mpr.h
> @@ -0,0 +1,64 @@
> +/* mpr.h - Header file for Freescale mpr121 capacitive touch sensor

no filename please

> + * controllor */
> +
> +#ifndef MPR_H
> +#define MPR_H
> +
> +/* Register definitions */
> +#define ELE_TOUCH_STATUS_0_ADDR	0x0
> +#define ELE_TOUCH_STATUS_1_ADDR	0X1
> +#define MHD_RISING_ADDR		0x2b
> +#define NHD_RISING_ADDR		0x2c
> +#define NCL_RISING_ADDR		0x2d
> +#define FDL_RISING_ADDR		0x2e
> +#define MHD_FALLING_ADDR	0x2f
> +#define NHD_FALLING_ADDR	0x30
> +#define NCL_FALLING_ADDR	0x31
> +#define FDL_FALLING_ADDR	0x32
> +#define ELE0_TOUCH_THRESHOLD_ADDR	0x41
> +#define ELE0_RELEASE_THRESHOLD_ADDR	0x42
> +/* ELE0...ELE11's threshold will set in a loop */

typo

> +#define AFE_CONF_ADDR			0x5c
> +#define FILTER_CONF_ADDR		0x5d
> +
> +/* ELECTRODE_CONF: this register is most important register, it
> + * control how many of electrode is enabled. If you set this register
> + * to 0x0, it make the sensor going to suspend mode. Other value(low
> + * bit is non-zero) will make the sensor into Run mode.  This register
> + * should be write at last.

typo

> + */
> +#define ELECTRODE_CONF_ADDR		0x5e
> +#define AUTO_CONFIG_CTRL_ADDR		0x7b
> +/* AUTO_CONFIG_USL: Upper Limit for auto baseline search, this
> + * register is related to VDD supplied on your board, the value of
> + * this register is calc by EQ: `((VDD-0.7)/VDD) * 256`.

typo

> + * AUTO_CONFIG_LSL: Low Limit of auto baseline search. This is 65% of
> + * USL AUTO_CONFIG_TL: The Traget Level of auto baseline search, This
> + * is 90% of USL  */

typo

> +#define AUTO_CONFIG_USL_ADDR		0x7d
> +#define AUTO_CONFIG_LSL_ADDR		0x7e
> +#define AUTO_CONFIG_TL_ADDR		0x7f
> +
> +/* Threshold of touch/release trigger */
> +#define TOUCH_THRESHOLD			0x0f
> +#define RELEASE_THRESHOLD		0x0a
> +/* Mask Button bits of STATUS_0 & STATUS_1 register */

and or bit-and?

> +#define TOUCH_STATUS_MASK		0xfff
> +/* MPR121 have 12 electrodes */
> +#define MPR121_MAX_KEY_COUNT		12
> +
> +
> +/**
> + * @keycount: how many key maped

typo: "keys" ?

> + * @vdd_uv: voltage of vdd supply the chip in uV

- typo
- uppercase for vdd

> + * @matrix: maxtrix of keys
> + * @wakeup: can key wake up system.

typo

> + */
> +struct mpr121_platform_data {
> +	u16 keycount;
> +	u16 *matrix;
> +	int wakeup;
> +	int vdd_uv;
> +};
> +
> +#endif
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.htmln Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
