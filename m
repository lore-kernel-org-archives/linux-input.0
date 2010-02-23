From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [PATCH v2 2/2] Input: TWL4030-vibra: use dynamic workqueue
Date: Tue, 23 Feb 2010 16:27:59 +0200
Message-ID: <1266935279-331-2-git-send-email-ext-jari.vanhala@nokia.com>
References: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58324 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab0BWO2R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 09:28:17 -0500
In-Reply-To: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jari Vanhala <ext-jari.vanhala@nokia.com>

Change static workqueue to dynamically created &
destroyed version.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/misc/twl4030-vibra.c |   69 ++++++++++++++++++++++++++----------
 1 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 50f7537..0d5be20 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -45,6 +45,7 @@ struct vibra_info {
 	struct workqueue_struct *workqueue;
 	struct work_struct	play_work;
 	spinlock_t		lock; /* for workqueue */
+	int			users;
 
 	bool			enabled;
 	int			speed;
@@ -153,6 +154,49 @@ out:
 	return 0;
 }
 
+static int twl4030_vibra_open(struct input_dev *input)
+{
+	struct vibra_info *info = input_get_drvdata(input);
+
+	if (info->workqueue == NULL) {
+		info->workqueue = create_singlethread_workqueue("vibra");
+		if (info->workqueue == NULL) {
+			dev_err(&input->dev, "couldn't create workqueue\n");
+			return -ENOMEM;
+		}
+	}
+
+	info->users++;
+	return 0;
+}
+
+static void twl4030_vibra_wq_destroy(struct vibra_info *info)
+{
+	struct workqueue_struct *wq;
+
+	spin_lock(&info->lock);
+	wq = info->workqueue;
+	info->workqueue = NULL;
+	spin_unlock(&info->lock);
+
+	if (wq) {
+		cancel_work_sync(&info->play_work);
+		INIT_WORK(&info->play_work, vibra_play_work); /* cleanup */
+		destroy_workqueue(wq);
+	}
+
+	if (info->enabled)
+		vibra_disable(info);
+}
+
+static void twl4030_vibra_close(struct input_dev *input)
+{
+	struct vibra_info *info = input_get_drvdata(input);
+
+	if (!(--info->users))
+		twl4030_vibra_wq_destroy(info);
+}
+
 /*** Module ***/
 #if CONFIG_PM
 static int twl4030_vibra_suspend(struct device *dev)
@@ -197,12 +241,8 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	info->workqueue = create_singlethread_workqueue("vibra");
-	if (info->workqueue == NULL) {
-		dev_err(&pdev->dev, "couldn't create workqueue\n");
-		ret = -ENOMEM;
-		goto err_kzalloc;
-	}
+	info->workqueue = NULL;
+	info->users = 0;
 	INIT_WORK(&info->play_work, vibra_play_work);
 	spin_lock_init(&info->lock);
 
@@ -210,13 +250,15 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
 	if (info->input_dev == NULL) {
 		dev_err(&pdev->dev, "couldn't allocate input device\n");
 		ret = -ENOMEM;
-		goto err_workq;
+		goto err_kzalloc;
 	}
 	input_set_drvdata(info->input_dev, info);
 
 	info->input_dev->name = "twl4030:vibrator";
 	info->input_dev->id.version = 1;
 	info->input_dev->dev.parent = pdev->dev.parent;
+	info->input_dev->open = twl4030_vibra_open;
+	info->input_dev->close = twl4030_vibra_close;
 	set_bit(FF_RUMBLE, info->input_dev->ffbit);
 
 	ret = input_register_device(info->input_dev);
@@ -239,8 +281,6 @@ err_ireg:
 	info->input_dev = NULL;
 err_ialloc:
 	input_free_device(info->input_dev);
-err_workq:
-	destroy_workqueue(info->workqueue);
 err_kzalloc:
 	kfree(info);
 	return ret;
@@ -249,17 +289,8 @@ err_kzalloc:
 static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
 {
 	struct vibra_info *info = platform_get_drvdata(pdev);
-	struct workqueue_struct *wq;
-
-	spin_lock(&info->lock);
-	wq = info->workqueue;
-	info->workqueue = NULL;
-	spin_unlock(&info->lock);
 
-	cancel_work_sync(&info->play_work);
-	destroy_workqueue(wq);
-	if (info->enabled)
-		vibra_disable(info);
+	twl4030_vibra_wq_destroy(info);
 	/* this also free ff-memless which (in turn) kfree info */
 	input_unregister_device(info->input_dev);
 
-- 
1.6.3.3

