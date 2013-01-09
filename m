From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v3] Input: mms114: Use devm_* APIs
Date: Wed,  9 Jan 2013 14:52:33 +0530
Message-ID: <1357723353-11144-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62207 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab3AIJbg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 04:31:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so914236pad.5
        for <linux-input@vger.kernel.org>; Wed, 09 Jan 2013 01:31:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, patches@linaro.org, Joonyoung Shim <jy0922.shim@samsung.com>

devm_* APIs are device managed and make the exit and clean up code
simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
Compile tested against linux-next (20130109).
Changes since:
v2:
Addressed review comments.
v1:
Removed input_unregister_device() call.
---
 drivers/input/touchscreen/mms114.c |   54 ++++++++++-------------------------
 1 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 98841d8..a9cb475 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -429,12 +429,12 @@ static int mms114_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(struct mms114_data), GFP_KERNEL);
-	input_dev = input_allocate_device();
+	data = devm_kzalloc(&client->dev, sizeof(struct mms114_data),
+			    GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&client->dev);
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -466,57 +466,36 @@ static int mms114_probe(struct i2c_client *client,
 	input_set_drvdata(input_dev, data);
 	i2c_set_clientdata(client, data);
 
-	data->core_reg = regulator_get(&client->dev, "avdd");
+	data->core_reg = devm_regulator_get(&client->dev, "avdd");
 	if (IS_ERR(data->core_reg)) {
 		error = PTR_ERR(data->core_reg);
 		dev_err(&client->dev,
 			"Unable to get the Core regulator (%d)\n", error);
-		goto err_free_mem;
+		return error;
 	}
 
-	data->io_reg = regulator_get(&client->dev, "vdd");
+	data->io_reg = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->io_reg)) {
 		error = PTR_ERR(data->io_reg);
 		dev_err(&client->dev,
 			"Unable to get the IO regulator (%d)\n", error);
-		goto err_core_reg;
+		return error;
 	}
 
-	error = request_threaded_irq(client->irq, NULL, mms114_interrupt,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "mms114", data);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			mms114_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			dev_name(&client->dev), data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_io_reg;
+		return error;
 	}
 	disable_irq(client->irq);
 
 	error = input_register_device(data->input_dev);
-	if (error)
-		goto err_free_irq;
-
-	return 0;
-
-err_free_irq:
-	free_irq(client->irq, data);
-err_io_reg:
-	regulator_put(data->io_reg);
-err_core_reg:
-	regulator_put(data->core_reg);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(data);
-	return error;
-}
-
-static int mms114_remove(struct i2c_client *client)
-{
-	struct mms114_data *data = i2c_get_clientdata(client);
-
-	free_irq(client->irq, data);
-	regulator_put(data->io_reg);
-	regulator_put(data->core_reg);
-	input_unregister_device(data->input_dev);
-	kfree(data);
+	if (error) {
+		dev_err(&client->dev, "Failed to register device\n");
+		return error;
+	}
 
 	return 0;
 }
@@ -590,7 +569,6 @@ static struct i2c_driver mms114_driver = {
 		.of_match_table = of_match_ptr(mms114_dt_match),
 	},
 	.probe		= mms114_probe,
-	.remove		= mms114_remove,
 	.id_table	= mms114_id,
 };
 
-- 
1.7.4.1

