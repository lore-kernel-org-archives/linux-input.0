From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
Date: Fri,  1 Oct 2010 17:25:41 +0530
Message-ID: <584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:56109 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756654Ab0JAL6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 07:58:05 -0400
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/input/keyboard/Kconfig          |    9 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/spear-keyboard.c |  362 +++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/spear-keyboard.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9cc488d..cb9f6b1 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -424,6 +424,15 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
 
+config KEYBOARD_SPEAR
+	tristate "ST SPEAR keyboard support"
+	depends on PLAT_SPEAR
+	help
+	  Say Y here if you want to use the SPEAR keyboard.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spear-keboard.
+
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
 	depends on TWL4030_CORE
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 504b591..b21c54d 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
 obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
+obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
new file mode 100644
index 0000000..4830e11
--- /dev/null
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -0,0 +1,362 @@
+/*
+ * drivers/input/keyboard/keyboard-spear.c
+ *
+ * SPEAr Keyboard Driver
+ * Based on omap-keypad driver
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeup.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <plat/keyboard.h>
+
+/* Keyboard Regsiters */
+#define MODE_REG	0x00	/* 16 bit reg */
+#define STATUS_REG	0x0C	/* 2 bit reg */
+#define DATA_REG	0x10	/* 8 bit reg */
+#define INTR_MASK	0x54
+
+/* Register Values */
+/*
+ * pclk freq mask = (APB FEQ -1)= 82 MHZ.Programme bit 15-9 in mode
+ * control register as 1010010(82MHZ)
+ */
+#define PCLK_FREQ_MSK	0xA400	/* 82 MHz */
+#define START_SCAN	0x0100
+#define SCAN_RATE_10	0x0000
+#define SCAN_RATE_20	0x0004
+#define SCAN_RATE_40	0x0008
+#define SCAN_RATE_80	0x000C
+#define MODE_KEYBOARD	0x0002
+#define DATA_AVAIL	0x2
+
+#define KEY_MASK	0xFF000000
+#define KEY_VALUE	0x00FFFFFF
+#define ROW_MASK	0xF0
+#define COLUMN_MASK	0x0F
+#define ROW_SHIFT	4
+
+struct spear_kbd {
+	struct input_dev *input;
+	void __iomem *io_base;		/* Keyboard Base Address */
+	struct clk *clk;
+	u8 last_key ;
+	u8 last_event;
+	int *keymap;
+	int keymapsize;
+};
+/* TODO: Need to optimize this function */
+static inline int get_key_value(struct spear_kbd *dev, int row, int col)
+{
+	int i, key;
+
+	key = KEY(row, col, 0);
+	for (i = 0; i < dev->keymapsize; i++)
+		if ((dev->keymap[i] & KEY_MASK) == key)
+			return dev->keymap[i] & KEY_VALUE;
+	return -ENOKEY;
+}
+
+static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
+{
+	struct spear_kbd *dev = dev_id;
+	int key;
+	u8 sts, val = 0;
+
+	sts = readb(dev->io_base + STATUS_REG);
+	if (sts & DATA_AVAIL) {
+		/* following reads active (row, col) pair */
+		val = readb(dev->io_base + DATA_REG);
+		key = get_key_value(dev, (val & ROW_MASK)>>ROW_SHIFT, (val
+					& COLUMN_MASK));
+
+		/* valid key press event */
+		if (key >= 0) {
+			if (dev->last_event == 1) {
+				/* check if we missed a release event */
+				input_report_key(dev->input, dev->last_key,
+						!dev->last_event);
+			}
+			/* notify key press */
+			dev->last_event = 1;
+			dev->last_key = key;
+			input_report_key(dev->input, key, dev->last_event);
+		} else {
+			/* notify key release */
+			dev->last_event = 0;
+			input_report_key(dev->input, dev->last_key,
+					dev->last_event);
+		}
+	} else
+		return IRQ_NONE;
+
+	/* clear interrupt */
+	writeb(0, dev->io_base + STATUS_REG);
+
+	return IRQ_HANDLED;
+}
+
+static int spear_kbd_open(struct input_dev *dev)
+{
+	struct spear_kbd *kbd = input_get_drvdata(dev);
+	u16 val;
+
+	/* start key scan */
+	val = readw(kbd->io_base + MODE_REG);
+	val |= START_SCAN;
+	writew(val, kbd->io_base + MODE_REG);
+
+	return 0;
+}
+
+static void spear_kbd_close(struct input_dev *dev)
+{
+	struct spear_kbd *kbd = input_get_drvdata(dev);
+	u16 val;
+
+	/* stop key scan */
+	val = readw(kbd->io_base + MODE_REG);
+	val &= ~START_SCAN;
+	writew(val, kbd->io_base + MODE_REG);
+}
+
+static int __init spear_kbd_probe(struct platform_device *pdev)
+{
+	struct spear_kbd *kbd;
+	struct kbd_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	int i, ret, irq, size;
+	u16 val = 0;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no keyboard resource defined\n");
+		return -EBUSY;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "keyboard region already claimed\n");
+		return -EBUSY;
+	}
+
+	kbd = kzalloc(sizeof(*kbd), GFP_KERNEL);
+	if (!kbd) {
+		dev_err(&pdev->dev, "out of memory\n");
+		ret = -ENOMEM;
+		goto err_release_mem_region;
+	}
+
+	kbd->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(kbd->clk)) {
+		ret = PTR_ERR(kbd->clk);
+		goto err_kfree;
+	}
+
+	ret = clk_enable(kbd->clk);
+	if (ret < 0)
+		goto err_clk_put;
+
+	platform_set_drvdata(pdev, kbd);
+	kbd->keymapsize = pdata->keymapsize;
+	size = kbd->keymapsize * sizeof(*pdata->keymap);
+	kbd->keymap = kmalloc(size, GFP_KERNEL);
+	if (!kbd->keymap)
+		goto err_clear_plat_data;
+
+	memcpy(kbd->keymap, pdata->keymap, size);
+
+	kbd->io_base = ioremap(res->start, resource_size(res));
+	if (!kbd->io_base) {
+		dev_err(&pdev->dev, "ioremap fail for kbd_region\n");
+		ret = -ENOMEM;
+		goto err_kfree_keymap;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "not able to get irq for the device\n");
+		ret = irq;
+		goto err_iounmap;
+	}
+
+	kbd->input = input_allocate_device();
+	if (!kbd->input) {
+		ret = -ENOMEM;
+		dev_err(&pdev->dev, "input device allocation fail\n");
+		goto err_iounmap;
+	}
+
+	if (pdata->rep)
+		__set_bit(EV_REP, kbd->input->evbit);
+
+	/* setup input device */
+	__set_bit(EV_KEY, kbd->input->evbit);
+
+	for (i = 0; i < kbd->keymapsize; i++)
+		__set_bit(kbd->keymap[i] & KEY_MAX, kbd->input->keybit);
+
+	kbd->input->name = "keyboard";
+	kbd->input->phys = "keyboard/input0";
+	kbd->input->dev.parent = &pdev->dev;
+	kbd->input->id.bustype = BUS_HOST;
+	kbd->input->id.vendor = 0x0001;
+	kbd->input->id.product = 0x0001;
+	kbd->input->id.version = 0x0100;
+	kbd->input->open = spear_kbd_open;
+	kbd->input->close = spear_kbd_close;
+	input_set_drvdata(kbd->input, kbd);
+
+	ret = input_register_device(kbd->input);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to register keyboard device\n");
+		goto err_free_dev;
+	}
+
+	/* program keyboard */
+	val |= SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
+	writew(val, kbd->io_base + MODE_REG);
+
+	writeb(1, kbd->io_base + STATUS_REG);
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	ret = request_irq(irq, spear_kbd_interrupt, 0, "keyboard",
+			kbd);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq fail\n");
+		goto err_unregister_dev;
+	}
+
+	return 0;
+
+err_unregister_dev:
+	input_unregister_device(kbd->input);
+	goto err_iounmap;
+err_free_dev:
+	input_free_device(kbd->input);
+err_iounmap:
+	iounmap(kbd->io_base);
+err_kfree_keymap:
+	kfree(kbd->keymap);
+err_clear_plat_data:
+	platform_set_drvdata(pdev, NULL);
+	clk_disable(kbd->clk);
+err_clk_put:
+	clk_put(kbd->clk);
+err_kfree:
+	kfree(kbd);
+err_release_mem_region:
+	release_mem_region(res->start, resource_size(res));
+
+	return ret;
+}
+
+static int spear_kbd_remove(struct platform_device *pdev)
+{
+	struct spear_kbd *kbd = platform_get_drvdata(pdev);
+	struct resource *res;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	free_irq(irq, pdev);
+
+	/* unregister input device */
+	input_unregister_device(kbd->input);
+
+	iounmap(kbd->io_base);
+	kfree(kbd->keymap);
+	platform_set_drvdata(pdev, NULL);
+	clk_disable(kbd->clk);
+	clk_put(kbd->clk);
+	kfree(kbd);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int spear_kbd_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spear_kbd *kbd = platform_get_drvdata(pdev);
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	clk_disable(kbd->clk);
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(irq);
+
+	return 0;
+}
+
+static int spear_kbd_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spear_kbd *kbd = platform_get_drvdata(pdev);
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(irq);
+	clk_enable(kbd->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops spear_kbd_pm_ops = {
+	.suspend	= spear_kbd_suspend,
+	.resume		= spear_kbd_resume,
+};
+#endif
+
+static struct platform_driver spear_kbd_driver = {
+	.probe		= spear_kbd_probe,
+	.remove		= spear_kbd_remove,
+	.driver		= {
+		.name	= "keyboard",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &spear_kbd_pm_ops,
+#endif
+	},
+};
+
+static int __devinit spear_kbd_init(void)
+{
+	return platform_driver_register(&spear_kbd_driver);
+}
+module_init(spear_kbd_init);
+
+static void __exit spear_kbd_exit(void)
+{
+	platform_driver_unregister(&spear_kbd_driver);
+}
+module_exit(spear_kbd_exit);
+
+MODULE_AUTHOR("Rajeev Kumar");
+MODULE_DESCRIPTION("SPEAr Keyboard Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.2

