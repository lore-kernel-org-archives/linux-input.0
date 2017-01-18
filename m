From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 20/33] Input: elan_i2c_core - Use 'dev' instead of dereferencing it and other changes
Date: Wed, 18 Jan 2017 09:46:41 -0800
Message-ID: <1484761614-12225-21-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, KT Liao <kt.liao@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Use local variable 'dev' instead of dereferencing it several times.
Other relevant changes:
  Simplify error return
  Replace devm_add_action() with devm_add_action_or_reset()

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'if (e) return e; return 0;' with 'return e;'
- Use local variable 'struct device *dev' consistently

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/mouse/elan_i2c_core.c | 59 +++++++++++++------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa598f7f4372..806f304e6356 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -210,10 +210,7 @@ static int elan_query_product(struct elan_tp_data *data)
 
 	error = data->ops->get_sm_version(data->client, &data->ic_type,
 					  &data->sm_version);
-	if (error)
-		return error;
-
-	return 0;
+	return error;
 }
 
 static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
@@ -926,12 +923,12 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	*/
 	if (data->in_fw_update) {
 		complete(&data->fw_completion);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	error = data->ops->get_report(data->client, report);
 	if (error)
-		goto out;
+		return IRQ_HANDLED;
 
 	if (report[ETP_REPORT_ID_OFFSET] != ETP_REPORT_ID)
 		dev_err(dev, "invalid report id data (%x)\n",
@@ -939,7 +936,6 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	else
 		elan_report_absolute(data, report);
 
-out:
 	return IRQ_HANDLED;
 }
 
@@ -1041,8 +1037,7 @@ static int elan_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(struct elan_tp_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct elan_tp_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1053,29 +1048,24 @@ static int elan_probe(struct i2c_client *client,
 	init_completion(&data->fw_completion);
 	mutex_init(&data->sysfs_mutex);
 
-	data->vcc = devm_regulator_get(&client->dev, "vcc");
+	data->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		error = PTR_ERR(data->vcc);
 		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vcc' regulator: %d\n",
+			dev_err(dev, "Failed to get 'vcc' regulator: %d\n",
 				error);
 		return error;
 	}
 
 	error = regulator_enable(data->vcc);
 	if (error) {
-		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", error);
+		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				elan_disable_regulator, data);
+	error = devm_add_action_or_reset(dev, elan_disable_regulator, data);
 	if (error) {
-		regulator_disable(data->vcc);
-		dev_err(&client->dev,
-			"Failed to add disable regulator action: %d\n",
+		dev_err(dev, "Failed to add disable regulator action: %d\n",
 			error);
 		return error;
 	}
@@ -1093,15 +1083,14 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	dev_info(&client->dev,
+	dev_info(dev,
 		 "Elan Touchpad: Module ID: 0x%04x, Firmware: 0x%04x, Sample: 0x%04x, IAP: 0x%04x\n",
 		 data->product_id,
 		 data->fw_version,
 		 data->sm_version,
 		 data->iap_version);
 
-	dev_dbg(&client->dev,
-		"Elan Touchpad Extra Information:\n"
+	dev_dbg(dev, "Elan Touchpad Extra Information:\n"
 		"    Max ABS X,Y:   %d,%d\n"
 		"    Width X,Y:   %d,%d\n"
 		"    Resolution X,Y:   %d,%d (dots/mm)\n",
@@ -1118,38 +1107,32 @@ static int elan_probe(struct i2c_client *client,
 	 * Systems using device tree should set up interrupt via DTS,
 	 * the rest will use the default falling edge interrupts.
 	 */
-	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+	irqflags = dev->of_node ? 0 : IRQF_TRIGGER_FALLING;
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, elan_isr,
+	error = devm_request_threaded_irq(dev, client->irq, NULL, elan_isr,
 					  irqflags | IRQF_ONESHOT,
 					  client->name, data);
 	if (error) {
-		dev_err(&client->dev, "cannot register irq=%d\n", client->irq);
+		dev_err(dev, "cannot register irq=%d\n", client->irq);
 		return error;
 	}
 
-	error = sysfs_create_groups(&client->dev.kobj, elan_sysfs_groups);
+	error = sysfs_create_groups(&dev->kobj, elan_sysfs_groups);
 	if (error) {
-		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
-			error);
+		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				elan_remove_sysfs_groups, data);
+	error = devm_add_action_or_reset(dev, elan_remove_sysfs_groups, data);
 	if (error) {
-		elan_remove_sysfs_groups(data);
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n",
+		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
 	}
 
 	error = input_register_device(data->input);
 	if (error) {
-		dev_err(&client->dev, "failed to register input device: %d\n",
-			error);
+		dev_err(dev, "failed to register input device: %d\n", error);
 		return error;
 	}
 
@@ -1157,8 +1140,8 @@ static int elan_probe(struct i2c_client *client,
 	 * Systems using device tree should set up wakeup via DTS,
 	 * the rest will configure device as wakeup source by default.
 	 */
-	if (!client->dev.of_node)
-		device_init_wakeup(&client->dev, true);
+	if (!dev->of_node)
+		device_init_wakeup(dev, true);
 
 	return 0;
 }
-- 
2.7.4
