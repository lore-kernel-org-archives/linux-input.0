From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH]  Input: max11801_ts - convert to devm
Date: Wed, 24 Jul 2013 20:05:02 -0300
Message-ID: <1374707102-5461-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43899 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3GXXFL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jul 2013 19:05:11 -0400
Received: by mail-gg0-f174.google.com with SMTP id y3so208830ggc.33
        for <linux-input@vger.kernel.org>; Wed, 24 Jul 2013 16:05:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Converting to devm functions can make the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/max11801_ts.c | 37 ++++++++-------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index 00bc6ca..9f84fcd 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -181,12 +181,11 @@ static int max11801_ts_probe(struct i2c_client *client,
 	struct input_dev *input_dev;
 	int error;
 
-	data = kzalloc(sizeof(struct max11801_data), GFP_KERNEL);
-	input_dev = input_allocate_device();
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&client->dev);
 	if (!data || !input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	data->client = client;
@@ -205,38 +204,21 @@ static int max11801_ts_probe(struct i2c_client *client,
 
 	max11801_ts_phy_init(data);
 
-	error = request_threaded_irq(client->irq, NULL, max11801_ts_interrupt,
-				     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-				     "max11801_ts", data);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					  max11801_ts_interrupt,
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					  "max11801_ts", data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	error = input_register_device(data->input_dev);
 	if (error)
-		goto err_free_irq;
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
-static int max11801_ts_remove(struct i2c_client *client)
-{
-	struct max11801_data *data = i2c_get_clientdata(client);
-
-	free_irq(client->irq, data);
-	input_unregister_device(data->input_dev);
-	kfree(data);
-
-	return 0;
 }
 
 static const struct i2c_device_id max11801_ts_id[] = {
@@ -252,7 +234,6 @@ static struct i2c_driver max11801_ts_driver = {
 	},
 	.id_table	= max11801_ts_id,
 	.probe		= max11801_ts_probe,
-	.remove		= max11801_ts_remove,
 };
 
 module_i2c_driver(max11801_ts_driver);
-- 
1.8.1.2

