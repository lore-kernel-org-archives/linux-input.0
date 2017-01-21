From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/13] Input: touchscreen - Drop calls to platform_set_drvdata and i2c_set_clientdata
Date: Sat, 21 Jan 2017 10:45:55 -0800
Message-ID: <1485024365-3368-4-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

There is no call to i2c_get_clientdata(), platform_get_drvdata(),
or dev_get_drvdata() in any of the drivers in this patch.
Drop the unnecessary calls to to i2c_set_clientdata() and
platform_set_drvdata().

This conversion was done automatically with coccinelle.
The semantic patch is available at
https://github.com/groeck/coccinelle-patches/blob/master/common/pdev.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/88pm860x-ts.c     | 3 ---
 drivers/input/touchscreen/colibri-vf50-ts.c | 2 --
 drivers/input/touchscreen/egalax_ts.c       | 1 -
 drivers/input/touchscreen/max11801_ts.c     | 1 -
 drivers/input/touchscreen/sx8654.c          | 1 -
 5 files changed, 8 deletions(-)

diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index 251ff2aa0633..7ed828a51f4c 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -240,8 +240,6 @@ static int pm860x_touch_probe(struct platform_device *pdev)
 	if (!touch)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, touch);
-
 	touch->idev = devm_input_allocate_device(&pdev->dev);
 	if (!touch->idev) {
 		dev_err(&pdev->dev, "Failed to allocate input device!\n");
@@ -285,7 +283,6 @@ static int pm860x_touch_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, touch);
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index 69828d015d45..69c08acae264 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -311,8 +311,6 @@ static int vf50_ts_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, touchdev);
-
 	input->name = DRIVER_NAME;
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 1afc08b08155..3592a946950b 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -229,7 +229,6 @@ static int egalax_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	i2c_set_clientdata(client, ts);
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index 82079cde849c..d87b89da114e 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -216,7 +216,6 @@ static int max11801_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	i2c_set_clientdata(client, data);
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 642f4a53de50..ed29db3ec731 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -253,7 +253,6 @@ static int sx8654_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	i2c_set_clientdata(client, sx8654);
 	return 0;
 }
 
-- 
2.7.4
