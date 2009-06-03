From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 3 Jun 2009 14:24:18 +0800
Message-ID: <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	 <200906021655.18476.u.luckas@road.de>
	 <200906021714.42186.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00163646bf8a8b57a0046b6bb557
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f104.google.com ([209.85.221.104]:50392 "EHLO
	mail-qy0-f104.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbZFCGYR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 02:24:17 -0400
Received: by qyk2 with SMTP id 2so1612379qyk.33
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2009 23:24:18 -0700 (PDT)
In-Reply-To: <200906021714.42186.u.luckas@road.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--00163646bf8a8b57a0046b6bb557
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Jun 2, 2009 at 11:14 PM, Uli Luckas <u.luckas@road.de> wrote:
> One more...
>
> As all gpio handling is done in a workqueue,
> gpio_set_value_cansleep/gpio_get_value_cansleep could probably be used. This
> would make the driver ready for gpios on external controllers (via i2c for
> example).
>

Sounds good, patch updated again, with attachment.

>From 76776dfc468dc35f0d8394a2331e1a91f390e642 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 7 May 2009 15:49:32 +0800
Subject: [PATCH] input: add support for generic GPIO-based matrix keypad

Original patch by Marek Vasut, modified by Eric in:

1. use delayed work to simplify the debouncing process

2. build keycode array for fast lookup

3. combine col_polarity/row_polarity into a single active_low
   field (are there some cases where the GPIOs are externally
   connected with an inverter and thus causing two different
   polarity requirement??)

4. use a generic bit array based XOR algorithm to detect key
   press/release, which should make the column assertion time
   shorter and code a bit cleaner

5. remove the ALT_FN handling, which is no way generic, ALT_FN
   key should be treated as no different from other keys, and
   translation can be done by commands like 'loadkeys'.

6. explicitly disable row IRQs and flush potential pending work,
   and schedule an immediate scan after resuming as suggested
   by Uli Luckas

7. incorporate review comments from many others

Patch tested on Littleton/PXA310 (though PXA310 has a dedicate keypad
controller, I have to configure those pins as generic GPIO to use this
driver, works quite well, though ;-), and Sharp Zaurus model SL-C7x0
and SL-C1000.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
Reviewed-by: Uli Luckas <u.luckas@road.de>
Reviewed-by: Russell King <linux@arm.linux.org.uk>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig         |   10 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/matrix_keypad.c |  379 ++++++++++++++++++++++++++++++++
 include/linux/input/matrix_keypad.h    |   34 +++
 4 files changed, 424 insertions(+), 0 deletions(-)
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
index 0000000..2078d64
--- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,379 @@
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
+static int __devinit build_keycodes(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
+	uint32_t *key;
+	int i;
+
+	keypad->keycodes = kzalloc(MATRIX_MAX_KEYS * sizeof(int), GFP_KERNEL);
+	if (keypad->keycodes == NULL)
+		return -ENOMEM;
+
+	key = &pdata->key_map[0];
+	for (i = 0; i < pdata->key_map_size; i++, key++) {
+		keypad->keycodes[KEY_ROWCOL(*key)] = KEY_VAL(*key);
+		set_bit(KEY_VAL(*key), input_dev->keybit);
+	}
+	return 0;
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
+		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
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
+	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
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
+			container_of(work, struct matrix_keypad, work.work);
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
+				 pm_message_t state)
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
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
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
+	err = build_keycodes(keypad);
+	if (err)
+		goto err_free_input;
+
+	err = input_register_device(keypad->input_dev);
+	if (err)
+		goto err_free_keycodes;
+
+	err = init_matrix_gpio(keypad);
+	if (err)
+		goto err_unregister;
+
+	device_init_wakeup(&pdev->dev, 1);
+	return 0;
+
+err_unregister:
+	input_unregister_device(input_dev);
+err_free_keycodes:
+	kfree(keypad->keycodes);
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
+	kfree(keypad->keycodes);
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

--00163646bf8a8b57a0046b6bb557
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-input-add-support-for-generic-GPIO-based-matrix-key.patch"
Content-Disposition: attachment;
	filename="0001-input-add-support-for-generic-GPIO-based-matrix-key.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvhnkec70

RnJvbSA3Njc3NmRmYzQ2OGRjMzVmMGQ4Mzk0YTIzMzFlMWE5MWYzOTBlNjQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDcgTWF5IDIwMDkgMTU6NDk6MzIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBpbnB1
dDogYWRkIHN1cHBvcnQgZm9yIGdlbmVyaWMgR1BJTy1iYXNlZCBtYXRyaXgga2V5cGFkCgpPcmln
aW5hbCBwYXRjaCBieSBNYXJlayBWYXN1dCwgbW9kaWZpZWQgYnkgRXJpYyBpbjoKCjEuIHVzZSBk
ZWxheWVkIHdvcmsgdG8gc2ltcGxpZnkgdGhlIGRlYm91bmNpbmcgcHJvY2VzcwoKMi4gYnVpbGQg
a2V5Y29kZSBhcnJheSBmb3IgZmFzdCBsb29rdXAKCjMuIGNvbWJpbmUgY29sX3BvbGFyaXR5L3Jv
d19wb2xhcml0eSBpbnRvIGEgc2luZ2xlIGFjdGl2ZV9sb3cKICAgZmllbGQgKGFyZSB0aGVyZSBz
b21lIGNhc2VzIHdoZXJlIHRoZSBHUElPcyBhcmUgZXh0ZXJuYWxseQogICBjb25uZWN0ZWQgd2l0
aCBhbiBpbnZlcnRlciBhbmQgdGh1cyBjYXVzaW5nIHR3byBkaWZmZXJlbnQKICAgcG9sYXJpdHkg
cmVxdWlyZW1lbnQ/PykKCjQuIHVzZSBhIGdlbmVyaWMgYml0IGFycmF5IGJhc2VkIFhPUiBhbGdv
cml0aG0gdG8gZGV0ZWN0IGtleQogICBwcmVzcy9yZWxlYXNlLCB3aGljaCBzaG91bGQgbWFrZSB0
aGUgY29sdW1uIGFzc2VydGlvbiB0aW1lCiAgIHNob3J0ZXIgYW5kIGNvZGUgYSBiaXQgY2xlYW5l
cgoKNS4gcmVtb3ZlIHRoZSBBTFRfRk4gaGFuZGxpbmcsIHdoaWNoIGlzIG5vIHdheSBnZW5lcmlj
LCBBTFRfRk4KICAga2V5IHNob3VsZCBiZSB0cmVhdGVkIGFzIG5vIGRpZmZlcmVudCBmcm9tIG90
aGVyIGtleXMsIGFuZAogICB0cmFuc2xhdGlvbiBjYW4gYmUgZG9uZSBieSBjb21tYW5kcyBsaWtl
ICdsb2Fka2V5cycuCgo2LiBleHBsaWNpdGx5IGRpc2FibGUgcm93IElSUXMgYW5kIGZsdXNoIHBv
dGVudGlhbCBwZW5kaW5nIHdvcmssCiAgIGFuZCBzY2hlZHVsZSBhbiBpbW1lZGlhdGUgc2NhbiBh
ZnRlciByZXN1bWluZyBhcyBzdWdnZXN0ZWQKICAgYnkgVWxpIEx1Y2thcwoKNy4gaW5jb3Jwb3Jh
dGUgcmV2aWV3IGNvbW1lbnRzIGZyb20gbWFueSBvdGhlcnMKClBhdGNoIHRlc3RlZCBvbiBMaXR0
bGV0b24vUFhBMzEwICh0aG91Z2ggUFhBMzEwIGhhcyBhIGRlZGljYXRlIGtleXBhZApjb250cm9s
bGVyLCBJIGhhdmUgdG8gY29uZmlndXJlIHRob3NlIHBpbnMgYXMgZ2VuZXJpYyBHUElPIHRvIHVz
ZSB0aGlzCmRyaXZlciwgd29ya3MgcXVpdGUgd2VsbCwgdGhvdWdoIDstKSwgYW5kIFNoYXJwIFph
dXJ1cyBtb2RlbCBTTC1DN3gwCmFuZCBTTC1DMTAwMC4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIFZh
c3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBUcmlsb2sgU29uaSA8c29u
aS50cmlsb2tAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogVWxpIEx1Y2thcyA8dS5sdWNrYXNAcm9h
ZC5kZT4KUmV2aWV3ZWQtYnk6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4K
UmV2aWV3ZWQtYnk6IFJvYmVydCBKYXJ6bWlrIDxyb2JlcnQuamFyem1pa0BmcmVlLmZyPgpTaWdu
ZWQtb2ZmLWJ5OiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJz
L2lucHV0L2tleWJvYXJkL0tjb25maWcgICAgICAgICB8ICAgMTAgKwogZHJpdmVycy9pbnB1dC9r
ZXlib2FyZC9NYWtlZmlsZSAgICAgICAgfCAgICAxICsKIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
bWF0cml4X2tleXBhZC5jIHwgIDM3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
aW5jbHVkZS9saW51eC9pbnB1dC9tYXRyaXhfa2V5cGFkLmggICAgfCAgIDM0ICsrKwogNCBmaWxl
cyBjaGFuZ2VkLCA0MjQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2lucHV0L2tleWJvYXJkL21hdHJpeF9rZXlwYWQuYwogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvaW5wdXQvbWF0cml4X2tleXBhZC5oCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnIGIvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9LY29uZmlnCmluZGV4IGVhMjYzOGIuLjZiOWY4OWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvS2NvbmZpZworKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcK
QEAgLTMzMiw0ICszMzIsMTQgQEAgY29uZmlnIEtFWUJPQVJEX1NIX0tFWVNDCiAKIAkgIFRvIGNv
bXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQogCSAgbW9k
dWxlIHdpbGwgYmUgY2FsbGVkIHNoX2tleXNjLgorCitjb25maWcgS0VZQk9BUkRfTUFUUklYCisJ
dHJpc3RhdGUgIkdQSU8gZHJpdmVuIG1hdHJpeCBrZXlwYWQgc3VwcG9ydCIKKwlkZXBlbmRzIG9u
IEdFTkVSSUNfR1BJTworCWhlbHAKKwkgIEVuYWJsZSBzdXBwb3J0IGZvciBHUElPIGRyaXZlbiBt
YXRyaXgga2V5cGFkCisKKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNo
b29zZSBNIGhlcmU6IHRoZQorCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIG1hdHJpeF9rZXlwYWQu
CisKIGVuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlIGIv
ZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQppbmRleCAzNjM1MWUxLi4xMzQ5NDA4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlCisrKyBiL2RyaXZlcnMv
aW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUKQEAgLTI4LDMgKzI4LDQgQEAgb2JqLSQoQ09ORklHX0tF
WUJPQVJEX0hQN1hYKQkJKz0gam9ybmFkYTcyMF9rYmQubwogb2JqLSQoQ09ORklHX0tFWUJPQVJE
X01BUExFKQkJKz0gbWFwbGVfa2V5Yi5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfQkZJTikJCSs9
IGJmNTR4LWtleXMubwogb2JqLSQoQ09ORklHX0tFWUJPQVJEX1NIX0tFWVNDKQkJKz0gc2hfa2V5
c2Mubworb2JqLSQoQ09ORklHX0tFWUJPQVJEX01BVFJJWCkJCSs9IG1hdHJpeF9rZXlwYWQubwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tYXRyaXhfa2V5cGFkLmMgYi9kcml2
ZXJzL2lucHV0L2tleWJvYXJkL21hdHJpeF9rZXlwYWQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi4yMDc4ZDY0Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9pbnB1dC9r
ZXlib2FyZC9tYXRyaXhfa2V5cGFkLmMKQEAgLTAsMCArMSwzNzkgQEAKKy8qCisgKiBkcml2ZXJz
L2lucHV0L2tleWJvYXJkL21hdHJpeF9rZXlwYWQuYworICoKKyAqICBHUElPIGRyaXZlbiBtYXRy
aXgga2V5Ym9hcmQgZHJpdmVyCisgKgorICogIENvcHlyaWdodCAoYykgMjAwOCBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPgorICoKKyAqICBCYXNlZCBvbiBjb3JnaWtiZC5jCisg
KgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqICBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgv
aW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisjaW5jbHVkZSA8bGludXgvaXJxLmg+
CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvamlmZmllcy5o
PgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4KKyNp
bmNsdWRlIDxsaW51eC9pbnB1dC9tYXRyaXhfa2V5cGFkLmg+CisKK3N0cnVjdCBtYXRyaXhfa2V5
cGFkIHsKKwlzdHJ1Y3QgbWF0cml4X2tleXBhZF9wbGF0Zm9ybV9kYXRhICpwZGF0YTsKKwlzdHJ1
Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXY7CisKKwl1aW50MzJfdCBsYXN0X2tleV9zdGF0ZVtNQVRS
SVhfTUFYX0NPTFNdOworCXVpbnQzMl90ICprZXljb2RlczsKKwlzdHJ1Y3QgZGVsYXllZF93b3Jr
IHdvcms7Cit9OworCitzdGF0aWMgaW50IF9fZGV2aW5pdCBidWlsZF9rZXljb2RlcyhzdHJ1Y3Qg
bWF0cml4X2tleXBhZCAqa2V5cGFkKQoreworCXN0cnVjdCBtYXRyaXhfa2V5cGFkX3BsYXRmb3Jt
X2RhdGEgKnBkYXRhID0ga2V5cGFkLT5wZGF0YTsKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9k
ZXYgPSBrZXlwYWQtPmlucHV0X2RldjsKKwl1aW50MzJfdCAqa2V5OworCWludCBpOworCisJa2V5
cGFkLT5rZXljb2RlcyA9IGt6YWxsb2MoTUFUUklYX01BWF9LRVlTICogc2l6ZW9mKGludCksIEdG
UF9LRVJORUwpOworCWlmIChrZXlwYWQtPmtleWNvZGVzID09IE5VTEwpCisJCXJldHVybiAtRU5P
TUVNOworCisJa2V5ID0gJnBkYXRhLT5rZXlfbWFwWzBdOworCWZvciAoaSA9IDA7IGkgPCBwZGF0
YS0+a2V5X21hcF9zaXplOyBpKyssIGtleSsrKSB7CisJCWtleXBhZC0+a2V5Y29kZXNbS0VZX1JP
V0NPTCgqa2V5KV0gPSBLRVlfVkFMKCprZXkpOworCQlzZXRfYml0KEtFWV9WQUwoKmtleSksIGlu
cHV0X2Rldi0+a2V5Yml0KTsKKwl9CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBp
bnQgbG9va3VwX2tleWNvZGUoc3RydWN0IG1hdHJpeF9rZXlwYWQgKmtleXBhZCwKKwkJCQkgICBp
bnQgcm93LCBpbnQgY29sKQoreworCXJldHVybiBrZXlwYWQtPmtleWNvZGVzWyhyb3cgPDwgNCkg
KyBjb2xdOworfQorCisvKiBOT1RFOiBub3JtYWxseSB0aGUgR1BJTyBoYXMgdG8gYmUgcHV0IGlu
dG8gSGlaIHdoZW4gZGUtYWN0aXZhdGVkIHRvIGNhdXNlCisgKiBtaW5pbXVtIHNpZGUgZWZmZWN0
IHdoZW4gc2Nhbm5pbmcgb3RoZXIgY29sdW1ucywgaGVyZSBpdCBpcyBjb25maWd1cmVkIHRvCisg
KiBiZSBpbnB1dCwgYW5kIGl0IHNob3VsZCB3b3JrIG9uIG1vc3QgcGxhdGZvcm1zLgorICovCitz
dGF0aWMgdm9pZCBfX2FjdGl2YXRlX2NvbChzdHJ1Y3QgbWF0cml4X2tleXBhZF9wbGF0Zm9ybV9k
YXRhICpwZGF0YSwKKwkJCSBpbnQgY29sLCBpbnQgb24pCit7CisJaW50IGxldmVsX29uID0gIXBk
YXRhLT5hY3RpdmVfbG93OworCisJaWYgKG9uKQorCQlncGlvX2RpcmVjdGlvbl9vdXRwdXQocGRh
dGEtPmNvbF9ncGlvc1tjb2xdLCBsZXZlbF9vbik7CisJZWxzZSB7CisJCWdwaW9fc2V0X3ZhbHVl
X2NhbnNsZWVwKHBkYXRhLT5jb2xfZ3Bpb3NbY29sXSwgIWxldmVsX29uKTsKKwkJZ3Bpb19kaXJl
Y3Rpb25faW5wdXQocGRhdGEtPmNvbF9ncGlvc1tjb2xdKTsKKwl9Cit9CisKK3N0YXRpYyB2b2lk
IGFjdGl2YXRlX2FsbF9jb2xzKHN0cnVjdCBtYXRyaXhfa2V5cGFkX3BsYXRmb3JtX2RhdGEgKnBk
YXRhLCBpbnQgb24pCit7CisJaW50IGNvbDsKKworCWZvciAoY29sID0gMDsgY29sIDwgcGRhdGEt
Pm51bV9jb2xfZ3Bpb3M7IGNvbCsrKQorCQlfX2FjdGl2YXRlX2NvbChwZGF0YSwgY29sLCBvbik7
Cit9CisKK3N0YXRpYyB2b2lkIGFjdGl2YXRlX2NvbChzdHJ1Y3QgbWF0cml4X2tleXBhZF9wbGF0
Zm9ybV9kYXRhICpwZGF0YSwKKwkJCSBpbnQgY29sLCBpbnQgb24pCit7CisJX19hY3RpdmF0ZV9j
b2wocGRhdGEsIGNvbCwgb24pOworCisJaWYgKG9uICYmIHBkYXRhLT5jb2xfc2Nhbl9kZWxheV91
cykKKwkJdWRlbGF5KHBkYXRhLT5jb2xfc2Nhbl9kZWxheV91cyk7Cit9CisKK3N0YXRpYyBpbnQg
cm93X2Fzc2VydGVkKHN0cnVjdCBtYXRyaXhfa2V5cGFkX3BsYXRmb3JtX2RhdGEgKnBkYXRhLCBp
bnQgcm93KQoreworCXJldHVybiBncGlvX2dldF92YWx1ZV9jYW5zbGVlcChwZGF0YS0+cm93X2dw
aW9zW3Jvd10pID8KKwkJCSFwZGF0YS0+YWN0aXZlX2xvdyA6IHBkYXRhLT5hY3RpdmVfbG93Owor
fQorCitzdGF0aWMgdm9pZCBlbmFibGVfcm93X2lycXMoc3RydWN0IG1hdHJpeF9rZXlwYWQgKmtl
eXBhZCkKK3sKKwlzdHJ1Y3QgbWF0cml4X2tleXBhZF9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGtl
eXBhZC0+cGRhdGE7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgcGRhdGEtPm51bV9yb3df
Z3Bpb3M7IGkrKykKKwkJZW5hYmxlX2lycShncGlvX3RvX2lycShwZGF0YS0+cm93X2dwaW9zW2ld
KSk7Cit9CisKK3N0YXRpYyB2b2lkIGRpc2FibGVfcm93X2lycXMoc3RydWN0IG1hdHJpeF9rZXlw
YWQgKmtleXBhZCkKK3sKKwlzdHJ1Y3QgbWF0cml4X2tleXBhZF9wbGF0Zm9ybV9kYXRhICpwZGF0
YSA9IGtleXBhZC0+cGRhdGE7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgcGRhdGEtPm51
bV9yb3dfZ3Bpb3M7IGkrKykKKwkJZGlzYWJsZV9pcnFfbm9zeW5jKGdwaW9fdG9faXJxKHBkYXRh
LT5yb3dfZ3Bpb3NbaV0pKTsKK30KKworLyoKKyAqIFRoaXMgZ2V0cyB0aGUga2V5cyBmcm9tIGtl
eWJvYXJkIGFuZCByZXBvcnRzIGl0IHRvIGlucHV0IHN1YnN5c3RlbQorICovCitzdGF0aWMgdm9p
ZCBtYXRyaXhfa2V5cGFkX3NjYW4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0cnVj
dCBtYXRyaXhfa2V5cGFkICprZXlwYWQgPQorCQkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBt
YXRyaXhfa2V5cGFkLCB3b3JrLndvcmspOworCXN0cnVjdCBtYXRyaXhfa2V5cGFkX3BsYXRmb3Jt
X2RhdGEgKnBkYXRhID0ga2V5cGFkLT5wZGF0YTsKKwl1aW50MzJfdCBuZXdfc3RhdGVbTUFUUklY
X01BWF9DT0xTXTsKKwlpbnQgcm93LCBjb2w7CisKKwkvKiBkZS1hY3RpdmF0ZSBhbGwgY29sdW1u
cyBmb3Igc2Nhbm5pbmcgKi8KKwlhY3RpdmF0ZV9hbGxfY29scyhwZGF0YSwgMCk7CisKKwltZW1z
ZXQobmV3X3N0YXRlLCAwLCBzaXplb2YobmV3X3N0YXRlKSk7CisKKwkvKiBhc3NlcnQgZWFjaCBj
b2x1bW4gYW5kIHJlYWQgdGhlIHJvdyBzdGF0dXMgb3V0ICovCisJZm9yIChjb2wgPSAwOyBjb2wg
PCBwZGF0YS0+bnVtX2NvbF9ncGlvczsgY29sKyspIHsKKworCQlhY3RpdmF0ZV9jb2wocGRhdGEs
IGNvbCwgMSk7CisKKwkJZm9yIChyb3cgPSAwOyByb3cgPCBwZGF0YS0+bnVtX3Jvd19ncGlvczsg
cm93KyspCisJCQluZXdfc3RhdGVbY29sXSB8PSByb3dfYXNzZXJ0ZWQocGRhdGEsIHJvdykgPwor
CQkJCQkJKDEgPDwgcm93KSA6IDA7CisJCWFjdGl2YXRlX2NvbChwZGF0YSwgY29sLCAwKTsKKwl9
CisKKwlmb3IgKGNvbCA9IDA7IGNvbCA8IHBkYXRhLT5udW1fY29sX2dwaW9zOyBjb2wrKykgewor
CQl1aW50MzJfdCBiaXRzX2NoYW5nZWQ7CisKKwkJYml0c19jaGFuZ2VkID0ga2V5cGFkLT5sYXN0
X2tleV9zdGF0ZVtjb2xdIF4gbmV3X3N0YXRlW2NvbF07CisJCWlmIChiaXRzX2NoYW5nZWQgPT0g
MCkKKwkJCWNvbnRpbnVlOworCisJCWZvciAocm93ID0gMDsgcm93IDwgcGRhdGEtPm51bV9yb3df
Z3Bpb3M7IHJvdysrKSB7CisJCQlpZiAoKGJpdHNfY2hhbmdlZCAmICgxIDw8IHJvdykpID09IDAp
CisJCQkJY29udGludWU7CisKKwkJCWlucHV0X3JlcG9ydF9rZXkoa2V5cGFkLT5pbnB1dF9kZXYs
CisJCQkJCWxvb2t1cF9rZXljb2RlKGtleXBhZCwgcm93LCBjb2wpLAorCQkJCQluZXdfc3RhdGVb
Y29sXSAmICgxIDw8IHJvdykpOworCQl9CisJfQorCWlucHV0X3N5bmMoa2V5cGFkLT5pbnB1dF9k
ZXYpOworCW1lbWNweShrZXlwYWQtPmxhc3Rfa2V5X3N0YXRlLCBuZXdfc3RhdGUsIHNpemVvZihu
ZXdfc3RhdGUpKTsKKworCWFjdGl2YXRlX2FsbF9jb2xzKHBkYXRhLCAxKTsKKwllbmFibGVfcm93
X2lycXMoa2V5cGFkKTsKK30KKworc3RhdGljIGlycXJldHVybl90IG1hdHJpeF9rZXlwYWRfaW50
ZXJydXB0KGludCBpcnEsIHZvaWQgKmlkKQoreworCXN0cnVjdCBtYXRyaXhfa2V5cGFkICprZXlw
YWQgPSBpZDsKKworCWRpc2FibGVfcm93X2lycXMoa2V5cGFkKTsKKwlzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJmtleXBhZC0+d29yaywKKwkJCW1zZWNzX3RvX2ppZmZpZXMoa2V5cGFkLT5wZGF0YS0+
ZGVib3VuY2VfbXMpKTsKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKKyNpZmRlZiBDT05GSUdf
UE0KK3N0YXRpYyBpbnQgbWF0cml4X2tleXBhZF9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsCisJCQkJIHBtX21lc3NhZ2VfdCBzdGF0ZSkKK3sKKwlzdHJ1Y3QgbWF0cml4X2tl
eXBhZCAqa2V5cGFkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisJc3RydWN0IG1hdHJp
eF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBrZXlwYWQtPnBkYXRhOworCWludCBpOwor
CisJZGlzYWJsZV9yb3dfaXJxcyhrZXlwYWQpOworCWZsdXNoX3dvcmsoJmtleXBhZC0+d29yay53
b3JrKTsKKworCWlmIChkZXZpY2VfbWF5X3dha2V1cCgmcGRldi0+ZGV2KSkKKwkJZm9yIChpID0g
MDsgaSA8IHBkYXRhLT5udW1fcm93X2dwaW9zOyBpKyspCisJCQllbmFibGVfaXJxX3dha2UoZ3Bp
b190b19pcnEocGRhdGEtPnJvd19ncGlvc1tpXSkpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRp
YyBpbnQgbWF0cml4X2tleXBhZF9yZXN1bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
K3sKKwlzdHJ1Y3QgbWF0cml4X2tleXBhZCAqa2V5cGFkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cGRldik7CisJc3RydWN0IG1hdHJpeF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBrZXlw
YWQtPnBkYXRhOworCWludCBpOworCisJaWYgKGRldmljZV9tYXlfd2FrZXVwKCZwZGV2LT5kZXYp
KQorCQlmb3IgKGkgPSAwOyBpIDwgcGRhdGEtPm51bV9yb3dfZ3Bpb3M7IGkrKykKKwkJCWRpc2Fi
bGVfaXJxX3dha2UoZ3Bpb190b19pcnEocGRhdGEtPnJvd19ncGlvc1tpXSkpOworCisJLyogVWxp
IEx1Y2thczogc2NoZWR1bGUgYW4gaW1tZWRpYXRlIGtleSBzY2FuIGFzIGFsbCBrZXkgc3RhdGUg
Y2hhbmdlcworCSAqIHdlcmUgbG9zdCB3aGlsZSB0aGUgZGV2aWNlIHdhcyBzdXNwZW5kZWQsIGNv
bHVtbnMgd2lsbCBiZSBhY3RpdmF0ZWQKKwkgKiBhbmQgSVJRcyBiZSBlbmFibGVkIGFmdGVyIHRo
ZSBzY2FuLgorCSAqLworCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygma2V5cGFkLT53b3JrLCAwKTsK
KwlyZXR1cm4gMDsKK30KKyNlbHNlCisjZGVmaW5lIG1hdHJpeF9rZXlwYWRfc3VzcGVuZAlOVUxM
CisjZGVmaW5lIG1hdHJpeF9rZXlwYWRfcmVzdW1lCU5VTEwKKyNlbmRpZgorCitzdGF0aWMgaW50
IF9fZGV2aW5pdCBpbml0X21hdHJpeF9ncGlvKHN0cnVjdCBtYXRyaXhfa2V5cGFkICprZXlwYWQp
Cit7CisJc3RydWN0IG1hdHJpeF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBrZXlwYWQt
PnBkYXRhOworCWludCBpLCBlcnIgPSAtRUlOVkFMOworCisJLyogaW5pdGlhbGl6ZWQgc3Ryb2Jl
IGxpbmVzIGFzIG91dHB1dHMsIGFjdGl2YXRlZCAqLworCWZvciAoaSA9IDA7IGkgPCBwZGF0YS0+
bnVtX2NvbF9ncGlvczsgaSsrKSB7CisJCWVyciA9IGdwaW9fcmVxdWVzdChwZGF0YS0+Y29sX2dw
aW9zW2ldLCAibWF0cml4X2tiZF9jb2wiKTsKKwkJaWYgKGVycikgeworCQkJcHJfZXJyKCJmYWls
ZWQgdG8gcmVxdWVzdCBHUElPJWQgZm9yIENPTCVkXG4iLAorCQkJCQlwZGF0YS0+Y29sX2dwaW9z
W2ldLCBpKTsKKwkJCWdvdG8gZXJyX2ZyZWVfY29sczsKKwkJfQorCisJCWdwaW9fZGlyZWN0aW9u
X291dHB1dChwZGF0YS0+Y29sX2dwaW9zW2ldLCAhcGRhdGEtPmFjdGl2ZV9sb3cpOworCX0KKwor
CWZvciAoaSA9IDA7IGkgPCBwZGF0YS0+bnVtX3Jvd19ncGlvczsgaSsrKSB7CisJCWVyciA9IGdw
aW9fcmVxdWVzdChwZGF0YS0+cm93X2dwaW9zW2ldLCAibWF0cml4X2tiZF9yb3ciKTsKKwkJaWYg
KGVycikgeworCQkJcHJfZXJyKCJmYWlsZWQgdG8gcmVxdWVzdCBHUElPJWQgZm9yIFJPVyVkXG4i
LAorCQkJCQlwZGF0YS0+cm93X2dwaW9zW2ldLCBpKTsKKwkJCWdvdG8gZXJyX2ZyZWVfcm93czsK
KwkJfQorCisJCWdwaW9fZGlyZWN0aW9uX2lucHV0KHBkYXRhLT5yb3dfZ3Bpb3NbaV0pOworCX0K
KworCWZvciAoaSA9IDA7IGkgPCBwZGF0YS0+bnVtX3Jvd19ncGlvczsgaSsrKSB7CisJCWVyciA9
IHJlcXVlc3RfaXJxKGdwaW9fdG9faXJxKHBkYXRhLT5yb3dfZ3Bpb3NbaV0pLAorCQkJCW1hdHJp
eF9rZXlwYWRfaW50ZXJydXB0LCBJUlFGX0RJU0FCTEVEIHwKKwkJCQlJUlFGX1RSSUdHRVJfUklT
SU5HIHwgSVJRRl9UUklHR0VSX0ZBTExJTkcsCisJCQkJIm1hdHJpeC1rZXlwYWQiLCBrZXlwYWQp
OworCQlpZiAoZXJyKSB7CisJCQlwcl9lcnIoIlVuYWJsZSB0byBhY3F1aXJlIGludGVycnVwdCBm
b3IgR1BJTyBsaW5lICVpXG4iLAorCQkJCXBkYXRhLT5yb3dfZ3Bpb3NbaV0pOworCQkJZ290byBl
cnJfZnJlZV9pcnFzOworCQl9CisJfQorCXJldHVybiAwOworCitlcnJfZnJlZV9pcnFzOgorCWZv
ciAoaSA9IGkgLSAxOyBpID49IDA7IGktLSkKKwkJZnJlZV9pcnEoZ3Bpb190b19pcnEocGRhdGEt
PnJvd19ncGlvc1tpXSksIGtleXBhZCk7CisKK2Vycl9mcmVlX3Jvd3M6CisJZm9yIChpID0gaSAt
IDE7IGkgPj0gMDsgaS0tKQorCQlncGlvX2ZyZWUocGRhdGEtPnJvd19ncGlvc1tpXSk7CisKK2Vy
cl9mcmVlX2NvbHM6CisJZm9yIChpID0gaSAtIDE7IGkgPj0gMDsgaS0tKQorCQlncGlvX2ZyZWUo
cGRhdGEtPmNvbF9ncGlvc1tpXSk7CisKKwlyZXR1cm4gZXJyOworfQorCitzdGF0aWMgaW50IF9f
ZGV2aW5pdCBtYXRyaXhfa2V5cGFkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cit7CisJc3RydWN0IG1hdHJpeF9rZXlwYWRfcGxhdGZvcm1fZGF0YSAqcGRhdGE7CisJc3RydWN0
IG1hdHJpeF9rZXlwYWQgKmtleXBhZDsKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXY7CisJ
aW50IGVyciA9IC1FTk9NRU07CisKKwlwZGF0YSA9IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOwor
CWlmIChwZGF0YSA9PSBOVUxMKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIHBsYXRmb3Jt
IGRhdGEgZGVmaW5lZFxuIik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWtleXBhZCA9IGt6
YWxsb2Moc2l6ZW9mKHN0cnVjdCBtYXRyaXhfa2V5cGFkKSwgR0ZQX0tFUk5FTCk7CisJaWYgKGtl
eXBhZCA9PSBOVUxMKQorCQlyZXR1cm4gLUVOT01FTTsKKworCWlucHV0X2RldiA9IGlucHV0X2Fs
bG9jYXRlX2RldmljZSgpOworCWlmICghaW5wdXRfZGV2KQorCQlnb3RvIGVycl9mcmVlX2tleXBh
ZDsKKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGtleXBhZCk7CisKKwlrZXlwYWQtPmlu
cHV0X2RldiA9IGlucHV0X2RldjsKKwlrZXlwYWQtPnBkYXRhID0gcGRhdGE7CisJSU5JVF9ERUxB
WUVEX1dPUksoJmtleXBhZC0+d29yaywgbWF0cml4X2tleXBhZF9zY2FuKTsKKworCWlucHV0X2Rl
di0+bmFtZQkJPSBwZGV2LT5uYW1lOworCWlucHV0X2Rldi0+aWQuYnVzdHlwZQk9IEJVU19IT1NU
OworCWlucHV0X2Rldi0+ZGV2LnBhcmVudAk9ICZwZGV2LT5kZXY7CisJaW5wdXRfZGV2LT5ldmJp
dFswXQk9IEJJVF9NQVNLKEVWX0tFWSkgfCBCSVRfTUFTSyhFVl9SRVApOworCisJZXJyID0gYnVp
bGRfa2V5Y29kZXMoa2V5cGFkKTsKKwlpZiAoZXJyKQorCQlnb3RvIGVycl9mcmVlX2lucHV0Owor
CisJZXJyID0gaW5wdXRfcmVnaXN0ZXJfZGV2aWNlKGtleXBhZC0+aW5wdXRfZGV2KTsKKwlpZiAo
ZXJyKQorCQlnb3RvIGVycl9mcmVlX2tleWNvZGVzOworCisJZXJyID0gaW5pdF9tYXRyaXhfZ3Bp
byhrZXlwYWQpOworCWlmIChlcnIpCisJCWdvdG8gZXJyX3VucmVnaXN0ZXI7CisKKwlkZXZpY2Vf
aW5pdF93YWtldXAoJnBkZXYtPmRldiwgMSk7CisJcmV0dXJuIDA7CisKK2Vycl91bnJlZ2lzdGVy
OgorCWlucHV0X3VucmVnaXN0ZXJfZGV2aWNlKGlucHV0X2Rldik7CitlcnJfZnJlZV9rZXljb2Rl
czoKKwlrZnJlZShrZXlwYWQtPmtleWNvZGVzKTsKK2Vycl9mcmVlX2lucHV0OgorCWlucHV0X2Zy
ZWVfZGV2aWNlKGlucHV0X2Rldik7CitlcnJfZnJlZV9rZXlwYWQ6CisJa2ZyZWUoa2V5cGFkKTsK
KwlyZXR1cm4gZXJyOworfQorCitzdGF0aWMgaW50IF9fZGV2ZXhpdCBtYXRyaXhfa2V5cGFkX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBtYXRyaXhfa2V5
cGFkICprZXlwYWQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlpbnQgaTsKKworCWZv
ciAoaSA9IDA7IGkgPCBrZXlwYWQtPnBkYXRhLT5udW1fcm93X2dwaW9zOyBpKyspIHsKKwkJZnJl
ZV9pcnEoZ3Bpb190b19pcnEoa2V5cGFkLT5wZGF0YS0+cm93X2dwaW9zW2ldKSwga2V5cGFkKTsK
KwkJZ3Bpb19mcmVlKGtleXBhZC0+cGRhdGEtPnJvd19ncGlvc1tpXSk7CisJfQorCisJZm9yIChp
ID0gMDsgaSA8IGtleXBhZC0+cGRhdGEtPm51bV9jb2xfZ3Bpb3M7IGkrKykKKwkJZ3Bpb19mcmVl
KGtleXBhZC0+cGRhdGEtPmNvbF9ncGlvc1tpXSk7CisKKwlpbnB1dF91bnJlZ2lzdGVyX2Rldmlj
ZShrZXlwYWQtPmlucHV0X2Rldik7CisJa2ZyZWUoa2V5cGFkLT5rZXljb2Rlcyk7CisJa2ZyZWUo
a2V5cGFkKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIg
bWF0cml4X2tleXBhZF9kcml2ZXIgPSB7CisJLnByb2JlCQk9IG1hdHJpeF9rZXlwYWRfcHJvYmUs
CisJLnJlbW92ZQkJPSBfX2RldmV4aXRfcChtYXRyaXhfa2V5cGFkX3JlbW92ZSksCisJLnN1c3Bl
bmQJPSBtYXRyaXhfa2V5cGFkX3N1c3BlbmQsCisJLnJlc3VtZQkJPSBtYXRyaXhfa2V5cGFkX3Jl
c3VtZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAibWF0cml4LWtleXBhZCIsCisJCS5vd25l
cgk9IFRISVNfTU9EVUxFLAorCX0sCit9OworCitzdGF0aWMgaW50IF9faW5pdCBtYXRyaXhfa2V5
cGFkX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZtYXRy
aXhfa2V5cGFkX2RyaXZlcik7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBtYXRyaXhfa2V5cGFk
X2V4aXQodm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmbWF0cml4X2tleXBh
ZF9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChtYXRyaXhfa2V5cGFkX2luaXQpOworbW9kdWxl
X2V4aXQobWF0cml4X2tleXBhZF9leGl0KTsKKworTU9EVUxFX0FVVEhPUigiTWFyZWsgVmFzdXQg
PG1hcmVrLnZhc3V0QGdtYWlsLmNvbT4iKTsKK01PRFVMRV9ERVNDUklQVElPTigiR1BJTyBEcml2
ZW4gTWF0cml4IEtleXBhZCBEcml2ZXIiKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsKK01P
RFVMRV9BTElBUygicGxhdGZvcm06bWF0cml4LWtleXBhZCIpOwpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9pbnB1dC9tYXRyaXhfa2V5cGFkLmggYi9pbmNsdWRlL2xpbnV4L2lucHV0L21hdHJp
eF9rZXlwYWQuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi44YjY2MWNiCi0t
LSAvZGV2L251bGwKKysrIGIvaW5jbHVkZS9saW51eC9pbnB1dC9tYXRyaXhfa2V5cGFkLmgKQEAg
LTAsMCArMSwzNCBAQAorI2lmbmRlZiBfTUFUUklYX0tFWVBBRF9ICisjZGVmaW5lIF9NQVRSSVhf
S0VZUEFEX0gKKworI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisKKyNkZWZpbmUgTUFUUklYX01B
WF9ST1dTCQkxNgorI2RlZmluZSBNQVRSSVhfTUFYX0NPTFMJCTE2CisjZGVmaW5lIE1BVFJJWF9N
QVhfS0VZUwkJKE1BVFJJWF9NQVhfUk9XUyAqIE1BVFJJWF9NQVhfQ09MUykKKworc3RydWN0IG1h
dHJpeF9rZXlwYWRfcGxhdGZvcm1fZGF0YSB7CisJLyogc2NhbmNvZGUgbWFwIGZvciB0aGUgbWF0
cml4IGtleXMgKi8KKwl1aW50MzJfdAkqa2V5X21hcDsKKwlpbnQJCWtleV9tYXBfc2l6ZTsKKwor
CXVuc2lnbmVkCXJvd19ncGlvc1tNQVRSSVhfTUFYX1JPV1NdOworCXVuc2lnbmVkCWNvbF9ncGlv
c1tNQVRSSVhfTUFYX0NPTFNdOworCWludAkJbnVtX3Jvd19ncGlvczsKKwlpbnQJCW51bV9jb2xf
Z3Bpb3M7CisKKwl1bnNpZ25lZCBpbnQJYWN0aXZlX2xvdzsKKwl1bnNpZ25lZCBpbnQJY29sX3Nj
YW5fZGVsYXlfdXM7CisKKwkvKiBrZXkgZGVib3VuY2UgaW50ZXJ2YWwgaW4gbWlsbGktc2Vjb25k
ICovCisJdW5zaWduZWQgaW50CWRlYm91bmNlX21zOworfTsKKworI2RlZmluZSBLRVkocm93LCBj
b2wsIHZhbCkJKCgoKHJvdykgJiAoTUFUUklYX01BWF9ST1dTIC0gMSkpIDw8IDI4KSB8XAorCQkJ
CSAoKChjb2wpICYgKE1BVFJJWF9NQVhfQ09MUyAtIDEpKSA8PCAyNCkgfFwKKwkJCQkgKHZhbCAm
IDB4ZmZmZmZmKSkKKworI2RlZmluZSBLRVlfUk9XQ09MKGspCQkoKChrKSA+PiAyNCkgJiAweGZm
KQorI2RlZmluZSBLRVlfVkFMKGspCQkoKGspICYgMHhmZmZmZmYpCisKKyNlbmRpZiAvKiBfTUFU
UklYX0tFWVBBRF9IICovCi0tIAoxLjYuMC40Cgo=
--00163646bf8a8b57a0046b6bb557--
