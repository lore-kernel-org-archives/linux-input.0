From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/3] Matrix keypad
Date: Wed, 9 Jul 2008 03:41:20 +0200
Message-ID: <200807090341.20397.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AdBdIU9jnH54HFp"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:29183 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYGIBj0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2008 21:39:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1478137fkq.5
        for <linux-input@vger.kernel.org>; Tue, 08 Jul 2008 18:39:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--Boundary-00=_AdBdIU9jnH54HFp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
this is the gpio driven matrix keypad. Final version.
I also CCed it to linux-input since it might interest them.

--Boundary-00=_AdBdIU9jnH54HFp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="09-matrix_keypad.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="09-matrix_keypad.patch"

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index efd70a9..31b91ba 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -323,4 +323,14 @@ config KEYBOARD_SH_KEYSC
 
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
index 0edc8f2..b22bae1 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
new file mode 100644
index 0000000..1a1503d
--- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,351 @@
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
+#include <linux/matrix_keypad.h>
+
+struct matrix_keypad {
+	struct matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+
+	spinlock_t lock;
+	struct timer_list timer;
+
+	unsigned int suspended;
+	unsigned long suspend_jiffies;
+
+	/* on, off, alt flags */
+	unsigned int size;
+	unsigned int *flags;
+};
+
+/*
+ * Get alternate function button status (if there is any on our keypad)
+ */
+static unsigned char matrix_keypad_get_fn(struct matrix_keypad *keypad)
+{
+	unsigned char fn = 0;
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+
+	if (!pdata->alt_row || !pdata->alt_col)
+		return 0;
+
+	/* get the altfn key status */
+	gpio_set_value(pdata->row_gpio[pdata->alt_row],	!pdata->row_polarity);
+	udelay(50);
+	fn = !!gpio_get_value(pdata->col_gpio[pdata->alt_col]);
+	if (pdata->col_polarity)
+		fn = !fn;
+	gpio_set_value(pdata->row_gpio[pdata->alt_row],	pdata->row_polarity);
+	return fn;
+}
+
+/*
+ * Lookup the key in our keymap
+ */
+static unsigned int matrix_keypad_lookup(int row, int col,
+				struct matrix_keypad *keypad, int altfn)
+{
+	int i;
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+
+	for (i = 0; i < pdata->map_size; i++)
+		if ((row == ((pdata->map[i]>>28) & 0xf)) &&
+		     (col == ((pdata->map[i]>>24) & 0xf)))
+			return (pdata->map[i] >> (12 * altfn)) & 0xfff;
+	return 0xfff;
+}
+
+/*
+ * This gets the keys from keyboard and reports it to input subsystem
+ */
+static void matrix_keypad_process(struct matrix_keypad *keypad)
+{
+	unsigned char fn = 0;
+	int i, j, pressed = 0;
+	unsigned long flags;
+	int gpio, key = 0;
+	struct matrix_keypad_platform_data *pdata = keypad->pdata;
+
+	spin_lock_irqsave(&keypad->lock, flags);
+
+	/* disable interrupts */
+	for (i = 0; i < pdata->col_gpio_size; i++)
+		set_irq_type(gpio_to_irq(pdata->col_gpio[i]),
+				IRQF_TRIGGER_NONE);
+
+	/* set all unreadable */
+	for (i = 0; i < pdata->row_gpio_size; i++)
+		gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
+
+	fn = matrix_keypad_get_fn(keypad);
+
+	/* read the keypad matrix */
+	for (i = 0; i < pdata->row_gpio_size; i++) {
+		gpio_set_value(pdata->row_gpio[i], !pdata->row_polarity);
+		udelay(50);
+		for (j = 0; j < pdata->col_gpio_size; j++) {
+				gpio = gpio_get_value(pdata->col_gpio[j]);
+				if (pdata->col_polarity)
+					gpio = !gpio;
+				if (gpio)
+					pressed++;
+				key = matrix_keypad_lookup(i, j, keypad, fn);
+				if (key == 0xfff)
+					continue;
+				if (gpio) {
+					input_report_key(keypad->input_dev,
+							key, 1);
+					keypad->flags[(key/32) + (keypad->size
+						* fn)] |= 1<<(key%32);
+				} else if ((keypad->flags[(key/32) +
+						(keypad->size * fn)] &
+						(1<<(key%32))) && !gpio) {
+					input_report_key(keypad->input_dev,
+							key, 0);
+					keypad->flags[(key/32) + (keypad->size
+						* fn)] &= ~(1<<(key%32));
+				}
+		}
+		gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
+		udelay(50);
+	}
+
+	/* set all readable */
+	for (i = 0; i < pdata->row_gpio_size; i++)
+		gpio_set_value(pdata->row_gpio[i],
+				!pdata->row_polarity);
+
+	/* reenable interrupts */
+	for (i = 0; i < pdata->col_gpio_size; i++)
+		set_irq_type(gpio_to_irq(pdata->col_gpio[i]),
+			    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);
+
+	/* report to input subsystem */
+	input_sync(keypad->input_dev);
+
+	/* if there were any new keypresses, handle repeats by rereading */
+	if (pressed)
+		mod_timer(&keypad->timer, jiffies + msecs_to_jiffies(
+				    pdata->debounce_interval));
+
+	spin_unlock_irqrestore(&keypad->lock, flags);
+}
+
+/*
+ * Interrupt handler
+ */
+static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
+{
+	struct matrix_keypad *keypad = id;
+
+	if (!timer_pending(&keypad->timer)) {
+		udelay(20);
+		matrix_keypad_process(keypad);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Timer checking for released keys and still held keys
+ */
+static void matrix_keypad_timer_callback(unsigned long data)
+{
+	struct matrix_keypad *keypad = (struct matrix_keypad *) data;
+	matrix_keypad_process(keypad);
+}
+
+#ifdef CONFIG_PM
+static int matrix_keypad_suspend(struct platform_device *dev,
+				pm_message_t state)
+{
+	int i;
+	struct matrix_keypad *keypad = platform_get_drvdata(dev);
+
+	keypad->suspended = 1;
+
+	/* we dont really want to suspend power key here */
+	for (i = 1; i < keypad->pdata->row_gpio_size; i++)
+		gpio_direction_input(keypad->pdata->row_gpio[i]);
+
+	return 0;
+}
+
+static int matrix_keypad_resume(struct platform_device *dev)
+{
+	int i;
+	struct matrix_keypad *keypad = platform_get_drvdata(dev);
+
+	/* Set strobe lines as outputs, low */
+	for (i = 0; i < keypad->pdata->row_gpio_size; i++)
+		gpio_direction_output(keypad->pdata->row_gpio[i], 0);
+
+	/* Upon resume, ignore the suspend key for a short while */
+	keypad->suspend_jiffies = jiffies;
+	keypad->suspended = 0;
+
+	return 0;
+}
+#else
+#define matrix_keypad_suspend	NULL
+#define matrix_keypad_resume	NULL
+#endif
+
+/*
+ * Everything starts here
+ */
+static int __init matrix_keypad_probe(struct platform_device *pdev)
+{
+	struct matrix_keypad *keypad;
+	struct input_dev *input_dev;
+	int i, err = -ENOMEM;
+
+	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !input_dev)
+		goto fail;
+
+	platform_set_drvdata(pdev, keypad);
+
+	keypad->input_dev = input_dev;
+	keypad->pdata = pdev->dev.platform_data;
+	keypad->size = (keypad->pdata->map_size / sizeof(unsigned int))+1;
+	keypad->flags = kzalloc(2 * keypad->size, GFP_KERNEL);
+	if (!keypad->flags)
+		goto fail;
+
+	spin_lock_init(&keypad->lock);
+
+	/* Init Keyboard rescan timer */
+	init_timer(&keypad->timer);
+	keypad->timer.function = matrix_keypad_timer_callback;
+	keypad->timer.data = (unsigned long) keypad;
+
+	keypad->suspend_jiffies = jiffies;
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+		BIT_MASK(EV_PWR) | BIT_MASK(EV_SW);
+	input_dev->keycodesize = sizeof(unsigned int);
+
+	for (i = 0; i < keypad->pdata->map_size; i++) {
+		if ((keypad->pdata->map[i] & 0xfff) != 0xfff)
+			set_bit((keypad->pdata->map[i] & 0xfff),
+				input_dev->keybit);
+		if (((keypad->pdata->map[i] >> 12) & 0xfff) != 0xfff)
+			set_bit((keypad->pdata->map[i] >> 12) & 0xfff,
+				input_dev->keybit);
+	}
+
+	err = input_register_device(keypad->input_dev);
+	if (err)
+		goto fail;
+
+	for (i = 0; i < keypad->pdata->col_gpio_size; i++) {
+		gpio_direction_input(keypad->pdata->col_gpio[i]);
+		if (request_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
+				matrix_keypad_interrupt, IRQF_DISABLED |
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"matrix-keypad", keypad))
+			printk(KERN_ERR "Unable to acquire interrupt"
+				" for GPIO line %i\n",
+				keypad->pdata->col_gpio[i]);
+	}
+
+	/* Set strobe lines as outputs, low */
+	for (i = 0; i < keypad->pdata->row_gpio_size; i++) {
+		err = gpio_request(keypad->pdata->row_gpio[i],
+				    "KBD_LINE");
+		if (err)
+			goto gpio_err;
+		gpio_direction_output(keypad->pdata->row_gpio[i], 0);
+	}
+
+	return 0;
+
+gpio_err:
+	for (i = i-1; i >= 0; i--)
+		gpio_free(keypad->pdata->row_gpio[i]);
+
+fail:	input_free_device(input_dev);
+	kfree(keypad);
+	return err;
+}
+
+/*
+ * Everything ends here
+ */
+static int matrix_keypad_remove(struct platform_device *pdev)
+{
+	int i;
+	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
+
+	for (i = 0; i < keypad->pdata->col_gpio_size; i++)
+		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
+				    keypad);
+
+	for (i = 0; i < keypad->pdata->row_gpio_size; i++)
+		gpio_free(keypad->pdata->row_gpio[i]);
+
+	del_timer_sync(&keypad->timer);
+
+	input_unregister_device(keypad->input_dev);
+
+	kfree(keypad->flags);
+	kfree(keypad);
+
+	return 0;
+}
+
+static struct platform_driver matrix_keypad_driver = {
+	.probe		= matrix_keypad_probe,
+	.remove		= matrix_keypad_remove,
+	.suspend	= matrix_keypad_suspend,
+	.resume		= matrix_keypad_resume,
+	.driver		= {
+		.name	= "matrix-keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __devinit matrix_keypad_init(void)
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
diff --git a/include/linux/matrix_keypad.h b/include/linux/matrix_keypad.h
new file mode 100644
index 0000000..fe72721
--- /dev/null
+++ b/include/linux/matrix_keypad.h
@@ -0,0 +1,35 @@
+#ifndef _MATRIX_KEYPAD_H
+#define _MATRIX_KEYPAD_H
+
+#include <linux/input.h>
+
+struct matrix_keypad_platform_data {
+
+	/* code map for the matrix keys */
+	unsigned int	*map;
+	int		map_size;
+
+	unsigned int	*col_gpio;
+	int		col_gpio_size;
+	unsigned int	*row_gpio;
+	int		row_gpio_size;
+
+	/* ALTFN key */
+	int		alt_row;
+	int		alt_col;
+
+	/* line polarities */
+	unsigned int	col_polarity;
+	unsigned int	row_polarity;
+
+	/* key debounce interval */
+	unsigned int	debounce_interval;
+};
+
+#define KEY(row, col, val, alt)	(((row) << 28) | ((col) << 24) | \
+				((alt & 0xfff) << 12) | (val & 0xfff))
+
+/* key not connected */
+#define KEY_NC	0xfff
+
+#endif /* _MATRIX_KEYPAD_H */

--Boundary-00=_AdBdIU9jnH54HFp--
