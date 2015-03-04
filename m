From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] input: driver for microcontroller keys on the iPaq h3xxx
Date: Wed,  4 Mar 2015 13:45:27 +0100
Message-ID: <1425473127-25934-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:41643 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966AbbCDMph (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 07:45:37 -0500
Received: by labgm9 with SMTP id gm9so4548107lab.8
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2015 04:45:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Alessandro GARDICH <gremlin@gremlin.it>, Dmitry Artamonow <mad_soft@inbox.ru>

This adds a key input driver for the keys found on the h3xxx
iPAQ series.

Based on a driver from handhelds.org 2.6.21 kernel, written
by Alessandro GARDICH.

Signed-off-by: Alessandro GARDICH <gremlin@gremlin.it>
Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Improve KConfig help text for module building
- Delete useless <linux/version.h> include
- Don't clamp key up/down to bool, core will handle it
- Staticize keycodes
- Split out open/close operations
- Use devm_input_allocate_device()
- Copy keycodes to state container struct
- Set keycodesize and keycodemax
- Use SIMPLE_DEV_PM_OPS()
---
 drivers/input/keyboard/Kconfig           |  10 ++
 drivers/input/keyboard/Makefile          |   1 +
 drivers/input/keyboard/ipaq-micro-keys.c | 166 +++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/input/keyboard/ipaq-micro-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a89ba7cb96f1..35cf866617d2 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -588,6 +588,16 @@ config KEYBOARD_DAVINCI
 	  To compile this driver as a module, choose M here: the
 	  module will be called davinci_keyscan.
 
+config KEYBOARD_IPAQ_MICRO
+	tristate "Buttons on Micro SoC (iPaq h3100,h3600,h3700)"
+	depends on MFD_IPAQ_MICRO
+	help
+	  Say Y to enable support for the buttons attached to
+	  Micro peripheral controller on iPAQ h3100/h3600/h3700
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ipaq-micro-keys.
+
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
 	depends on ARCH_OMAP1
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 470767884bd8..a171b7119674 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
 obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
+obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
 obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
new file mode 100644
index 000000000000..4226354f25e5
--- /dev/null
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -0,0 +1,166 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * h3600 atmel micro companion support, key subdevice
+ * based on previous kernel 2.4 version
+ * Author : Alessandro Gardich <gremlin@gremlin.it>
+ * Author : Linus Walleij <linus.walleij@linaro.org>
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/pm.h>
+#include <linux/sysctl.h>
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/ipaq-micro.h>
+
+struct ipaq_micro_keys {
+	struct ipaq_micro *micro;
+	struct input_dev *input;
+	u16 *codes;
+};
+
+static const u16 micro_keycodes[] = {
+	KEY_RECORD,		/* 1:  Record button			*/
+	KEY_CALENDAR,		/* 2:  Calendar				*/
+	KEY_ADDRESSBOOK,	/* 3:  Contacts (looks like Outlook)	*/
+	KEY_MAIL,		/* 4:  Envelope (Q on older iPAQs)	*/
+	KEY_HOMEPAGE,		/* 5:  Start (looks like swoopy arrow)	*/
+	KEY_UP,			/* 6:  Up				*/
+	KEY_RIGHT,		/* 7:  Right				*/
+	KEY_LEFT,		/* 8:  Left				*/
+	KEY_DOWN,		/* 9:  Down				*/
+};
+
+static void micro_key_receive(void *data, int len, unsigned char *msg)
+{
+	struct ipaq_micro_keys *keys = data;
+	int key, down;
+
+	down = 0x80 & msg[0];
+	key  = 0x7f & msg[0];
+
+	if (key < ARRAY_SIZE(micro_keycodes)) {
+		input_report_key(keys->input, keys->codes[key], down);
+		input_sync(keys->input);
+	}
+}
+
+static int micro_key_open(struct input_dev *input)
+{
+	struct ipaq_micro_keys *keys = input_get_drvdata(input);
+
+	spin_lock(&keys->micro->lock);
+	keys->micro->key = micro_key_receive;
+	keys->micro->key_data = keys;
+	spin_unlock(&keys->micro->lock);
+
+	return 0;
+}
+
+static void micro_key_close(struct input_dev *input)
+{
+	struct ipaq_micro_keys *keys = input_get_drvdata(input);
+
+	spin_lock(&keys->micro->lock);
+	keys->micro->key = NULL;
+	keys->micro->key_data = NULL;
+	spin_unlock(&keys->micro->lock);
+}
+
+static int micro_key_probe(struct platform_device *pdev)
+{
+	struct ipaq_micro_keys *keys;
+	int ret;
+	int i;
+
+	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
+	if (!keys)
+		return -ENOMEM;
+	keys->input = devm_input_allocate_device(&pdev->dev);
+	if (!keys->input)
+		return -ENOMEM;
+
+	keys->input->keycodesize = sizeof(micro_keycodes[0]);
+	keys->input->keycodemax = ARRAY_SIZE(micro_keycodes);
+	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
+			   keys->input->keycodesize * keys->input->keycodemax,
+			   GFP_KERNEL);
+	keys->input->keycode = keys->codes;
+
+	keys->micro = dev_get_drvdata(pdev->dev.parent);
+	keys->input->evbit[0] = BIT(EV_KEY);
+	set_bit(EV_KEY, keys->input->evbit);
+	for (i = 0; i < ARRAY_SIZE(micro_keycodes); i++) {
+		set_bit(micro_keycodes[i], keys->input->keybit);
+	}
+	keys->input->name = "h3600 micro keys";
+	keys->input->open = micro_key_open;
+	keys->input->close = micro_key_close;
+	input_set_drvdata(keys->input, keys);
+
+	ret = input_register_device(keys->input);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, keys);
+	return 0;
+}
+
+static int micro_key_remove(struct platform_device *pdev)
+{
+	struct ipaq_micro_keys *keys = platform_get_drvdata(pdev);
+
+	input_unregister_device(keys->input);
+
+	return 0;
+}
+
+static int __maybe_unused micro_key_suspend(struct device *dev)
+{
+	struct ipaq_micro_keys *keys = dev_get_drvdata(dev);
+
+	spin_lock(&keys->micro->lock);
+	keys->micro->key = NULL;
+	keys->micro->key_data = NULL;
+	spin_unlock(&keys->micro->lock);
+
+	return 0;
+}
+
+static int __maybe_unused micro_key_resume(struct device *dev)
+{
+	struct ipaq_micro_keys *keys = dev_get_drvdata(dev);
+
+	spin_lock(&keys->micro->lock);
+	keys->micro->key = micro_key_receive;
+	keys->micro->key_data = keys;
+	spin_unlock(&keys->micro->lock);
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(micro_key_dev_pm_ops, micro_key_suspend, micro_key_resume);
+
+struct platform_driver micro_key_device_driver = {
+	.driver = {
+		.name    = "ipaq-micro-keys",
+		.pm	= &micro_key_dev_pm_ops,
+	},
+	.probe   = micro_key_probe,
+	.remove  = micro_key_remove,
+};
+module_platform_driver(micro_key_device_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("driver for iPAQ Atmel micro keys");
+MODULE_ALIAS("platform:ipaq-micro-keys");
-- 
1.9.3

