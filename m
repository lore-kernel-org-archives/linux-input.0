From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 1/7] Input: pixcir_i2c_ts: Use devres managed resource allocations
Date: Mon, 5 May 2014 12:04:32 +0300
Message-ID: <1399280678-23925-2-git-send-email-rogerq@ti.com>
References: <1399280678-23925-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399280678-23925-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use devm_() and friends for allocating memory, input device
and IRQ.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 38 ++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 02392d2..8a083bd 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -130,6 +130,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 {
 	const struct pixcir_ts_platform_data *pdata =
 			dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
 	struct pixcir_i2c_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
@@ -139,12 +140,14 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!tsdata || !input) {
-		dev_err(&client->dev, "Failed to allocate driver data!\n");
-		error = -ENOMEM;
-		goto err_free_mem;
+	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
+	if (!tsdata)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
 	}
 
 	tsdata->client = client;
@@ -165,29 +168,22 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 
 	input_set_drvdata(input, tsdata);
 
-	error = request_threaded_irq(client->irq, NULL, pixcir_ts_isr,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     client->name, tsdata);
+	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  client->name, tsdata);
 	if (error) {
-		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-		goto err_free_mem;
+		dev_err(dev, "failed to request irq %d\n", client->irq);
+		return error;
 	}
 
 	error = input_register_device(input);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	i2c_set_clientdata(client, tsdata);
 	device_init_wakeup(&client->dev, 1);
 
 	return 0;
-
-err_free_irq:
-	free_irq(client->irq, tsdata);
-err_free_mem:
-	input_free_device(input);
-	kfree(tsdata);
-	return error;
 }
 
 static int pixcir_i2c_ts_remove(struct i2c_client *client)
@@ -198,10 +194,6 @@ static int pixcir_i2c_ts_remove(struct i2c_client *client)
 
 	tsdata->exiting = true;
 	mb();
-	free_irq(client->irq, tsdata);
-
-	input_unregister_device(tsdata->input);
-	kfree(tsdata);
 
 	return 0;
 }
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
