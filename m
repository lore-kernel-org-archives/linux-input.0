From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] goldfish: virtual input event driver
Date: Mon, 21 Jan 2013 23:45:58 +0000
Message-ID: <20130121234543.19969.61394.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33150 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3AUXZg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 18:25:36 -0500
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id r0M08u8k012968
	for <linux-input@vger.kernel.org>; Tue, 22 Jan 2013 00:09:03 GMT
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Brian Swetland <swetland@google.com>

This device is a direct pipe from "hardware" to the input
event subsystem, allowing us to avoid having to route
"keypad" style events through an AT keyboard driver (gross!)

As with the other submissions this driver is cross architecture.

Signed-off-by: Mike A. Chan <mikechan@google.com>
[Tided up to work on x86]
Signed-off-by: Sheng Yang <sheng@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
[Ported to 3.4]
Signed-off-by: Tom Keel <thomas.keel@intel.com>
[Cleaned up for 3.7 and submission]
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/keyboard/Kconfig           |   10 ++
 drivers/input/keyboard/Makefile          |    1 
 drivers/input/keyboard/goldfish_events.c |  187 ++++++++++++++++++++++++++++++
 drivers/tty/goldfish.c                   |   19 +--
 4 files changed, 205 insertions(+), 12 deletions(-)
 create mode 100644 drivers/input/keyboard/goldfish_events.c


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 008f96a..07f7bb2 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -482,6 +482,16 @@ config KEYBOARD_SAMSUNG
 	  To compile this driver as a module, choose M here: the
 	  module will be called samsung-keypad.
 
+config KEYBOARD_GOLDFISH_EVENTS
+	depends on GOLDFISH
+	tristate "Generic Input Event device for Goldfish"
+	help
+	  Say Y here to get an input event device for the Goldfish virtual
+	  device emulator.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goldfish-events.
+
 if TTY
 
 config KEYBOARD_STOWAWAY
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 44e7600..49b1645 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
+obj-$(CONFIG_KEYBOARD_GOLDFISH_EVENTS)	+= goldfish_events.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
 obj-$(CONFIG_KEYBOARD_GPIO_POLLED)	+= gpio_keys_polled.o
 obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
new file mode 100644
index 0000000..8b1f0cd
--- /dev/null
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (C) 2012 Intel, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+enum {
+	REG_READ        = 0x00,
+	REG_SET_PAGE    = 0x00,
+	REG_LEN         = 0x04,
+	REG_DATA        = 0x08,
+
+	PAGE_NAME       = 0x00000,
+	PAGE_EVBITS     = 0x10000,
+	PAGE_ABSDATA    = 0x20000 | EV_ABS,
+};
+
+struct event_dev {
+	struct input_dev *input;
+	int irq;
+	void __iomem *addr;
+	char name[0];
+};
+
+static irqreturn_t events_interrupt(int irq, void *dev_id)
+{
+	struct event_dev *edev = dev_id;
+	unsigned type, code, value;
+
+	type = __raw_readl(edev->addr + REG_READ);
+	code = __raw_readl(edev->addr + REG_READ);
+	value = __raw_readl(edev->addr + REG_READ);
+
+	input_event(edev->input, type, code, value);
+	if (type == EV_KEY)
+		input_sync(edev->input);
+	return IRQ_HANDLED;
+}
+
+static void events_import_bits(struct event_dev *edev,
+			unsigned long bits[], unsigned type, size_t count)
+{
+	int i, j;
+	size_t size;
+	uint8_t val;
+	void __iomem *addr = edev->addr;
+	__raw_writel(PAGE_EVBITS | type, addr + REG_SET_PAGE);
+	size = __raw_readl(addr + REG_LEN) * 8;
+	if (size < count)
+		count = size;
+	addr = addr + REG_DATA;
+	for (i = 0; i < count; i += 8) {
+		val = __raw_readb(addr++);
+		for (j = 0; j < 8; j++)
+			if (val & 1 << j)
+				set_bit(i + j, bits);
+	}
+}
+
+static int events_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	struct event_dev *edev = NULL;
+	struct resource *res;
+	unsigned keymapnamelen;
+	int i;
+	int count;
+	int irq;
+	void __iomem *addr;
+	int ret;
+
+	input_dev = input_allocate_device();
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!input_dev || !res)
+		goto fail;
+
+	addr = devm_ioremap(&pdev->dev, res->start, 4096);
+	irq = platform_get_irq(pdev, 0);
+
+	if (!addr || irq < 0)
+		goto fail;
+
+	__raw_writel(PAGE_NAME, addr + REG_SET_PAGE);
+	keymapnamelen = __raw_readl(addr + REG_LEN);
+
+	edev = devm_kzalloc(&pdev->dev, sizeof(struct event_dev) + keymapnamelen + 1,
+								GFP_KERNEL);
+	if (!edev)
+		goto fail;
+
+	edev->input = input_dev;
+	edev->addr = addr;
+	edev->irq = irq;
+
+	for (i = 0; i < keymapnamelen; i++)
+		edev->name[i] = __raw_readb(edev->addr + REG_DATA + i);
+
+	pr_debug("events_probe() keymap=%s\n", edev->name);
+
+	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
+	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
+	events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
+	events_import_bits(edev, input_dev->absbit, EV_ABS, ABS_MAX);
+	events_import_bits(edev, input_dev->mscbit, EV_MSC, MSC_MAX);
+	events_import_bits(edev, input_dev->ledbit, EV_LED, LED_MAX);
+	events_import_bits(edev, input_dev->sndbit, EV_SND, SND_MAX);
+	events_import_bits(edev, input_dev->ffbit, EV_FF, FF_MAX);
+	events_import_bits(edev, input_dev->swbit, EV_SW, SW_MAX);
+
+	__raw_writel(PAGE_ABSDATA, addr + REG_SET_PAGE);
+	count = __raw_readl(addr + REG_LEN) / (4 * 4);
+	if (count > ABS_MAX)
+		count = ABS_MAX;
+	for (i = 0; i < count; i++) {
+		int val[4];
+		int j;
+		if (!test_bit(i, input_dev->absbit))
+			continue;
+		for (j = 0; j < ARRAY_SIZE(val); j++)
+			val[j] = __raw_readl(edev->addr + REG_DATA + (i * ARRAY_SIZE(val) + j) * 4);
+		input_set_abs_params(input_dev, i, val[0], val[1],
+							val[2], val[3]);
+	}
+
+	platform_set_drvdata(pdev, edev);
+
+	input_dev->name = edev->name;
+	input_set_drvdata(input_dev, edev);
+
+	ret = input_register_device(input_dev);
+	if (ret)
+		goto fail;
+
+	if (devm_request_irq(&pdev->dev, edev->irq, events_interrupt, 0,
+				"goldfish-events-keypad", edev) < 0) {
+		input_unregister_device(input_dev);
+		return -EINVAL;
+	}
+
+	return 0;
+
+fail:
+	input_free_device(input_dev);
+	return -EINVAL;
+}
+
+static int events_remove(struct platform_device *pdev)
+{
+	struct event_dev *edev = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = edev->input;
+	input_unregister_device(input_dev);
+	return 0;
+}
+
+static struct platform_driver events_driver = {
+	.probe = events_probe,
+	.remove = events_remove,
+	.driver = {
+		.name = "goldfish_events",
+	},
+};
+
+module_platform_driver(events_driver);
+
+MODULE_AUTHOR("Brian Swetland");
+MODULE_DESCRIPTION("Goldfish Event Device");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index e2ccb6d..f17d2e4 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -72,23 +72,18 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	unsigned long irq_flags;
 	unsigned char *buf;
 	u32 count;
-	struct tty_struct *tty;
 
 	count = readl(base + GOLDFISH_TTY_BYTES_READY);
 	if(count == 0)
 		return IRQ_NONE;
 
-	tty = tty_port_tty_get(&qtty->port);
-	if (tty) {
-		count = tty_prepare_flip_string(tty, &buf, count);
-		spin_lock_irqsave(&qtty->lock, irq_flags);
-		writel((u32)buf, base + GOLDFISH_TTY_DATA_PTR);
-		writel(count, base + GOLDFISH_TTY_DATA_LEN);
-		writel(GOLDFISH_TTY_CMD_READ_BUFFER, base + GOLDFISH_TTY_CMD);
-		spin_unlock_irqrestore(&qtty->lock, irq_flags);
-		tty_schedule_flip(tty);
-		tty_kref_put(tty);
-	}
+	count = tty_prepare_flip_string(&qtty->port, &buf, count);
+	spin_lock_irqsave(&qtty->lock, irq_flags);
+	writel((u32)buf, base + GOLDFISH_TTY_DATA_PTR);
+	writel(count, base + GOLDFISH_TTY_DATA_LEN);
+	writel(GOLDFISH_TTY_CMD_READ_BUFFER, base + GOLDFISH_TTY_CMD);
+	spin_unlock_irqrestore(&qtty->lock, irq_flags);
+	tty_schedule_flip(&qtty->port);
 	return IRQ_HANDLED;
 }
 

