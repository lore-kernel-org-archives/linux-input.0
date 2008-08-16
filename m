From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] GPIO driven matrix keypad driver
Date: Sat, 16 Aug 2008 19:22:35 +0200
Message-ID: <200808161922.36021.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_czwpIQUyn7aRI83"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:44400 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYHPRSw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Aug 2008 13:18:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1215763fgg.17
        for <linux-input@vger.kernel.org>; Sat, 16 Aug 2008 10:18:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

--Boundary-00=_czwpIQUyn7aRI83
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
the following patch adds the generic GPIO driven matrix keypad driver. I 
tested this on two devices I had available - palmtc and palmt3. It should be 
able to replace corgikbd.c later as well, but I dont have that device. And 
since this is platform independent driver, any chip that makes it's GPIOs 
available through gpiolib should be OK with this driver as well. Please 
consider applying.

Thanks
Marek

--Boundary-00=_czwpIQUyn7aRI83
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0012-Matrix-add-GPIO-driven-matrix-keypad-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0012-Matrix-add-GPIO-driven-matrix-keypad-driver.patch"

=46rom fd96a2a7df64e5d26a757bd91b56bcefdbbc543e Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Sat, 16 Aug 2008 18:53:05 +0200
Subject: [PATCH] Matrix: add GPIO driven matrix keypad driver

=2D--
 drivers/input/keyboard/Kconfig         |   10 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/matrix_keypad.c |  346 ++++++++++++++++++++++++++++=
++++
 include/linux/matrix_keypad.h          |   39 ++++
 4 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/matrix_keypad.c
 create mode 100644 include/linux/matrix_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index efd70a9..31b91ba 100644
=2D-- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -323,4 +323,14 @@ config KEYBOARD_SH_KEYSC
=20
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
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index 0edc8f2..b22bae1 100644
=2D-- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)		+=3D jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+=3D bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MATRIX)		+=3D matrix_keypad.o
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboar=
d/matrix_keypad.c
new file mode 100644
index 0000000..7fc20f4
=2D-- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,346 @@
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
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/matrix_keypad.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+
+struct matrix_keypad {
+	struct matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+
+	struct task_struct *kthread;
+	unsigned char irqs;
+
+	/* on, off, alt flags */
+	unsigned char *flags;
+};
+
+/*
+ * Lookup the key in our keymap
+ */
+static unsigned int matrix_keypad_lookup(int row, int col,
+				struct matrix_keypad *keypad)
+{
+	int i;
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+
+	for (i =3D 0; i < pdata->map_size; i++)
+		if ((row =3D=3D ((pdata->map[i]>>28) & 0xf)) &&
+		     (col =3D=3D ((pdata->map[i]>>24) & 0xf)))
+			return pdata->map[i] & 0xfff;
+	return 0xfff;
+}
+
+/*
+ * This analyzes the key and reports it to the input subsystem
+ */
+static unsigned int matrix_keypad_process(struct matrix_keypad *keypad,
+					int i, int j)
+{
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int pressed =3D 0, key =3D 0, gpio;
+
+	gpio =3D gpio_get_value(pdata->col_gpio[j]);
+	if (pdata->col_polarity)
+		gpio =3D !gpio;
+	if (gpio)
+		pressed++;
+	key =3D matrix_keypad_lookup(i, j, keypad);
+	if (key =3D=3D 0xfff)
+		return pressed;
+	if (key & KEY_SFT)
+		input_report_key(keypad->input_dev, KEY_LEFTSHIFT, 1);
+	if (gpio) {
+		input_report_key(keypad->input_dev, key & 0x7ff, 1);
+		keypad->flags[key / 8] |=3D 1 << (key % 8);
+	} else if ((keypad->flags[key / 8] & (1 << (key % 8))) && !gpio) {
+		input_report_key(keypad->input_dev, key & 0x7ff, 0);
+		keypad->flags[key / 8] &=3D ~(1 << (key % 8));
+	}
+	if (key & KEY_SFT)
+		input_report_key(keypad->input_dev, KEY_LEFTSHIFT, 0);
+
+	return pressed;
+}
+
+/*
+ * This gets the keys from keyboard
+ */
+static int matrix_keypad_thread(void *arg)
+{
+	int i, j, pressed;
+	struct matrix_keypad *keypad =3D arg;
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+
+	set_freezable();
+	while (!kthread_should_stop()) {
+		if (try_to_freeze())
+			continue;
+
+		pressed =3D 0;
+
+		/* set all unreadable */
+		for (i =3D 0; i < pdata->row_gpio_size; i++)
+			gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
+
+		/* read the keypad matrix */
+		for (i =3D 0; i < pdata->row_gpio_size; i++) {
+			gpio_set_value(pdata->row_gpio[i],
+					!pdata->row_polarity);
+			udelay(pdata->gpio_delay);
+
+			for (j =3D 0; j < pdata->col_gpio_size; j++)
+				pressed +=3D matrix_keypad_process(keypad, i, j);
+
+			gpio_set_value(pdata->row_gpio[i], pdata->row_polarity);
+			udelay(pdata->gpio_delay);
+		}
+
+		/* set all readable */
+		for (i =3D 0; i < pdata->row_gpio_size; i++)
+			gpio_set_value(pdata->row_gpio[i],
+					!pdata->row_polarity);
+
+
+		/* report to input subsystem */
+		input_sync(keypad->input_dev);
+
+		if (pressed)
+			msleep(pdata->scan_delay);
+		else {
+			/* reenable interrupts */
+			if (!keypad->irqs) {
+				for (i =3D 0; i < pdata->col_gpio_size; i++)
+					enable_irq(gpio_to_irq(
+							pdata->col_gpio[i]));
+				keypad->irqs =3D 1;
+			}
+			schedule();
+		}
+	}
+	return 0;
+}
+
+/*
+ * Interrupt handler
+ */
+static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
+{
+	struct matrix_keypad *keypad =3D id;
+	unsigned long flags;
+	int i;
+
+	/* disable interrupts as soon as possible */
+	local_irq_save(flags);
+	if (keypad->irqs) {
+		for (i =3D 0; i < keypad->pdata->col_gpio_size; i++)
+			disable_irq(gpio_to_irq(keypad->pdata->col_gpio[i]));
+		keypad->irqs =3D 0;
+		wake_up_process(keypad->kthread);
+	}
+	local_irq_restore(flags);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+static int matrix_keypad_suspend(struct platform_device *dev,
+				pm_message_t state)
+{
+	struct matrix_keypad *keypad =3D platform_get_drvdata(dev);
+
+	return keypad->pdata->suspend ?
+		keypad->pdata->suspend(dev, state) : 0;
+}
+
+static int matrix_keypad_resume(struct platform_device *dev)
+{
+	struct matrix_keypad *keypad =3D platform_get_drvdata(dev);
+
+	return keypad->pdata->resume ? keypad->pdata->resume(dev) : 0;
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
+	int i, err =3D -ENOMEM;
+
+	keypad =3D kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!keypad || !input_dev)
+		goto fail;
+
+	platform_set_drvdata(pdev, keypad);
+
+	keypad->input_dev =3D input_dev;
+	keypad->pdata =3D pdev->dev.platform_data;
+	keypad->flags =3D kzalloc(4 * KEY_CNT, GFP_KERNEL);
+	if (!keypad->flags)
+		goto fail;
+
+	input_dev->name =3D pdev->name;
+	input_dev->id.bustype =3D BUS_HOST;
+	input_dev->dev.parent =3D &pdev->dev;
+
+	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+		BIT_MASK(EV_PWR) | BIT_MASK(EV_SW);
+	input_dev->keycodesize =3D sizeof(unsigned int);
+
+	for (i =3D 0; i < keypad->pdata->map_size; i++) {
+		if ((keypad->pdata->map[i] & 0xfff) !=3D 0xfff)
+			set_bit((keypad->pdata->map[i] & 0xfff),
+				input_dev->keybit);
+		if (((keypad->pdata->map[i] >> 12) & 0xfff) !=3D 0xfff)
+			set_bit((keypad->pdata->map[i] >> 12) & 0xfff,
+				input_dev->keybit);
+	}
+
+	err =3D input_register_device(keypad->input_dev);
+	if (err)
+		goto fail;
+
+	for (i =3D 0; i < keypad->pdata->col_gpio_size; i++) {
+		err =3D gpio_request(keypad->pdata->col_gpio[i], "KBD_IRQ");
+		if (err)
+			goto gpio_err;
+		err =3D gpio_direction_input(keypad->pdata->col_gpio[i]);
+		if (err) {
+			gpio_free(keypad->pdata->col_gpio[i]);
+			goto gpio_err;
+		}
+		if (request_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
+				matrix_keypad_interrupt, IRQF_DISABLED |
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_SAMPLE_RANDOM,
+				"matrix-keypad", keypad)) {
+			printk(KERN_ERR "Unable to acquire interrupt"
+				" for GPIO line %i\n",
+				keypad->pdata->col_gpio[i]);
+			gpio_free(keypad->pdata->col_gpio[i]);
+			goto gpio_err;
+		}
+	}
+
+	/* Set strobe lines as outputs, low */
+	for (i =3D 0; i < keypad->pdata->row_gpio_size; i++) {
+		err =3D gpio_request(keypad->pdata->row_gpio[i], "KBD_LINE");
+		if (err)
+			goto gpio_err2;
+		err =3D gpio_direction_output(keypad->pdata->row_gpio[i],
+				    !keypad->pdata->row_polarity);
+		if (err) {
+			gpio_free(keypad->pdata->row_gpio[i]);
+			goto gpio_err2;
+		}
+	}
+	keypad->irqs =3D 1;
+	keypad->kthread =3D kthread_run(matrix_keypad_thread, keypad, "matrix");
+	if (IS_ERR(keypad->kthread))
+		goto thread_err;
+
+	return 0;
+
+thread_err:
+	i =3D keypad->pdata->row_gpio_size;
+gpio_err2:
+	for (i =3D i-1; i >=3D 0; i--)
+		gpio_free(keypad->pdata->row_gpio[i]);
+	for (i =3D 0; i < keypad->pdata->col_gpio_size; i++) {
+		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]), keypad);
+		gpio_free(keypad->pdata->col_gpio[i]);
+	}
+	goto fail;
+gpio_err:
+	for (i =3D i-1; i >=3D 0; i--) {
+		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]), keypad);
+		gpio_free(keypad->pdata->col_gpio[i]);
+	}
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
+	struct matrix_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	kthread_stop(keypad->kthread);
+
+	for (i =3D 0; i < keypad->pdata->col_gpio_size; i++) {
+		free_irq(gpio_to_irq(keypad->pdata->col_gpio[i]),
+				    keypad);
+		gpio_free(keypad->pdata->col_gpio[i]);
+	}
+
+	for (i =3D 0; i < keypad->pdata->row_gpio_size; i++)
+		gpio_free(keypad->pdata->row_gpio[i]);
+
+	input_unregister_device(keypad->input_dev);
+
+	kfree(keypad->flags);
+	kfree(keypad);
+
+	return 0;
+}
+
+static struct platform_driver matrix_keypad_driver =3D {
+	.probe		=3D matrix_keypad_probe,
+	.remove		=3D matrix_keypad_remove,
+	.suspend	=3D matrix_keypad_suspend,
+	.resume		=3D matrix_keypad_resume,
+	.driver		=3D {
+		.name	=3D "matrix-keypad",
+		.owner	=3D THIS_MODULE,
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
index 0000000..653b33c
=2D-- /dev/null
+++ b/include/linux/matrix_keypad.h
@@ -0,0 +1,39 @@
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
+	/* line polarities */
+	unsigned int	col_polarity;
+	unsigned int	row_polarity;
+
+	/* key debounce interval */
+	unsigned int	scan_delay;
+
+	/* GPIO level change delay */
+	unsigned int	gpio_delay;
+
+	/* Callbacks */
+	int (*suspend)(struct platform_device *dev, pm_message_t state);
+	int (*resume)(struct platform_device *dev);
+};
+
+#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val & 0xfff))
+
+/* key not connected */
+#define KEY_NC	0xfff
+/* key to be pressed with shift */
+#define KEY_SFT	0x800
+
+#endif /* _MATRIX_KEYPAD_H */
=2D-=20
1.5.6


--Boundary-00=_czwpIQUyn7aRI83--
