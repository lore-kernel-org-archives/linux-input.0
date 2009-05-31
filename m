From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sun, 31 May 2009 22:29:08 +0800
Message-ID: <f17812d70905310729r501ed41fja622392c187c5cbb@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <200905271526.59064.u.luckas@road.de>
	 <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	 <20090531142027.GA22540@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f130.google.com ([209.85.221.130]:51243 "EHLO
	mail-qy0-f130.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290AbZEaO3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 10:29:07 -0400
Received: by qyk36 with SMTP id 36so977701qyk.33
        for <linux-input@vger.kernel.org>; Sun, 31 May 2009 07:29:08 -0700 (PDT)
In-Reply-To: <20090531142027.GA22540@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, May 31, 2009 at 10:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, May 31, 2009 at 10:12:25PM +0800, Eric Miao wrote:
>> +static void __devinit build_keycodes(struct matrix_keypad *keypad)
>> +{
>> + =C2=A0 =C2=A0 struct matrix_keypad_platform_data *pdata =3D keypad=
->pdata;
>> + =C2=A0 =C2=A0 struct input_dev *input_dev =3D keypad->input_dev;
>> + =C2=A0 =C2=A0 uint32_t *key;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * sizeo=
f(int), GFP_KERNEL);
>
> This doesn't check for failure...

Oops, updated (together with the release) as below:

=46rom 5a742cd04aaa0f48519f52583fc6043458922a31 Mon Sep 17 00:00:00 200=
1
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 7 May 2009 15:49:32 +0800
Subject: [PATCH] input: add support for generic GPIO-based matrix keypa=
d

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Reviewed-by: Uli Luckas <u.luckas@road.de>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/Kconfig         |   10 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/matrix_keypad.c |  375 ++++++++++++++++++++++++=
++++++++
 include/linux/input/matrix_keypad.h    |   34 +++
 4 files changed, 420 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/matrix_keypad.c
 create mode 100644 include/linux/input/matrix_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
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
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
index 36351e1..1349408 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)		+=3D jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+=3D bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MATRIX)		+=3D matrix_keypad.o
diff --git a/drivers/input/keyboard/matrix_keypad.c
b/drivers/input/keyboard/matrix_keypad.c
new file mode 100644
index 0000000..61c7153
--- /dev/null
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -0,0 +1,375 @@
+/*
+ * drivers/input/keyboard/matrix_keypad.c
+ *
+ *  GPIO driven matrix keyboard driver
+ *
+ *  Copyright (c) 2008 Marek Vasut <marek.vasut@gmail.com>
+ *
+ *  Based on corgikbd.c
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
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
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	struct input_dev *input_dev =3D keypad->input_dev;
+	uint32_t *key;
+	int i;
+
+	keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * sizeof(int), GFP_KERNE=
L);
+	if (keypad->keycodes =3D=3D NULL)
+		return -ENOMEM;
+
+	key =3D &pdata->key_map[0];
+	for (i =3D 0; i < pdata->key_map_size; i++, key++) {
+		keypad->keycodes[KEY_ROWCOL(*key)] =3D KEY_VAL(*key);
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
+/* NOTE: normally the GPIO has to be put into HiZ when de-activated to=
 cause
+ * minimum side effect when scanning other columns, here it is configu=
red to
+ * be input, and it should work on most platforms.
+ */
+static void __activate_col(struct matrix_keypad_platform_data *pdata,
+			 int col, int on)
+{
+	int level_on =3D !pdata->active_low;
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
+	for (col =3D 0; col < pdata->num_col_gpios; col++)
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
+static int row_asserted(struct matrix_keypad_platform_data *pdata, int=
 row)
+{
+	return gpio_get_value(pdata->row_gpios[row]) ?
+			!pdata->active_low : pdata->active_low;
+}
+
+static void enable_row_irqs(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int i;
+
+	for (i =3D 0; i < pdata->num_row_gpios; i++)
+		enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+}
+
+static void disable_row_irqs(struct matrix_keypad *keypad)
+{
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int i;
+
+	for (i =3D 0; i < pdata->num_row_gpios; i++)
+		disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+}
+
+/*
+ * This gets the keys from keyboard and reports it to input subsystem
+ */
+static void matrix_keypad_scan(struct work_struct *work)
+{
+	struct matrix_keypad *keypad =3D
+	       	container_of(work, struct matrix_keypad, work.work);
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	uint32_t new_state[MATRIX_MAX_COLS];
+	int row, col;
+
+	/* de-activate all columns for scanning */
+	activate_all_cols(pdata, 0);
+
+	memset(new_state, 0, sizeof(new_state));
+
+	/* assert each column and read the row status out */
+	for (col =3D 0; col < pdata->num_col_gpios; col++) {
+
+		activate_col(pdata, col, 1);
+
+		for (row =3D 0; row < pdata->num_row_gpios; row++)
+			new_state[col] |=3D row_asserted(pdata, row) ?
+						(1 << row) : 0;
+		activate_col(pdata, col, 0);
+	}
+
+	for (col =3D 0; col < pdata->num_col_gpios; col++) {
+		uint32_t bits_changed;
+	=09
+		bits_changed =3D keypad->last_key_state[col] ^ new_state[col];
+		if (bits_changed =3D=3D 0)
+			continue;
+
+		for (row =3D 0; row < pdata->num_row_gpios; row++) {
+			if ((bits_changed & (1 << row)) =3D=3D 0)
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
+	struct matrix_keypad *keypad =3D id;
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
+	struct matrix_keypad *keypad =3D platform_get_drvdata(pdev);
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int i;
+
+	disable_row_irqs(keypad);
+	flush_work(&keypad->work.work);
+
+	if (device_may_wakeup(&pdev->dev))
+		for (i =3D 0; i < pdata->num_row_gpios; i++)
+			enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+
+	return 0;
+}
+
+static int matrix_keypad_resume(struct platform_device *pdev)
+{
+	struct matrix_keypad *keypad =3D platform_get_drvdata(pdev);
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int i;
+
+	if (device_may_wakeup(&pdev->dev))
+		for (i =3D 0; i < pdata->num_row_gpios; i++)
+			disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+
+	/* Uli Luckas: schedule an immediate key scan as all key state change=
s
+	 * were lost while the device was suspended, columns will be activate=
d
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
+	struct matrix_keypad_platform_data *pdata =3D keypad->pdata;
+	int i, err =3D -EINVAL;
+
+	/* initialized strobe lines as outputs, activated */
+	for (i =3D 0; i < pdata->num_col_gpios; i++) {
+		err =3D gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		if (err) {
+			pr_err("failed to request GPIO%d for COL%d\n",
+					pdata->col_gpios[i], i);
+			goto err_free_cols;
+		}
+
+		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
+	}
+
+	for (i =3D 0; i < pdata->num_row_gpios; i++) {
+		err =3D gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		if (err) {
+			pr_err("failed to request GPIO%d for ROW%d\n",
+					pdata->row_gpios[i], i);
+			goto err_free_rows;
+		}
+
+		gpio_direction_input(pdata->row_gpios[i]);
+	}
+
+	for (i =3D 0; i < pdata->num_row_gpios; i++) {
+		err =3D request_irq(gpio_to_irq(pdata->row_gpios[i]),
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
+	for (i =3D i - 1; i >=3D 0; i--)
+		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+
+err_free_rows:
+	for (i =3D i - 1; i >=3D 0; i--)
+		gpio_free(pdata->row_gpios[i]);
+
+err_free_cols:
+	for (i =3D i - 1; i >=3D 0; i--)
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
+	int err =3D -ENOMEM;
+
+	if ((pdata =3D pdev->dev.platform_data) =3D=3D NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	keypad =3D kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	if (keypad =3D=3D NULL)
+		return -ENOMEM;
+
+	input_dev =3D input_allocate_device();
+	if (!input_dev)
+		goto err_free_keypad;
+
+	platform_set_drvdata(pdev, keypad);
+
+	keypad->input_dev =3D input_dev;
+	keypad->pdata =3D pdata;
+	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
+
+	input_dev->name		=3D pdev->name;
+	input_dev->id.bustype	=3D BUS_HOST;
+	input_dev->dev.parent	=3D &pdev->dev;
+	input_dev->evbit[0]	=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+
+	err =3D build_keycodes(keypad);
+	if (err)
+		goto err_free_input;
+
+	err =3D input_register_device(keypad->input_dev);
+	if (err)
+		goto err_free_keycodes;
+
+	err =3D init_matrix_gpio(keypad);
+	if (err)
+		goto err_unregister;
+
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
+static int __devexit matrix_keypad_remove(struct platform_device *pdev=
)
+{
+	struct matrix_keypad *keypad =3D platform_get_drvdata(pdev);
+	int i;
+
+	for (i =3D 0; i < keypad->pdata->num_row_gpios; i++) {
+		free_irq(gpio_to_irq(keypad->pdata->row_gpios[i]), keypad);
+		gpio_free(keypad->pdata->row_gpios[i]);
+	}
+
+	for (i =3D 0; i < keypad->pdata->num_col_gpios; i++)
+		gpio_free(keypad->pdata->col_gpios[i]);
+
+	input_unregister_device(keypad->input_dev);
+	kfree(keypad->keycodes);
+	kfree(keypad);
+	return 0;
+}
+
+static struct platform_driver matrix_keypad_driver =3D {
+	.probe		=3D matrix_keypad_probe,
+	.remove		=3D __devexit_p(matrix_keypad_remove),
+	.suspend	=3D matrix_keypad_suspend,
+	.resume		=3D matrix_keypad_resume,
+	.driver		=3D {
+		.name	=3D "matrix-keypad",
+		.owner	=3D THIS_MODULE,
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
--=20
1.6.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
