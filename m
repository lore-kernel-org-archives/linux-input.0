From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] input: st1232: Convert to devm_* infrastructure
Date: Wed, 10 Apr 2013 11:10:27 +0200
Message-ID: <1365585027-8123-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:55284 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3DJJKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Apr 2013 05:10:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org

Use the devm_* managed functions to allocate resources.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/input/touchscreen/st1232.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

Compile-tested only.

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d9d05e2..f091451 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -157,12 +157,10 @@ static int st1232_ts_probe(struct i2c_client *client,
 	}
 
 
-	ts = kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&client->dev);
+	if (!ts || !input_dev)
+		return -ENOMEM;
 
 	ts->client = client;
 	ts->input_dev = input_dev;
@@ -179,41 +177,30 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X, MAX_X, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
 
-	error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
-				     IRQF_ONESHOT, client->name, ts);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					  st1232_ts_irq_handler, IRQF_ONESHOT,
+					  client->name, ts);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
 		dev_err(&client->dev, "Unable to register %s input device\n",
 			input_dev->name);
-		goto err_free_irq;
+		return error;
 	}
 
 	i2c_set_clientdata(client, ts);
 	device_init_wakeup(&client->dev, 1);
 
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, ts);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(ts);
-	return error;
 }
 
 static int st1232_ts_remove(struct i2c_client *client)
 {
-	struct st1232_ts_data *ts = i2c_get_clientdata(client);
-
 	device_init_wakeup(&client->dev, 0);
-	free_irq(client->irq, ts);
-	input_unregister_device(ts->input_dev);
-	kfree(ts);
 
 	return 0;
 }
-- 
Regards,

Laurent Pinchart

