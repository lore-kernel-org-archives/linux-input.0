From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] input: IMX: add imx-keypad driver to support the
 Keypad Port present in the imx application processors family.
Date: Sun, 31 Jan 2010 01:08:02 -0800
Message-ID: <20100131090802.GD12320@core.coreip.homeip.net>
References: <1264852407.2587.4.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:34717 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0AaJIJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 04:08:09 -0500
Received: by pzk2 with SMTP id 2so3150824pzk.21
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 01:08:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264852407.2587.4.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Alberto,

On Sat, Jan 30, 2010 at 12:53:27PM +0100, Alberto Panizzo wrote:
> 
> Changes in v6:
> -MXC to IMX pattern change (apart of Kconfig dependencies)
> -Comment style fixes
> -Greater check delay in debouncing process (10). 
> -Improve the usage of keypad->exit_flag: now it is false only between open and 
>  close functions. And if we handle an interrupt out there, leave all interrupts
>  masked, and wait for another open to re enable they.
> -Remove unnecessary "free events" mechanism (tested with evtest).
> 

I took the liberty of making some changes to the driver, could you
please give the patch below a try and if I did not mess it up I will
fold it into your v6 version and apply to next.

Thank you.

-- 
Dmitry


Input: imx-keypad - assorted fixes

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/imx_keypad.c |  153 ++++++++++++++++-------------------
 1 files changed, 71 insertions(+), 82 deletions(-)


diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 6bdea71..2ee5b79 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -62,8 +62,7 @@ struct imx_keypad {
 #define IMX_KEYPAD_SCANS_FOR_STABILITY 3
 	int			stable_count;
 
-	/* If true the driver is shutting down */
-	bool			exit_flag;
+	bool			enabled;
 
 	/* Masks for enabled rows/cols */
 	unsigned short		rows_en_mask;
@@ -157,27 +156,27 @@ static void imx_keypad_fire_events(struct imx_keypad *keypad,
 		int code;
 
 		if ((keypad->cols_en_mask & (1 << col)) == 0)
-			continue; /* Column not enabled */
+			continue; /* Column is not enabled */
 
 		bits_changed = keypad->matrix_stable_state[col] ^
 						matrix_volatile_state[col];
 
 		if (bits_changed == 0)
-			continue; /* Column not contain changes */
+			continue; /* Column does not contain changes */
 
 		for (row = 0; row < MAX_MATRIX_KEY_ROWS; row++) {
 			if ((keypad->rows_en_mask & (1 << row)) == 0)
-				continue; /* Row not enabled */
+				continue; /* Row is not enabled */
 			if ((bits_changed & (1 << row)) == 0)
-				continue; /* Row not contain changes */
+				continue; /* Row does not contain changes */
 
 			code = MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
 			input_event(input_dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(input_dev, keypad->keycodes[code],
-				       matrix_volatile_state[col] & (1 << row));
+				matrix_volatile_state[col] & (1 << row));
 			dev_dbg(&input_dev->dev, "Event code: %d, val: %d",
-					keypad->keycodes[code],
-				       matrix_volatile_state[col] & (1 << row));
+				keypad->keycodes[code],
+				matrix_volatile_state[col] & (1 << row));
 		}
 	}
 	input_sync(input_dev);
@@ -185,12 +184,10 @@ static void imx_keypad_fire_events(struct imx_keypad *keypad,
 
 /*
  * imx_keypad_check_for_events is the timer handler.
- * It is executed in a non interruptible area of the kernel (Soft interrupt)
  */
 static void imx_keypad_check_for_events(unsigned long data)
 {
 	struct imx_keypad *keypad = (struct imx_keypad *) data;
-	struct input_dev *input_dev = keypad->input_dev;
 	unsigned short matrix_volatile_state[MAX_MATRIX_KEY_COLS];
 	unsigned short reg_val;
 	bool state_changed, is_zero_matrix;
@@ -198,22 +195,17 @@ static void imx_keypad_check_for_events(unsigned long data)
 
 	memset(matrix_volatile_state, 0, sizeof(matrix_volatile_state));
 
-	/* If the driver is shutting down, exit now.*/
-	if (keypad->exit_flag) {
-		dev_dbg(&input_dev->dev, "%s: exiting.\n", __func__);
-		return;
-	}
-
 	imx_keypad_scan_matrix(keypad, matrix_volatile_state);
 
 	state_changed = false;
-	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && !state_changed; i++) {
+	for (i = 0; i < MAX_MATRIX_KEY_COLS; i++) {
 		if ((keypad->cols_en_mask & (1 << i)) == 0)
 			continue;
 
-		if (keypad->matrix_unstable_state[i] ^
-						matrix_volatile_state[i])
+		if (keypad->matrix_unstable_state[i] ^ matrix_volatile_state[i]) {
 			state_changed = true;
+			break;
+		}
 	}
 
 	/*
@@ -225,14 +217,14 @@ static void imx_keypad_check_for_events(unsigned long data)
 	 */
 	if (state_changed) {
 		memcpy(keypad->matrix_unstable_state, matrix_volatile_state,
-						sizeof(matrix_volatile_state));
+			sizeof(matrix_volatile_state));
 		keypad->stable_count = 0;
 	} else
 		keypad->stable_count++;
 
 	/*
-	 * If the matrix is not as stable as we want reschedule a matrix scan
-	 * near in the future.
+	 * If the matrix is not as stable as we want reschedule scan
+	 * in the near future.
 	 */
 	if (keypad->stable_count < IMX_KEYPAD_SCANS_FOR_STABILITY) {
 		mod_timer(&keypad->check_matrix_timer,
@@ -241,30 +233,32 @@ static void imx_keypad_check_for_events(unsigned long data)
 	}
 
 	/*
-	 * If the matrix is stable as we need, fire the events and save the new
-	 * stable state.
-	 * Note, if the matrix is more stable (keypad->stable_count >
-	 * IMX_KEYPAD_SCANS_FOR_STABILITY)all events are already fired.We are in
-	 * the loop of multiple key pressure detection waiting for a change.
+	 * If the matrix state is stable, fire the events and save the new
+	 * stable state. Note, if the matrix is kept stable for longer
+	 * (keypad->stable_count > IMX_KEYPAD_SCANS_FOR_STABILITY) all
+	 * events have already been generated.
 	 */
 	if (keypad->stable_count == IMX_KEYPAD_SCANS_FOR_STABILITY) {
 		imx_keypad_fire_events(keypad, matrix_volatile_state);
 
 		memcpy(keypad->matrix_stable_state, matrix_volatile_state,
-						sizeof(matrix_volatile_state));
+			sizeof(matrix_volatile_state));
 	}
 
 	is_zero_matrix = true;
-	for (i = 0; (i < MAX_MATRIX_KEY_COLS) && is_zero_matrix; i++)
-		if (matrix_volatile_state[i] != 0)
+	for (i = 0; i < MAX_MATRIX_KEY_COLS; i++) {
+		if (matrix_volatile_state[i] != 0) {
 			is_zero_matrix = false;
+			break;
+		}
+	}
 
 
 	if (is_zero_matrix) {
 		/*
-		 * No keys are still pressed.
-		 * Enable only the KDI interrupt for future key pressures.
-		 * (clear the KDI status bit and his sync chain before)
+		 * All keys have been released. Enable only the KDI
+		 * interrupt for future key presses (clear the KDI
+		 * status bit and its sync chain before that).
 		 */
 		reg_val = readw(keypad->mmio_base + KPSR);
 		reg_val |= KBD_STAT_KPKD | KBD_STAT_KDSC;
@@ -276,12 +270,13 @@ static void imx_keypad_check_for_events(unsigned long data)
 		writew(reg_val, keypad->mmio_base + KPSR);
 	} else {
 		/*
-		 * Still there are keys pressed. Schedule a rescan for multiple
-		 * key pressure detection and enable the KRI interrupt for fast
-		 * reaction to an all key release event.
+		 * Some keys are still pressed. Schedule a rescan in
+		 * attempt to detect multiple key presses and enable
+		 * the KRI interrupt to react quickly to key release
+		 * event.
 		 */
 		mod_timer(&keypad->check_matrix_timer,
-						jiffies + msecs_to_jiffies(60));
+			  jiffies + msecs_to_jiffies(60));
 
 		reg_val = readw(keypad->mmio_base + KPSR);
 		reg_val |= KBD_STAT_KPKR | KBD_STAT_KRSS;
@@ -301,21 +296,20 @@ static irqreturn_t imx_keypad_irq_handler(int irq, void *dev_id)
 
 	reg_val = readw(keypad->mmio_base + KPSR);
 
-	/* Disable every keypad interrupt */
+	/* Disable both interrupt types */
 	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
 	/* Clear interrupts status bits */
 	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD;
 	writew(reg_val, keypad->mmio_base + KPSR);
 
-	/* If the driver is shutting down, leave all interrupts disabled.*/
-	if (keypad->exit_flag)
-		return IRQ_HANDLED;
-
-	/* The matrix is supposed to be changed */
-	keypad->stable_count = 0;
+	if (keypad->enabled) {
+		/* The matrix is supposed to be changed */
+		keypad->stable_count = 0;
 
-	/* Schedule the scanning procedure near in the future */
-	mod_timer(&keypad->check_matrix_timer, jiffies + msecs_to_jiffies(2));
+		/* Schedule the scanning procedure near in the future */
+		mod_timer(&keypad->check_matrix_timer,
+			  jiffies + msecs_to_jiffies(2));
+	}
 
 	return IRQ_HANDLED;
 }
@@ -333,7 +327,7 @@ static void imx_keypad_config(struct imx_keypad *keypad)
 	reg_val |= (keypad->cols_en_mask & 0xff) << 8;	/* cols */
 	writew(reg_val, keypad->mmio_base + KPCR);
 
-	/* Write 0's to KPDR[15:8] (Colums)*/
+	/* Write 0's to KPDR[15:8] (Colums) */
 	reg_val = readw(keypad->mmio_base + KPDR);
 	reg_val &= 0x00ff;
 	writew(reg_val, keypad->mmio_base + KPDR);
@@ -369,6 +363,23 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
 	writew(0xff00, keypad->mmio_base + KPCR);
 }
 
+static void imx_keypad_close(struct input_dev *dev)
+{
+	struct imx_keypad *keypad = input_get_drvdata(dev);
+
+	dev_dbg(&dev->dev, ">%s\n", __func__);
+
+	/* Mark keypad as being inactive */
+	keypad->enabled = false;
+	synchronize_irq(keypad->irq);
+	del_timer_sync(&keypad->check_matrix_timer);
+
+	imx_keypad_inhibit(keypad);
+
+	/* Disable clock unit */
+	clk_disable(keypad->clk);
+}
+
 static int imx_keypad_open(struct input_dev *dev)
 {
 	struct imx_keypad *keypad = input_get_drvdata(dev);
@@ -376,11 +387,7 @@ static int imx_keypad_open(struct input_dev *dev)
 	dev_dbg(&dev->dev, ">%s\n", __func__);
 
 	/* We became active from now */
-	keypad->exit_flag = false;
-	/* Init Keypad timer */
-	init_timer(&keypad->check_matrix_timer);
-	keypad->check_matrix_timer.function = imx_keypad_check_for_events;
-	keypad->check_matrix_timer.data = (unsigned long) keypad;
+	keypad->enabled = true;
 
 	/* Enable the kpp clock */
 	clk_enable(keypad->clk);
@@ -389,35 +396,17 @@ static int imx_keypad_open(struct input_dev *dev)
 	/* Sanity control, not all the rows must be actived now. */
 	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) == 0) {
 		dev_err(&dev->dev,
-		"too much keys pressed for now, control pins initialisation\n");
+			"too many keys pressed, control pins initialisation\n");
 		goto open_err;
 	}
 
 	return 0;
 
 open_err:
-	keypad->exit_flag = true;
-	del_timer_sync(&keypad->check_matrix_timer);
-	imx_keypad_inhibit(keypad);
+	imx_keypad_close(dev);
 	return -EIO;
 }
 
-static void imx_keypad_close(struct input_dev *dev)
-{
-	struct imx_keypad *keypad = input_get_drvdata(dev);
-
-	dev_dbg(&dev->dev, ">%s\n", __func__);
-
-	/* Make sure no checks are pending (avoid races).*/
-	keypad->exit_flag = true;
-	del_timer_sync(&keypad->check_matrix_timer);
-
-	imx_keypad_inhibit(keypad);
-
-	/* Disable clock unit */
-	clk_disable(keypad->clk);
-}
-
 static int __devinit imx_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
@@ -467,6 +456,9 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	keypad->irq = irq;
 	keypad->stable_count = 0;
 
+	setup_timer(&keypad->check_matrix_timer,
+		    imx_keypad_check_for_events, (unsigned long) keypad);
+
 	keypad->mmio_base = ioremap(res->start, resource_size(res));
 	if (keypad->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
@@ -489,7 +481,8 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 
 	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
 	   keypad->cols_en_mask > ((1 << MAX_MATRIX_KEY_COLS) - 1)) {
-		dev_err(&pdev->dev, "invalid key data (too rows or colums)\n");
+		dev_err(&pdev->dev,
+			"invalid key data (too many rows or colums)\n");
 		error = -EINVAL;
 		goto failed_clock_put;
 	}
@@ -513,11 +506,11 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(input_dev, keypad);
 
-	/* Enable the interrupt handler. */
-	/* If there are spurious interrupts the handler will mask them all. */
-	keypad->exit_flag = true;
+	/* Ensure that the keypad will stay dormant until opened */
+	imx_keypad_inhibit(keypad);
+
 	error = request_irq(irq, imx_keypad_irq_handler, IRQF_DISABLED,
-			pdev->name, keypad);
+			    pdev->name, keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		goto failed_clock_put;
@@ -533,8 +526,6 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, keypad);
 	device_init_wakeup(&pdev->dev, 1);
 
-	dev_info(&pdev->dev, "device probed\n");
-
 	return 0;
 
 failed_free_irq:
@@ -572,8 +563,6 @@ static int __devexit imx_keypad_remove(struct platform_device *pdev)
 
 	kfree(keypad);
 
-	dev_info(&pdev->dev, "device removed\n");
-
 	return 0;
 }
 
