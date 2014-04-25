From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Input: twl6040-vibra - use devm functions
Date: Fri, 25 Apr 2014 11:38:28 -0300
Message-ID: <1398436708-3903-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:46202 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYOi5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 10:38:57 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so3346019ykb.22
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 07:38:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: peter.ujfalusi@ti.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_regulator_bulk_get() and devm_input_allocate_device() can make the
code cleaner and smaller as we do not need to call regulator_bulk_free() in the
error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also use devm_input_allocate_device()

 drivers/input/misc/twl6040-vibra.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 77dc23b..76aa602 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -323,8 +323,9 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	 * When booted with Device tree the regulators are attached to the
 	 * parent device (twl6040 MFD core)
 	 */
-	ret = regulator_bulk_get(twl6040_core_dev, ARRAY_SIZE(info->supplies),
-				 info->supplies);
+	ret = devm_regulator_bulk_get(twl6040_core_dev,
+				      ARRAY_SIZE(info->supplies),
+				      info->supplies);
 	if (ret) {
 		dev_err(info->dev, "couldn't get regulators %d\n", ret);
 		return ret;
@@ -336,7 +337,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(info->dev, "failed to set VDDVIBL volt %d\n",
 				ret);
-			goto err_regulator;
+			return ret;
 		}
 	}
 
@@ -346,17 +347,16 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(info->dev, "failed to set VDDVIBR volt %d\n",
 				ret);
-			goto err_regulator;
+			return ret;
 		}
 	}
 
 	INIT_WORK(&info->play_work, vibra_play_work);
 
-	info->input_dev = input_allocate_device();
+	info->input_dev = devm_input_allocate_device(&pdev->dev);
 	if (info->input_dev == NULL) {
 		dev_err(info->dev, "couldn't allocate input device\n");
-		ret = -ENOMEM;
-		goto err_regulator;
+		return -ENOMEM;
 	}
 
 	input_set_drvdata(info->input_dev, info);
@@ -370,7 +370,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	ret = input_ff_create_memless(info->input_dev, NULL, vibra_play);
 	if (ret < 0) {
 		dev_err(info->dev, "couldn't register vibrator to FF\n");
-		goto err_ialloc;
+		return ret;
 	}
 
 	ret = input_register_device(info->input_dev);
@@ -385,10 +385,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 
 err_iff:
 	input_ff_destroy(info->input_dev);
-err_ialloc:
-	input_free_device(info->input_dev);
-err_regulator:
-	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
 	return ret;
 }
 
@@ -397,7 +393,6 @@ static int twl6040_vibra_remove(struct platform_device *pdev)
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
 	input_unregister_device(info->input_dev);
-	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
 
 	return 0;
 }
-- 
1.8.3.2

