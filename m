From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: matrix-keypad - switch to using dev_pm_ops
Date: Wed, 2 Dec 2009 22:12:01 -0800
Message-ID: <20091203061200.GG9121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:33434 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbZLCGL6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 01:11:58 -0500
Received: by pzk14 with SMTP id 14so1020747pzk.23
        for <linux-input@vger.kernel.org>; Wed, 02 Dec 2009 22:12:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Input: matrix-keypad - switch to using dev_pm_ops

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/matrix_keypad.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)


diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index a1152ba..d3c8b61 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -215,8 +215,9 @@ static void matrix_keypad_stop(struct input_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t state)
+static int matrix_keypad_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
@@ -237,8 +238,9 @@ static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t stat
 	return 0;
 }
 
-static int matrix_keypad_resume(struct platform_device *pdev)
+static int matrix_keypad_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
@@ -257,9 +259,9 @@ static int matrix_keypad_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define matrix_keypad_suspend	NULL
-#define matrix_keypad_resume	NULL
+
+static const SIMPLE_DEV_PM_OPS(matrix_keypad_pm_ops,
+				matrix_keypad_suspend, matrix_keypad_resume);
 #endif
 
 static int __devinit init_matrix_gpio(struct platform_device *pdev,
@@ -432,11 +434,12 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
 	.remove		= __devexit_p(matrix_keypad_remove),
-	.suspend	= matrix_keypad_suspend,
-	.resume		= matrix_keypad_resume,
 	.driver		= {
 		.name	= "matrix-keypad",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &matrix_keypad_pm_ops,
+#endif
 	},
 };
 
-- 
Dmitry
