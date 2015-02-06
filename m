From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFT/PATCH] Input: bfin_rotary - introduce open and close methods
Date: Thu, 5 Feb 2015 22:56:03 -0800
Message-ID: <20150206065603.GA40057@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37513 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbbBFG4I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 01:56:08 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.zhang@analog.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Introduce open and close methods for the input device to postpone enabling
the device until it is needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Hi Sonic,

Could you please tell me if the driver still works with this parch?

Thanks!

 drivers/input/misc/bfin_rotary.c | 70 ++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 09d7612..1bc9409 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -35,6 +35,10 @@ struct bfin_rot {
 	unsigned int down_key;
 	unsigned int button_key;
 	unsigned int rel_code;
+
+	unsigned short mode;
+	unsigned short debounce;
+
 	unsigned short cnt_config;
 	unsigned short cnt_imask;
 	unsigned short cnt_debounce;
@@ -94,6 +98,35 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int bfin_rotary_open(struct input_dev *input)
+{
+	struct bfin_rot *rotary = input_get_drvdata(input);
+	unsigned short val;
+
+	if (rotary->mode & ROT_DEBE)
+		writew(rotary->debounce & DPRESCALE,
+			rotary->base + CNT_DEBOUNCE_OFF);
+
+	writew(rotary->mode & ~CNTE, rotary->base + CNT_CONFIG_OFF);
+
+	val = UCIE | DCIE;
+	if (rotary->button_key)
+		val |= CZMIE;
+	writew(val, rotary->base + CNT_IMASK_OFF);
+
+	writew(rotary->mode | CNTE, rotary->base + CNT_CONFIG_OFF);
+
+	return 0;
+}
+
+static void bfin_rotary_close(struct input_dev *input)
+{
+	struct bfin_rot *rotary = input_get_drvdata(input);
+
+	writew(0, rotary->base + CNT_CONFIG_OFF);
+	writew(0, rotary->base + CNT_IMASK_OFF);
+}
+
 static void bfin_rotary_free_action(void *data)
 {
 	peripheral_free_list(data);
@@ -154,6 +187,9 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	rotary->button_key = pdata->rotary_button_key;
 	rotary->rel_code = pdata->rotary_rel_code;
 
+	rotary->mode = pdata->mode;
+	rotary->debounce = pdata->debounce;
+
 	input->name = pdev->name;
 	input->phys = "bfin-rotary/input0";
 	input->dev.parent = &pdev->dev;
@@ -165,6 +201,9 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	input->open = bfin_rotary_open;
+	input->close = bfin_rotary_close;
+
 	if (rotary->up_key) {
 		__set_bit(EV_KEY, input->evbit);
 		__set_bit(rotary->up_key, input->keybit);
@@ -179,6 +218,9 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		__set_bit(rotary->button_key, input->keybit);
 	}
 
+	/* Quiesce the device before requesting irq */
+	bfin_rotary_close(input);
+
 	rotary->irq = platform_get_irq(pdev, 0);
 	if (rotary->irq < 0) {
 		dev_err(dev, "No rotary IRQ specified\n");
@@ -199,39 +241,12 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	if (pdata->rotary_button_key)
-		writew(CZMIE, rotary->base + CNT_IMASK_OFF);
-
-	if (pdata->mode & ROT_DEBE)
-		writew(pdata->debounce & DPRESCALE,
-			rotary->base + CNT_DEBOUNCE_OFF);
-
-	if (pdata->mode)
-		writew(readw(rotary->base + CNT_CONFIG_OFF) |
-			(pdata->mode & ~CNTE),
-			rotary->base + CNT_CONFIG_OFF);
-
-	writew(readw(rotary->base + CNT_IMASK_OFF) | UCIE | DCIE,
-		rotary->base + CNT_IMASK_OFF);
-	writew(readw(rotary->base + CNT_CONFIG_OFF) | CNTE,
-		rotary->base + CNT_CONFIG_OFF);
-
 	platform_set_drvdata(pdev, rotary);
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
 }
 
-static int bfin_rotary_remove(struct platform_device *pdev)
-{
-	struct bfin_rot *rotary = platform_get_drvdata(pdev);
-
-	writew(0, rotary->base + CNT_CONFIG_OFF);
-	writew(0, rotary->base + CNT_IMASK_OFF);
-
-	return 0;
-}
-
 static int __maybe_unused bfin_rotary_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -270,7 +285,6 @@ static SIMPLE_DEV_PM_OPS(bfin_rotary_pm_ops,
 
 static struct platform_driver bfin_rotary_device_driver = {
 	.probe		= bfin_rotary_probe,
-	.remove		= bfin_rotary_remove,
 	.driver		= {
 		.name	= "bfin-rotary",
 		.pm	= &bfin_rotary_pm_ops,
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
