From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 04/11] Input: bu21013_ts - annotate supend/resume methods as __maybe_unused
Date: Fri,  9 Aug 2019 17:20:32 -0700
Message-ID: <20190810002039.95876-5-dmitry.torokhov@gmail.com>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead if #ifdef-ing out suspend and resume methods, let's mark
them as __maybe_unused to get better compile time coverage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/bu21013_ts.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index e9cb020ed725..0bdadd24296f 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -634,7 +634,6 @@ static int bu21013_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 /**
  * bu21013_suspend() - suspend the touch screen controller
  * @dev: pointer to device structure
@@ -642,7 +641,7 @@ static int bu21013_remove(struct i2c_client *client)
  * This function is used to suspend the
  * touch panel controller and returns integer
  */
-static int bu21013_suspend(struct device *dev)
+static int __maybe_unused bu21013_suspend(struct device *dev)
 {
 	struct bu21013_ts *ts = dev_get_drvdata(dev);
 	struct i2c_client *client = ts->client;
@@ -665,7 +664,7 @@ static int bu21013_suspend(struct device *dev)
  * This function is used to resume the touch panel
  * controller and returns integer.
  */
-static int bu21013_resume(struct device *dev)
+static int __maybe_unused bu21013_resume(struct device *dev)
 {
 	struct bu21013_ts *ts = dev_get_drvdata(dev);
 	struct i2c_client *client = ts->client;
@@ -693,11 +692,7 @@ static int bu21013_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops bu21013_dev_pm_ops = {
-	.suspend = bu21013_suspend,
-	.resume  = bu21013_resume,
-};
-#endif
+static SIMPLE_DEV_PM_OPS(bu21013_dev_pm_ops, bu21013_suspend, bu21013_resume);
 
 static const struct i2c_device_id bu21013_id[] = {
 	{ DRIVER_TP, 0 },
@@ -708,9 +703,7 @@ MODULE_DEVICE_TABLE(i2c, bu21013_id);
 static struct i2c_driver bu21013_driver = {
 	.driver	= {
 		.name	=	DRIVER_TP,
-#ifdef CONFIG_PM
 		.pm	=	&bu21013_dev_pm_ops,
-#endif
 	},
 	.probe		=	bu21013_probe,
 	.remove		=	bu21013_remove,
-- 
2.23.0.rc1.153.gdeed80330f-goog
