From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] goldfish: virtual input event driver
Date: Wed, 23 Jan 2013 20:15:47 -0800
Message-ID: <20130124041547.GB7112@core.coreip.homeip.net>
References: <20130123173840.996.9588.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:61870 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab3AXEPu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 23:15:50 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so5166204pbc.0
        for <linux-input@vger.kernel.org>; Wed, 23 Jan 2013 20:15:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130123173840.996.9588.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi Alan,

On Wed, Jan 23, 2013 at 05:38:43PM +0000, Alan Cox wrote:
> From: Brian Swetland <swetland@google.com>
> 
> This device is a direct pipe from "hardware" to the input
> event subsystem, allowing us to avoid having to route
> "keypad" style events through an AT keyboard driver (gross!)
> 
> As with the other submissions this driver is cross architecture.
> 
> Signed-off-by: Mike A. Chan <mikechan@google.com>
> [Tided up to work on x86]
> Signed-off-by: Sheng Yang <sheng@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
> Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
> Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
> Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
> [Ported to 3.4]
> Signed-off-by: Tom Keel <thomas.keel@intel.com>
> [Cleaned up for 3.7 and submission]
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I do not have drivers/tty/goldfish.c so I dropped that change... I also
had a few more cleanups, the result is below.

I know you stepping away for a while so unless I hear from you in a day
or so I will apply the patch as is.

Thanks!

-- 
Dmitry

Input: goldfish - virtual input event driver

From: Brian Swetland <swetland@google.com>

This device is a direct pipe from "hardware" to the input event subsystem,
allowing us to avoid having to route "keypad" style events through an
AT keyboard driver (gross!).

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
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig           |   10 ++
 drivers/input/keyboard/Makefile          |    1 
 drivers/input/keyboard/goldfish_events.c |  194 ++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/input/keyboard/goldfish_events.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 7adfe68..0e72c87 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -488,6 +488,16 @@ config KEYBOARD_SAMSUNG
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
 config KEYBOARD_STOWAWAY
 	tristate "Stowaway keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 4d6c894..b25b243 100644
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
index 0000000..9f60a2e
--- /dev/null
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -0,0 +1,194 @@
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
+	input_sync(edev->input);
+	return IRQ_HANDLED;
+}
+
+static void events_import_bits(struct event_dev *edev,
+			unsigned long bits[], unsigned type, size_t count)
+{
+	void __iomem *addr = edev->addr;
+	int i, j;
+	size_t size;
+	uint8_t val;
+
+	__raw_writel(PAGE_EVBITS | type, addr + REG_SET_PAGE);
+
+	size = __raw_readl(addr + REG_LEN) * 8;
+	if (size < count)
+		count = size;
+
+	addr += REG_DATA;
+	for (i = 0; i < count; i += 8) {
+		val = __raw_readb(addr++);
+		for (j = 0; j < 8; j++)
+			if (val & 1 << j)
+				set_bit(i + j, bits);
+	}
+}
+
+static void events_import_abs_params(struct event_dev *edev)
+{
+	struct input_dev *input_dev = edev->input;
+	void __iomem *addr = edev->addr;
+	u32 val[4];
+	int count;
+	int i, j;
+
+	__raw_writel(PAGE_ABSDATA, addr + REG_SET_PAGE);
+
+	count = __raw_readl(addr + REG_LEN) / sizeof(val);
+	if (count > ABS_MAX)
+		count = ABS_MAX;
+
+	for (i = 0; i < count; i++) {
+		if (!test_bit(i, input_dev->absbit))
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(val); j++) {
+			int offset = (i * ARRAY_SIZE(val) + j) * sizeof(u32);
+			val[j] = __raw_readl(edev->addr + REG_DATA + offset);
+		}
+
+		input_set_abs_params(input_dev, i,
+				     val[0], val[1], val[2], val[3]);
+	}
+}
+
+static int events_probe(struct platform_device *pdev)
+{
+	struct input_dev *input_dev;
+	struct event_dev *edev;
+	struct resource *res;
+	unsigned keymapnamelen;
+	void __iomem *addr;
+	int irq;
+	int i;
+	int error;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	addr = devm_ioremap(&pdev->dev, res->start, 4096);
+	if (!addr)
+		return -ENOMEM;
+
+	__raw_writel(PAGE_NAME, addr + REG_SET_PAGE);
+	keymapnamelen = __raw_readl(addr + REG_LEN);
+
+	edev = devm_kzalloc(&pdev->dev,
+			    sizeof(struct event_dev) + keymapnamelen + 1,
+			    GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
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
+	input_dev->name = edev->name;
+	input_dev->id.bustype = BUS_HOST;
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
+	events_import_abs_params(edev);
+
+	error = devm_request_irq(&pdev->dev, edev->irq, events_interrupt, 0,
+				 "goldfish-events-keypad", edev);
+	if (error)
+		return error;
+
+	error = input_register_device(input_dev);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static struct platform_driver events_driver = {
+	.probe	= events_probe,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "goldfish_events",
+	},
+};
+
+module_platform_driver(events_driver);
+
+MODULE_AUTHOR("Brian Swetland");
+MODULE_DESCRIPTION("Goldfish Event Device");
+MODULE_LICENSE("GPL");
