From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sun, 31 May 2009 22:12:25 +0800
Message-ID: <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <200905271526.59064.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:23827 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZEaOMY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 10:12:24 -0400
Received: by qw-out-2122.google.com with SMTP id 5so4700459qwd.37
        for <linux-input@vger.kernel.org>; Sun, 31 May 2009 07:12:25 -0700 (PDT)
In-Reply-To: <200905271526.59064.u.luckas@road.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Uli,

Sorry for the delay, and yes, the suspend/resume process is a little
bit out of consideration, I've made some modifications according to
your review, together with several other minor changes:

1. disable row GPIO IRQs and flush work queue in suspend and
schedule an immediate key scan out of resume (columns will
be activated and row IRQs be enabled after scan)

2. de-activating column GPIO turns the GPIO into input, thus a
HiZ state on most platforms, causing no side effect to the scan
of other columns. (Not turning them into input makes detection
of multiple keys failed on PXA/Sharp Zaurus).

3. minor corrections of the __devinit, __devexit_p() stuffs

Patch updated as follows:

>From e2f972a03845b5f1eb631eca481c06b620a88f27 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 7 May 2009 15:49:32 +0800
Subject: [PATCH] input: add support for generic GPIO-based matrix keypad

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Reviewed-by: Uli Luckas <u.luckas@road.de>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig         |   10 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/matrix_keypad.c |  368 ++++++++++++++++++++++++++++++++
 include/linux/input/matrix_keypad.h    |   34 +++
 4 files changed, 413 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/matrix_keypad.c
 create mode 100644 include/linux/input/matrix_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ea2638b..6b9f89c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -332,4 +332,14 @@ config KEYBOARD_SH_KEYSC

 	  To compile this driver as a module, choose M here: the
 	  module will be called sh_keysc.
+
+config KEYBOARD_MATRIX
+	tristate "GPIO driven matrix keypad support"
+	depends on GENERIC_GPIO
+	help
+	  Enable support for GPIO driven matrix keypad
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called matrix_keypad.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 36351e1..1349408 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
diff --git a/drivers/input/keyboard/matrix_keypad.c
b/drivers/input/keyboard/matrix_keypad.c
new file mode 100644
index 0000000..affad7e
--- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,368 @@
+/*
+ * drivers/input/keyboard/matrix_keypad.c
+ *
+ *  GPIO driven matrix keyboard driver
+ *
+ *  Copyright (c) 2008 Marek Vasut <marek.vasut@gmail.com>
+ *
+ *  Based on corgikbd.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/input/matrix_keypad.h>
+
+struct matrix_keypad {
+	struct matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+
+	uint32_t last_key_state[MATRIX_MAX_COLS];
+	uint32_t *keycodes;
+	struct delayed_work work;
+};
+
+static void __devinit build_keycodes(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
+	uint32_t *key;
+	int i;
+
+	keypad->keycodes = kzalloc(MATRIX_MAX_KEYS * sizeof(int), GFP_KERNEL);
+
+	key = &pdata->key_map[0];
+	for (i = 0; i < pdata->key_map_size; i++, key++) {
+		keypad->keycodes[KEY_ROWCOL(*key)] = KEY_VAL(*key);
+		set_bit(KEY_VAL(*key), input_dev->keybit);
+	}
+}
+
+static unsigned int lookup_keycode(struct matrix_keypad *keypad,
+				   int row, int col)
+{
+	return keypad->keycodes[(row << 4) + col];
+}
+
+/* NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
+ * minimum side effect when scanning other columns, here it is configured to
+ * be input, and it should work on most platforms.
+ */
+static void __activate_col(struct matrix_keypad_platform_data *pdata,
+			 int col, int on)
+{
+	int level_on = !pdata->active_low;
+
+	if (on)
+		gpio_direction_output(pdata->col_gpios[col], level_on);
+	else {
+		gpio_set_value(pdata->col_gpios[col], !level_on);
+		gpio_direction_input(pdata->col_gpios[col]);
+	}
+}
+
+static void activate_all_cols(struct matrix_keypad_platform_data
*pdata, int on)
+{
+	int col;
+
+	for (col = 0; col < pdata->num_col_gpios; col++)
+		__activate_col(pdata, col, on);
+}
+
+static void activate_col(struct matrix_keypad_platform_data *pdata,
+			 int col, int on)
+{
+	__activate_col(pdata, col, on);
+
+	if (on && pdata->col_scan_delay_us)
+		udelay(pdata->col_scan_delay_us);
+}
+
+static int row_asserted(struct matrix_keypad_platform_data *pdata, int row)
+{
+	return gpio_get_value(pdata->row_gpios[row]) ?
+			!pdata->active_low : pdata->active_low;
+}
+
+static void enable_row_irqs(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	for (i = 0; i < pdata->num_row_gpios; i++)
+		enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+}
+
+static void disable_row_irqs(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	for (i = 0; i < pdata->num_row_gpios; i++)
+		disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+}
+
+/*
+ * This gets the keys from keyboard and reports it to input subsystem
+ */
+static void matrix_keypad_scan(struct work_struct *work)
+{
+	struct matrix_keypad *keypad =
+	       	container_of(work, struct matrix_keypad, work.work);
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	uint32_t new_state[MATRIX_MAX_COLS];
+	int row, col;
+
+	/* de-activate all columns for scanning */
+	activate_all_cols(pdata, 0);
+
+	memset(new_state, 0, sizeof(new_state));
+
+	/* assert each column and read the row status out */
+	for (col = 0; col < pdata->num_col_gpios; col++) {
+
+		activate_col(pdata, col, 1);
+
+		for (row = 0; row < pdata->num_row_gpios; row++)
+			new_state[col] |= row_asserted(pdata, row) ?
+						(1 << row) : 0;
+		activate_col(pdata, col, 0);
+	}
+
+	for (col = 0; col < pdata->num_col_gpios; col++) {
+		uint32_t bits_changed;
+		
+		bits_changed = keypad->last_key_state[col] ^ new_state[col];
+		if (bits_changed == 0)
+			continue;
+
+		for (row = 0; row < pdata->num_row_gpios; row++) {
+			if ((bits_changed & (1 << row)) == 0)
+				continue;
+
+			input_report_key(keypad->input_dev,
+					lookup_keycode(keypad, row, col),
+					new_state[col] & (1 << row));
+		}
+	}
+	input_sync(keypad->input_dev);
+	memcpy(keypad->last_key_state, new_state, sizeof(new_state));
+
+	activate_all_cols(pdata, 1);
+	enable_row_irqs(keypad);
+}
+
+static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
+{
+	struct matrix_keypad *keypad = id;
+
+	disable_row_irqs(keypad);
+	schedule_delayed_work(&keypad->work,
+			msecs_to_jiffies(keypad->pdata->debounce_ms));
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+static int matrix_keypad_suspend(struct platform_device *pdev,
pm_message_t state)
+{
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	disable_row_irqs(keypad);
+	flush_work(&keypad->work.work);
+
+	if (device_may_wakeup(&pdev->dev))
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+
+	return 0;
+}
+
+static int matrix_keypad_resume(struct platform_device *pdev)
+{
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	if (device_may_wakeup(&pdev->dev))
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+
+	/* Uli Luckas: schedule an immediate key scan as all key state changes
+	 * were lost while the device was suspended, columns will be activated
+	 * and IRQs be enabled after the scan.
+	 */
+	schedule_delayed_work(&keypad->work, 0);
+	return 0;
+}
+#else
+#define matrix_keypad_suspend	NULL
+#define matrix_keypad_resume	NULL
+#endif
+
+static int __devinit init_matrix_gpio(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i, err = -EINVAL;
+
+	/* initialized strobe lines as outputs, activated */
+	for (i = 0; i < pdata->num_col_gpios; i++) {
+		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		if (err) {
+			pr_err("failed to request GPIO%d for COL%d\n",
+					pdata->col_gpios[i], i);
+			goto err_free_cols;
+		}
+
+		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		if (err) {
+			pr_err("failed to request GPIO%d for ROW%d\n",
+					pdata->row_gpios[i], i);
+			goto err_free_rows;
+		}
+
+		gpio_direction_input(pdata->row_gpios[i]);
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
+				matrix_keypad_interrupt, IRQF_DISABLED |
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"matrix-keypad", keypad);
+		if (err) {
+			pr_err("Unable to acquire interrupt for GPIO line %i\n",
+				pdata->row_gpios[i]);
+			goto err_free_irqs;
+		}
+	}
+	return 0;
+
+err_free_irqs:
+	for (i = i - 1; i >= 0; i--)
+		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+
+err_free_rows:
+	for (i = i - 1; i >= 0; i--)
+		gpio_free(pdata->row_gpios[i]);
+
+err_free_cols:
+	for (i = i - 1; i >= 0; i--)
+		gpio_free(pdata->col_gpios[i]);
+
+	return err;
+}
+
+static int __devinit matrix_keypad_probe(struct platform_device *pdev)
+{
+	struct matrix_keypad_platform_data *pdata;
+	struct matrix_keypad *keypad;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
+
+	if ((pdata = pdev->dev.platform_data) == NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	if (keypad == NULL)
+		return -ENOMEM;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		goto err_free_keypad;
+
+	platform_set_drvdata(pdev, keypad);
+
+	keypad->input_dev = input_dev;
+	keypad->pdata = pdata;
+	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+
+	input_dev->name		= pdev->name;
+	input_dev->id.bustype	= BUS_HOST;
+	input_dev->dev.parent	= &pdev->dev;
+	input_dev->evbit[0]	= BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+
+	build_keycodes(keypad);
+
+	err = input_register_device(keypad->input_dev);
+	if (err)
+		goto err_free_input;
+
+	err = init_matrix_gpio(keypad);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	input_unregister_device(input_dev);
+err_free_input:
+	input_free_device(input_dev);
+err_free_keypad:
+	kfree(keypad);
+	return err;
+}
+
+static int __devexit matrix_keypad_remove(struct platform_device *pdev)
+{
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < keypad->pdata->num_row_gpios; i++) {
+		free_irq(gpio_to_irq(keypad->pdata->row_gpios[i]), keypad);
+		gpio_free(keypad->pdata->row_gpios[i]);
+	}
+
+	for (i = 0; i < keypad->pdata->num_col_gpios; i++)
+		gpio_free(keypad->pdata->col_gpios[i]);
+
+	input_unregister_device(keypad->input_dev);
+	kfree(keypad);
+	return 0;
+}
+
+static struct platform_driver matrix_keypad_driver = {
+	.probe		= matrix_keypad_probe,
+	.remove		= __devexit_p(matrix_keypad_remove),
+	.suspend	= matrix_keypad_suspend,
+	.resume		= matrix_keypad_resume,
+	.driver		= {
+		.name	= "matrix-keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init matrix_keypad_init(void)
+{
+	return platform_driver_register(&matrix_keypad_driver);
+}
+
+static void __exit matrix_keypad_exit(void)
+{
+	platform_driver_unregister(&matrix_keypad_driver);
+}
+
+module_init(matrix_keypad_init);
+module_exit(matrix_keypad_exit);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("GPIO Driven Matrix Keypad Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:matrix-keypad");
diff --git a/include/linux/input/matrix_keypad.h
b/include/linux/input/matrix_keypad.h
new file mode 100644
index 0000000..8b661cb
--- /dev/null
+++ b/include/linux/input/matrix_keypad.h
@@ -0,0 +1,34 @@
+#ifndef _MATRIX_KEYPAD_H
+#define _MATRIX_KEYPAD_H
+
+#include <linux/input.h>
+
+#define MATRIX_MAX_ROWS		16
+#define MATRIX_MAX_COLS		16
+#define MATRIX_MAX_KEYS		(MATRIX_MAX_ROWS * MATRIX_MAX_COLS)
+
+struct matrix_keypad_platform_data {
+	/* scancode map for the matrix keys */
+	uint32_t	*key_map;
+	int		key_map_size;
+
+	unsigned	row_gpios[MATRIX_MAX_ROWS];
+	unsigned	col_gpios[MATRIX_MAX_COLS];
+	int		num_row_gpios;
+	int		num_col_gpios;
+
+	unsigned int	active_low;
+	unsigned int	col_scan_delay_us;
+
+	/* key debounce interval in milli-second */
+	unsigned int	debounce_ms;
+};
+
+#define KEY(row, col, val)	((((row) & (MATRIX_MAX_ROWS - 1)) << 28) |\
+				 (((col) & (MATRIX_MAX_COLS - 1)) << 24) |\
+				 (val & 0xffffff))
+
+#define KEY_ROWCOL(k)		(((k) >> 24) & 0xff)
+#define KEY_VAL(k)		((k) & 0xffffff)
+
+#endif /* _MATRIX_KEYPAD_H */
-- 
1.6.0.4
