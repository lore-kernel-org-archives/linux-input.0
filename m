From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 1/2] Input: atmel_mxt_ts: Use more managed resources
Date: Mon,  3 Jul 2017 14:38:42 +0200
Message-ID: <20170703123843.19340-2-sebastian.reichel@collabora.co.uk>
References: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Switch mxt_data and interrupt to resource managed allocation methods,
which cleans up the driver slightly and prepares for adding
reset GPIO support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dd042a9b0aaa..9a7b8eba64a6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3117,11 +3117,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	data = devm_kzalloc(&client->dev, sizeof(struct mxt_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
-	}
 
 	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
 		 client->adapter->nr, client->addr);
@@ -3135,19 +3133,20 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
 
-	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+				     mxt_interrupt,
 				     pdata->irqflags | IRQF_ONESHOT,
 				     client->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
-		goto err_free_mem;
+		return error;
 	}
 
 	disable_irq(client->irq);
 
 	error = mxt_initialize(data);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
 	if (error) {
@@ -3161,10 +3160,6 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 err_free_object:
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-err_free_irq:
-	free_irq(client->irq, data);
-err_free_mem:
-	kfree(data);
 	return error;
 }
 
@@ -3172,11 +3167,10 @@ static int mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data = i2c_get_clientdata(client);
 
+	disable_irq(data->irq);
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
-	free_irq(data->irq, data);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-	kfree(data);
 
 	return 0;
 }
-- 
2.13.2
