From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: twl6040-vibra - use devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 22:40:04 -0300
Message-ID: <1398390004-20535-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:53606 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaDYBkZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2014 21:40:25 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so2800683ykt.32
        for <linux-input@vger.kernel.org>; Thu, 24 Apr 2014 18:40:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: peter.ujfalusi@ti.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
do not need to call regulator_bulk_free() in the error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/misc/twl6040-vibra.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 77dc23b..bf0cb2d 100644
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
 
@@ -346,7 +347,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(info->dev, "failed to set VDDVIBR volt %d\n",
 				ret);
-			goto err_regulator;
+			return ret;
 		}
 	}
 
@@ -355,8 +356,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	info->input_dev = input_allocate_device();
 	if (info->input_dev == NULL) {
 		dev_err(info->dev, "couldn't allocate input device\n");
-		ret = -ENOMEM;
-		goto err_regulator;
+		return -ENOMEM;
 	}
 
 	input_set_drvdata(info->input_dev, info);
@@ -387,8 +387,6 @@ err_iff:
 	input_ff_destroy(info->input_dev);
 err_ialloc:
 	input_free_device(info->input_dev);
-err_regulator:
-	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
 	return ret;
 }
 
@@ -397,7 +395,6 @@ static int twl6040_vibra_remove(struct platform_device *pdev)
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
 	input_unregister_device(info->input_dev);
-	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
 
 	return 0;
 }
-- 
1.8.3.2

