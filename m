From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Wed, 2 Apr 2008 02:08:19 -0400
Message-ID: <20080402060819.GB14189@anvil.corenet.prv>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:26855 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYDBGIZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 02:08:25 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2000842hsl.5
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2008 23:08:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org

Hi Magnus,

On Fri, Mar 28, 2008 at 06:51:01PM +0900, Magnus Damm wrote:
> This is V2 of the MigoR touch screen driver. The chip we interface to
> is unfortunately a custom designed microcontroller speaking some
> undocumented protocol over i2c.
> 

Thank you for the patch, I just have a couple of comments below...
 
> +config TOUCHSCREEN_MIGOR
> +	tristate "Renesas MIGO-R touchscreen"
> +	depends on SH_MIGOR
> +	default n

N is the default default so this line is not needed.

> +
> +	if ((event == EVENT_PENDOWN) || (event == EVENT_REPEAT)) {
> +		input_report_key(priv->input, BTN_TOUCH, 1);
> +		input_report_abs(priv->input, ABS_X, ypos); /*X-Y swap*/
> +		input_report_abs(priv->input, ABS_Y, xpos);
> +		input_report_abs(priv->input, ABS_PRESSURE, 120);
> +		input_sync(priv->input);
> +	} else if (event == EVENT_PENUP) {
> +		input_report_abs(priv->input, ABS_PRESSURE, 0);

Don't you need to signal BTN_TOUCH release here?

> +	input_set_abs_params(priv->input, ABS_X, 95, 955, 0, 0);
> +	input_set_abs_params(priv->input, ABS_Y, 85, 935, 0, 0);
> +	input_set_abs_params(priv->input, ABS_PRESSURE, 0, 0, 0, 0);

The device does not support pressure reporting so don't pretend
to send one. If this was done because of tslib please fix tslib
instead.

> +
> +	priv->input->name = client->driver_name;
> +	priv->input->phys = "input/event0";

Normally we encode bus slot or port in phys. If this data
is unavailable it is better to omit phys altogether.

What we can and should do is properly set up input device in
sysfs hierarchy by parenting it to the i2c client:

	input->dev.parent = &client->dev;

> +	priv->input->id.bustype = BUS_ISA;

Not BUS_i2C?

> +
> +	res = input_register_device(priv->input);
> +	if (res) {
> +		input_free_device(priv->input);
> +		goto err1;
> +	}
> +
> +	if (request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
> +			client->driver_name, priv)) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		res = -EBUSY;
> +		goto err2;
> +	}
> +
> +	/* enable controller */
> +	if (i2c_master_send(client, migor_ts_ena_seq, sizeof(migor_ts_ena_seq))
> +	    == sizeof(migor_ts_ena_seq))
> +		return 0;
> +
> +	dev_err(&client->dev, "Unable to enable touchscreen.\n");
> +

Since you are not setting res here you will signal success the module
loader and bad things will happen.

I tried implementing my suggestions in the patch below, please let me
know if it still works for you and I will apply it.

Thanks!

-- 
Dmitry

Subject: Input: add support for SuperH MigoR touchscreen
From: Magnus Damm <magnus.damm@gmail.com>

Input: add support for SuperH MigoR touchscreen

This is V2 of the MigoR touch screen driver. The chip we interface to
is unfortunately a custom designed microcontroller speaking some
undocumented protocol over i2c.

The board specific code is expected to register this device as an i2c
chip using struct i2c_board_info [] and i2c_register_board_info().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/Kconfig    |   11 +
 drivers/input/touchscreen/Makefile   |    1 
 drivers/input/touchscreen/migor_ts.c |  222 +++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

Index: work/drivers/input/touchscreen/Kconfig
===================================================================
--- work.orig/drivers/input/touchscreen/Kconfig
+++ work/drivers/input/touchscreen/Kconfig
@@ -146,6 +146,17 @@ config TOUCHSCREEN_PENMOUNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called penmount.
 
+config TOUCHSCREEN_MIGOR
+	tristate "Renesas MIGO-R touchscreen"
+	depends on SH_MIGOR
+	help
+	  Say Y here to enable MIGO-R touchscreen support.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called migor_ts.
+
 config TOUCHSCREEN_TOUCHRIGHT
 	tristate "Touchright serial touchscreen"
 	select SERIO
Index: work/drivers/input/touchscreen/Makefile
===================================================================
--- work.orig/drivers/input/touchscreen/Makefile
+++ work/drivers/input/touchscreen/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corg
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
Index: work/drivers/input/touchscreen/migor_ts.c
===================================================================
--- /dev/null
+++ work/drivers/input/touchscreen/migor_ts.c
@@ -0,0 +1,222 @@
+/*
+ * Touch Screen driver for Renesas MIGO-R Platform
+ *
+ * Copyright (c) 2008 Magnus Damm
+ * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
+ *  Kenati Technologies Pvt Ltd.
+ *
+ * This file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU  General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include <linux/timer.h>
+
+#define EVENT_PENDOWN 1
+#define EVENT_REPEAT  2
+#define EVENT_PENUP   3
+
+struct migor_ts_priv {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct delayed_work work;
+	int irq;
+};
+
+static const u_int8_t migor_ts_ena_seq[17] = { 0x33, 0x22, 0x11,
+					       0x01, 0x06, 0x07, };
+static const u_int8_t migor_ts_dis_seq[17] = { };
+
+static void migor_ts_poscheck(struct work_struct *work)
+{
+	struct migor_ts_priv *priv = container_of(work,
+						  struct migor_ts_priv,
+						  work.work);
+	unsigned short xpos, ypos;
+	unsigned char event;
+	u_int8_t buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	/* Set Index 0 */
+	buf[0] = 0;
+	if (i2c_master_send(priv->client, buf, 1) != 1) {
+		dev_err(&priv->client->dev, "Unable to write i2c index\n");
+		goto out;
+	}
+
+	/* Now do Page Read */
+	if (i2c_master_recv(priv->client, buf, sizeof(buf)) != sizeof(buf)) {
+		dev_err(&priv->client->dev, "Unable to read i2c page\n");
+		goto out;
+	}
+
+	ypos = ((buf[9] & 0x03) << 8 | buf[8]);
+	xpos = ((buf[11] & 0x03) << 8 | buf[10]);
+	event = buf[12];
+
+	if ((event == EVENT_PENDOWN) || (event == EVENT_REPEAT)) {
+		input_report_key(priv->input, BTN_TOUCH, 1);
+		input_report_abs(priv->input, ABS_X, ypos); /*X-Y swap*/
+		input_report_abs(priv->input, ABS_Y, xpos);
+		input_sync(priv->input);
+	} else if (event == EVENT_PENUP) {
+		input_report_key(priv->input, BTN_TOUCH, 0);
+		input_sync(priv->input);
+	}
+ out:
+	enable_irq(priv->irq);
+}
+
+static irqreturn_t migor_ts_isr(int irq, void *dev_id)
+{
+	struct migor_ts_priv *priv = dev_id;
+
+	/* the touch screen controller chip is hooked up to the cpu
+	 * using i2c and a single interrupt line. the interrupt line
+	 * is pulled low whenever someone taps the screen. to deassert
+	 * the interrupt line we need to acknowledge the interrupt by
+	 * communicating with the controller over the slow i2c bus.
+	 *
+	 * we can't acknowledge from interrupt context since the i2c
+	 * bus controller may sleep, so we just disable the interrupt
+	 * here and handle the acknowledge using delayed work.
+	 */
+
+	disable_irq_nosync(irq);
+	schedule_delayed_work(&priv->work, HZ / 20);
+
+	return IRQ_HANDLED;
+}
+
+static int migor_ts_probe(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv;
+	struct input_dev *input;
+	int count;
+	int error;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		error = -ENOMEM;
+		goto err0;
+	}
+
+	dev_set_drvdata(&client->dev, priv);
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device.\n");
+		error = -ENOMEM;
+		goto err1;
+	}
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input, ABS_X, 95, 955, 0, 0);
+	input_set_abs_params(input, ABS_Y, 85, 935, 0, 0);
+
+	input->name = client->driver_name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	priv->client = client;
+	priv->input = input;
+	INIT_DELAYED_WORK(&priv->work, migor_ts_poscheck);
+	priv->irq = client->irq;
+
+	error = input_register_device(input);
+	if (error)
+		goto err1;
+
+	error = request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
+			    client->driver_name, priv);
+	if (error) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		goto err2;
+	}
+
+	/* enable controller */
+	count = i2c_master_send(client, migor_ts_ena_seq,
+				sizeof(migor_ts_ena_seq));
+	if (count != sizeof(migor_ts_ena_seq)) {
+		dev_err(&client->dev, "Unable to enable touchscreen.\n");
+		error = -ENXIO;
+		goto err3;
+	}
+
+	return 0;
+
+ err3:
+	free_irq(priv->irq, priv);
+ err2:
+	input_unregister_device(input);
+	input = NULL; /* so we dont try to free it below */
+ err1:
+	input_free_device(input);
+	kfree(priv);
+ err0:
+	dev_set_drvdata(&client->dev, NULL);
+	return error;
+}
+
+static int migor_ts_remove(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	/* cancel pending work and wait for migor_ts_poscheck() to finish */
+	cancel_delayed_work_sync(&priv->work);
+
+	/* disable controller */
+	i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	kfree(priv);
+
+	dev_set_drvdata(&client->dev, NULL);
+
+	return 0;
+}
+
+static struct i2c_driver migor_ts_driver = {
+	.driver = {
+		.name = "migor_ts",
+	},
+	.probe = migor_ts_probe,
+	.remove = migor_ts_remove,
+};
+
+static int __init migor_ts_init(void)
+{
+	return i2c_add_driver(&migor_ts_driver);
+}
+
+static void __exit migor_ts_exit(void)
+{
+	i2c_del_driver(&migor_ts_driver);
+}
+
+MODULE_DESCRIPTION("MigoR Touchscreen driver");
+MODULE_AUTHOR("Magnus Damm <damm@opensource.se>");
+MODULE_LICENSE("GPL");
+
+module_init(migor_ts_init);
+module_exit(migor_ts_exit);
