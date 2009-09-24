From: miguel.aguilar@ridgerun.com
Subject: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Thu, 24 Sep 2009 10:53:22 -0600
Message-ID: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:60805 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZIXQxi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 12:53:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Adds the driver for enabling key scan support for DaVinci platforms.

DM365 is the only platform that uses this driver at the moment.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/include/mach/keyscan.h |   35 +++
 drivers/input/keyboard/Kconfig               |   10 +
 drivers/input/keyboard/Makefile              |    1 +
 drivers/input/keyboard/davinci_keyscan.c     |  326 ++++++++++++++++++++++++++
 4 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/include/mach/keyscan.h
 create mode 100644 drivers/input/keyboard/davinci_keyscan.c

diff --git a/arch/arm/mach-davinci/include/mach/keyscan.h b/arch/arm/mach-davinci/include/mach/keyscan.h
new file mode 100644
index 0000000..6d64198
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/keyscan.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2009 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef DAVINCI_KEYSCAN_H
+#define DAVINCI_KEYSCAN_H
+
+#include <linux/io.h>
+
+struct davinci_ks_platform_data {
+	unsigned short	*keymap;
+	u32		keymapsize;
+	u32		rep:1;
+	u32		strobe;
+	u32		interval;
+};
+
+#endif
+
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a6b989a..72e560e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -361,4 +361,14 @@ config KEYBOARD_XTKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called xtkbd.
 
+config KEYBOARD_DAVINCI
+	tristate "TI DaVinci Key Scan"
+	depends on ARCH_DAVINCI_DM365
+	help
+	  Say Y to enable keypad module support for the TI DaVinci
+	  platforms (DM365)
+	  
+	  To compile this driver as a module, choose M here: the
+	  module will be called davinci_keyscan.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..28e42b6 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
+obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
new file mode 100644
index 0000000..074cf81
--- /dev/null
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -0,0 +1,326 @@
+/*
+ * DaVinci Key Scan Driver for TI platforms
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * Intial Code: Sandeep Paulraj <s-paulraj@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/errno.h>
+
+#include <asm/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/keyscan.h>
+
+/* Key scan registers */
+#define DAVINCI_KEYSCAN_KEYCTRL		0x0000
+#define DAVINCI_KEYSCAN_INTENA		0x0004
+#define DAVINCI_KEYSCAN_INTFLAG		0x0008
+#define DAVINCI_KEYSCAN_INTCLR		0x000c
+#define DAVINCI_KEYSCAN_STRBWIDTH	0x0010
+#define DAVINCI_KEYSCAN_INTERVAL	0x0014
+#define DAVINCI_KEYSCAN_CONTTIME	0x0018
+#define DAVINCI_KEYSCAN_CURRENTST	0x001c
+#define DAVINCI_KEYSCAN_PREVSTATE	0x0020
+#define DAVINCI_KEYSCAN_EMUCTRL		0x0024
+#define DAVINCI_KEYSCAN_IODFTCTRL	0x002c
+
+/* Key Control Register (KEYCTRL) */
+#define DAVINCI_KEYSCAN_KEYEN		0x00000001
+#define DAVINCI_KEYSCAN_PREVMODE	0x00000002
+#define DAVINCI_KEYSCAN_CHATOFF		0x00000004
+#define DAVINCI_KEYSCAN_AUTODET		0x00000008
+#define DAVINCI_KEYSCAN_SCANMODE	0x00000010
+#define DAVINCI_KEYSCAN_OUTTYPE		0x00000020
+#define DAVINCI_KEYSCAN_4X4		0x00000040
+
+/* Masks for the interrupts */
+#define DAVINCI_KEYSCAN_INT_CONT	0x00000008
+#define DAVINCI_KEYSCAN_INT_OFF		0x00000004
+#define DAVINCI_KEYSCAN_INT_ON		0x00000002
+#define DAVINCI_KEYSCAN_INT_CHANGE	0x00000001
+#define DAVINCI_KEYSCAN_INT_ALL		0x0000000f
+
+struct davinci_ks {
+	struct input_dev		*input;
+	struct davinci_ks_platform_data	*pdata;
+	int				irq;
+	void __iomem			*base;
+	resource_size_t			pbase;
+	size_t				base_size;
+	unsigned short			keymap[];
+};
+
+static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
+{
+	u32 base = (u32)davinci_ks->base;
+
+	__raw_writel(val,(u32 *)(base + addr));
+}
+
+static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
+{
+	u32 base = (u32)davinci_ks->base;
+
+	return __raw_readl((u32 *)(base + addr));
+}
+
+/* Initializing the kp Module */
+static void davinci_ks_initialize(struct davinci_ks *davinci_ks)
+{
+	u32 strobe = davinci_ks->pdata->strobe;
+	u32 interval = davinci_ks->pdata->interval;
+
+	/* Enable all interrupts */
+	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTENA);
+
+	/* Clear interrupts if any */
+	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTCLR);
+
+	/* Setup the scan period = strobe + interval */
+	davinci_ks_write(davinci_ks, strobe, DAVINCI_KEYSCAN_STRBWIDTH);
+	davinci_ks_write(davinci_ks, interval, DAVINCI_KEYSCAN_INTERVAL);
+	davinci_ks_write(davinci_ks, 0x01, DAVINCI_KEYSCAN_CONTTIME);
+
+	/* Enable Keyscan module and enable */
+	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET | DAVINCI_KEYSCAN_KEYEN,
+			DAVINCI_KEYSCAN_KEYCTRL);
+}
+
+static irqreturn_t davinci_ks_interrupt(int irq, void *dev_id)
+{
+	struct davinci_ks *davinci_ks = dev_id;
+	struct device *dev = &davinci_ks->input->dev;
+	unsigned short *keymap = davinci_ks->keymap;
+	int keymapsize = davinci_ks->pdata->keymapsize;
+	u32 prev_status, new_status, changed;
+	bool release;
+	int keycode = KEY_UNKNOWN;
+	int i;
+
+	/* Disable interrupt */
+	davinci_ks_write(davinci_ks, 0x0, DAVINCI_KEYSCAN_INTENA);
+
+	/* Reading previous and new status of the key scan */
+	prev_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_PREVSTATE);
+	new_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_CURRENTST);
+
+	changed = prev_status ^ new_status;
+
+	if(changed) {
+		/*
+		 * It goes go through all bits in changed to ensure
+		 * that no key changes are being missed
+		 */
+		for(i = 0 ; i < keymapsize; i++) {
+			if((changed>>i) & 0x1) {
+				keycode = keymap[i];
+				release = (new_status >> i) & 0x1;
+				dev_info(dev, "davinci_keyscan: key %d %s\n",
+				    keycode, release ? "released" : "pressed");
+				input_report_key(davinci_ks->input, keycode,
+						    !release);
+				input_sync(davinci_ks->input);
+			}
+		}
+		/* Clearing interrupt */
+		davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
+				    DAVINCI_KEYSCAN_INTCLR);
+	}
+
+	/* Enable interrupts */
+	davinci_ks_write(davinci_ks, 0x1, DAVINCI_KEYSCAN_INTENA);
+
+	return IRQ_HANDLED;
+}
+
+static int __init davinci_ks_probe(struct platform_device *pdev)
+{
+	struct davinci_ks *davinci_ks;
+	struct input_dev *key_dev;
+	struct resource *res, *mem;
+	struct device * dev = &pdev->dev;
+	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
+	int ret, i;
+
+	dev_info(dev, "DaVinci Key Scan Driver\n");
+
+	davinci_ks = kzalloc(sizeof(struct davinci_ks) +
+		sizeof(unsigned short) * pdata->keymapsize, GFP_KERNEL);
+	if(!davinci_ks) {
+		dev_dbg(dev, "could not allocate memory for private data\n");
+		return -ENOMEM;
+	}
+
+	if (!pdata->keymap) {
+		dev_dbg(dev, "no keymap from pdata\n");
+		return -EINVAL;
+	}
+
+	memcpy(davinci_ks->keymap, pdata->keymap,
+		    sizeof(unsigned short) * pdata->keymapsize);
+
+	key_dev = input_allocate_device();
+	if (!key_dev) {
+		dev_dbg(dev, "could not allocate input device\n");
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	platform_set_drvdata(pdev, davinci_ks);
+
+	davinci_ks->input = key_dev;
+
+	davinci_ks->irq = platform_get_irq(pdev, 0);
+	if (davinci_ks->irq < 0) {
+		dev_err(dev, "no key scan irq\n");
+		ret = davinci_ks->irq;
+		goto fail2;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no mem resource\n");
+		ret = -EINVAL;
+		goto fail2;
+	}
+
+	davinci_ks->pbase = res->start;
+	davinci_ks->base_size = resource_size(res);
+
+	mem = request_mem_region(davinci_ks->pbase, davinci_ks->base_size, pdev->name);
+	if (!mem) {
+		dev_err(dev, "key scan registers at %08x are not free\n",
+			davinci_ks->pbase);
+		ret = -EBUSY;
+		goto fail2;
+	}
+
+	davinci_ks->base = ioremap(davinci_ks->pbase, davinci_ks->base_size);
+	if (!davinci_ks->base) {
+		dev_err(dev, "can't ioremap MEM resource.\n");
+		ret = -ENOMEM;
+		goto fail3;
+	}
+
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		__set_bit(EV_REP, key_dev->evbit);
+
+	/* Setup input device */
+	__set_bit(EV_KEY, key_dev->evbit);
+
+	/* Setup the platform data */
+	davinci_ks->pdata = pdata;
+
+	for (i = 0; i < davinci_ks->pdata->keymapsize; i++)
+		__set_bit(davinci_ks->pdata->keymap[i], key_dev->keybit);
+
+	key_dev->name = "davinci_keyscan";
+	key_dev->phys = "davinci_keyscan/input0";
+	key_dev->dev.parent = &pdev->dev;
+	key_dev->id.bustype = BUS_HOST;
+	key_dev->id.vendor = 0x0001;
+	key_dev->id.product = 0x0001;
+	key_dev->id.version = 0x0001;
+	key_dev->keycode = davinci_ks->keymap;
+	key_dev->keycodesize = sizeof(davinci_ks->keymap[0]);
+	key_dev->keycodemax = davinci_ks->pdata->keymapsize;
+
+	ret = input_register_device(davinci_ks->input);
+	if (ret < 0) {
+		dev_err(dev, "unable to register DaVinci keyscan device\n");
+		goto fail4;
+	}
+
+	ret = request_irq(davinci_ks->irq, davinci_ks_interrupt, IRQF_DISABLED,
+                         "davinci_keyscan", davinci_ks);
+	if (ret < 0) {
+		dev_err(dev, "unable to register DaVinci keyscan Interrupt\n");
+		goto fail5;
+	}
+
+	davinci_ks_initialize(davinci_ks);
+
+	return 0;
+fail5:
+	input_unregister_device(davinci_ks->input);
+	key_dev = NULL;
+fail4:
+	iounmap(davinci_ks->base);
+fail3:
+	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
+fail2:
+	input_free_device(key_dev);
+fail1:
+	kfree(davinci_ks);
+
+	return ret;
+}
+
+static int __devexit davinci_ks_remove(struct platform_device *pdev)
+{
+	struct davinci_ks *davinci_ks = platform_get_drvdata(pdev);
+
+	free_irq(davinci_ks->irq, davinci_ks);
+
+	input_unregister_device(davinci_ks->input);
+
+	iounmap(davinci_ks->base);
+	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
+
+	platform_set_drvdata(pdev, NULL);
+
+	kfree(davinci_ks);
+
+	return 0;
+}
+
+static struct platform_driver davinci_ks_driver = {
+	.driver = {
+			.name = "davinci_keyscan",
+			.owner = THIS_MODULE,
+		},
+	.remove = __devexit_p(davinci_ks_remove),
+};
+
+static int __init davinci_ks_init(void)
+{
+	return platform_driver_probe(&davinci_ks_driver, davinci_ks_probe);
+}
+module_init(davinci_ks_init);
+
+static void __exit davinci_ks_exit(void)
+{
+	platform_driver_unregister(&davinci_ks_driver);
+}
+module_exit(davinci_ks_exit);
+
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_DESCRIPTION("Texas Instruments DaVinci Key Scan Driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4

