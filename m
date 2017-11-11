From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 1/2] Input: ili210x - use managed allocated resources
Date: Sat, 11 Nov 2017 07:02:30 +0200
Message-ID: <20171111050231.29047-2-andi@etezian.org>
References: <20171111050231.29047-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:47470 "EHLO
        12.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdKKFSb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Nov 2017 00:18:31 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0701616F9C1
        for <linux-input@vger.kernel.org>; Sat, 11 Nov 2017 06:02:54 +0100 (CET)
In-Reply-To: <20171111050231.29047-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@gmail.com>

Use managed allocated resources to simplify error handling during
probing.

Adjust goto labels and remove function accordingly.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ili210x.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6f76eeedf465..da868b1d0e83 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -224,12 +224,10 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	xmax = panel.finger_max.x_low | (panel.finger_max.x_high << 8);
 	ymax = panel.finger_max.y_low | (panel.finger_max.y_high << 8);
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!priv || !input) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	input = devm_input_allocate_device(&client->dev);
+	if (!priv || !input)
+		return -ENOMEM;
 
 	priv->client = client;
 	priv->input = input;
@@ -258,25 +256,26 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, priv);
 
-	error = request_irq(client->irq, ili210x_irq, pdata->irq_flags,
-			    client->name, priv);
+	error = devm_request_irq(&client->dev, client->irq,
+				 ili210x_irq, pdata->irq_flags,
+				 client->name, priv);
 	if (error) {
 		dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
 			error);
-		goto err_free_mem;
+		return error;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
+	error = devm_device_add_group(&client->dev, &ili210x_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
 			error);
-		goto err_free_irq;
+		return error;
 	}
 
 	error = input_register_device(priv->input);
 	if (error) {
 		dev_err(dev, "Cannot register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		return error;
 	}
 
 	device_init_wakeup(dev, 1);
@@ -286,26 +285,13 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		client->irq, firmware.id, firmware.major, firmware.minor);
 
 	return 0;
-
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
-err_free_irq:
-	free_irq(client->irq, priv);
-err_free_mem:
-	input_free_device(input);
-	kfree(priv);
-	return error;
 }
 
 static int ili210x_i2c_remove(struct i2c_client *client)
 {
 	struct ili210x *priv = i2c_get_clientdata(client);
 
-	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
-	free_irq(priv->client->irq, priv);
 	cancel_delayed_work_sync(&priv->dwork);
-	input_unregister_device(priv->input);
-	kfree(priv);
 
 	return 0;
 }
-- 
2.15.0

