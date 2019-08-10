From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 09/11] Input: bu21013_ts - fix suspend when wake source
Date: Fri,  9 Aug 2019 17:20:37 -0700
Message-ID: <20190810002039.95876-10-dmitry.torokhov@gmail.com>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If the touchscreen is configured as wakeup source we should not be cutting
off power to it.

Also, now that the driver relies on I2C client to supply IRQ, we do not
need to explicitly enable and disable IRQ for wakeup: if device is created
as wakeup source, I2C core will mark interrupt as wakeup one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/bu21013_ts.c | 48 +++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index d745643861cb..d7e16e915743 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -547,44 +547,44 @@ static int bu21013_remove(struct i2c_client *client)
 
 static int __maybe_unused bu21013_suspend(struct device *dev)
 {
-	struct bu21013_ts *ts = dev_get_drvdata(dev);
-	struct i2c_client *client = ts->client;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct bu21013_ts *ts = i2c_get_clientdata(client);
 
 	ts->touch_stopped = true;
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(client->irq);
-	else
-		disable_irq(client->irq);
+	mb();
+	disable_irq(client->irq);
 
-	regulator_disable(ts->regulator);
+	if (!device_may_wakeup(&client->dev))
+		regulator_disable(ts->regulator);
 
 	return 0;
 }
 
 static int __maybe_unused bu21013_resume(struct device *dev)
 {
-	struct bu21013_ts *ts = dev_get_drvdata(dev);
-	struct i2c_client *client = ts->client;
-	int retval;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct bu21013_ts *ts = i2c_get_clientdata(client);
+	int error;
 
-	retval = regulator_enable(ts->regulator);
-	if (retval < 0) {
-		dev_err(&client->dev, "bu21013 regulator enable failed\n");
-		return retval;
-	}
+	if (!device_may_wakeup(&client->dev)) {
+		error = regulator_enable(ts->regulator);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to re-enable regulator when resuming\n");
+			return error;
+		}
 
-	retval = bu21013_init_chip(ts);
-	if (retval < 0) {
-		dev_err(&client->dev, "bu21013 controller config failed\n");
-		return retval;
+		error = bu21013_init_chip(ts);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to reinitialize chip when resuming\n");
+			return error;
+		}
 	}
 
 	ts->touch_stopped = false;
-
-	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(client->irq);
-	else
-		enable_irq(client->irq);
+	mb();
+	enable_irq(client->irq);
 
 	return 0;
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog
