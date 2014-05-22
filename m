From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 1/2] Input: mcs_touchkey: use devm_* functions
Date: Thu, 22 May 2014 20:26:19 +0900
Message-ID: <1400757980-15156-2-git-send-email-beomho.seo@samsung.com>
References: <1400757980-15156-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10032 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbaEVL0Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 07:26:24 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Z0045Z3RY0D70@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 20:26:22 +0900 (KST)
In-reply-to: <1400757980-15156-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com
Cc: sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch use devm_* funtions in mcs_touchkey driver.
As a result, error path and remove() funtion is simplified.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |   49 +++++++++------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 1da8e0b..74df214 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -103,7 +103,6 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 	struct mcs_touchkey_data *data;
 	struct input_dev *input_dev;
 	unsigned int fw_reg;
-	int fw_ver;
 	int error;
 	int i;
 
@@ -116,11 +115,10 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 	data = kzalloc(sizeof(struct mcs_touchkey_data) +
 			sizeof(data->keycodes[0]) * (pdata->key_maxval + 1),
 			GFP_KERNEL);
-	input_dev = input_allocate_device();
+	input_dev = devm_input_allocate_device(&client->dev);
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -139,13 +137,12 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 		fw_reg = MCS5080_TOUCHKEY_FW;
 	}
 
-	fw_ver = i2c_smbus_read_byte_data(client, fw_reg);
-	if (fw_ver < 0) {
-		error = fw_ver;
+	error = i2c_smbus_read_byte_data(client, fw_reg);
+	if (error < 0) {
 		dev_err(&client->dev, "i2c read error[%d]\n", error);
-		goto err_free_mem;
-	}
-	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
+		return error;
+	} else
+		dev_info(&client->dev, "Firmware version: %d\n", error);
 
 	input_dev->name = "MELPAS MCS Touchkey";
 	input_dev->id.bustype = BUS_I2C;
@@ -176,40 +173,21 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 		data->poweron(true);
 	}
 
-	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     client->dev.driver->name, data);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			mcs_touchkey_interrupt,	IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			dev_name(&client->dev), data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	error = input_register_device(input_dev);
 	if (error)
-		goto err_free_irq;
+		dev_err(&client->dev, "Failed to register input device\n");
+		return error;
 
 	i2c_set_clientdata(client, data);
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, data);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(data);
-	return error;
-}
-
-static int mcs_touchkey_remove(struct i2c_client *client)
-{
-	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
-
-	free_irq(client->irq, data);
-	if (data->poweron)
-		data->poweron(false);
-	input_unregister_device(data->input_dev);
-	kfree(data);
-
-	return 0;
 }
 
 static void mcs_touchkey_shutdown(struct i2c_client *client)
@@ -269,7 +247,6 @@ static struct i2c_driver mcs_touchkey_driver = {
 		.pm	= &mcs_touchkey_pm_ops,
 	},
 	.probe		= mcs_touchkey_probe,
-	.remove		= mcs_touchkey_remove,
 	.shutdown       = mcs_touchkey_shutdown,
 	.id_table	= mcs_touchkey_id,
 };
-- 
1.7.9.5

