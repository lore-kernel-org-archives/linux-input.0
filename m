From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Mon,  8 Jun 2015 14:43:08 -0700
Message-ID: <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35769 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbFHVn0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 17:43:26 -0400
In-Reply-To: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This change creates a new input handler called "leds" that exports LEDs on input
devices as standard LED class devices in sysfs and allows controlling their
ptate via sysfs or via any of the standard LED triggers. This allows to
re-purpose and reassign LDEs on the keyboards to represent states other
than the standard keyboard states (CapsLock, NumLock, etc).

The old API of controlling input LEDs by writing into /dev/input/eventX
devices is still present and will take precedence over acessing via LEDs
subsystem (i.e. it may override state set by a trigger). If input device is
"grabbed" then requests coming through LED subsystem will be ignored.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/leds/leds-class.txt |   3 -
 drivers/input/Kconfig             |  13 +++
 drivers/input/Makefile            |   1 +
 drivers/input/input-leds.c        | 210 ++++++++++++++++++++++++++++++++++++++
 drivers/leds/Kconfig              |   3 -
 5 files changed, 224 insertions(+), 6 deletions(-)
 create mode 100644 drivers/input/input-leds.c

diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
index 79699c2..62261c0 100644
--- a/Documentation/leds/leds-class.txt
+++ b/Documentation/leds/leds-class.txt
@@ -2,9 +2,6 @@
 LED handling under Linux
 ========================
 
-If you're reading this and thinking about keyboard leds, these are
-handled by the input subsystem and the led class is *not* needed.
-
 In its simplest form, the LED class just allows control of LEDs from
 userspace. LEDs appear in /sys/class/leds/. The maximum brightness of the
 LED is defined in max_brightness file. The brightness file will set the brightness
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index a11ff74..a35532e 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -25,6 +25,19 @@ config INPUT
 
 if INPUT
 
+config INPUT_LEDS
+	tristate "Export input device LEDs in sysfs"
+	depends on LEDS_CLASS
+	default INPUT
+	help
+	  Say Y here if you would like to export LEDs on input devices
+	  as standard LED class devices in sysfs.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called input-leds.
+
 config INPUT_FF_MEMLESS
 	tristate "Support for memoryless force-feedback devices"
 	help
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 5ca3f63..0c9302c 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_INPUT_POLLDEV)	+= input-polldev.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
 obj-$(CONFIG_INPUT_MATRIXKMAP)	+= matrix-keymap.o
 
+obj-$(CONFIG_INPUT_LEDS)	+= input-leds.o
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
 obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
new file mode 100644
index 0000000..029a004
--- /dev/null
+++ b/drivers/input/input-leds.c
@@ -0,0 +1,210 @@
+/*
+ * LED support for the input layer
+ *
+ * Copyright 2010-2015 Samuel Thibault <samuel.thibault@ens-lyon.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/input.h>
+
+#if IS_ENABLED(CONFIG_VT)
+#define VT_TRIGGER(_name)	.trigger = _name
+#else
+#define VT_TRIGGER(_name)	.trigger = NULL
+#endif
+
+static const struct {
+	const char *name;
+	const char *trigger;
+} input_led_info[LED_CNT] = {
+	[LED_NUML]	= { "num-lock", VT_TRIGGER("kbd-numlock") },
+	[LED_CAPSL]	= { "caps-lock", VT_TRIGGER("kbd-capslock") },
+	[LED_SCROLLL]	= { "scroll-lock", VT_TRIGGER("kbd-scrollock") },
+	[LED_COMPOSE]	= { "compose" },
+	[LED_KANA]	= { "kana", VT_TRIGGER("kbd-kanalock") },
+	[LED_SLEEP]	= { "sleep" } ,
+	[LED_SUSPEND]	= { "suspend" },
+	[LED_MUTE]	= { "mute" },
+	[LED_MISC]	= { "misc" },
+	[LED_MAIL]	= { "mail" },
+	[LED_CHARGING]	= { "charging" },
+};
+
+struct input_led {
+	struct led_classdev cdev;
+	struct input_handle *handle;
+	unsigned int code; /* One of LED_* constants */
+};
+
+struct input_leds {
+	struct input_handle handle;
+	unsigned int num_leds;
+	struct input_led leds[];
+};
+
+static enum led_brightness input_leds_brightness_get(struct led_classdev *cdev)
+{
+	struct input_led *led = container_of(cdev, struct input_led, cdev);
+	struct input_dev *input = led->handle->dev;
+
+	return test_bit(led->code, input->ledbit) ? LED_FULL : LED_OFF;
+}
+
+static void input_leds_brightness_set(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct input_led *led = container_of(cdev, struct input_led, cdev);
+
+	input_inject_event(led->handle, EV_LED, led->code, !!brightness);
+}
+
+static void input_leds_event(struct input_handle *handle, unsigned int type,
+			     unsigned int code, int value)
+{
+}
+
+static int input_leds_connect(struct input_handler *handler,
+			      struct input_dev *dev,
+			      const struct input_device_id *id)
+{
+	struct input_leds *leds;
+	unsigned int num_leds;
+	int led_no = 0;
+	int led_code;
+	int error;
+
+	num_leds = bitmap_weight(dev->ledbit, LED_CNT);
+	if (!num_leds)
+		return -ENXIO;
+
+	leds = kzalloc(sizeof(*leds) + num_leds * sizeof(*leds->leds),
+		       GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	leds->num_leds = num_leds;
+
+	leds->handle.dev = dev;
+	leds->handle.handler = handler;
+	leds->handle.name = "leds";
+	leds->handle.private = leds;
+
+	error = input_register_handle(&leds->handle);
+	if (error)
+		goto err_free_mem;
+
+	error = input_open_device(&leds->handle);
+	if (error)
+		goto err_unregister_handle;
+
+	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
+		struct input_led *led = &leds->leds[led_no];
+
+		led->handle = &leds->handle;
+		led->code = led_code;
+
+		if (WARN_ON(!input_led_info[led_code].name))
+			continue;
+
+		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
+					   dev_name(&dev->dev),
+					   input_led_info[led_code].name);
+		if (!led->cdev.name) {
+			error = -ENOMEM;
+			goto err_unregister_leds;
+		}
+
+		led->cdev.brightness_get = input_leds_brightness_get;
+		led->cdev.brightness_set = input_leds_brightness_set;
+		led->cdev.default_trigger = input_led_info[led_code].trigger;
+
+		error = led_classdev_register(&dev->dev, &led->cdev);
+		if (error) {
+			dev_err(&dev->dev, "failed to register LED %s: %d\n",
+				led->cdev.name, error);
+			kfree(led->cdev.name);
+			goto err_unregister_leds;
+		}
+
+		led_no++;
+	}
+
+	return 0;
+
+err_unregister_leds:
+	while (--led_no >= 0) {
+		struct input_led *led = &leds->leds[led_no];
+
+		led_classdev_unregister(&led->cdev);
+		kfree(led->cdev.name);
+	}
+
+	input_close_device(&leds->handle);
+
+err_unregister_handle:
+	input_unregister_handle(&leds->handle);
+
+err_free_mem:
+	kfree(leds);
+	return error;
+}
+
+static void input_leds_disconnect(struct input_handle *handle)
+{
+	struct input_leds *leds = handle->private;
+	int i;
+
+	for (i = 0; i < leds->num_leds; i++) {
+		struct input_led *led = &leds->leds[i];
+
+		led_classdev_unregister(&led->cdev);
+		kfree(led->cdev.name);
+	}
+
+	input_close_device(handle);
+	input_unregister_handle(handle);
+
+	kfree(leds);
+}
+
+static const struct input_device_id input_leds_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_LED) },
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(input, input_leds_ids);
+
+static struct input_handler input_leds_handler = {
+	.event =	input_leds_event,
+	.connect =	input_leds_connect,
+	.disconnect =	input_leds_disconnect,
+	.name =		"leds",
+	.id_table =	input_leds_ids,
+};
+
+static int __init input_leds_init(void)
+{
+	return input_register_handler(&input_leds_handler);
+}
+module_init(input_leds_init);
+
+static void __exit input_leds_exit(void)
+{
+	input_unregister_handler(&input_leds_handler);
+}
+module_exit(input_leds_exit);
+
+MODULE_AUTHOR("Samuel Thibault <samuel.thibault@ens-lyon.org>");
+MODULE_AUTHOR("Dmitry Torokhov <dmitry.torokhov@gmail.com>");
+MODULE_DESCRIPTION("Input -> LEDs Bridge");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 966b960..4191614 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -11,9 +11,6 @@ menuconfig NEW_LEDS
 	  Say Y to enable Linux LED support.  This allows control of supported
 	  LEDs from both userspace and optionally, by kernel events (triggers).
 
-	  This is not related to standard keyboard LEDs which are controlled
-	  via the input system.
-
 if NEW_LEDS
 
 config LEDS_CLASS
-- 
2.2.0.rc0.207.ga3a616c

