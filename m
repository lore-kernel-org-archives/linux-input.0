From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH RFC] Add support for the matrix keyboard used in Bachmann's OT200
Date: Wed, 12 Dec 2012 14:35:41 +0100
Message-ID: <1355319341-26597-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:32922 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2LLNSa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Dec 2012 08:18:30 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so435889eek.19
        for <linux-input@vger.kernel.org>; Wed, 12 Dec 2012 05:18:29 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>

The used matrix keyboard controler (implemented via FPGA) supports
two simultaneous key presses. The driver sends the raw register
values for each key (row & column) to userspace.

In userspace a small tool is running, which reads a 'mapping'
file, processes the key events and send the configured keycodes
back to the kernel via uinput.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/input/keyboard/Kconfig        |   8 ++
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/ot200_keypad.c | 177 ++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/input/keyboard/ot200_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index de08740..56b5e37 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -468,6 +468,14 @@ config KEYBOARD_PMIC8XXX
 	  To compile this driver as a module, choose M here: the module will
 	  be called pmic8xxx-keypad.
 
+config KEYBOARD_OT200
+	tristate "OT200 Matrix Keypad support"
+	help
+	  Say Y here to enable the matrix keypad on Bachmann's OT200.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called ot200-keypad.
+	  
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
 	depends on HAVE_CLK
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 44e7600..3972737 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PMIC8XXX)		+= pmic8xxx-keypad.o
+obj-$(CONFIG_KEYBOARD_OT200)		+= ot200_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
diff --git a/drivers/input/keyboard/ot200_keypad.c b/drivers/input/keyboard/ot200_keypad.c
new file mode 100644
index 0000000..db9a147
--- /dev/null
+++ b/drivers/input/keyboard/ot200_keypad.c
@@ -0,0 +1,177 @@
+/*
+ * Bachmann ot200 matrix keypad driver.
+ *
+ * Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ *         Christian Gmeiner <christian.gmeiner@gmail.com>
+ *
+ * License: GPL as published by the FSF.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/input/matrix_keypad.h>
+
+#define KBC_INT_FLAG	0x4a
+#define KBC_INT_STATUS	0x4b
+#define KBC_FLAG_INT	(1 << 0)
+
+/* the custom FPGA can track max two different key presses */
+#define KBC_REG_1		0x50	/* register for first key */
+#define KBC_REG_2		0x51	/* register for second key */
+
+struct ot200_key {
+	struct input_dev *input_dev;
+	u8 last;
+};
+
+struct ot200_keypad {
+	struct ot200_key key1;
+	struct ot200_key key2;
+};
+
+static void ot200_keypad_scan_matrix(struct ot200_key *keypad, u32 key_val)
+{
+	struct input_dev *input_dev = keypad->input_dev;
+
+	input_event(input_dev, EV_MSC, MSC_SCAN, key_val);
+	input_sync(input_dev);
+}
+
+static irqreturn_t ot200_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct ot200_keypad *kbcd = dev_id;
+	u8 val_k1, val_k2;
+	u8 flag;
+
+	flag = inb(KBC_INT_FLAG);
+	if (!(flag & KBC_FLAG_INT))
+		return IRQ_NONE;
+
+	val_k1 = inb(KBC_REG_1);
+	val_k2 = inb(KBC_REG_2);
+
+	outb(KBC_FLAG_INT, KBC_INT_FLAG);
+
+	if (val_k1 != kbcd->key1.last) {
+		ot200_keypad_scan_matrix(&kbcd->key1, val_k1);
+		kbcd->key1.last = val_k1;
+	}
+	if (val_k2 != kbcd->key2.last) {
+		ot200_keypad_scan_matrix(&kbcd->key2, val_k2);
+		kbcd->key2.last = val_k2;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit ot200_setup_input(struct ot200_key *keypad,
+		struct platform_device *pdev,
+		const struct matrix_keymap_data *keymap_data)
+{
+	struct input_dev *input_dev;
+	int ret;
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	keypad->input_dev = input_dev;
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+
+	input_set_drvdata(input_dev, keypad);
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	ret = input_register_device(input_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		input_free_device(input_dev);
+	}
+	return ret;
+}
+
+static int __devinit ot200_keypad_probe(struct platform_device *pdev)
+{
+	struct ot200_keypad *kbcd;
+	int irq;
+	int ret;
+
+	kbcd = devm_kzalloc(&pdev->dev, sizeof(struct ot200_keypad), GFP_KERNEL);
+	if (!kbcd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get keypad irq\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = request_irq(irq, ot200_keypad_irq_handler,
+			    IRQF_DISABLED | IRQF_SHARED, pdev->name, kbcd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto out;
+	}
+
+	ret = ot200_setup_input(&kbcd->key1, pdev, NULL);
+	if (ret)
+		goto out;
+
+	ret = ot200_setup_input(&kbcd->key2, pdev, NULL);
+	if (ret)
+		goto err_setup;
+
+	platform_set_drvdata(pdev, kbcd);
+	return 0;
+
+err_setup:
+	input_unregister_device(kbcd->key1.input_dev);
+out:
+	return ret;
+}
+
+static int __devexit ot200_keypad_remove(struct platform_device *pdev)
+{
+	struct ot200_keypad *kbcd = platform_get_drvdata(pdev);
+	unsigned int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	free_irq(irq, pdev);
+
+	input_unregister_device(kbcd->key1.input_dev);
+	input_unregister_device(kbcd->key2.input_dev);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(kbcd);
+	return 0;
+}
+
+static struct platform_driver ot200_keypad_driver = {
+	.probe		= ot200_keypad_probe,
+	.remove		= __devexit_p(ot200_keypad_remove),
+	.driver		= {
+		.name	= "ot200-kpc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(ot200_keypad_driver);
+
+MODULE_AUTHOR("Sebastian A. Siewior <bigeasy@linutronix.de>");
+MODULE_DESCRIPTION("OT200 matrix keypad controler driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ot200-kpc");
-- 
1.7.12.2.421.g261b511

