From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [RFC PATCH 1/2] Input: add Uniwest EVI front panel driver
Date: Fri, 24 Jul 2015 10:43:20 -0700
Message-ID: <1437759801-24622-1-git-send-email-stillcompiling@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36171 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbGXRnn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 13:43:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, Nishanth Menon <nm@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Joshua Clayton <stillcompiling@gmail.com>

This is my first input driver, and my first attempt to istart the process of
upstreaming something, (other than a small patch). 
I apologize in advance :)

The Uniwest EVI front panel has 9 usable buttons
which correspond to keyboard keys, as well as
horizontal and verical slidersr,
(the sliders are like touch based scroll bars)
and 9 indicator LEDs

This initial version of the driver just supports the buttons.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/input/misc/Kconfig     |  10 ++
 drivers/input/misc/Makefile    |   1 +
 drivers/input/misc/evifpanel.c | 265 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/input/misc/evifpanel.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 23297ab..87ce0e6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -222,6 +222,16 @@ config INPUT_APANEL
 	 To compile this driver as a module, choose M here: the module will
 	 be called apanel.
 
+config INPUT_EVIFPANEL
+	tristate "Uniwest EVI Front panel"
+	select SERIO
+	help
+	  Say Y if you have a Uniwest EVI and want to enable the
+	  sliders and buttons on the front.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called evifpanel.
+
 config INPUT_GP2A
 	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
 	depends on I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 19c7603..5764467 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
 obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
+obj-$(CONFIG_INPUT_EVIFPANEL)		+= evifpanel.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
diff --git a/drivers/input/misc/evifpanel.c b/drivers/input/misc/evifpanel.c
new file mode 100644
index 0000000..aa28e6c
--- /dev/null
+++ b/drivers/input/misc/evifpanel.c
@@ -0,0 +1,265 @@
+/*
+ * Uniwest EVI Front Panel driver
+ *
+ * Copyright 2015 United Western Technologies
+ *
+ * Joshua Clayton <stillcompiling@gmail.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ */
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+
+#define DRIVER_DESC "Uniwest EVI Frontpanel input driver"
+MODULE_AUTHOR("Joshua Clayton <stillcompiling@gmail.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+struct evifpanel {
+	struct input_dev *dev;
+	struct serio *serio;
+	unsigned int bytes;
+	char name[64];
+	char phys[32];
+	unsigned char buf[8];
+};
+
+struct key_map {
+	u16 type;
+	u16 code;
+	s32 value;
+	unsigned int byte;
+	unsigned int offset;
+};
+
+static struct key_map btns[] = {
+	{ EV_KEY, KEY_F1, 1, 6, 0 },
+	{ EV_KEY, KEY_D, 1, 6, 1 },
+	{ EV_KEY, KEY_N, 1, 7, 0 },
+	{ EV_KEY, KEY_BACKSPACE, 1, 7, 1 },
+	{ EV_KEY, KEY_ENTER, 1, 7, 2 },
+	{ EV_KEY, KEY_ESC, 1, 7, 3 },
+	{ EV_KEY, KEY_F4, 1, 7, 4 },
+	{ EV_KEY, KEY_F3, 1, 7, 5 },
+	{ EV_KEY, KEY_F2, 1, 7, 6 },
+	{ },
+};
+
+static void fp_check_key(struct evifpanel *fp, struct key_map *key)
+{
+	s32 value = fp->buf[key->byte] & BIT(key->offset);
+
+	input_report_key(fp->dev, key->code, value);
+}
+
+/*
+ * Check buttons against array of key_map
+ */
+static void fp_check_btns(struct evifpanel *fp, struct key_map *key)
+{
+	while (key->type) {
+		switch (key->type) {
+		case EV_KEY:
+			fp_check_key(fp, key);
+			break;
+		default:
+			break; /* ignore unknown types */
+		}
+		key++;
+	}
+
+	input_sync(fp->dev);
+}
+
+/*
+ * Set the firmware version coming from the fp in an ascii file
+ */
+static void fp_set_fw_ver(struct evifpanel *fp)
+{
+	scnprintf(fp->serio->firmware_id, sizeof(fp->serio->firmware_id),
+			"evifpanel v%3.3u.%3.3u.%3.3u.%3.3u", fp->buf[4],
+			fp->buf[5], fp->buf[6], fp->buf[7]);
+
+	dev_info(&fp->serio->dev, "firmware found: %s\n",
+			fp->serio->firmware_id);
+}
+
+/*
+ * Request firmware version info from the device
+ */
+static void fp_request_fw_ver(struct evifpanel *fp)
+{
+	serio_write(fp->serio, '\xC0');
+	serio_write(fp->serio, '\x00');
+	serio_write(fp->serio, '\x00');
+	serio_write(fp->serio, '\x09');
+	serio_write(fp->serio, '\x00');
+	serio_write(fp->serio, '\x01');
+	serio_write(fp->serio, '\x00');
+	serio_write(fp->serio, '\x00');
+}
+
+/*
+ * Send zero or more input events based on the state of the fp
+ * Call this when you have a full packet.
+ */
+static int fp_parse_buf(struct evifpanel *fp)
+{
+	switch (fp->buf[1]) {
+	case '\x03':
+		fp_check_btns(fp, btns);
+		break;
+	case '\x09':
+		if (fp->buf[4] || fp->buf[5])
+			fp_set_fw_ver(fp);
+		break;
+	default:
+		dev_err(&fp->dev->dev, "Bad cmd id %X in sequence %llX\n",
+				fp->buf[1], *(u64 *)(fp->buf));
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void fp_add_byte(struct evifpanel *fp, unsigned char c)
+{
+	if (c != '\xC0' && !fp->bytes) {
+		dev_err(&fp->dev->dev, "drop %X. looking for check byte\n", c);
+		return;
+	}
+
+	if (c == '\xC0' && fp->bytes) {
+		/* msg check byte should not be found in the middle of a set */
+		dev_warn(&fp->dev->dev, "discarding %d bytes from %llX\n",
+			 fp->bytes, *(u64 *)(fp->buf));
+		fp->bytes = 0;
+	}
+
+	fp->buf[fp->bytes] = c;
+	++fp->bytes;
+}
+
+
+static irqreturn_t fp_interrupt(struct serio *serio, unsigned char data,
+		unsigned int flags)
+{
+	struct evifpanel *fp = serio_get_drvdata(serio);
+
+	fp_add_byte(fp, data);
+	if (fp->bytes == 8) {
+		fp_parse_buf(fp);
+		fp->bytes = 0;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fp_set_device_attrs(struct evifpanel *fp)
+{
+	snprintf(fp->name, sizeof(fp->name),
+			"EVI Frontpanel keypad and sliders");
+	snprintf(fp->phys, sizeof(fp->phys),
+			"%s/input0", fp->serio->phys);
+
+	fp->dev->name = fp->name;
+	fp->dev->phys = fp->phys;
+	fp->dev->id.bustype = BUS_RS232;
+	fp->dev->dev.parent = &fp->serio->dev;
+
+	fp->dev->evbit[0] = BIT_MASK(EV_KEY);
+	__set_bit(KEY_D, fp->dev->keybit);
+	__set_bit(KEY_N, fp->dev->keybit);
+	__set_bit(KEY_BACKSPACE, fp->dev->keybit);
+	__set_bit(KEY_ENTER, fp->dev->keybit);
+	__set_bit(KEY_F1, fp->dev->keybit);
+	__set_bit(KEY_F2, fp->dev->keybit);
+	__set_bit(KEY_F3, fp->dev->keybit);
+	__set_bit(KEY_F4, fp->dev->keybit);
+	__set_bit(KEY_ESC, fp->dev->keybit);
+}
+
+static int fp_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct evifpanel *fp;
+	struct input_dev *input_dev;
+	int error = -ENOMEM;
+
+	fp = kzalloc(sizeof(struct evifpanel), GFP_KERNEL);
+
+	input_dev = input_allocate_device();
+	if (!input_dev || !fp) {
+		pr_err("evifpanel: failed to get memory\n");
+		goto fail1;
+	}
+
+	fp->dev = input_dev;
+	fp->serio = serio;
+	fp_set_device_attrs(fp);
+	serio_set_drvdata(serio, fp);
+
+	error = serio_open(serio, drv);
+	if (error) {
+		pr_err("evifpanel: failed to open serio\n");
+		goto fail2;
+	}
+	fp_request_fw_ver(fp);
+
+	error = input_register_device(input_dev);
+	if (error) {
+		pr_err("evifpanel: failed to register input device\n");
+		goto fail3;
+	}
+
+	return 0;
+
+fail3:
+	serio_close(serio);
+fail2:
+	serio_set_drvdata(serio, NULL);
+fail1:
+	input_free_device(input_dev);
+	kfree(fp);
+	pr_err("fp_connect: FAILED\n");
+
+	return error;
+}
+
+static void fp_disconnect(struct serio *serio)
+{
+	struct evifpanel *fp = serio_get_drvdata(serio);
+
+	input_unregister_device(fp->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	kfree(fp);
+};
+
+static struct serio_device_id fp_ids[] = {
+	{
+		.type  = SERIO_RS232,
+		.proto = SERIO_ANY,
+		.id    = SERIO_ANY,
+		.extra = SERIO_ANY,
+	},
+	{ 0 }
+};
+
+static struct serio_driver fp_drv = {
+	.driver = {
+		.name = "evifpanel",
+	},
+	.description = DRIVER_DESC,
+	.id_table    = fp_ids,
+	.connect     = fp_connect,
+	.interrupt   = fp_interrupt,
+	.disconnect  = fp_disconnect,
+};
+
+module_serio_driver(fp_drv);
-- 
2.1.4

