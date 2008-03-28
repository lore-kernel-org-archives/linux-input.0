From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Fri, 28 Mar 2008 18:51:01 +0900
Message-ID: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:11143 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbYC1Jul (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2008 05:50:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so216484wah.23
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2008 02:50:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, lethal@linux-sh.org, broonie@sirena.org.uk, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

This is V2 of the MigoR touch screen driver. The chip we interface to
is unfortunately a custom designed microcontroller speaking some
undocumented protocol over i2c.

The board specific code is expected to register this device as an i2c
chip using struct i2c_board_info [] and i2c_register_board_info().

Changes since V1:
 - added cancel_delayed_work_sync()
 - added interrupt handler comment

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/touchscreen/Kconfig    |   12 +
 drivers/input/touchscreen/Makefile   |    1 
 drivers/input/touchscreen/migor_ts.c |  213 ++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)

--- 0001/drivers/input/touchscreen/Kconfig
+++ work/drivers/input/touchscreen/Kconfig	2008-03-28 15:19:11.000000000 +0900
@@ -134,6 +134,18 @@ config TOUCHSCREEN_HP7XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called jornada720_ts.
 
+config TOUCHSCREEN_MIGOR
+	tristate "Renesas MIGO-R touchscreen"
+	depends on SH_MIGOR
+	default n
+	help
+	  Say Y here to enable MIGO-R touchscreen support.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called migor_ts.
+
 config TOUCHSCREEN_PENMOUNT
 	tristate "Penmount serial touchscreen"
 	select SERIO
--- 0001/drivers/input/touchscreen/Makefile
+++ work/drivers/input/touchscreen/Makefile	2008-03-28 15:19:11.000000000 +0900
@@ -19,3 +19,4 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= pe
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
--- /dev/null
+++ work/drivers/input/touchscreen/migor_ts.c	2008-03-28 16:19:02.000000000 +0900
@@ -0,0 +1,213 @@
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
+		input_report_abs(priv->input, ABS_PRESSURE, 120);
+		input_sync(priv->input);
+	} else if (event == EVENT_PENUP) {
+		input_report_abs(priv->input, ABS_PRESSURE, 0);
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
+	return IRQ_HANDLED;
+}
+
+static int migor_ts_probe(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv;
+	int res = 0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL) {
+		dev_err(&client->dev, "failed to allocate driver data\n");
+		res = -ENOMEM;
+		goto err0;
+	}
+
+	dev_set_drvdata(&client->dev, priv);
+	priv->client = client;
+	INIT_DELAYED_WORK(&priv->work, migor_ts_poscheck);
+	priv->irq = client->irq;
+
+	priv->input = input_allocate_device();
+	if (!priv->input) {
+		dev_err(&client->dev, "Failed to allocate input device.\n");
+		res = -ENOMEM;
+		goto err1;
+	}
+
+	priv->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	priv->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(priv->input, ABS_X, 95, 955, 0, 0);
+	input_set_abs_params(priv->input, ABS_Y, 85, 935, 0, 0);
+	input_set_abs_params(priv->input, ABS_PRESSURE, 0, 0, 0, 0);
+
+	priv->input->name = client->driver_name;
+	priv->input->phys = "input/event0";
+	priv->input->id.bustype = BUS_ISA;
+
+	res = input_register_device(priv->input);
+	if (res) {
+		input_free_device(priv->input);
+		goto err1;
+	}
+
+	if (request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
+			client->driver_name, priv)) {
+		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		res = -EBUSY;
+		goto err2;
+	}
+
+	/* enable controller */
+	if (i2c_master_send(client, migor_ts_ena_seq, sizeof(migor_ts_ena_seq))
+	    == sizeof(migor_ts_ena_seq))
+		return 0;
+
+	dev_err(&client->dev, "Unable to enable touchscreen.\n");
+
+	free_irq(priv->irq, priv);
+ err2:
+	input_unregister_device(priv->input);
+ err1:
+	kfree(priv);
+ err0:
+	return res;
+}
+
+static int migor_ts_remove(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv = dev_get_drvdata(&client->dev);
+	int ret;
+
+	/* cancel pending work and wait for migor_ts_poscheck() to finish */
+	ret = cancel_delayed_work_sync(&priv->work);
+	if (ret)
+		return ret;
+
+	/* disable controller */
+	i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	kfree(priv);
+	return ret;
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
