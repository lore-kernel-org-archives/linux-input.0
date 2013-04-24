From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] input: egalax_ts: move to devm_* functions
Date: Wed, 24 Apr 2013 15:28:07 +0300
Message-ID: <1366806487-19075-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54105 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758400Ab3DXM2N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Apr 2013 08:28:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The usage of devm_* functions makes code cleaner and tidier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/touchscreen/egalax_ts.c | 46 +++++++++++------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 21584bf..bd6e9d7 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -167,24 +167,22 @@ static int egalax_firmware_version(struct i2c_client *client)
 }
 
 static int egalax_ts_probe(struct i2c_client *client,
-				       const struct i2c_device_id *id)
+			   const struct i2c_device_id *id)
 {
 	struct egalax_ts *ts;
 	struct input_dev *input_dev;
-	int ret;
 	int error;
 
-	ts = kzalloc(sizeof(struct egalax_ts), GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev, sizeof(struct egalax_ts), GFP_KERNEL);
 	if (!ts) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	input_dev = input_allocate_device();
+	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_ts;
+		return -ENOMEM;
 	}
 
 	ts->client = client;
@@ -194,14 +192,13 @@ static int egalax_ts_probe(struct i2c_client *client,
 	error = egalax_wake_up_device(client);
 	if (error) {
 		dev_err(&client->dev, "Failed to wake up the controller\n");
-		goto err_free_dev;
+		return error;
 	}
 
-	ret = egalax_firmware_version(client);
-	if (ret < 0) {
+	error = egalax_firmware_version(client);
+	if (error < 0) {
 		dev_err(&client->dev, "Failed to read firmware version\n");
-		error = -EIO;
-		goto err_free_dev;
+		return error;
 	}
 
 	input_dev->name = "EETI eGalax Touch Screen";
@@ -222,40 +219,25 @@ static int egalax_ts_probe(struct i2c_client *client,
 
 	input_set_drvdata(input_dev, ts);
 
-	error = request_threaded_irq(client->irq, NULL, egalax_ts_interrupt,
-				     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-				     "egalax_ts", ts);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					  egalax_ts_interrupt,
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  "egalax_ts", ts);
 	if (error < 0) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_dev;
+		return error;
 	}
 
 	error = input_register_device(ts->input_dev);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	i2c_set_clientdata(client, ts);
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, ts);
-err_free_dev:
-	input_free_device(input_dev);
-err_free_ts:
-	kfree(ts);
-
-	return error;
 }
 
 static int egalax_ts_remove(struct i2c_client *client)
 {
-	struct egalax_ts *ts = i2c_get_clientdata(client);
-
-	free_irq(client->irq, ts);
-
-	input_unregister_device(ts->input_dev);
-	kfree(ts);
-
 	return 0;
 }
 
-- 
1.8.2.rc0.22.gb3600c3

