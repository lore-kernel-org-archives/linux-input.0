From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Input: bf54x-keys - convert printk() to dev_*()
Date: Thu, 23 Jul 2009 03:15:46 -0400
Message-ID: <1248333346-19105-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35159 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbZGWHP7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 03:15:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/keyboard/bf54x-keys.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index d427f32..9be3109 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -184,14 +184,13 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 	int i, error;
 
 	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
-		printk(KERN_ERR DRV_NAME
-			": No rows, cols or keymap from pdata\n");
+		dev_err(&pdev->dev, "no rows, cols or keymap from pdata\n");
 		return -EINVAL;
 	}
 
 	if (!pdata->keymapsize ||
 	    pdata->keymapsize > (pdata->rows * pdata->cols)) {
-		printk(KERN_ERR DRV_NAME ": Invalid keymapsize\n");
+		dev_err(&pdev->dev, "invalid keymapsize\n");
 		return -EINVAL;
 	}
 
@@ -211,8 +210,8 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 
 	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
 	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
-		printk(KERN_WARNING DRV_NAME
-			": Invalid Debounce/Columndrive Time in platform data\n");
+		dev_warn(&pdev->dev,
+			"invalid platform debounce/columndrive time\n");
 		bfin_write_KPAD_MSEL(0xFF0);	/* Default MSEL	*/
 	} else {
 		bfin_write_KPAD_MSEL(
@@ -231,16 +230,14 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 
 	if (peripheral_request_list((u16 *)&per_rows[MAX_RC - pdata->rows],
 				    DRV_NAME)) {
-		printk(KERN_ERR DRV_NAME
-			": Requesting Peripherals failed\n");
+		dev_err(&pdev->dev, "requesting peripherals failed\n");
 		error = -EFAULT;
 		goto out0;
 	}
 
 	if (peripheral_request_list((u16 *)&per_cols[MAX_RC - pdata->cols],
 				    DRV_NAME)) {
-		printk(KERN_ERR DRV_NAME
-			": Requesting Peripherals failed\n");
+		dev_err(&pdev->dev, "requesting peripherals failed\n");
 		error = -EFAULT;
 		goto out1;
 	}
@@ -254,9 +251,8 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 	error = request_irq(bf54x_kpad->irq, bfin_kpad_isr,
 				0, DRV_NAME, pdev);
 	if (error) {
-		printk(KERN_ERR DRV_NAME
-			": unable to claim irq %d; error %d\n",
-			bf54x_kpad->irq, error);
+		dev_err(&pdev->dev, "unable to claim irq %d\n",
+			bf54x_kpad->irq);
 		goto out2;
 	}
 
@@ -297,8 +293,7 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 
 	error = input_register_device(input);
 	if (error) {
-		printk(KERN_ERR DRV_NAME
-			": Unable to register input device (%d)\n", error);
+		dev_err(&pdev->dev, "unable to register input device\n");
 		goto out4;
 	}
 
@@ -316,8 +311,7 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	printk(KERN_ERR DRV_NAME
-		": Blackfin BF54x Keypad registered IRQ %d\n", bf54x_kpad->irq);
+	dev_info(&pdev->dev, "initialized (IRQ %d)\n", bf54x_kpad->irq);
 
 	return 0;
 
-- 
1.6.3.3

