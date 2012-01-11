From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: nomadik-ske-keypad - convert to using
 SIMPLE_DEV_PM_OPS
Date: Tue, 10 Jan 2012 23:35:37 -0800
Message-ID: <20120111073537.18870.17178.stgit@hammer.corenet.prv>
References: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43800 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2AKHfn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 02:35:43 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so710880iab.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 23:35:43 -0800 (PST)
In-Reply-To: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Also proper guard for system suspend/resume methods is CONFIG_PM_SLEEP,
not CONFIG_PM.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/nomadik-ske-keypad.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index bc9f339..101e245 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -344,7 +344,7 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ske_keypad_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -372,20 +372,16 @@ static int ske_keypad_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops ske_keypad_dev_pm_ops = {
-	.suspend = ske_keypad_suspend,
-	.resume = ske_keypad_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(ske_keypad_dev_pm_ops,
+			 ske_keypad_suspend, ske_keypad_resume);
+
 static struct platform_driver ske_keypad_driver = {
 	.driver = {
 		.name = "nmk-ske-keypad",
 		.owner  = THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm = &ske_keypad_dev_pm_ops,
-#endif
 	},
 	.remove = __devexit_p(ske_keypad_remove),
 };

