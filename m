From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ili210x - switch to using devm_device_add_group()
Date: Wed, 6 Feb 2019 22:27:46 -0800
Message-ID: <20190207062746.GA30406@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

By switching to devm_device_add_group() we can complete driver conversion
to using managed resources and get rid of ili210x_i2c_remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6cfe463ac118..af1dd9cff12a 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -376,7 +376,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
+	error = devm_device_add_group(dev, &ili210x_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
 			error);
@@ -386,7 +386,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	error = input_register_device(priv->input);
 	if (error) {
 		dev_err(dev, "Cannot register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		return error;
 	}
 
 	device_init_wakeup(dev, 1);
@@ -396,17 +396,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		client->irq, firmware.id, firmware.major, firmware.minor);
 
 	return 0;
-
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
-	return error;
-}
-
-static int ili210x_i2c_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
-
-	return 0;
 }
 
 static int __maybe_unused ili210x_i2c_suspend(struct device *dev)
@@ -454,7 +443,6 @@ static struct i2c_driver ili210x_ts_driver = {
 	},
 	.id_table = ili210x_i2c_id,
 	.probe = ili210x_i2c_probe,
-	.remove = ili210x_i2c_remove,
 };
 
 module_i2c_driver(ili210x_ts_driver);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
