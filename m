From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 01/14 v3] Input: atmel_mxt_ts - use CONFIG_PM_SLEEP
Date: Wed, 18 Apr 2012 21:21:46 +0800
Message-ID: <1334755319-21365-2-git-send-email-djkurtz@chromium.org>
References: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f74.google.com ([209.85.214.74]:42674 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab2DRNWE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 09:22:04 -0400
Received: by bkcjm19 with SMTP id jm19so356485bkc.1
        for <linux-input@vger.kernel.org>; Wed, 18 Apr 2012 06:22:03 -0700 (PDT)
In-Reply-To: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

Simple cleanup to use newer PM APIs.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 19d4ea6..0a6e368 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1201,7 +1201,7 @@ static int __devexit mxt_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int mxt_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1239,13 +1239,10 @@ static int mxt_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops mxt_pm_ops = {
-	.suspend	= mxt_suspend,
-	.resume		= mxt_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
+
 static const struct i2c_device_id mxt_id[] = {
 	{ "qt602240_ts", 0 },
 	{ "atmel_mxt_ts", 0 },
@@ -1258,9 +1255,7 @@ static struct i2c_driver mxt_driver = {
 	.driver = {
 		.name	= "atmel_mxt_ts",
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &mxt_pm_ops,
-#endif
 	},
 	.probe		= mxt_probe,
 	.remove		= __devexit_p(mxt_remove),
-- 
1.7.7.3

