From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: Add a driver TSC-40 (serial)
Date: Tue, 27 Sep 2011 21:44:30 -0700
Message-ID: <20110928044430.GA28341@core.coreip.homeip.net>
References: <CAH9NwWetEaxzNihxRduvnWN0ADfJKADALmyeUVZnxr5cz-eU2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64103 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1I1Eoi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Sep 2011 00:44:38 -0400
Received: by ywb5 with SMTP id 5so6047953ywb.19
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2011 21:44:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH9NwWetEaxzNihxRduvnWN0ADfJKADALmyeUVZnxr5cz-eU2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Christian,

On Tue, Sep 27, 2011 at 09:30:10AM +0200, Christian Gmeiner wrote:
> From e90718a2fa33442c3897185653cbf5fd9a9d7bfe Mon Sep 17 00:00:00 2001
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Tue, 27 Sep 2011 11:22:25 +0200
> Subject: [PATCH v3] input: Add a driver TSC-40 (serial)
> 
> This patch adds the TSC-40 serial touchscreen driver and
> should be compatible with TSC-10 and TSC-25.
> 
> The driver was written by Linutronix on behalf of
> Bachmann electronic GmbH.
> 

Looking at the data sheet you mentioned it looks like it should be
possible to perform some validation of the data stream coming from the
device. Could you please tell me if the version below still works for
you?

Thanks.

-- 
Dmitry

Input: add a driver for TSC-40 serial touchscreen

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch adds the TSC-40 serial touchscreen driver and should be
compatible with TSC-10 and TSC-25.

The driver was written by Linutronix on behalf of Bachmann electronic GmbH.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig  |   12 ++
 drivers/input/touchscreen/Makefile |    1 
 drivers/input/touchscreen/tsc40.c  |  180 ++++++++++++++++++++++++++++++++++++
 include/linux/serio.h              |    1 
 4 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc40.c


diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index c27b28e..11a67e3 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -712,6 +712,18 @@ config TOUCHSCREEN_TOUCHIT213
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchit213.
 
+config TOUCHSCREEN_TSC_SERIO
+	tristate "TSC-10/25/40 serial touchscreen support"
+	select SERIO
+	help
+	  Say Y here if you have a TSC-10, 25 or 40 serial touchscreen connected
+	  to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc40.
+
 config TOUCHSCREEN_TSC2005
         tristate "TSC2005 based touchscreens"
         depends on SPI_MASTER && GENERIC_HARDIRQS
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index f2a1f0b..d697e16 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
+obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
diff --git a/drivers/input/touchscreen/tsc40.c b/drivers/input/touchscreen/tsc40.c
new file mode 100644
index 0000000..1a7b357
--- /dev/null
+++ b/drivers/input/touchscreen/tsc40.c
@@ -0,0 +1,180 @@
+/*
+ * TSC-40 serial touchscreen driver. It should be compatible with TSC-10 and 25.
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
+
+	x = ((data[1] & 0x03) << 8) | data[2];
+	y = ((data[3] & 0x03) << 8) | data[4];
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_key(dev, BTN_TOUCH, 1);
+
+	input_sync(dev);
+}
+
+static irqreturn_t tsc_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct tsc_ser *ptsc = serio_get_drvdata(serio);
+	struct input_dev *dev = ptsc->dev;
+
+	ptsc->data[ptsc->idx] = data;
+	switch (ptsc->idx++) {
+	case 0:
+		if (unlikely((data & 0x3e) != 0x10)) {
+			dev_dbg(&serio->dev,
+				"unsynchronized packet start (0x%02x)\n", data);
+			ptsc->idx = 0;
+		} else if (!(data & 0x01)) {
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_sync(dev);
+			ptsc->idx = 0;
+		}
+		break;
+
+	case 1:
+	case 3:
+		if (unlikely(data & 0xfc)) {
+			dev_dbg(&serio->dev,
+				"unsynchronized data 0x%02x at offset %d\n",
+				data, ptsc->idx - 1);
+			ptsc->idx = 0;
+		}
+		break;
+
+	case 4:
+		tsc_process_data(ptsc);
+		ptsc->idx = 0;
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int tsc_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct tsc_ser *ptsc;
+	struct input_dev *input_dev;
+	int error;
+
+	ptsc = kzalloc(sizeof(struct tsc_ser), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ptsc || !input_dev) {
+		error = -ENOMEM;
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
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	input_set_abs_params(ptsc->dev, ABS_X, 0, 0x3ff, 0, 0);
+	input_set_abs_params(ptsc->dev, ABS_Y, 0, 0x3ff, 0, 0);
+	input_set_abs_params(ptsc->dev, ABS_PRESSURE, 0, 0, 0, 0);
+	serio_set_drvdata(serio, ptsc);
+
+	error = serio_open(serio, drv);
+	if (error)
+		goto fail2;
+
+	error = input_register_device(ptsc->dev);
+	if (error)
+		goto fail3;
+
+	return 0;
+
+fail3:
+	serio_close(serio);
+fail2:
+	serio_set_drvdata(serio, NULL);
+fail1:
+	input_free_device(input_dev);
+	kfree(ptsc);
+	return error;
+}
+
+static void tsc_disconnect(struct serio *serio)
+{
+	struct tsc_ser *ptsc = serio_get_drvdata(serio);
+
+	serio_close(serio);
+
+	input_unregister_device(ptsc->dev);
+	kfree(ptsc);
+
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
index e26f478..be7dfb0 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -199,5 +199,6 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_DYNAPRO	0x3a
 #define SERIO_HAMPSHIRE	0x3b
 #define SERIO_PS2MULT	0x3c
+#define SERIO_TSC40	0x3d
 
 #endif
