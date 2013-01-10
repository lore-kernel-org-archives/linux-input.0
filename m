From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 1/2] Input: twl4030-vibra: Convert to use devm_* in probe
Date: Thu, 10 Jan 2013 14:36:04 +0100
Message-ID: <1357824965-30614-2-git-send-email-peter.ujfalusi@ti.com>
References: <1357824965-30614-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41973 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3AJNgP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jan 2013 08:36:15 -0500
In-Reply-To: <1357824965-30614-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Cleanup to use devm_* when it is possible at probe time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/input/misc/twl4030-vibra.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 78eb6b3..1fe7644 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -219,7 +219,7 @@ static int twl4030_vibra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -230,8 +230,7 @@ static int twl4030_vibra_probe(struct platform_device *pdev)
 	info->input_dev = input_allocate_device();
 	if (info->input_dev == NULL) {
 		dev_err(&pdev->dev, "couldn't allocate input device\n");
-		ret = -ENOMEM;
-		goto err_kzalloc;
+		return -ENOMEM;
 	}
 
 	input_set_drvdata(info->input_dev, info);
@@ -264,8 +263,6 @@ err_iff:
 	input_ff_destroy(info->input_dev);
 err_ialloc:
 	input_free_device(info->input_dev);
-err_kzalloc:
-	kfree(info);
 	return ret;
 }
 
@@ -275,7 +272,6 @@ static int twl4030_vibra_remove(struct platform_device *pdev)
 
 	/* this also free ff-memless and calls close if needed */
 	input_unregister_device(info->input_dev);
-	kfree(info);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.8.1

