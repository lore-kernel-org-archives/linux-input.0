From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 01/20] Input: atmel_mxt_ts - use CONFIG_PM_SLEEP
Date: Tue, 13 Mar 2012 20:04:04 +0800
Message-ID: <1331640263-18935-2-git-send-email-djkurtz@chromium.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Simple cleanup to use newer PM APIs.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a596c27..b71de8f 100644
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
