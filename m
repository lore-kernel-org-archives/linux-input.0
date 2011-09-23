From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v2] input: Add a driver TSC-40 (serial)
Date: Fri, 23 Sep 2011 12:35:31 +0200
Message-ID: <CAH9NwWfPwg69DpGNyd0rDs=OEDpBxrD_D_QPuunwMLN1iF3nyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37317 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1IWKfv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 06:35:51 -0400
Received: by iaqq3 with SMTP id q3so3782114iaq.19
        for <linux-input@vger.kernel.org>; Fri, 23 Sep 2011 03:35:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

>From 7fc3295f1a4d987af846851f13d185e5f5877411 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 23 Sep 2011 14:22:18 +0200
Subject: [PATCH v2] input: Add a driver TSC40 (serial)

This patch adds the TSC-40 serial touchscreen driver and
should be compatible with TSC-10 and TSC-25.

The driver was written by Linutronix on behalf of
Bachmann electronic GmbH.

Changes v1 -> v2:
- initialisation of the controller moved to inputattach
- incorporated feedback from Dmitry Torokhov and
  Sebastian Andrzej Siewior

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/input/touchscreen/Kconfig  |    7 ++
 drivers/input/touchscreen/Makefile |    1 +
 drivers/input/touchscreen/tsc40.c  |  176 ++++++++++++++++++++++++++++++++++++
 include/linux/serio.h              |    1 +
 4 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc40.c

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index cabd9e5..c1b6ed9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -651,6 +651,13 @@ config TOUCHSCREEN_TOUCHIT213
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchit213.

+config TOUCHSCREEN_TSC_SERIO
+	tristate "TSC-10/25/40 serial touchscreen"
+	select SERIO
+	help
+	  Say Y here if you have a TSC-10, 25 or 40 serial touchscreen connected
+	  to your system.
+
 config TOUCHSCREEN_TSC2005
         tristate "TSC2005 based touchscreens"
         depends on SPI_MASTER && GENERIC_HARDIRQS
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 282d6f7..f957676 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
+obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
diff --git a/drivers/input/touchscreen/tsc40.c
b/drivers/input/touchscreen/tsc40.c
new file mode 100644
index 0000000..eeb53a8
--- /dev/null
+++ b/drivers/input/touchscreen/tsc40.c
@@ -0,0 +1,176 @@
+/*
+ * TSC-40 serial touchscreen driver. It should be compatiible with
TSC-10 and 25.
+ * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ * License: GPLv2 as published by the FSF.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+
+#define PACKET_LENGTH  5
+struct tsc_ser {
+	struct input_dev *dev;
+	struct serio *serio;
+	u32 idx;
+	unsigned char data[PACKET_LENGTH];
+	char phys[32];
+};
+
+static void tsc_process_data(struct tsc_ser *ptsc)
+{
+	struct input_dev *dev = ptsc->dev;
+	u8 *data = ptsc->data;
+	u32 x;
+	u32 y;
+	u32 touch;
+
+	x = ((data[1] & 0x03) << 8) | data[2];
+	y = ((data[3] & 0x03) << 8) | data[4];
+	touch = data[0] & 0x01;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_abs(dev, ABS_PRESSURE, touch << 7);
+	input_report_key(dev, BTN_TOUCH, touch);
+
+	input_sync(dev);
+
+	ptsc->idx = 0;
+}
+
+static int pen_is_up(u8 data)
+{
+	/* SW[01] are unknown */
+	u8 val = data & 0x3f;
+	u8 up_val = 1 << 4;
+
+	return val == up_val;
+}
+
+static irqreturn_t tsc_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct tsc_ser *ptsc = serio_get_drvdata(serio);
+	struct input_dev *dev = ptsc->dev;
+
+	if (!ptsc->idx && pen_is_up(data)) {
+		input_report_key(dev, BTN_TOUCH, 0);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+		input_sync(dev);
+		return IRQ_HANDLED;
+	}
+
+	ptsc->data[ptsc->idx] = data;
+	ptsc->idx++;
+
+	if (ptsc->idx < PACKET_LENGTH)
+		return IRQ_HANDLED;
+
+	tsc_process_data(ptsc);
+
+	return IRQ_HANDLED;
+}
+
+static int tsc_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct tsc_ser *ptsc;
+	struct input_dev *input_dev;
+	int ret;
+
+	ptsc = kzalloc(sizeof(struct tsc_ser), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ptsc || !input_dev) {
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	ptsc->serio = serio;
+	ptsc->dev = input_dev;
+	snprintf(ptsc->phys, sizeof(ptsc->phys), "%s/input0", serio->phys);
+
+	input_dev->name = "TSC-10/25/40 Serial TouchScreen";
+	input_dev->phys = ptsc->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_TSC40;
+	input_dev->id.product = 40;
+	input_dev->id.version = 0x0001;
+	input_dev->dev.parent = &serio->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(ptsc->dev, ABS_X, 0, 0x3ff, 0, 0);
+	input_set_abs_params(ptsc->dev, ABS_Y, 0, 0x3ff, 0, 0);
+	input_set_abs_params(ptsc->dev, ABS_PRESSURE, 0, 0, 0, 0);
+	serio_set_drvdata(serio, ptsc);
+
+	ret = serio_open(serio, drv);
+	if (ret)
+		goto fail2;
+
+	ret = input_register_device(ptsc->dev);
+	if (ret)
+		goto fail3;
+
+	return 0;
+fail3:
+	serio_close(serio);
+fail2:
+	serio_set_drvdata(serio, NULL);
+fail1:
+	input_free_device(input_dev);
+	kfree(ptsc);
+	return ret;
+}
+
+static void tsc_disconnect(struct serio *serio)
+{
+	struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+	serio_close(serio);
+	input_unregister_device(ptsc->dev);
+	kfree(ptsc);
+	serio_set_drvdata(serio, NULL);
+}
+
+static struct serio_device_id tsc_serio_ids[] = {
+	{
+		.type   = SERIO_RS232,
+		.proto  = SERIO_TSC40,
+		.id     = SERIO_ANY,
+		.extra  = SERIO_ANY,
+	},
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(serio, tsc_serio_ids);
+
+#define DRIVER_DESC    "TSC-10/25/40 serial touchscreen driver"
+
+static struct serio_driver tsc_drv = {
+	.driver	= {
+		.name   = "tsc40",
+	},
+	.description    = DRIVER_DESC,
+	.id_table	= tsc_serio_ids,
+	.interrupt      = tsc_interrupt,
+	.connect	= tsc_connect,
+	.disconnect     = tsc_disconnect,
+};
+
+static int __init tsc_ser_init(void)
+{
+	return serio_register_driver(&tsc_drv);
+}
+module_init(tsc_ser_init);
+
+static void __exit tsc_exit(void)
+{
+	serio_unregister_driver(&tsc_drv);
+}
+module_exit(tsc_exit);
+
+MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPLv2");
diff --git a/include/linux/serio.h b/include/linux/serio.h
index e26f478..5c0aa61 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -199,5 +199,6 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_DYNAPRO	0x3a
 #define SERIO_HAMPSHIRE	0x3b
 #define SERIO_PS2MULT	0x3c
+#define SERIO_TSC40 	0x3d

 #endif
-- 
1.7.4.1
