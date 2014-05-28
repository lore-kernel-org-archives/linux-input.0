From: Beomho Seo <beomho.seo@samsung.com>
Subject: [RESEND PATCH v4 2/2] Input: mcs5000_ts: use devm_* functions
Date: Wed, 28 May 2014 18:13:16 +0900
Message-ID: <1401268396-23072-3-git-send-email-beomho.seo@samsung.com>
References: <1401268396-23072-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44147 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbaE1JNV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 05:13:21 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6A008RK1M64YB0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 28 May 2014 18:13:18 +0900 (KST)
In-reply-to: <1401268396-23072-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, sachin.kamat@linaro.org
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch use devm_* functions in mcs5000_ts driver.
As, a result, error patch and remove() function is simplified.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
Changes in v4:
- None.
Changes in v3:
- None.
Changes in v2:
- Additionally use devm_kzalloc for mcs_ts_data struct.
---
 drivers/input/touchscreen/mcs5000_ts.c |   42 +++++++++-----------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 647e36f..6b57e28 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -196,12 +196,11 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	if (!dev_get_platdata(&client->dev))
 		return -EINVAL;
 
-	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
-	input_dev = input_allocate_device();
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&client->dev);
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		ret = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -223,40 +222,24 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	if (data->platform_data->cfg_pin)
 		data->platform_data->cfg_pin();
 
-	ret = request_threaded_irq(client->irq, NULL, mcs5000_ts_interrupt,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT, "mcs5000_ts", data);
-
-	if (ret < 0) {
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			mcs5000_ts_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			"mcs5000_ts", data);
+	if (ret) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return ret;
 	}
 
 	ret = input_register_device(data->input_dev);
-	if (ret < 0)
-		goto err_free_irq;
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register input device\n");
+		return ret;
+	}
 
 	mcs5000_ts_phys_init(data);
 	i2c_set_clientdata(client, data);
 
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, data);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(data);
-	return ret;
-}
-
-static int mcs5000_ts_remove(struct i2c_client *client)
-{
-	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
-
-	free_irq(client->irq, data);
-	input_unregister_device(data->input_dev);
-	kfree(data);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -291,7 +274,6 @@ MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
 
 static struct i2c_driver mcs5000_ts_driver = {
 	.probe		= mcs5000_ts_probe,
-	.remove		= mcs5000_ts_remove,
 	.driver = {
 		.name = "mcs5000_ts",
 #ifdef CONFIG_PM
-- 
1.7.9.5

