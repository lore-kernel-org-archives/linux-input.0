From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFT] i8042 - always reset upon resuming from S2R
Date: Fri, 16 Jul 2010 01:07:35 -0700
Message-ID: <20100716080735.GB14120@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46128 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935847Ab0GPIHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 04:07:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Hi,

There are a quite a few boxes that require use of i8042.reset option
to get their keyboard/mice/touchpads operable after suspend to ram.
The patch below changes behavior of i8042 to always reset the controller
after resuming from S2R and while it does fix the issue on some of the
affected boxes and does not appear to have any adverse effects on my
boxes that do not exibit the problem I would love for people to try
it out on their hardware. I am interested in tests on hardware that
needs the reset flag and on hardware that wroks fine without it.

Thanks!

-- 
Dmitry

Input: i8042 - reset keyboard controller wehen resuming from S2R

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some laptops, such as Lenovo 3000 N100, require keyboard controller reset
in order to have touchpad operable after suspend to RAM. Even if box does
not need the reset it should be safe to do so, so instead of chasing
after misbehaving boxes and grow DMI tables. let's reset the controller
unconditionally.

Reported-and-tested-by: Jerome Lacoste <jerome.lacoste@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   65 +++++++++++++++++++++++++++----------------
 1 files changed, 41 insertions(+), 24 deletions(-)


diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 6440a8f..258b98b 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -861,9 +861,6 @@ static int i8042_controller_selftest(void)
 	unsigned char param;
 	int i = 0;
 
-	if (!i8042_reset)
-		return 0;
-
 	/*
 	 * We try this 5 times; on some really fragile systems this does not
 	 * take the first time...
@@ -1020,7 +1017,8 @@ static void i8042_controller_reset(void)
  * Reset the controller if requested.
  */
 
-	i8042_controller_selftest();
+	if (i8042_reset)
+		i8042_controller_selftest();
 
 /*
  * Restore the original control register setting.
@@ -1094,23 +1092,11 @@ static void i8042_dritek_enable(void)
 #ifdef CONFIG_PM
 
 /*
- * Here we try to restore the original BIOS settings to avoid
- * upsetting it.
- */
-
-static int i8042_pm_reset(struct device *dev)
-{
-	i8042_controller_reset();
-
-	return 0;
-}
-
-/*
  * Here we try to reset everything back to a state we had
  * before suspending.
  */
 
-static int i8042_pm_restore(struct device *dev)
+static int i8042_controller_resume(bool force_reset)
 {
 	int error;
 
@@ -1118,9 +1104,11 @@ static int i8042_pm_restore(struct device *dev)
 	if (error)
 		return error;
 
-	error = i8042_controller_selftest();
-	if (error)
-		return error;
+	if (i8042_reset || force_reset) {
+		error = i8042_controller_selftest();
+		if (error)
+			return error;
+	}
 
 /*
  * Restore original CTR value and disable all ports
@@ -1162,6 +1150,28 @@ static int i8042_pm_restore(struct device *dev)
 	return 0;
 }
 
+/*
+ * Here we try to restore the original BIOS settings to avoid
+ * upsetting it.
+ */
+
+static int i8042_pm_reset(struct device *dev)
+{
+	i8042_controller_reset();
+
+	return 0;
+}
+
+static int i8042_pm_resume(struct device *dev)
+{
+	/*
+	 * On resume from S2R we always try to reset the controller
+	 * to bring it in a sane state. (In case of S2D we expect
+	 * BIOS to reset the controller for us.)
+	 */
+	return i8042_controller_resume(true);
+}
+
 static int i8042_pm_thaw(struct device *dev)
 {
 	i8042_interrupt(0, NULL);
@@ -1169,9 +1179,14 @@ static int i8042_pm_thaw(struct device *dev)
 	return 0;
 }
 
+static int i8042_pm_restore(struct device *dev)
+{
+	return i8042_controller_resume(false);
+}
+
 static const struct dev_pm_ops i8042_pm_ops = {
 	.suspend	= i8042_pm_reset,
-	.resume		= i8042_pm_restore,
+	.resume		= i8042_pm_resume,
 	.thaw		= i8042_pm_thaw,
 	.poweroff	= i8042_pm_reset,
 	.restore	= i8042_pm_restore,
@@ -1389,9 +1404,11 @@ static int __init i8042_probe(struct platform_device *dev)
 
 	i8042_platform_device = dev;
 
-	error = i8042_controller_selftest();
-	if (error)
-		return error;
+	if (i8042_reset) {
+		error = i8042_controller_selftest();
+		if (error)
+			return error;
+	}
 
 	error = i8042_controller_init();
 	if (error)
