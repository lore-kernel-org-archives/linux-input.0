From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Wed, 4 Apr 2007 01:16:57 -0400
Message-ID: <200704040116.58366.dtor@insightbb.com>
References: <20070221221629.59088fed@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070221221629.59088fed@localhost>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Thursday 22 February 2007 01:16, Stephen Hemminger wrote:
> I did a little investigation and the touchscreen on B6210 is
> attached via the 8250 serial port. I tried enabling it with
> inputattach but seem to get garbage.
> 
> I can extract the initialization code from the evtouch driver
> to a usermode program and read information from /dev/ttyS0.
> 
> The lifebook psmouse extension won't work because it tries
> to grab the 8042 (touchpad) rather than the touch screen.
> 
> Ideas?
> 

Please try the patch below. You will need to load 8250_pnp,
serport and fujitsu_ts modules, then do

        inputattach -fjt /dev/ttyS0

You can find patched version of inputattach here:

	http://www.kernel.org/pub/linux/kernel/people/dtor/

Please let me know if it works for you.

-- 
Dmitry


Input: add driver for Fujitsu serial touchscreens

Such touchscreen are found in Fujitsu lifebook P-series laptops.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/Kconfig      |   17 ++
 drivers/input/touchscreen/Makefile     |   15 +-
 drivers/input/touchscreen/fujitsu_ts.c |  191 +++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 9 deletions(-)

Index: linux/drivers/input/touchscreen/Kconfig
===================================================================
--- linux.orig/drivers/input/touchscreen/Kconfig
+++ linux/drivers/input/touchscreen/Kconfig
@@ -44,9 +44,9 @@ config TOUCHSCREEN_BITSY
 config TOUCHSCREEN_CORGI
 	tristate "SharpSL (Corgi and Spitz series) touchscreen driver"
 	depends on PXA_SHARPSL
-	default y	
+	default y
 	help
-	  Say Y here to enable the driver for the touchscreen on the 
+	  Say Y here to enable the driver for the touchscreen on the
 	  Sharp SL-C7xx and SL-Cxx00 series of PDAs.
 
 	  If unsure, say N.
@@ -54,6 +54,19 @@ config TOUCHSCREEN_CORGI
 	  To compile this driver as a module, choose M here: the
 	  module will be called corgi_ts.
 
+config TOUCHSCREEN_FUJITSU
+	tristate "Fujitsu serial touchscreen"
+	select SERIO
+	help
+	  Say Y here if you have the Fujitsu touchscreen (such as one
+	  installed in Lifebook P series laptop) connected to your
+	  system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fujitsu-ts.
+
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
 	select SERIO
Index: linux/drivers/input/touchscreen/Makefile
===================================================================
--- linux.orig/drivers/input/touchscreen/Makefile
+++ linux/drivers/input/touchscreen/Makefile
@@ -5,13 +5,14 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
-obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
-obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
-obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
-obj-$(CONFIG_TOUCHSCREEN_ELO)	+= elo.o
-obj-$(CONFIG_TOUCHSCREEN_MTOUCH) += mtouch.o
-obj-$(CONFIG_TOUCHSCREEN_MK712)	+= mk712.o
-obj-$(CONFIG_TOUCHSCREEN_HP600)	+= hp680_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
+obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
+obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
+obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
+obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
+obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
Index: linux/drivers/input/touchscreen/fujitsu_ts.c
===================================================================
--- /dev/null
+++ linux/drivers/input/touchscreen/fujitsu_ts.c
@@ -0,0 +1,190 @@
+/*
+ * Fujitsu serial touchscreen driver
+ *
+ * Copyright (c) Dmitry Torokhov <dtor@mail.ru>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+
+#define DRIVER_DESC	"Fujitsu serial touchscreen driver"
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+#define FUJITSU_PACKET_LENGTH 5
+
+#define FUJITSU_MIN_X	0
+#define FUJITSU_MAX_X	4095
+#define FUJITSU_MIN_Y	0
+#define FUJITSU_MAX_Y	4095
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct fujitsu {
+	struct input_dev *dev;
+	struct serio *serio;
+	int idx;
+	unsigned char data[FUJITSU_LENGTH];
+	char phys[32];
+};
+
+static irqreturn_t fujitsu_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct fujitsu *fujitsu = serio_get_drvdata(serio);
+	struct input_dev *dev = fujitsu->dev;
+
+	if (fujitsu->idx == 0) {
+		if ((data & 0xf8) != 0x80)
+			return IRQ_HANDLED;
+	} else {
+		if ((data & 0x80) != 0x00) {
+			fujitsu->idx = 0;
+			return IRQ_HANDLED;
+		}
+	}
+
+	fujitsu->data[fujitsu->idx++] = data;
+
+	if (fujitsu->idx == FUJITSU_PACKET_LENGTH) {
+
+		input_report_abs(dev, ABS_X,
+			(fujitsu->data[2] << 7) | fujitsu->data[1]);
+		input_report_abs(dev, ABS_Y,
+			(fujitsu->data[4] << 7) | fujitsu->data[3]);
+		input_report_key(dev, BTN_TOUCH,
+				 (fujitsu->data[0] & 0x03) != 2);
+		input_sync(dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * fujitsu_disconnect() is the opposite of fujitsu_connect()
+ */
+
+static void fujitsu_disconnect(struct serio *serio)
+{
+	struct fujitsu *fujitsu = serio_get_drvdata(serio);
+
+	input_get_device(fujitsu->dev);
+	input_unregister_device(fujitsu->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_put_device(fujitsu->dev);
+	kfree(fujitsu);
+}
+
+/*
+ * fujitsu_connect() is the routine that is called when someone adds a
+ * new serio device that supports the Fujitsu protocol and registers it
+ * as input device.
+ */
+
+static int fujitsu_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct fujitsu *fujitsu;
+	struct input_dev *input_dev;
+	int err;
+
+	fujitsu = kzalloc(sizeof(struct fujitsu), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!fujitsu || !input_dev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	fujitsu->serio = serio;
+	fujitsu->dev = input_dev;
+	snprintf(fujitsu->phys, sizeof(fujitsu->phys),
+		 "%s/input0", serio->phys);
+
+	input_dev->name = "Fujitsu Serial Touchscreen";
+	input_dev->phys = fujitsu->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_FUJITSU;
+	input_dev->id.product = 0;
+	input_dev->id.version = 0x0100;
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(tw->dev, ABS_X, TW_MIN_XC, TW_MAX_XC, 0, 0);
+	input_set_abs_params(tw->dev, ABS_Y, TW_MIN_YC, TW_MAX_YC, 0, 0);
+
+	serio_set_drvdata(serio, fujitsu);
+
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail2;
+
+	err = input_register_device(fujitsu->dev);
+	if (err)
+		goto fail3;
+
+	return 0;
+
+ fail3:	serio_close(serio);
+ fail2:	serio_set_drvdata(serio, NULL);
+ fail1:	input_free_device(input_dev);
+	kfree(fujitsu);
+	return err;
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static struct serio_device_id fujitsu_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_FUJITSU,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, fujitsu_serio_ids);
+
+static struct serio_driver fujitsu_drv = {
+	.driver		= {
+		.name	= "fujitsu_ts",
+	},
+	.description	= DRIVER_DESC,
+	.id_table	= fujitsu_serio_ids,
+	.interrupt	= fujitsu_interrupt,
+	.connect	= fujitsu_connect,
+	.disconnect	= fujitsu_disconnect,
+};
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+static int __init fujitsu_init(void)
+{
+	return serio_register_driver(&fujitsu_drv);
+}
+
+static void __exit fujitsu_exit(void)
+{
+	serio_unregister_driver(&fujitsu_drv);
+}
+
+module_init(fujitsu_init);
+module_exit(fujitsu_exit);
