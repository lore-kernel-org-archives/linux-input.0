From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] input: misc: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:24:18 +0900
Message-ID: <002601ce579f$af006ba0$0d0142e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51788 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab3EWKYU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 06:24:20 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN800CEKY8AIWZ0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 23 May 2013 19:24:19 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Also, unnecessary dev_set_drvdata() is removed, because the driver core
clears the driver data to NULL after device_release or on probe failure.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/sgi_btns.c  |    7 ++-----
 drivers/input/misc/sparcspkr.c |   14 +++++---------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index ad6415c..95cf299 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -128,7 +128,7 @@ static int sgi_buttons_probe(struct platform_device *pdev)
 	__clear_bit(KEY_RESERVED, input->keybit);
 
 	bdev->poll_dev = poll_dev;
-	dev_set_drvdata(&pdev->dev, bdev);
+	platform_set_drvdata(pdev, bdev);
 
 	error = input_register_polled_device(poll_dev);
 	if (error)
@@ -139,19 +139,16 @@ static int sgi_buttons_probe(struct platform_device *pdev)
  err_free_mem:
 	input_free_polled_device(poll_dev);
 	kfree(bdev);
-	dev_set_drvdata(&pdev->dev, NULL);
 	return error;
 }
 
 static int sgi_buttons_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct buttons_dev *bdev = dev_get_drvdata(dev);
+	struct buttons_dev *bdev = platform_get_drvdata(pdev);
 
 	input_unregister_polled_device(bdev->poll_dev);
 	input_free_polled_device(bdev->poll_dev);
 	kfree(bdev);
-	dev_set_drvdata(dev, NULL);
 
 	return 0;
 }
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index a53586a..65fd315 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -175,7 +175,7 @@ static int sparcspkr_probe(struct device *dev)
 
 static void sparcspkr_shutdown(struct platform_device *dev)
 {
-	struct sparcspkr_state *state = dev_get_drvdata(&dev->dev);
+	struct sparcspkr_state *state = platform_get_drvdata(dev);
 	struct input_dev *input_dev = state->input_dev;
 
 	/* turn off the speaker */
@@ -211,7 +211,7 @@ static int bbc_beep_probe(struct platform_device *op)
 	if (!info->regs)
 		goto out_free;
 
-	dev_set_drvdata(&op->dev, state);
+	platform_set_drvdata(op, state);
 
 	err = sparcspkr_probe(&op->dev);
 	if (err)
@@ -220,7 +220,6 @@ static int bbc_beep_probe(struct platform_device *op)
 	return 0;
 
 out_clear_drvdata:
-	dev_set_drvdata(&op->dev, NULL);
 	of_iounmap(&op->resource[0], info->regs, 6);
 
 out_free:
@@ -231,7 +230,7 @@ out_err:
 
 static int bbc_remove(struct platform_device *op)
 {
-	struct sparcspkr_state *state = dev_get_drvdata(&op->dev);
+	struct sparcspkr_state *state = platform_get_drvdata(op);
 	struct input_dev *input_dev = state->input_dev;
 	struct bbc_beep_info *info = &state->u.bbc;
 
@@ -242,7 +241,6 @@ static int bbc_remove(struct platform_device *op)
 
 	of_iounmap(&op->resource[0], info->regs, 6);
 
-	dev_set_drvdata(&op->dev, NULL);
 	kfree(state);
 
 	return 0;
@@ -290,7 +288,7 @@ static int grover_beep_probe(struct platform_device *op)
 	if (!info->enable_reg)
 		goto out_unmap_freq_regs;
 
-	dev_set_drvdata(&op->dev, state);
+	platform_set_drvdata(op, state);
 
 	err = sparcspkr_probe(&op->dev);
 	if (err)
@@ -299,7 +297,6 @@ static int grover_beep_probe(struct platform_device *op)
 	return 0;
 
 out_clear_drvdata:
-	dev_set_drvdata(&op->dev, NULL);
 	of_iounmap(&op->resource[3], info->enable_reg, 1);
 
 out_unmap_freq_regs:
@@ -312,7 +309,7 @@ out_err:
 
 static int grover_remove(struct platform_device *op)
 {
-	struct sparcspkr_state *state = dev_get_drvdata(&op->dev);
+	struct sparcspkr_state *state = platform_get_drvdata(op);
 	struct grover_beep_info *info = &state->u.grover;
 	struct input_dev *input_dev = state->input_dev;
 
@@ -324,7 +321,6 @@ static int grover_remove(struct platform_device *op)
 	of_iounmap(&op->resource[3], info->enable_reg, 1);
 	of_iounmap(&op->resource[2], info->freq_regs, 2);
 
-	dev_set_drvdata(&op->dev, NULL);
 	kfree(state);
 
 	return 0;
-- 
1.7.10.4


