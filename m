From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: migor-ts - rework probe() to simplify error path
Date: Mon, 14 Nov 2011 00:33:43 -0800
Message-ID: <1321259623-10887-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1321259623-10887-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43411 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1KNIdu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:33:50 -0500
Received: by ggnb2 with SMTP id b2so5931413ggn.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:33:50 -0800 (PST)
In-Reply-To: <1321259623-10887-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>

Register input device last so that we do not have to reset
input device pointer after calling input_unregister_device().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/migor_ts.c |   43 ++++++++++++++-------------------
 1 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index 704169f..5226194 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -137,21 +137,20 @@ static int migor_ts_probe(struct i2c_client *client,
 	int error;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&client->dev, "failed to allocate driver data\n");
-		error = -ENOMEM;
-		goto err0;
-	}
-
 	input = input_allocate_device();
-	if (!input) {
-		dev_err(&client->dev, "Failed to allocate input device.\n");
+	if (!priv || !input) {
+		dev_err(&client->dev, "failed to allocate memory\n");
 		error = -ENOMEM;
-		goto err1;
+		goto err_free_mem;
 	}
 
+	priv->client = client;
+	priv->input = input;
+	priv->irq = client->irq;
+
 	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	__set_bit(BTN_TOUCH, input->keybit);
 
 	input_set_abs_params(input, ABS_X, 95, 955, 0, 0);
 	input_set_abs_params(input, ABS_Y, 85, 935, 0, 0);
@@ -165,34 +164,28 @@ static int migor_ts_probe(struct i2c_client *client,
 
 	input_set_drvdata(input, priv);
 
-	priv->client = client;
-	priv->input = input;
-	priv->irq = client->irq;
-
-	error = input_register_device(input);
-	if (error)
-		goto err1;
-
 	error = request_threaded_irq(priv->irq, NULL, migor_ts_isr,
                                      IRQF_TRIGGER_LOW | IRQF_ONESHOT,
                                      client->name, priv);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-		goto err2;
+		goto err_free_mem;
 	}
 
+	error = input_register_device(input);
+	if (error)
+		goto err_free_irq;
+
 	i2c_set_clientdata(client, priv);
 	device_init_wakeup(&client->dev, 1);
+
 	return 0;
 
- err2:
-	input_unregister_device(input);
-	input = NULL; /* so we dont try to free it below */
- err1:
+ err_free_irq:
+	free_irq(priv->irq, priv);
+ err_free_mem:
 	input_free_device(input);
 	kfree(priv);
- err0:
-	dev_set_drvdata(&client->dev, NULL);
 	return error;
 }
 
-- 
1.7.6.4

