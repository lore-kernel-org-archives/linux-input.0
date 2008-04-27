From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Sun, 27 Apr 2008 01:07:39 -0400
Message-ID: <20080427050739.GA8218@anvil.corenet.prv>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se> <20080402060819.GB14189@anvil.corenet.prv> <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com> <20080404120837.ZZRA012@mailhub.coreip.homeip.net> <aec7e5c30804250329m5fc62921y4da1cd0f6ee6b215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aec7e5c30804250329m5fc62921y4da1cd0f6ee6b215@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Hi Magnus,

On Fri, Apr 25, 2008 at 07:29:28PM +0900, Magnus Damm wrote:
> Hi Dmitry,
> 
> Thanks for all your help with this driver.
> 
> On Sat, Apr 5, 2008 at 1:14 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >  On Fri, Apr 04, 2008 at 05:21:48PM +0900, Magnus Damm wrote:
> >  > I just tested using latest sh-2.6 git with evtest. Everything seems to
> >  > work well. The patch is much cleaner now. Please apply.
> >  >
> >
> >  I was just looking the driver over one more time before applying it
> >  and I think there is a race in migor_ts_remove():
> >
> >  +       /* cancel pending work and wait for migor_ts_poscheck() to finish */
> >
> > +       cancel_delayed_work_sync(&priv->work);
> >  +
> >
> >  What if interrupt comes here, before we got a chance to shut off the
> >  device? IRQ is still enabled and it will schedule migor_ts_poscheck()
> >  again. I think we need to call disable_irq() before canceling the work.
> >  Since the driver does not support sharing IRQs that should be allright.
> >  What do you think?
> 
> I think you are right. Doing a disable_irq() before canceling the work
> sounds good. Can you please add that, or do you want me to fix and
> repost?
>

Almost done ;) I also wanted to start the controller only when there are
users for the interface, by defining ->open and ->close methods for the
input device. Could you please take a look at the updated patch and if
it still works I will aplly it.

Thanks a lot.

-- 
Dmitry

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
 drivers/input/touchscreen/migor_ts.c |  249 +++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)

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
@@ -12,6 +12,7 @@ obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corg
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
@@ -0,0 +1,249 @@
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
+	if (event == EVENT_PENDOWN || event == EVENT_REPEAT) {
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
+
+static int migor_ts_open(struct input_dev *dev)
+{
+	struct migor_ts_priv *priv = input_get_drvdata(dev);
+	struct i2c_client *client = priv->client;
+	int count;
+
+	/* enable controller */
+	count = i2c_master_send(client, migor_ts_ena_seq,
+				sizeof(migor_ts_ena_seq));
+	if (count != sizeof(migor_ts_ena_seq)) {
+		dev_err(&client->dev, "Unable to enable touchscreen.\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void migor_ts_close(struct input_dev *dev)
+{
+	struct migor_ts_priv *priv = input_get_drvdata(dev);
+	struct i2c_client *client = priv->client;
+
+	disable_irq(priv->irq);
+
+	/* cancel pending work and wait for migor_ts_poscheck() to finish */
+	if (cancel_delayed_work_sync(&priv->work)) {
+		/*
+		 * if migor_ts_poscheck was canceled we need to enable IRQ
+		 * here to balance disable done in migor_ts_isr.
+		 */
+		enable_irq(priv->irq);
+	}
+
+	/* disable controller */
+	i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
+
+	enable_irq(priv->irq);
+}
+
+static int migor_ts_probe(struct i2c_client *client)
+{
+	struct migor_ts_priv *priv;
+	struct input_dev *input;
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
+	input->open = migor_ts_open;
+	input->close = migor_ts_close;
+
+	input_set_drvdata(input, priv);
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
+	return 0;
+
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
