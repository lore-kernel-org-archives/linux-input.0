From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Thu, 11 Jun 2009 21:03:53 -0700
Message-ID: <200906112103.54043.dmitry.torokhov@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com> <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:8716 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZFLFIG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2009 01:08:06 -0400
Received: by rv-out-0506.google.com with SMTP id f9so581764rvb.1
        for <linux-input@vger.kernel.org>; Thu, 11 Jun 2009 22:08:08 -0700 (PDT)
In-Reply-To: <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

On Sunday 07 June 2009 07:04:09 Eric Miao wrote:
> On Wed, Jun 3, 2009 at 2:24 PM, Eric Miao<eric.y.miao@gmail.com> wrote:
> > On Tue, Jun 2, 2009 at 11:14 PM, Uli Luckas <u.luckas@road.de> wrote:
> >> One more...
> >>
> >> As all gpio handling is done in a workqueue,
> >> gpio_set_value_cansleep/gpio_get_value_cansleep could probably be used.
> >> This would make the driver ready for gpios on external controllers (via
> >> i2c for example).
> >
> > Sounds good, patch updated again, with attachment.
>
> Hi Dmitry,
>
> I'd like to know if this patch is able to get into the boat of the
> next merge window, I have several patches depending on
> this, and it seems that Trilok has something as well. I know
> it might take some time to review all this, but let me know
> if there are anything I can help.
>

Eric,

I tried to merge your latest patch with some work I have done earlier,
the result is below. Please give it a try and if it still works then
I will queue it for pull.

The most important change IMHO is the way IRQs are enabled and disabled.
We cannot simply do that without any locking because (on SMP) more than
one interrupt handler may be executing at the same time causing interrupts
being disabled several times. Same goes for enabling interrupts at the end
of the scan - once first is enabled we have a chance of getting it raised
right away and then we have 2 pieces racing against each other, one
enabling and another disabling interrupts. Also care is needed to flush
work properly at remove time. Please check out the logic for holes in case
I missed something.

Other changes:
- Make key table definition useable to other drivers;
- Allow changing keymap from userspace
- open/close
- various cleanups.

Thanks!

--
Dmitry

Input: add support for generic GPIO-based matrix keypad

From: Eric Miao <eric.y.miao@gmail.com>

Original patch by Marek Vasut, modified by Eric in:

1. use delayed work to simplify the debouncing
2. combine col_polarity/row_polarity into a single active_low field
3. use a generic bit array based XOR algorithm to detect key
   press/release, which should make the column assertion time
   shorter and code a bit cleaner
4. remove the ALT_FN handling, which is no way generic, the ALT_FN
   key should be treated as no different from other keys, and
   translation will be done by user space by commands like 'loadkeys'.

[dtor@mail.ru: fix error unwinding path, support changing keymap
 from userspace]
Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Kconfig         |   13 +
 drivers/input/keyboard/Makefile        |    1 
 drivers/input/keyboard/matrix_keypad.c |  453 ++++++++++++++++++++++++++++++++
 include/linux/input/matrix_keypad.h    |   65 +++++
 4 files changed, 530 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/keyboard/matrix_keypad.c
 create mode 100644 include/linux/input/matrix_keypad.h


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d2df103..a6b989a 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -158,7 +158,16 @@ config KEYBOARD_GPIO
 	  with configuration data saying which GPIOs are used.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called gpio-keys.
+	  module will be called gpio_keys.
+
+config KEYBOARD_MATRIX
+	tristate "GPIO driven matrix keypad support"
+	depends on GENERIC_GPIO
+	help
+	  Enable support for GPIO driven matrix keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called matrix_keypad.
 
 config KEYBOARD_HIL_OLD
 	tristate "HP HIL keyboard support (simple driver)"
@@ -254,7 +263,7 @@ config KEYBOARD_PXA27x
 	tristate "PXA27x/PXA3xx keypad support"
 	depends on PXA27x || PXA3xx
 	help
-	  Enable support for PXA27x/PXA3xx keypad controller
+	  Enable support for PXA27x/PXA3xx keypad controller.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa27x_keypad.
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 632efbc..b5b5eae 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
 obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
+obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
new file mode 100644
index 0000000..4040cf0
--- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,453 @@
+/*
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
+#include <linux/types.h>
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
+	const struct matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+	unsigned short *keycodes;
+
+	uint32_t last_key_state[MATRIX_MAX_COLS];
+	struct delayed_work work;
+	bool scan_pending;
+	bool stopped;
+	spinlock_t lock;
+};
+
+/*
+ * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
+ * minmal side effect when scanning other columns, here it is configured to
+ * be input, and it should work on most platforms.
+ */
+static void __activate_col(const struct matrix_keypad_platform_data *pdata,
+			   int col, bool on)
+{
+	bool level_on = !pdata->active_low;
+
+	if (on) {
+		gpio_direction_output(pdata->col_gpios[col], level_on);
+	} else {
+		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
+		gpio_direction_input(pdata->col_gpios[col]);
+	}
+}
+
+static void activate_col(const struct matrix_keypad_platform_data *pdata,
+			 int col, bool on)
+{
+	__activate_col(pdata, col, on);
+
+	if (on && pdata->col_scan_delay_us)
+		udelay(pdata->col_scan_delay_us);
+}
+
+static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
+			      bool on)
+{
+	int col;
+
+	for (col = 0; col < pdata->num_col_gpios; col++)
+		__activate_col(pdata, col, on);
+}
+
+static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
+			 int row)
+{
+	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
+			!pdata->active_low : pdata->active_low;
+}
+
+static void enable_row_irqs(struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	for (i = 0; i < pdata->num_row_gpios; i++)
+		enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+}
+
+static void disable_row_irqs(struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
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
+		container_of(work, struct matrix_keypad, work.work);
+	struct input_dev *input_dev = keypad->input_dev;
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	uint32_t new_state[MATRIX_MAX_COLS];
+	int row, col, code;
+
+	/* de-activate all columns for scanning */
+	activate_all_cols(pdata, false);
+
+	memset(new_state, 0, sizeof(new_state));
+
+	/* assert each column and read the row status out */
+	for (col = 0; col < pdata->num_col_gpios; col++) {
+
+		activate_col(pdata, col, true);
+
+		for (row = 0; row < pdata->num_row_gpios; row++)
+			new_state[col] |=
+				row_asserted(pdata, row) ? (1 << row) : 0;
+
+		activate_col(pdata, col, false);
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
+			code = (row << 4) + col;
+			input_event(input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(input_dev,
+					 keypad->keycodes[code],
+					 new_state[col] & (1 << row));
+		}
+	}
+	input_sync(input_dev);
+
+	memcpy(keypad->last_key_state, new_state, sizeof(new_state));
+
+	activate_all_cols(pdata, true);
+
+	/* Enable IRQs again */
+	spin_lock_irq(&keypad->lock);
+	keypad->scan_pending = false;
+	enable_row_irqs(keypad);
+	spin_unlock_irq(&keypad->lock);
+}
+
+static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
+{
+	struct matrix_keypad *keypad = id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&keypad->lock, flags);
+
+	/*
+	 * See if another IRQ beaten us to it and scheduled the
+	 * scan already. In that case we should not try to
+	 * disable IRQs again.
+	 */
+	if (unlikely(keypad->scan_pending || keypad->stopped))
+		goto out;
+
+	disable_row_irqs(keypad);
+	keypad->scan_pending = true;
+	schedule_delayed_work(&keypad->work,
+		msecs_to_jiffies(keypad->pdata->debounce_ms));
+
+out:
+	spin_unlock_irqrestore(&keypad->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static int matrix_keypad_start(struct input_dev *dev)
+{
+	struct matrix_keypad *keypad = input_get_drvdata(dev);
+
+	keypad->stopped = false;
+	mb();
+
+	/*
+	 * Schedule an immediate key scan to capture current key state;
+	 * columns will be activated and IRQs be enabled after the scan.
+	 */
+	schedule_delayed_work(&keypad->work, 0);
+
+	return 0;
+}
+
+static void matrix_keypad_stop(struct input_dev *dev)
+{
+	struct matrix_keypad *keypad = input_get_drvdata(dev);
+
+	keypad->stopped = true;
+	mb();
+	flush_work(&keypad->work.work);
+	/*
+	 * matrix_keypad_scan() will leave IRQs enabled;
+	 * we should disable them now.
+	 */
+	disable_row_irqs(keypad);
+}
+
+#ifdef CONFIG_PM
+static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	matrix_keypad_stop(keypad->input_dev);
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
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	if (device_may_wakeup(&pdev->dev))
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+
+	matrix_keypad_start(keypad->input_dev);
+
+	return 0;
+}
+#else
+#define matrix_keypad_suspend	NULL
+#define matrix_keypad_resume	NULL
+#endif
+
+static int __devinit init_matrix_gpio(struct platform_device *pdev,
+					struct matrix_keypad *keypad)
+{
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i, err = -EINVAL;
+
+	/* initialized strobe lines as outputs, activated */
+	for (i = 0; i < pdata->num_col_gpios; i++) {
+		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to request GPIO%d for COL%d\n",
+				pdata->col_gpios[i], i);
+			goto err_free_cols;
+		}
+
+		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to request GPIO%d for ROW%d\n",
+				pdata->row_gpios[i], i);
+			goto err_free_rows;
+		}
+
+		gpio_direction_input(pdata->row_gpios[i]);
+	}
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
+				matrix_keypad_interrupt,
+				IRQF_DISABLED |
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"matrix-keypad", keypad);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Unable to acquire interrupt for GPIO line %i\n",
+				pdata->row_gpios[i]);
+			goto err_free_irqs;
+		}
+	}
+	return 0;
+
+err_free_irqs:
+	while (--i >= 0)
+		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+	i = pdata->num_row_gpios;
+err_free_rows:
+	while (--i >= 0)
+		gpio_free(pdata->row_gpios[i]);
+	i = pdata->num_col_gpios;
+err_free_cols:
+	while (--i >= 0)
+		gpio_free(pdata->col_gpios[i]);
+
+	return err;
+}
+
+static int __devinit matrix_keypad_probe(struct platform_device *pdev)
+{
+	const struct matrix_keypad_platform_data *pdata;
+	const struct matrix_keymap_data *keymap_data;
+	struct matrix_keypad *keypad;
+	struct input_dev *input_dev;
+	unsigned short *keycodes;
+	int i;
+	int err;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	keymap_data = pdata->keymap_data;
+	if (!keymap_data) {
+		dev_err(&pdev->dev, "no keymap data defined\n");
+		return -EINVAL;
+	}
+
+	if (!keymap_data->max_keymap_size) {
+		dev_err(&pdev->dev, "invalid keymap data supplied\n");
+		return -EINVAL;
+	}
+
+	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	keycodes = kzalloc(keymap_data->max_keymap_size *
+				sizeof(keypad->keycodes),
+			   GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !keycodes || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	keypad->input_dev = input_dev;
+	keypad->pdata = pdata;
+	keypad->keycodes = keycodes;
+	keypad->stopped = true;
+	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+	spin_lock_init(&keypad->lock);
+
+	input_dev->name		= pdev->name;
+	input_dev->id.bustype	= BUS_HOST;
+	input_dev->dev.parent	= &pdev->dev;
+	input_dev->evbit[0]	= BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	input_dev->open		= matrix_keypad_start;
+	input_dev->close	= matrix_keypad_stop;
+
+	input_dev->keycode	= keycodes;
+	input_dev->keycodesize	= sizeof(*keycodes);
+	input_dev->keycodemax	= keymap_data->max_keymap_size;
+
+	for (i = 0; i < keymap_data->keymap_size; i++) {
+		unsigned int key = keymap_data->keymap[i];
+		unsigned int row = KEY_ROW(key);
+		unsigned int col = KEY_COL(key);
+		unsigned short code = KEY_VAL(key);
+
+		keycodes[(row << 4) + col] = code;
+		__set_bit(code, input_dev->keybit);
+	}
+	__clear_bit(KEY_RESERVED, input_dev->keybit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	input_set_drvdata(input_dev, keypad);
+
+	err = input_register_device(keypad->input_dev);
+	if (err)
+		goto err_free_mem;
+
+	err = init_matrix_gpio(pdev, keypad);
+	if (err)
+		goto err_unregister;
+
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+
+err_unregister:
+	input_unregister_device(input_dev);
+	input_dev = NULL;
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(keycodes);
+	kfree(keypad);
+	return err;
+}
+
+static int __devexit matrix_keypad_remove(struct platform_device *pdev)
+{
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
+	int i;
+
+	device_init_wakeup(&pdev->dev, 0);
+
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+		gpio_free(pdata->row_gpios[i]);
+	}
+
+	for (i = 0; i < pdata->num_col_gpios; i++)
+		gpio_free(pdata->col_gpios[i]);
+
+	input_unregister_device(keypad->input_dev);
+	platform_set_drvdata(pdev, NULL);
+	kfree(keypad->keycodes);
+	kfree(keypad);
+
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
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
new file mode 100644
index 0000000..f945402
--- /dev/null
+++ b/include/linux/input/matrix_keypad.h
@@ -0,0 +1,65 @@
+#ifndef _MATRIX_KEYPAD_H
+#define _MATRIX_KEYPAD_H
+
+#include <linux/types.h>
+#include <linux/input.h>
+
+#define MATRIX_MAX_ROWS		16
+#define MATRIX_MAX_COLS		16
+
+#define KEY(row, col, val)	((((row) & (MATRIX_MAX_ROWS - 1)) << 24) |\
+				 (((col) & (MATRIX_MAX_COLS - 1)) << 16) |\
+				 (val & 0xffff))
+
+#define KEY_ROW(k)		(((k) >> 24) & 0xff)
+#define KEY_COL(k)		(((k) >> 16) & 0xff)
+#define KEY_VAL(k)		((k) & 0xffff)
+
+/**
+ * struct matrix_keymap_data - keymap for matrix keyboards
+ * @keymap: pointer to array of uint32 values encoded with KEY() macro
+ * 	representing keymap
+ * @keymap_size: number of entries (initialized) in this keymap
+ * @max_keymap_size: maximum size of keymap supported by the device
+ *
+ * This structure is supposed to be used by platform code to supply
+ * keymaps to drivers that implement matrix-like keypads/keyboards.
+ */
+struct matrix_keymap_data {
+	const uint32_t *keymap;
+	unsigned int	keymap_size;
+	unsigned int	max_keymap_size;
+};
+
+/**
+ * struct matrix_keypad_platform_data - platform-dependent keypad data
+ * @keymap_data: pointer to &matrix_keymap_data
+ * @row_gpios: array of gpio numbers reporesenting rows
+ * @col_gpios: array of gpio numbers reporesenting colums
+ * @num_row_gpios: actual number of row gpios used by device
+ * @num_col_gpios: actual number of col gpios used by device
+ * @col_scan_delay_us: delay, measured in microseconds, that is
+ * 	needed before we can keypad after activating column gpio
+ * @debounce_ms: debounce interval in milliseconds
+ *
+ * This structure represents platform-specific data that use used by
+ * matrix_keypad driver to perform proper initialization.
+ */
+struct matrix_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
+
+	unsigned int	row_gpios[MATRIX_MAX_ROWS];
+	unsigned int	col_gpios[MATRIX_MAX_COLS];
+	unsigned int	num_row_gpios;
+	unsigned int	num_col_gpios;
+
+	unsigned int	col_scan_delay_us;
+
+	/* key debounce interval in milli-second */
+	unsigned int	debounce_ms;
+
+	bool		active_low;
+	bool		wakeup;
+};
+
+#endif /* _MATRIX_KEYPAD_H */

