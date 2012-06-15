From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] Input: twl4030-vibra: Convert to use devm_* in probe
Date: Fri, 15 Jun 2012 13:22:11 +0300
Message-ID: <1339755732-23774-2-git-send-email-peter.ujfalusi@ti.com>
References: <1339755732-23774-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339755732-23774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com
List-Id: linux-input@vger.kernel.org

Cleanup to use devm_* when it is possible at probe time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/input/misc/twl4030-vibra.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index fc0ed9b..d1e1a7e 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -205,7 +205,7 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -216,8 +216,7 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
 	info->input_dev = input_allocate_device();
 	if (info->input_dev == NULL) {
 		dev_err(&pdev->dev, "couldn't allocate input device\n");
-		ret = -ENOMEM;
-		goto err_kzalloc;
+		return -ENOMEM;
 	}
 
 	input_set_drvdata(info->input_dev, info);
@@ -250,8 +249,6 @@ err_iff:
 	input_ff_destroy(info->input_dev);
 err_ialloc:
 	input_free_device(info->input_dev);
-err_kzalloc:
-	kfree(info);
 	return ret;
 }
 
@@ -261,7 +258,6 @@ static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
 
 	/* this also free ff-memless and calls close if needed */
 	input_unregister_device(info->input_dev);
-	kfree(info);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.8.6
