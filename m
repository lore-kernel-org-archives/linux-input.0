From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 03/10] Input: atmel_mxt_ts - refactor input device creation
Date: Fri,  1 Feb 2013 16:11:45 +0800
Message-ID: <1359706312-24642-4-git-send-email-djkurtz@chromium.org>
References: <1359706312-24642-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52450 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab3BAIMM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Feb 2013 03:12:12 -0500
Received: by mail-pb0-f41.google.com with SMTP id ro12so2062961pbb.0
        for <linux-input@vger.kernel.org>; Fri, 01 Feb 2013 00:12:12 -0800 (PST)
In-Reply-To: <1359706312-24642-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, Daniel Kurtz <djkurtz@chromium.org>

Move input device initialization to its own helper function.
This is in preparation of a future patch that makes input device
conditional on the device not being in its bootloader.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 91 ++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 84f0408..9afc26e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1111,52 +1111,23 @@ static void mxt_input_close(struct input_dev *dev)
 	mxt_stop(data);
 }
 
-static int mxt_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static int mxt_input_dev_create(struct mxt_data *data)
 {
-	const struct mxt_platform_data *pdata = client->dev.platform_data;
-	struct mxt_data *data;
 	struct input_dev *input_dev;
 	int error;
 	unsigned int num_mt_slots;
 
-	if (!pdata)
-		return -EINVAL;
-
-	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	data->input_dev = input_dev = input_allocate_device();
+	if (!input_dev)
 		return -ENOMEM;
-	}
-
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
 
 	input_dev->name = "Atmel maXTouch Touchscreen";
-	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
-		 client->adapter->nr, client->addr);
 	input_dev->phys = data->phys;
-
 	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = &client->dev;
+	input_dev->dev.parent = &data->client->dev;
 	input_dev->open = mxt_input_open;
 	input_dev->close = mxt_input_close;
 
-	data->client = client;
-	data->input_dev = input_dev;
-	data->pdata = pdata;
-	data->irq = client->irq;
-
-	mxt_calc_resolution(data);
-
-	error = mxt_initialize(data);
-	if (error)
-		goto err_free_mem;
-
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
@@ -1172,10 +1143,8 @@ static int mxt_probe(struct i2c_client *client,
 	/* For multi touch */
 	num_mt_slots = data->T9_reportid_max - data->T9_reportid_min + 1;
 	error = input_mt_init_slots(input_dev, num_mt_slots, 0);
-	if (error) {
-		input_free_device(input_dev);
-		goto err_free_object;
-	}
+	if (error)
+		goto err_free_device;
 
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, MXT_MAX_AREA, 0, 0);
@@ -1187,14 +1156,54 @@ static int mxt_probe(struct i2c_client *client,
 			     0, 255, 0, 0);
 
 	input_set_drvdata(input_dev, data);
-	i2c_set_clientdata(client, data);
 
 	error = input_register_device(input_dev);
-	if (error) {
-		input_free_device(input_dev);
-		goto err_free_object;
+	if (error)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	input_free_device(data->input_dev);
+	data->input_dev = NULL;
+	return error;
+}
+
+static int __devinit mxt_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	const struct mxt_platform_data *pdata = client->dev.platform_data;
+	struct mxt_data *data;
+	int error;
+
+	if (!pdata)
+		return -EINVAL;
+
+	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
+	if (!data) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
 	}
 
+	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
+		 client->adapter->nr, client->addr);
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	data->pdata = pdata;
+	data->irq = client->irq;
+
+	mxt_calc_resolution(data);
+
+	error = mxt_initialize(data);
+	if (error)
+		goto err_free_mem;
+
+	error = mxt_input_dev_create(data);
+	if (error)
+		goto err_free_object;
+
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
 				     pdata->irqflags | IRQF_ONESHOT,
 				     client->name, data);
-- 
1.8.1

