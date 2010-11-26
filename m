From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [PATCH] input/tc3589x: add support for tc3589x driver
Date: Fri, 26 Nov 2010 20:35:13 +0530
Message-ID: <1290783913-30728-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:58303 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab0KZPFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 10:05:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ken.lierman@windriver.com
Cc: dmitry.torokhov@gmail.com, alan@linux.intel.com, linus.walleij@stericsson.com, rabin.vincent@stericsson.com, linux-input@vger.kernel.org, sundar.iyer@stericsson.com

This adds support for the TC35893 keypad controller
as a MFD client to the TC3589x driver

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 drivers/input/keyboard/Kconfig          |   19 ++
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/tc3589x-keypad.c |  498 +++++++++++++++++++++++++++++++
 3 files changed, 518 insertions(+), 0 deletions(-)
 create mode 100755 drivers/input/keyboard/tc3589x-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b8c51b9..01326fd 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -443,6 +443,25 @@ config KEYBOARD_OMAP4
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap4-keypad.
 
	  To compile this driver as a module, choose M here: the
	  module will be called spear-keboard.
+
+config KEYBOARD_TC3589X
+        tristate "TC3589X Keypad support"
+        depends on MFD_TC3589X  
+        help
+          Say Y here if you want to use the keypad controller on
+          TC35892/3 I/O expander
+
+          To compile this driver as a module, choose M here: the
+          module will be called tc3589x-keypad
+
 config KEYBOARD_TNETV107X
 	tristate "TI TNETV107X keypad support"
 	depends on ARCH_DAVINCI_TNETV107X
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a34452e..4411c70 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
+obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
 obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
new file mode 100755
index 0000000..fb1a2f2
--- /dev/null
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -0,0 +1,498 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Jayeeta Banerjee <jayeeta.banerjee@stericsson.com>
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ *
+ * License Terms: GNU General Public License, version 2
+ *
+ * TC35893 MFD Keypad Controller driver
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/mfd/tc3589x.h>
+
+/* Maximum supported keypad matrix row/columns size */
+#define TC3589x_MAX_KPROW               8
+#define TC3589x_MAX_KPCOL               12
+
+/* keypad related Constants */
+#define TC3589x_MAX_DEBOUNCE_SETTLE     0xFF
+#define DEDICATED_KEY_VAL	   	0xFF
+
+/* Pull up/down masks */
+#define TC3589x_NO_PULL_MASK	0x0
+#define TC3589x_PULL_DOWN_MASK	0x1
+#define TC3589x_PULL_UP_MASK	0x2
+#define TC3589x_PULLUP_ALL_MASK	0xAA
+#define TC3589x_IO_PULL_VAL(index, mask)	((mask)<<((index)%4)*2))
+
+/* Bit masks for IOCFG register */
+#define IOCFG_BALLCFG		0x01
+#define IOCFG_IG		0x08
+
+#define KP_EVCODE_COL_MASK	0x0F
+#define KP_EVCODE_ROW_MASK	0x70
+#define KP_RELEASE_EVT_MASK	0x80
+
+#define KP_ROW_SHIFT		4
+
+#define KP_NO_VALID_KEY_MASK	0x7F
+
+/* bit masks for RESTCTRL register */
+#define TC3589x_KBDRST		0x2
+#define TC3589x_IRQRST		0x10
+#define TC3589x_RESET_ALL	0x1B
+
+/* KBDMFS register bit mask */
+#define TC3589x_KBDMFS_EN	0x1
+
+/* CLKEN register bitmask */
+#define KPD_CLK_EN		0x1
+
+/* RSTINTCLR register bit mask */
+#define IRQ_CLEAR		0x1
+
+/* bit masks for keyboard interrupts*/
+#define TC3589x_EVT_LOSS_INT	0x8
+#define TC3589x_EVT_INT		0x4
+#define TC3589x_KBD_LOSS_INT	0x2
+#define TC3589x_KBD_INT		0x1
+
+/* bit masks for keyboard interrupt clear*/
+#define TC3589x_EVT_INT_CLR	0x2
+#define TC3589x_KBD_INT_CLR	0x1
+
+#define TC3589x_KBD_KEYMAP_SIZE     64
+
+/**
+ * struct tc_keypad - data structure used by keypad driver
+ * @input:      pointer to input device object
+ * @board:      keypad platform device
+ * @krow:	number of rows
+ * @kcol:	number of coloumns
+ * @keymap:     matrix scan code table for keycodes
+ * @enable:	bool to enable/disable keypad operation
+ */
+struct tc_keypad {
+	struct tc3589x *tc3589x;
+	struct input_dev *input;
+	const struct tc3589x_keypad_platform_data *board;
+	unsigned int krow;
+	unsigned int kcol;
+	unsigned short keymap[TC3589x_KBD_KEYMAP_SIZE];
+	bool enable;
+};
+
+static int __devinit tc3589x_keypad_init_key_hardware(struct tc_keypad *keypad)
+{
+	int ret;
+	struct tc3589x *tc3589x = keypad->tc3589x;
+	u8 settle_time = keypad->board->settle_time;
+	u8 dbounce_period = keypad->board->debounce_period;
+	u8 rows = keypad->board->krow & 0xf;	/* mask out the nibble */
+	u8 column = keypad->board->kcol & 0xf;	/* mask out the nibble */
+
+	/* validate platform configurations */
+	if ((keypad->board->kcol > TC3589x_MAX_KPCOL) ||
+	    (keypad->board->krow > TC3589x_MAX_KPROW) ||
+	    (keypad->board->debounce_period > TC3589x_MAX_DEBOUNCE_SETTLE) ||
+	    (keypad->board->settle_time > TC3589x_MAX_DEBOUNCE_SETTLE))
+		return -EINVAL;
+
+	/* configure KBDSIZE 4 LSbits for cols and 4 MSbits for rows */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDSIZE, 0x0,
+			(rows << KP_ROW_SHIFT) | column);
+	if (ret < 0)
+		return ret;
+
+	/* configure dedicated key config, no dedicated key selected */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBCFG_LSB,
+						0x0, DEDICATED_KEY_VAL);
+	if (ret < 0)
+		return ret;
+
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBCFG_MSB,
+						0x0, DEDICATED_KEY_VAL);
+	if (ret < 0)
+		return ret;
+
+	/* Configure settle time */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDSETTLE_REG,
+						0x0, settle_time);
+	if (ret < 0)
+		return ret;
+
+	/* Configure debounce time */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDBOUNCE, 0x0, dbounce_period);
+	if (ret < 0)
+		return ret;
+
+	/* Start of initialise keypad GPIOs */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOCFG, 0x0, IOCFG_IG);
+	if (ret < 0)
+		return ret;
+
+	/* Configure pull-up resistors for all row GPIOs */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOPULLCFG0_LSB, 0x0,
+			TC3589x_PULLUP_ALL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOPULLCFG0_MSB, 0x0,
+			TC3589x_PULLUP_ALL_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Configure pull-up resistors for all column GPIOs */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOPULLCFG1_LSB, 0x0,
+			TC3589x_PULLUP_ALL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOPULLCFG1_MSB, 0x0,
+			TC3589x_PULLUP_ALL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = tc3589x_set_bits(tc3589x, TC3589x_IOPULLCFG2_LSB, 0x0,
+			TC3589x_PULLUP_ALL_MASK);
+
+	return ret;
+}
+
+#define TC35893_DATA_REGS              4
+#define TC35893_KEYCODE_FIFO_EMPTY     0x7f
+#define TC35893_KEYCODE_FIFO_CLEAR     0xff
+
+static irqreturn_t tc3589x_keypad_irq(int irq, void *dev)
+{
+	struct tc_keypad *keypad = (struct tc_keypad *)dev;
+	struct tc3589x *tc3589x = keypad->tc3589x;
+	u8 i, row_index, col_index, kbd_code, up;
+	u8 code;
+
+	for (i = 0; i < (TC35893_DATA_REGS * 2); i++) {
+		kbd_code = tc3589x_reg_read(tc3589x, TC3589x_EVTCODE_FIFO);
+
+		/* loop till fifo is empty and no more keys are pressed */
+		if ((kbd_code == TC35893_KEYCODE_FIFO_EMPTY) ||
+				(kbd_code == TC35893_KEYCODE_FIFO_CLEAR))
+			continue;
+
+		/* valid key is found */
+		col_index = kbd_code & KP_EVCODE_COL_MASK;
+		row_index = (kbd_code & KP_EVCODE_ROW_MASK) >> KP_ROW_SHIFT;
+		code = MATRIX_SCAN_CODE(row_index, col_index, 0x3);
+		up = kbd_code & KP_RELEASE_EVT_MASK;
+
+		input_event(keypad->input, EV_MSC, MSC_SCAN, code);
+		input_report_key(keypad->input, keypad->keymap[code], !up);
+		input_sync(keypad->input);
+	}
+
+	/* clear IRQ */
+	tc3589x_set_bits(tc3589x, TC3589x_KBDIC,
+			0x0, TC3589x_EVT_INT_CLR | TC3589x_KBD_INT_CLR);
+	/* enable IRQ */
+	tc3589x_set_bits(tc3589x, TC3589x_KBDMSK,
+			0x0, TC3589x_EVT_LOSS_INT | TC3589x_EVT_INT);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit tc3589x_keypad_enable(struct tc3589x *tc3589x)
+{
+	int ret;
+
+	/* pull the keypad module out of reset */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_RSTCTRL, TC3589x_KBDRST, 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* configure KBDMFS */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDMFS, 0x0, TC3589x_KBDMFS_EN);
+	if (ret < 0)
+		return ret;
+
+	/* enable the keypad clock */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_CLKEN, 0x0, KPD_CLK_EN);
+	if (ret < 0)
+		return ret;
+
+	/* clear pending IRQs */
+	ret =  tc3589x_set_bits(tc3589x, TC3589x_RSTINTCLR, 0x0, 0x1);
+	if (ret < 0)
+		return ret;
+
+	/* enable the IRQs */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDMSK, 0x0,
+					TC3589x_EVT_LOSS_INT | TC3589x_EVT_INT);
+
+	return ret;
+}
+
+static int __devexit tc3589x_keypad_disable(struct tc3589x *tc3589x)
+{
+	int ret;
+
+	/* clear IRQ */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDIC,
+			0x0, TC3589x_EVT_INT_CLR | TC3589x_KBD_INT_CLR);
+	if (ret < 0)
+		return ret;
+
+	/* disable all interrupts */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_KBDMSK,
+			~(TC3589x_EVT_LOSS_INT | TC3589x_EVT_INT), 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* disable the keypad module */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_CLKEN, 0x1, 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* put the keypad module into reset */
+	ret = tc3589x_set_bits(tc3589x, TC3589x_RSTCTRL, TC3589x_KBDRST, 0x1);
+
+	return ret;
+}
+
+static ssize_t keypad_show_attr_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+        struct platform_device *pdev = to_platform_device(dev);
+        struct tc_keypad *keypad = platform_get_drvdata(pdev);
+
+	return sprintf(buf, "%u\n", keypad->enable);
+}
+
+static ssize_t keypad_store_attr_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+        struct platform_device *pdev = to_platform_device(dev);
+        struct tc_keypad *keypad = platform_get_drvdata(pdev);
+        struct tc3589x *tc3589x = keypad->tc3589x;
+	unsigned long state;
+
+	if (sscanf(buf, "%lu", &state) != 1)
+		return -EINVAL;
+
+	if ((state != 1) && (state != 0))
+		return -EINVAL;
+
+	if (state != keypad->enable) {
+		if (state)
+			tc3589x_keypad_enable(tc3589x);
+		else
+			tc3589x_keypad_disable(tc3589x);
+		keypad->enable = state;
+	}
+
+	return strnlen(buf, count);
+}
+
+static DEVICE_ATTR(enable, S_IWUSR | S_IRUGO,
+		keypad_show_attr_enable, keypad_store_attr_enable);
+
+static struct attribute *tc3589x_keypad_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL,
+};
+
+static struct attribute_group tc3589x_attr_group = {
+	.attrs = tc3589x_keypad_attrs,
+};
+
+static int __devinit tc3589x_keypad_probe(struct platform_device *pdev)
+{
+	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
+	struct tc_keypad *keypad;
+	struct input_dev *input;
+	const struct tc3589x_keypad_platform_data *plat;
+	int error, irq;
+
+	plat  = tc3589x->pdata->keypad;
+	if (!plat) {
+		dev_err(&pdev->dev, "invalid keypad platform data\n");
+		return -EINVAL;
+	}
+
+        irq = platform_get_irq(pdev, 0);
+        if (irq < 0)
+                return irq;
+
+	keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!keypad || !input) {
+		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	keypad->board = plat;
+	keypad->input = input;
+	keypad->tc3589x = tc3589x;
+
+	/* enable the keypad module */
+	error = tc3589x_keypad_enable(tc3589x);
+	if (error < 0) {
+		dev_err(&pdev->dev, "failed to enable keypad module\n");
+		goto err_free_mem;
+	}
+
+	error = tc3589x_keypad_init_key_hardware(keypad);
+	if (error < 0) {
+		dev_err(&pdev->dev, "failed to configure keypad module\n");
+		goto err_free_mem;
+	}
+
+	input->id.bustype = BUS_HOST;
+	input->name = pdev->name;
+	input->dev.parent = &pdev->dev;
+
+	input->keycode = keypad->keymap;
+	input->keycodesize = sizeof(keypad->keymap[0]);
+	input->keycodemax = ARRAY_SIZE(keypad->keymap);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+
+	__set_bit(EV_KEY, input->evbit);
+	if (!plat->no_autorepeat)
+		__set_bit(EV_REP, input->evbit);
+
+	matrix_keypad_build_keymap(plat->keymap_data, 0x3,
+			input->keycode, input->keybit);
+
+	error = request_threaded_irq(irq, NULL,
+			tc3589x_keypad_irq, plat->irqtype,
+			"tc3589x-keypad", keypad);
+	if (error < 0) {
+		dev_err(&pdev->dev,
+				"Could not allocate irq %d,error %d\n",
+				plat->irq, error);
+		goto err_free_mem;
+	}
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev, "Could not register input device\n");
+		goto err_free_irq;
+	}
+
+	device_init_wakeup(&pdev->dev, plat->enable_wakeup);
+	device_set_wakeup_capable(&pdev->dev, plat->enable_wakeup);
+
+	/* sysfs implementation for dynamic enable/disable the input event */
+	error = sysfs_create_group(&pdev->dev.kobj, &tc3589x_attr_group);
+	if (error) {
+		dev_err(&pdev->dev, "Could not register sysfs entries\n");
+		goto err_free_irq;
+	}
+
+	keypad->enable = true;
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+
+err_free_irq:
+	free_irq(plat->irq, keypad);
+err_free_mem:
+	input_free_device(input);
+	kfree(keypad);
+	return error;
+}
+
+static int __devexit tc3589x_keypad_remove(struct platform_device *pdev)
+{
+        struct tc_keypad *keypad = platform_get_drvdata(pdev);
+        struct tc3589x *tc3589x = keypad->tc3589x;
+
+	free_irq(keypad->board->irq, keypad);
+
+	sysfs_remove_group(&pdev->dev.kobj, &tc3589x_attr_group);
+
+	input_unregister_device(keypad->input);
+
+	tc3589x_keypad_disable(tc3589x);
+
+	kfree(keypad);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tc3589x_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct tc_keypad *keypad = platform_get_drvdata(pdev);
+	struct tc3589x *tc3589x = keypad->tc3589x;
+	int irq = keypad->board->irq;
+
+	/* disable the IRQ */
+	if (!device_may_wakeup(&pdev->dev))
+		tc3589x_keypad_disable(tc3589x);
+	else
+		enable_irq_wake(irq);
+
+	return 0;
+}
+
+static int tc3589x_keypad_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct tc_keypad *keypad = platform_get_drvdata(pdev);
+	struct tc3589x *tc3589x = keypad->tc3589x;
+	int irq = keypad->board->irq;
+
+	/* enable the IRQ */
+	if (!device_may_wakeup(&pdev->dev))
+		tc3589x_keypad_enable(tc3589x);
+	else
+		disable_irq_wake(irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tc3589x_keypad_dev_pm_ops = {
+	.suspend = tc3589x_keypad_suspend,
+	.resume  = tc3589x_keypad_resume,
+};
+#endif
+
+static struct platform_driver tc3589x_keypad_driver = {
+	.driver.name  = "tc3589x-keypad",
+	.driver.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+	.driver.pm = &tc3589x_keypad_dev_pm_ops,
+#endif
+	.probe = tc3589x_keypad_probe,
+	.remove = __devexit_p(tc3589x_keypad_remove),
+};
+
+static int __init tc3589x_keypad_init(void)
+{
+	return platform_driver_register(&tc3589x_keypad_driver);
+}
+
+static void __exit tc3589x_keypad_exit(void)
+{
+	return platform_driver_unregister(&tc3589x_keypad_driver);
+}
+
+module_init(tc3589x_keypad_init);
+module_exit(tc3589x_keypad_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jayeeta Banerjee/Sundar Iyer");
+MODULE_DESCRIPTION("TC35893 Keypad Driver");
+
-- 
1.7.2.dirty

