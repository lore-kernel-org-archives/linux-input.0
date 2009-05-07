From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input: add driver for EETI touchpanels
Date: Thu, 7 May 2009 19:35:02 +0200
Message-ID: <20090507173502.GA12946@buzzloop.caiaq.de>
References: <1241002247-23923-1-git-send-email-daniel@caiaq.de> <1241019084-19204-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:49552 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbZEGRfI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 13:35:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 673067C801A
	for <linux-input@vger.kernel.org>; Thu,  7 May 2009 19:35:06 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWDHcVuBtlJ8 for <linux-input@vger.kernel.org>;
	Thu,  7 May 2009 19:35:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1241019084-19204-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Wed, Apr 29, 2009 at 05:31:24PM +0200, Daniel Mack wrote:
> This patch adds a driver for EETI's I2C connected touchscreens.

Ignore that for now, please. There are some minor flaws I need to fix
first. Will provide an update as soon as I can.

Anyway, if there are any semantic things anyone would like me to change,
I'd appreciate any input :)

Daniel



>  drivers/input/touchscreen/Kconfig   |    9 ++
>  drivers/input/touchscreen/Makefile  |    1 +
>  drivers/input/touchscreen/eeti_ts.c |  253 +++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/eeti_ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index b01fd61..53edad0 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -111,6 +111,15 @@ config TOUCHSCREEN_DA9034
>  	  Say Y here to enable the support for the touchscreen found
>  	  on Dialog Semiconductor DA9034 PMIC.
>  
> +config TOUCHSCREEN_EETI
> +	tristate "EETI touchscreen panel support"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for I2C connected EETI touch panels.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called eeti_ts.
> +
>  config TOUCHSCREEN_FUJITSU
>  	tristate "Fujitsu serial touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 6700f7b..91292cf 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
>  obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
> +obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
> diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
> new file mode 100644
> index 0000000..14cd33b
> --- /dev/null
> +++ b/drivers/input/touchscreen/eeti_ts.c
> @@ -0,0 +1,253 @@
> +/*
> + * Touch Screen driver for EETI's I2C connected touch screen panels
> + *   Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> + *
> + * See EETI's software guide for the protocol specification:
> + *   http://home.eeti.com.tw/web20/eg/guide.htm
> + *
> + * Based on migor_ts.c
> + *   Copyright (c) 2008 Magnus Damm
> + *   Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>
> + *
> + * This file is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU  General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This file is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/timer.h>
> +
> +struct eeti_ts_priv {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct delayed_work work;
> +	int irq;
> +};
> +
> +#define REPORT_BIT_PRESSED	(1 << 0)
> +#define REPORT_BIT_AD0		(1 << 1)
> +#define REPORT_BIT_AD1		(1 << 2)
> +#define REPORT_BIT_HAS_PRESSURE	(1 << 6)
> +#define REPORT_RES_BITS(v)	(((v) >> 1) + 11)
> +
> +static void eeti_ts_read(struct work_struct *work)
> +{
> +	char buf[6];
> +	unsigned int x, y, res, pressed;
> +	struct eeti_ts_priv *priv =
> +		container_of(work, struct eeti_ts_priv, work.work);
> +
> +	i2c_master_recv(priv->client, buf, sizeof(buf));
> +
> +	/* drop non-report packets */
> +	if (!(buf[0] & 0x80))
> +		return;
> +
> +	pressed = buf[0] & REPORT_BIT_PRESSED;
> +	res = REPORT_RES_BITS(buf[0] & (REPORT_BIT_AD0 | REPORT_BIT_AD1));
> +	x = buf[2] | (buf[1] << 8);
> +	y = buf[4] | (buf[3] << 8);
> +
> +	/* fix the range to 11 bits */
> +	x >>= res - 11;
> +	y >>= res - 11;
> +
> +	if (buf[0] & REPORT_BIT_HAS_PRESSURE)
> +		input_report_abs(priv->input, ABS_PRESSURE, buf[5]);
> +
> +	input_report_key(priv->input, BTN_TOUCH, !!pressed);
> +	input_report_abs(priv->input, ABS_X, x);
> +	input_report_abs(priv->input, ABS_Y, y);
> +	input_sync(priv->input);
> +	enable_irq(priv->irq);
> +}
> +
> +static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
> +{
> +	struct eeti_ts_priv *priv = dev_id;
> +
> +	 /* postpone I2C transactions as we are atomic */
> +	disable_irq_nosync(irq);
> +	schedule_delayed_work(&priv->work, HZ / 100);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int eeti_ts_open(struct input_dev *dev)
> +{
> +	struct eeti_ts_priv *priv = input_get_drvdata(dev);
> +	/* Read the events once to arm the IRQ */
> +	eeti_ts_read(&priv->work.work);
> +
> +	return 0;
> +}
> +
> +static void eeti_ts_close(struct input_dev *dev)
> +{
> +	struct eeti_ts_priv *priv = input_get_drvdata(dev);
> +	disable_irq(priv->irq);
> +	cancel_delayed_work_sync(&priv->work);
> +}
> +
> +static int eeti_ts_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *idp)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct eeti_ts_priv *priv;
> +	struct input_dev *input;
> +	int err = -ENOMEM;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +		return -EIO;
> +
> +	/* In contrast to what's described in the datasheet, there seems
> +	 * to be no way of probing the presence of that device using I2C
> +	 * commands. So we need to blindly believe it is there, and wait
> +	 * for interrupts to occur. */
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&client->dev, "failed to allocate driver data\n");
> +		goto err0;
> +	}
> +
> +	input = input_allocate_device();
> +	if (!input) {
> +		dev_err(&client->dev, "Failed to allocate input device.\n");
> +		goto err1;
> +	}
> +
> +	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	/* 11 bit axes */
> +	input_set_abs_params(input, ABS_X, 0, (1 << 11) - 1, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, (1 << 11) - 1, 0, 0);
> +	input_set_abs_params(input, ABS_PRESSURE, 0, 0xff, 0, 0);
> +
> +	input->name = client->name;
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +	input->open = eeti_ts_open;
> +	input->close = eeti_ts_close;
> +
> +	input_set_drvdata(input, priv);
> +
> +	priv->client = client;
> +	priv->input = input;
> +	priv->irq = client->irq;
> +	dev_set_drvdata(&client->dev, priv);
> +	INIT_DELAYED_WORK(&priv->work, eeti_ts_read);
> +
> +	err = input_register_device(input);
> +	if (err)
> +		goto err1;
> +
> +	err = request_irq(priv->irq, eeti_ts_isr, IRQF_TRIGGER_FALLING,
> +			  client->name, priv);
> +	if (err) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		goto err2;
> +	}
> +
> +	/* Disable the irq for now. It will be enabled once the input device
> +	 * is opened. */
> +	disable_irq(priv->irq);
> +
> +	device_init_wakeup(&client->dev, 1);
> +	return 0;
> +
> +err2:
> +	input_unregister_device(input);
> +	input = NULL; /* so we dont try to free it below */
> +err1:
> +	input_free_device(input);
> +	kfree(priv);
> +err0:
> +	dev_set_drvdata(&client->dev, NULL);
> +	return err;
> +}
> +
> +static int eeti_ts_remove(struct i2c_client *client)
> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	free_irq(priv->irq, priv);
> +	input_unregister_device(priv->input);
> +	dev_set_drvdata(&client->dev, NULL);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +
> +static int eeti_ts_resume(struct i2c_client *client)
> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +#else
> +#define eeti_ts_suspend NULL
> +#define eeti_ts_resume NULL
> +#endif
> +
> +static const struct i2c_device_id eeti_ts_id[] = {
> +	{ "eeti_ts", 0 },
> +};
> +MODULE_DEVICE_TABLE(i2c, eeti_ts);
> +
> +static struct i2c_driver eeti_ts_driver = {
> +	.driver = {
> +		.name = "eeti_ts",
> +	},
> +	.probe = eeti_ts_probe,
> +	.remove = eeti_ts_remove,
> +	.suspend = eeti_ts_suspend,
> +	.resume = eeti_ts_resume,
> +	.id_table = eeti_ts_id,
> +};
> +
> +static int __init eeti_ts_init(void)
> +{
> +	return i2c_add_driver(&eeti_ts_driver);
> +}
> +
> +static void __exit eeti_ts_exit(void)
> +{
> +	i2c_del_driver(&eeti_ts_driver);
> +}
> +
> +MODULE_DESCRIPTION("EETI Touchscreen driver");
> +MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
> +MODULE_LICENSE("GPL");
> +
> +module_init(eeti_ts_init);
> +module_exit(eeti_ts_exit);
> -- 
> 1.6.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
