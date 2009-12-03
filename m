From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH] input: twl4030_keypad enable / disable feature
Date: Thu,  3 Dec 2009 12:58:20 +0200
Message-ID: <1259837900-10803-3-git-send-email-samu.p.onkalo@nokia.com>
References: <1259837900-10803-1-git-send-email-samu.p.onkalo@nokia.com>
 <1259837900-10803-2-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23357 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974AbZLCK6l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 05:58:41 -0500
In-Reply-To: <1259837900-10803-2-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Implements HW level enable / disable functionality to twl4030_keypad
driver. Disable functionality turns interrupt generation off from
keypad driver which effectively blocks all keypad activity.
Enable functions allows interrupt handling again.
If the key was pressed while keypad is re-enabled, event is not registered.
A new key must be pressed or currently pressed key must be released.

This functionality is controlled via input subsystem. twl4030_keypad
driver sets up callback functions for input subsystem.

Keypad is also blocked during suspend mode.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/input/keyboard/twl4030_keypad.c |  153 ++++++++++++++++++++++++++-----
 1 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 9a2977c..18468d9 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -32,6 +32,7 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/mutex.h>
 
 
 /*
@@ -59,9 +60,11 @@ struct twl4030_keypad {
 	unsigned	n_rows;
 	unsigned	n_cols;
 	unsigned	irq;
+	unsigned	disable_depth;
 
 	struct device *dbg_dev;
 	struct input_dev *input;
+	struct mutex	mutex;
 };
 
 /*----------------------------------------------------------------------*/
@@ -155,6 +158,24 @@ static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 reg)
 	return ret;
 }
 
+static int twl4030_kp_enable_interrupts(struct twl4030_keypad *kp)
+{
+	u8 reg;
+	int ret;
+	/* Enable KP and TO interrupts now. */
+	reg = (u8)~(KEYP_IMR1_KP | KEYP_IMR1_TO);
+	ret = twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
+	return ret;
+}
+
+static void twl4030_kp_disable_interrupts(struct twl4030_keypad *kp)
+{
+	u8 reg;
+	/* mask all events - we don't care about the result */
+	reg = KEYP_IMR1_MIS | KEYP_IMR1_TO | KEYP_IMR1_LK | KEYP_IMR1_KP;
+	(void)twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
+}
+
 static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
 {
 	/* If all bits in a row are active for all coloumns then
@@ -198,25 +219,11 @@ static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
 	return 0;
 }
 
-static void twl4030_kp_scan(struct twl4030_keypad *kp, bool release_all)
+static void twl4030_kp_report_changes(struct twl4030_keypad *kp, u16 *new_state)
 {
 	struct input_dev *input = kp->input;
-	u16 new_state[TWL4030_MAX_ROWS];
 	int col, row;
 
-	if (release_all)
-		memset(new_state, 0, sizeof(new_state));
-	else {
-		/* check for any changes */
-		int ret = twl4030_read_kp_matrix_state(kp, new_state);
-
-		if (ret < 0)	/* panic ... */
-			return;
-
-		if (twl4030_is_in_ghost_state(kp, new_state))
-			return;
-	}
-
 	/* check for changes and print those */
 	for (row = 0; row < kp->n_rows; row++) {
 		int changed = new_state[row] ^ kp->kp_state[row];
@@ -244,6 +251,60 @@ static void twl4030_kp_scan(struct twl4030_keypad *kp, bool release_all)
 	input_sync(input);
 }
 
+static inline int twl4030_kp_disabled(struct twl4030_keypad *kp)
+{
+	return kp->disable_depth != 0;
+}
+
+static void twl4030_kp_enable(struct twl4030_keypad *kp)
+{
+	mutex_lock(&kp->mutex);
+	WARN_ON(!twl4030_kp_disabled(kp));
+	if (--kp->disable_depth == 0) {
+		enable_irq(kp->irq);
+		twl4030_kp_enable_interrupts(kp);
+	}
+	mutex_unlock(&kp->mutex);
+}
+
+static int twl4030_kp_scan(struct twl4030_keypad *kp, u16 *new_state)
+{
+	/* check for any changes */
+	int ret = twl4030_read_kp_matrix_state(kp, new_state);
+	if (ret < 0)    /* panic ... */
+		return ret;
+
+	return twl4030_is_in_ghost_state(kp, new_state);
+}
+
+static void twl4030_kp_disable(struct twl4030_keypad *kp)
+{
+	u16 new_state[TWL4030_MAX_ROWS];
+
+	mutex_lock(&kp->mutex);
+	if (kp->disable_depth++ == 0) {
+		memset(new_state, 0, sizeof(new_state));
+		twl4030_kp_report_changes(kp, new_state);
+		twl4030_kp_disable_interrupts(kp);
+		disable_irq(kp->irq);
+	}
+	mutex_unlock(&kp->mutex);
+}
+
+static int twl4030_disable(struct input_dev *dev)
+{
+	struct twl4030_keypad *kp = dev_get_drvdata(dev->dev.parent);
+	twl4030_kp_disable(kp);
+	return 0;
+}
+
+static int twl4030_enable(struct input_dev *dev)
+{
+	struct twl4030_keypad *kp = dev_get_drvdata(dev->dev.parent);
+	twl4030_kp_enable(kp);
+	return 0;
+}
+
 /*
  * Keypad interrupt handler
  */
@@ -252,6 +313,7 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 	struct twl4030_keypad *kp = _kp;
 	u8 reg;
 	int ret;
+	u16 new_state[TWL4030_MAX_ROWS];
 
 #ifdef CONFIG_LOCKDEP
 	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
@@ -264,12 +326,22 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 	/* Read & Clear TWL4030 pending interrupt */
 	ret = twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
 
+	mutex_lock(&kp->mutex);
+	if (twl4030_kp_disabled(kp)) {
+		mutex_unlock(&kp->mutex);
+		return IRQ_HANDLED;
+	}
+
 	/* Release all keys if I2C has gone bad or
 	 * the KEYP has gone to idle state */
 	if (ret >= 0 && (reg & KEYP_IMR1_KP))
-		twl4030_kp_scan(kp, false);
+		twl4030_kp_scan(kp, new_state);
 	else
-		twl4030_kp_scan(kp, true);
+		memset(new_state, 0, sizeof(new_state));
+
+	twl4030_kp_report_changes(kp, new_state);
+
+	mutex_unlock(&kp->mutex);
 
 	return IRQ_HANDLED;
 }
@@ -337,7 +409,6 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
 	struct twl4030_keypad *kp;
 	struct input_dev *input;
-	u8 reg;
 	int error;
 
 	if (!pdata || !pdata->rows || !pdata->cols ||
@@ -353,6 +424,8 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	mutex_init(&kp->mutex);
+
 	/* Get the debug Device */
 	kp->dbg_dev = &pdev->dev;
 	kp->input = input;
@@ -379,6 +452,9 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 	input->id.product	= 0x0001;
 	input->id.version	= 0x0003;
 
+	input->enable		= twl4030_enable;
+	input->disable		= twl4030_disable;
+
 	input->keycode		= kp->keymap;
 	input->keycodesize	= sizeof(kp->keymap[0]);
 	input->keycodemax	= ARRAY_SIZE(kp->keymap);
@@ -411,18 +487,17 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 	}
 
 	/* Enable KP and TO interrupts now. */
-	reg = (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
-	if (twl4030_kpwrite_u8(kp, reg, KEYP_IMR1)) {
-		error = -EIO;
+	error = twl4030_kp_enable_interrupts(kp);
+	if (error < 0)
 		goto err4;
-	}
 
 	platform_set_drvdata(pdev, kp);
+
 	return 0;
 
 err4:
 	/* mask all events - we don't care about the result */
-	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
+	twl4030_kp_disable_interrupts(kp);
 err3:
 	free_irq(kp->irq, NULL);
 err2:
@@ -446,6 +521,35 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int twl4030_kp_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);
+	twl4030_kp_disable(kp);
+	return 0;
+}
+
+static int twl4030_kp_resume(struct platform_device *pdev)
+{
+	struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);
+	twl4030_kp_enable(kp);
+	return 0;
+}
+
+static void twl4030_kp_shutdown(struct platform_device *pdev)
+{
+	struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);
+	/* Disable controller */
+	twl4030_kpwrite_u8(kp, 0, KEYP_CTRL);
+}
+#else
+
+#define twl4030_kp_suspend	NULL
+#define twl4030_kp_resume	NULL
+#define twl4030_kp_shutdown	NULL
+
+#endif /* CONFIG_PM */
+
 /*
  * NOTE: twl4030 are multi-function devices connected via I2C.
  * So this device is a child of an I2C parent, thus it needs to
@@ -455,6 +559,9 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 static struct platform_driver twl4030_kp_driver = {
 	.probe		= twl4030_kp_probe,
 	.remove		= __devexit_p(twl4030_kp_remove),
+	.suspend	= twl4030_kp_suspend,
+	.resume		= twl4030_kp_resume,
+	.shutdown	= twl4030_kp_shutdown,
 	.driver		= {
 		.name	= "twl4030_keypad",
 		.owner	= THIS_MODULE,
-- 
1.6.0.4

