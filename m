From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Thu, 5 Apr 2007 12:39:53 -0700
Message-ID: <20070405123953.1dd00102@localhost>
References: <20070221221629.59088fed@localhost>
	<200704040116.58366.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704040116.58366.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Here is a cleaned up version of the patch that at least builds....
----------------------------------------------------------------------
Input: add driver for Fujitsu serial touchscreens

Such touchscreen are found in Fujitsu lifebook P-series laptops.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/Kconfig      |   13 ++
 drivers/input/touchscreen/Makefile     |   15 +-
 drivers/input/touchscreen/fujitsu_ts.c |  194 +++++++++++++++++++++++++++++++++
 include/linux/serio.h                  |    1 
 4 files changed, 216 insertions(+), 7 deletions(-)

--- b6210.orig/drivers/input/touchscreen/Kconfig	2007-04-04 15:40:38.000000000 -0700
+++ b6210/drivers/input/touchscreen/Kconfig	2007-04-04 15:47:03.000000000 -0700
@@ -54,6 +54,19 @@
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
--- b6210.orig/drivers/input/touchscreen/Makefile	2007-04-04 15:40:38.000000000 -0700
+++ b6210/drivers/input/touchscreen/Makefile	2007-04-04 15:47:03.000000000 -0700
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
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b6210/drivers/input/touchscreen/fujitsu_ts.c	2007-04-05 12:36:11.000000000 -0700
@@ -0,0 +1,194 @@
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
+#define FUJITSU_LENGTH 5
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
+	printk(KERN_DEBUG "fujitsu ts interrupt data %x\n", data);
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
+	if (fujitsu->idx == FUJITSU_LENGTH) {
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
+
+	input_set_abs_params(input_dev, ABS_X, FUJITSU_MIN_X, FUJITSU_MAX_X,
+			     0, 0);
+	input_set_abs_params(input_dev, ABS_Y, FUJITSU_MIN_Y, FUJITSU_MAX_Y,
+			     0, 0);
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
--- b6210.orig/include/linux/serio.h	2007-04-05 11:06:15.000000000 -0700
+++ b6210/include/linux/serio.h	2007-04-05 11:06:40.000000000 -0700
@@ -209,5 +209,6 @@
 #define SERIO_PENMOUNT	0x31
 #define SERIO_TOUCHRIGHT	0x32
 #define SERIO_TOUCHWIN	0x33
+#define SERIO_FUJITSU	0x34
 
 #endif
