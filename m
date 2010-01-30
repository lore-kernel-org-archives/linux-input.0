From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: [PATCH v6] input: IMX: add imx-keypad driver to support the Keypad
 Port present in the imx application processors family.
Date: Sat, 30 Jan 2010 12:53:27 +0100
Message-ID: <1264852407.2587.4.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50750 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0A3Lxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 06:53:32 -0500
Received: by ewy19 with SMTP id 19so360777ewy.21
        for <linux-input@vger.kernel.org>; Sat, 30 Jan 2010 03:53:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

The IMX family of Application Processors is shipped with a Keypad Port
supported now by this driver.

The peripheral can control up to an 8x8 matrix key pad where all the scanning
procedure is done via software.

The hardware provide two interrupts: one for a key pressed (KDI) and one for
all key releases (KRI). There is also a simple circuit for glitch reduction
(said for synchronization) made by two series of 3 D-latches clocked by the
keypad-clock that stabilize the interrupts sources.
KDI and KRI are fired only if the respective conditions are maintained for at
last 4 keypad-clock cycle.

Since those circuits are poor for a correct debounce process (the keypad-clock
frequency is 32K and bounces longer than 94us are not masked) the driver,
when an interrupt arrive, sample the matrix with a period of 10ms until
for IMX_KEYPAD_SCANS_FOR_STABILITY (3) times the matrix result stable.
After reached the stability proper events are fired comparing the new and
previous stable state.
If some keys are maintained pressed, the driver continue to probe the matrix
with a greater period (60ms) to catch possible multiple key pressures without
overloading the cpu.
This process ends when all keys are released.

This driver is tested to build in kernel or as a module and follow the
specification of Freescale Application processors:
i.MX25 i.MX27 i.MX31 i.MX35 i.MX51 especially tested on i.MX31.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---

Changes in v4:
-Better error handling.
-Coding style fixes.
-Fix parameters of clk_get.

Changes in v5:
-Rework of debouncing process. Now it is the driver that decide when the
 matrix is stable to check for events.

Changes in v6:
-MXC to IMX pattern change (apart of Kconfig dependencies)
-Comment style fixes
-Greater check delay in debouncing process (10). 
-Improve the usage of keypad->exit_flag: now it is false only between open and 
 close functions. And if we handle an interrupt out there, leave all interrupts
 masked, and wait for another open to re enable they.
-Remove unnecessary "free events" mechanism (tested with evtest).

 drivers/input/keyboard/Kconfig      |    9 +
 drivers/input/keyboard/Makefile     |    1 +
 drivers/input/keyboard/imx_keypad.c |  605 +++++++++++++++++++++++++++++++++++
 3 files changed, 615 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/imx_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 02c836e..78e6cf5 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -292,6 +292,15 @@ config KEYBOARD_MAX7359
 	  To compile this driver as a module, choose M here: the
 	  module will be called max7359_keypad.
 
+config KEYBOARD_IMX
+	tristate "IMX keypad support"
+	depends on ARCH_MXC
+	help
+	  Enable support for IMX keypad port.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx_keypad.
+
 config KEYBOARD_NEWTON
 	tristate "Newton keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 78654ef..b3f8567 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
+obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
new file mode 100644
index 0000000..6bdea71
--- /dev/null
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -0,0 +1,605 @@
+/*
+ * Driver for the IMX keypad port.
+ * Copyright (C) 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * <<Power management needs to be implemented>>.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+
+/*
+ * Keypad Controller registers (halfword)
+ */
+#define KPCR		0x00 /* Keypad Control Register */
+
+#define KPSR		0x02 /* Keypad Status Register */
+#define KBD_STAT_KPKD	(0x1 << 0) /* Key Press Interrupt Status bit (w1c) */
+#define KBD_STAT_KPKR	(0x1 << 1) /* Key Release Interrupt Status bit (w1c) */
+#define KBD_STAT_KDSC	(0x1 << 2) /* Key Depress Synch Chain Status bit (w1c)*/
+#define KBD_STAT_KRSS	(0x1 << 3) /* Key Release Synch Status bit (w1c)*/
+#define KBD_STAT_KDIE	(0x1 << 8) /* Key Depress Interrupt Enable Status bit */
+#define KBD_STAT_KRIE	(0x1 << 9) /* Key Release Interrupt Enable */
+#define KBD_STAT_KPPEN	(0x1 << 10) /* Keypad Clock Enable */
+
+#define KDDR		0x04 /* Keypad Data Direction Register */
+#define KPDR		0x06 /* Keypad Data Register */
+
+#define MAX_MATRIX_KEY_ROWS	8
+#define MAX_MATRIX_KEY_COLS	8
+#define MATRIX_ROW_SHIFT	3
+
+#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
+
+struct imx_keypad {
+
+	struct clk *clk;
+	struct input_dev *input_dev;
+	void __iomem *mmio_base;
+
+	int			irq;
+	struct timer_list	check_matrix_timer;
+
+	/*
+	 * The matrix is stable only if no changes are detected after
+	 * IMX_KEYPAD_SCANS_FOR_STABILITY scans
+	 */
+#define IMX_KEYPAD_SCANS_FOR_STABILITY 3
+	int			stable_count;
+
+	/* If true the driver is shutting down */
+	bool			exit_flag;
+
+	/* Masks for enabled rows/cols */
+	unsigned short		rows_en_mask;
+	unsigned short		cols_en_mask;
+
+	unsigned short		keycodes[MAX_MATRIX_KEY_NUM];
+
+	/*
+	 * Matrix states:
+	 * -stable: achieved after a complete debounce process.
+	 * -unstable: used in the debouncing process.
+	 */
+	unsigned short		matrix_stable_state[MAX_MATRIX_KEY_COLS];
+	unsigned short		matrix_unstable_state[MAX_MATRIX_KEY_COLS];
+};
+
+/* Scan the matrix and return the new state in *matrix_volatile_state. */
+static void imx_keypad_scan_matrix(struct imx_keypad *keypad,
+				  unsigned short *matrix_volatile_state)
+{
+	int col;
+	unsigned short reg_val;
+
+	for (col = 0; col < MAX_MATRIX_KEY_COLS; col++) {
+		if ((keypad->cols_en_mask & (1 << col)) == 0)
+			continue;
+		/*
+		 * Discharge keypad capacitance:
+		 * 2. write 1s on column data.
+		 * 3. configure columns as totem-pole to discharge capacitance.
+		 * 4. configure columns as open-drain.
+		 */
+		reg_val = readw(keypad->mmio_base + KPDR);
+		reg_val |= 0xff00;
+		writew(reg_val, keypad->mmio_base + KPDR);
+
+		reg_val = readw(keypad->mmio_base + KPCR);
+		reg_val &= ~((keypad->cols_en_mask & 0xff) << 8);
+		writew(reg_val, keypad->mmio_base + KPCR);
+
+		udelay(2);
+
+		reg_val = readw(keypad->mmio_base + KPCR);
+		reg_val |= (keypad->cols_en_mask & 0xff) << 8;
+		writew(reg_val, keypad->mmio_base + KPCR);
+
+		/*
+		 * 5. Write a single column to 0, others to 1.
+		 * 6. Sample row inputs and save data.
+		 * 7. Repeat steps 2 - 6 for remaining columns.
+		 */
+		reg_val = readw(keypad->mmio_base + KPDR);
+		reg_val &= ~(1 << (8 + col));
+		writew(reg_val, keypad->mmio_base + KPDR);
+
+		/*
+		 * Delay added to avoid propagating the 0 from column to row
+		 * when scanning.
+		 */
+		udelay(5);
+
+		/*
+		 * 1s in matrix_volatile_state[col] means key pressures
+		 * throw data from non enabled rows.
+		 */
+		reg_val = readw(keypad->mmio_base + KPDR);
+		matrix_volatile_state[col] = (~reg_val) & keypad->rows_en_mask;
+	}
+
+	/*
+	 * Return in standby mode:
+	 * 9. write 0s to columns
+	 */
+	reg_val = readw(keypad->mmio_base + KPDR);
+	reg_val &= 0x00ff;
+	writew(reg_val, keypad->mmio_base + KPDR);
+}
+
+/*
+ * Compare the new matrix state (volatile) with the stable one stored in
+ * keypad->matrix_stable_state and fire events if changes are detected.
+ */
+static void imx_keypad_fire_events(struct imx_keypad *keypad,
+				   unsigned short *matrix_volatile_state)
+{
+	struct input_dev *input_dev = keypad->input_dev;
+	int row, col;
+
+	for (col = 0; col < MAX_MATRIX_KEY_COLS; col++) {
+		unsigned short bits_changed;
+		int code;
+
+		if ((keypad->cols_en_mask & (1 << col)) == 0)
+			continue; /* Column not enabled */
+
+		bits_changed = keypad->matrix_stable_state[col] ^
+						matrix_volatile_state[col];
+
+		if (bits_changed == 0)
+			continue; /* Column not contain changes */
+
+		for (row = 0; row < MAX_MATRIX_KEY_ROWS; row++) {
+			if ((keypad->rows_en_mask & (1 << row)) == 0)
+				continue; /* Row not enabled */
+			if ((bits_changed & (1 << row)) == 0)
+				continue; /* Row not contain changes */
+
+			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
+			input_event(input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(input_dev, keypad->keycodes[code],
+				       matrix_volatile_state[col] & (1 << row));
+			dev_dbg(&input_dev->dev, "Event code: %d, val: %d",
+					keypad->keycodes[code],
+				       matrix_volatile_state[col] & (1 << row));
+		}
+	}
+	input_sync(input_dev);
+}
+
+/*
+ * imx_keypad_check_for_events is the timer handler.
+ * It is executed in a non interruptible area of the kernel (Soft interrupt)
+ */
+static void imx_keypad_check_for_events(unsigned long data)
+{
+	struct imx_keypad *keypad = (struct imx_keypad *) data;
+	struct input_dev *input_dev = keypad->input_dev;
+	unsigned short matrix_volatile_state[MAX_MATRIX_KEY_COLS];
+	unsigned short reg_val;
+	bool state_changed, is_zero_matrix;
+	int i;
+
+	memset(matrix_volatile_state, 0, sizeof(matrix_volatile_state));
+
+	/* If the driver is shutting down, exit now.*/
+	if (keypad->exit_flag) {
+		dev_dbg(&input_dev->dev, "%s: exiting.\n", __func__);
+		return;
+	}
+
+	imx_keypad_scan_matrix(keypad, matrix_volatile_state);
+
+	state_changed = false;
+	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && !state_changed; i++) {
+		if ((keypad->cols_en_mask & (1 << i)) == 0)
+			continue;
+
+		if (keypad->matrix_unstable_state[i] ^
+						matrix_volatile_state[i])
+			state_changed = true;
+	}
+
+	/*
+	 * If the matrix state is changed from the previous scan
+	 *   (Re)Begin the debouncing process, saving the new state in
+	 *    keypad->matrix_unstable_state.
+	 * else
+	 *   Increase the count of number of scans with a stable state.
+	 */
+	if (state_changed) {
+		memcpy(keypad->matrix_unstable_state, matrix_volatile_state,
+						sizeof(matrix_volatile_state));
+		keypad->stable_count = 0;
+	} else
+		keypad->stable_count++;
+
+	/*
+	 * If the matrix is not as stable as we want reschedule a matrix scan
+	 * near in the future.
+	 */
+	if (keypad->stable_count < IMX_KEYPAD_SCANS_FOR_STABILITY) {
+		mod_timer(&keypad->check_matrix_timer,
+			  jiffies + msecs_to_jiffies(10));
+		return;
+	}
+
+	/*
+	 * If the matrix is stable as we need, fire the events and save the new
+	 * stable state.
+	 * Note, if the matrix is more stable (keypad->stable_count >
+	 * IMX_KEYPAD_SCANS_FOR_STABILITY)all events are already fired.We are in
+	 * the loop of multiple key pressure detection waiting for a change.
+	 */
+	if (keypad->stable_count == IMX_KEYPAD_SCANS_FOR_STABILITY) {
+		imx_keypad_fire_events(keypad, matrix_volatile_state);
+
+		memcpy(keypad->matrix_stable_state, matrix_volatile_state,
+						sizeof(matrix_volatile_state));
+	}
+
+	is_zero_matrix = true;
+	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && is_zero_matrix; i++)
+		if (matrix_volatile_state[i] != 0)
+			is_zero_matrix = false;
+
+
+	if (is_zero_matrix) {
+		/*
+		 * No keys are still pressed.
+		 * Enable only the KDI interrupt for future key pressures.
+		 * (clear the KDI status bit and his sync chain before)
+		 */
+		reg_val = readw(keypad->mmio_base + KPSR);
+		reg_val |= KBD_STAT_KPKD | KBD_STAT_KDSC;
+		writew(reg_val, keypad->mmio_base + KPSR);
+
+		reg_val = readw(keypad->mmio_base + KPSR);
+		reg_val |= KBD_STAT_KDIE;
+		reg_val &= ~KBD_STAT_KRIE;
+		writew(reg_val, keypad->mmio_base + KPSR);
+	} else {
+		/*
+		 * Still there are keys pressed. Schedule a rescan for multiple
+		 * key pressure detection and enable the KRI interrupt for fast
+		 * reaction to an all key release event.
+		 */
+		mod_timer(&keypad->check_matrix_timer,
+						jiffies + msecs_to_jiffies(60));
+
+		reg_val = readw(keypad->mmio_base + KPSR);
+		reg_val |= KBD_STAT_KPKR | KBD_STAT_KRSS;
+		writew(reg_val, keypad->mmio_base + KPSR);
+
+		reg_val = readw(keypad->mmio_base + KPSR);
+		reg_val |= KBD_STAT_KRIE;
+		reg_val &= ~KBD_STAT_KDIE;
+		writew(reg_val, keypad->mmio_base + KPSR);
+	}
+}
+
+static irqreturn_t imx_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct imx_keypad *keypad = dev_id;
+	unsigned short reg_val;
+
+	reg_val = readw(keypad->mmio_base + KPSR);
+
+	/* Disable every keypad interrupt */
+	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
+	/* Clear interrupts status bits */
+	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD;
+	writew(reg_val, keypad->mmio_base + KPSR);
+
+	/* If the driver is shutting down, leave all interrupts disabled.*/
+	if (keypad->exit_flag)
+		return IRQ_HANDLED;
+
+	/* The matrix is supposed to be changed */
+	keypad->stable_count = 0;
+
+	/* Schedule the scanning procedure near in the future */
+	mod_timer(&keypad->check_matrix_timer, jiffies + msecs_to_jiffies(2));
+
+	return IRQ_HANDLED;
+}
+
+static void imx_keypad_config(struct imx_keypad *keypad)
+{
+	unsigned short reg_val;
+
+	/*
+	 * Include enabled rows in interrupt generation (KPCR[7:0])
+	 * Configure keypad columns as open-drain (KPCR[15:8])
+	 */
+	reg_val = readw(keypad->mmio_base + KPCR);
+	reg_val |= keypad->rows_en_mask & 0xff;		/* rows */
+	reg_val |= (keypad->cols_en_mask & 0xff) << 8;	/* cols */
+	writew(reg_val, keypad->mmio_base + KPCR);
+
+	/* Write 0's to KPDR[15:8] (Colums)*/
+	reg_val = readw(keypad->mmio_base + KPDR);
+	reg_val &= 0x00ff;
+	writew(reg_val, keypad->mmio_base + KPDR);
+
+	/* Configure columns as output, rows as input (KDDR[15:0]) */
+	writew(0xff00, keypad->mmio_base + KDDR);
+
+	/*
+	 * Clear Key Depress and Key Release status bit.
+	 * Clear both synchronizer chain.
+	 */
+	reg_val = readw(keypad->mmio_base + KPSR);
+	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD |
+		   KBD_STAT_KDSC | KBD_STAT_KRSS;
+	writew(reg_val, keypad->mmio_base + KPSR);
+
+	/* Enable KDI and disable KRI (avoid false release events). */
+	reg_val |= KBD_STAT_KDIE;
+	reg_val &= ~KBD_STAT_KRIE;
+	writew(reg_val, keypad->mmio_base + KPSR);
+}
+
+static void imx_keypad_inhibit(struct imx_keypad *keypad)
+{
+	unsigned short reg_val;
+
+	/* Inhibit KDI and KRI interrupts. */
+	reg_val = readw(keypad->mmio_base + KPSR);
+	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
+	writew(reg_val, keypad->mmio_base + KPSR);
+
+	/* Colums as open drain and disable all rows */
+	writew(0xff00, keypad->mmio_base + KPCR);
+}
+
+static int imx_keypad_open(struct input_dev *dev)
+{
+	struct imx_keypad *keypad = input_get_drvdata(dev);
+
+	dev_dbg(&dev->dev, ">%s\n", __func__);
+
+	/* We became active from now */
+	keypad->exit_flag = false;
+	/* Init Keypad timer */
+	init_timer(&keypad->check_matrix_timer);
+	keypad->check_matrix_timer.function = imx_keypad_check_for_events;
+	keypad->check_matrix_timer.data = (unsigned long) keypad;
+
+	/* Enable the kpp clock */
+	clk_enable(keypad->clk);
+	imx_keypad_config(keypad);
+
+	/* Sanity control, not all the rows must be actived now. */
+	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) == 0) {
+		dev_err(&dev->dev,
+		"too much keys pressed for now, control pins initialisation\n");
+		goto open_err;
+	}
+
+	return 0;
+
+open_err:
+	keypad->exit_flag = true;
+	del_timer_sync(&keypad->check_matrix_timer);
+	imx_keypad_inhibit(keypad);
+	return -EIO;
+}
+
+static void imx_keypad_close(struct input_dev *dev)
+{
+	struct imx_keypad *keypad = input_get_drvdata(dev);
+
+	dev_dbg(&dev->dev, ">%s\n", __func__);
+
+	/* Make sure no checks are pending (avoid races).*/
+	keypad->exit_flag = true;
+	del_timer_sync(&keypad->check_matrix_timer);
+
+	imx_keypad_inhibit(keypad);
+
+	/* Disable clock unit */
+	clk_disable(keypad->clk);
+}
+
+static int __devinit imx_keypad_probe(struct platform_device *pdev)
+{
+	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
+	struct imx_keypad *keypad;
+	struct input_dev *input_dev;
+	struct resource *res;
+	int irq, error, i;
+
+	if (keymap_data == NULL) {
+		dev_err(&pdev->dev, "no keymap defined\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq defined in platform data\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no I/O memory defined in platform data\n");
+		return -EINVAL;
+	}
+
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		return -EBUSY;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&pdev->dev, "failed to allocate the input device\n");
+		error = -ENOMEM;
+		goto failed_rel_mem;
+	}
+
+	keypad = kzalloc(sizeof(struct imx_keypad), GFP_KERNEL);
+	if (!keypad) {
+		dev_err(&pdev->dev, "not enough memory for driver data\n");
+		error = -ENOMEM;
+		goto failed_free_input;
+	}
+
+	keypad->input_dev = input_dev;
+	keypad->irq = irq;
+	keypad->stable_count = 0;
+
+	keypad->mmio_base = ioremap(res->start, resource_size(res));
+	if (keypad->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENOMEM;
+		goto failed_free_priv;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, "kpp");
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to get keypad clock\n");
+		error = PTR_ERR(keypad->clk);
+		goto failed_unmap;
+	}
+
+	/* Search for rows and cols enabled */
+	for (i = 0; i < keymap_data->keymap_size; i++) {
+		keypad->rows_en_mask |= 1 << KEY_ROW(keymap_data->keymap[i]);
+		keypad->cols_en_mask |= 1 << KEY_COL(keymap_data->keymap[i]);
+	}
+
+	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
+	   keypad->cols_en_mask > ((1 << MAX_MATRIX_KEY_COLS) - 1)) {
+		dev_err(&pdev->dev, "invalid key data (too rows or colums)\n");
+		error = -EINVAL;
+		goto failed_clock_put;
+	}
+	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
+	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
+
+	/* Init the Input device */
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->open = imx_keypad_open;
+	input_dev->close = imx_keypad_close;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	input_dev->keycode = keypad->keycodes;
+	input_dev->keycodesize = sizeof(keypad->keycodes[0]);
+	input_dev->keycodemax = ARRAY_SIZE(keypad->keycodes);
+
+	matrix_keypad_build_keymap(keymap_data, MATRIX_ROW_SHIFT,
+				keypad->keycodes, input_dev->keybit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	input_set_drvdata(input_dev, keypad);
+
+	/* Enable the interrupt handler. */
+	/* If there are spurious interrupts the handler will mask them all. */
+	keypad->exit_flag = true;
+	error = request_irq(irq, imx_keypad_irq_handler, IRQF_DISABLED,
+			pdev->name, keypad);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto failed_clock_put;
+	}
+
+	/* Register the input device */
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_irq;
+	}
+
+	platform_set_drvdata(pdev, keypad);
+	device_init_wakeup(&pdev->dev, 1);
+
+	dev_info(&pdev->dev, "device probed\n");
+
+	return 0;
+
+failed_free_irq:
+	free_irq(irq, pdev);
+failed_clock_put:
+	clk_put(keypad->clk);
+failed_unmap:
+	iounmap(keypad->mmio_base);
+failed_free_priv:
+	kfree(keypad);
+failed_free_input:
+	input_free_device(input_dev);
+failed_rel_mem:
+	release_mem_region(res->start, resource_size(res));
+	return error;
+}
+
+static int __devexit imx_keypad_remove(struct platform_device *pdev)
+{
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	dev_dbg(&pdev->dev, ">%s\n", __func__);
+
+	platform_set_drvdata(pdev, NULL);
+
+	input_unregister_device(keypad->input_dev);
+
+	free_irq(keypad->irq, keypad);
+	clk_put(keypad->clk);
+
+	iounmap(keypad->mmio_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	kfree(keypad);
+
+	dev_info(&pdev->dev, "device removed\n");
+
+	return 0;
+}
+
+static struct platform_driver imx_keypad_driver = {
+	.driver		= {
+		.name	= "imx-keypad",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= imx_keypad_probe,
+	.remove		= __devexit_p(imx_keypad_remove),
+};
+
+static int __init imx_keypad_init(void)
+{
+	return platform_driver_register(&imx_keypad_driver);
+}
+
+static void __exit imx_keypad_exit(void)
+{
+	platform_driver_unregister(&imx_keypad_driver);
+}
+
+module_init(imx_keypad_init);
+module_exit(imx_keypad_exit);
+
+MODULE_AUTHOR("Alberto Panizzo <maramaopercheseimorto@gmail.com>");
+MODULE_DESCRIPTION("IMX Keypad Port Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-keypad");
-- 
1.6.3.3



