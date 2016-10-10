From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 7/8] Input: elan_i2c - store the irq in struct elan_tp_data
Date: Mon, 10 Oct 2016 18:42:34 +0200
Message-ID: <1476117755-8113-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

And make sure we have one available.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4
---
 drivers/input/mouse/elan_i2c_core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index d15b338..6f16eb4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -62,6 +62,7 @@ struct elan_tp_data {
 	struct i2c_client	*client;
 	struct input_dev	*input;
 	struct regulator	*vcc;
+	int			irq;
 
 	const struct elan_transport_ops *ops;
 
@@ -457,7 +458,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
 
 	dev_dbg(&client->dev, "Starting firmware update....\n");
 
-	disable_irq(client->irq);
+	disable_irq(data->irq);
 	data->in_fw_update = true;
 
 	retval = __elan_update_firmware(data, fw);
@@ -471,7 +472,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
 	}
 
 	data->in_fw_update = false;
-	enable_irq(client->irq);
+	enable_irq(data->irq);
 
 	return retval;
 }
@@ -599,7 +600,7 @@ static ssize_t calibrate_store(struct device *dev,
 	if (retval)
 		return retval;
 
-	disable_irq(client->irq);
+	disable_irq(data->irq);
 
 	data->mode |= ETP_ENABLE_CALIBRATE;
 	retval = data->ops->set_mode(client, data->mode);
@@ -645,7 +646,7 @@ out_disable_calibrate:
 			retval = error;
 	}
 out:
-	enable_irq(client->irq);
+	enable_irq(data->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return retval ?: count;
 }
@@ -711,7 +712,7 @@ static ssize_t acquire_store(struct device *dev, struct device_attribute *attr,
 	if (retval)
 		return retval;
 
-	disable_irq(client->irq);
+	disable_irq(data->irq);
 
 	data->baseline_ready = false;
 
@@ -753,7 +754,7 @@ out_disable_calibrate:
 			retval = error;
 	}
 out:
-	enable_irq(client->irq);
+	enable_irq(data->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return retval ?: count;
 }
@@ -1026,6 +1027,9 @@ static int elan_probe(struct i2c_client *client,
 	struct elan_tp_data *data;
 	unsigned long irqflags;
 	int error;
+	int irq;
+
+	irq = client->irq;
 
 	if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
 	    i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -1041,6 +1045,11 @@ static int elan_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
+	if (irq <= 0) {
+		dev_err(dev, "no IRQ provided.\n");
+		return -ENODEV;
+	}
+
 	data = devm_kzalloc(&client->dev, sizeof(struct elan_tp_data),
 			    GFP_KERNEL);
 	if (!data)
@@ -1049,6 +1058,7 @@ static int elan_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 
 	data->ops = transport_ops;
+	data->irq = irq;
 	data->client = client;
 	init_completion(&data->fw_completion);
 	mutex_init(&data->sysfs_mutex);
@@ -1121,12 +1131,12 @@ static int elan_probe(struct i2c_client *client,
 	 */
 	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
+	error = devm_request_threaded_irq(&client->dev, data->irq,
 					  NULL, elan_isr,
 					  irqflags | IRQF_ONESHOT,
 					  client->name, data);
 	if (error) {
-		dev_err(&client->dev, "cannot register irq=%d\n", client->irq);
+		dev_err(&client->dev, "cannot register irq=%d\n", data->irq);
 		return error;
 	}
 
@@ -1179,12 +1189,12 @@ static int __maybe_unused elan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	disable_irq(client->irq);
+	disable_irq(data->irq);
 
 	if (device_may_wakeup(dev)) {
 		ret = elan_sleep(data);
 		/* Enable wake from IRQ */
-		data->irq_wake = (enable_irq_wake(client->irq) == 0);
+		data->irq_wake = (enable_irq_wake(data->irq) == 0);
 	} else {
 		ret = elan_disable_power(data);
 	}
@@ -1200,7 +1210,7 @@ static int __maybe_unused elan_resume(struct device *dev)
 	int error;
 
 	if (device_may_wakeup(dev) && data->irq_wake) {
-		disable_irq_wake(client->irq);
+		disable_irq_wake(data->irq);
 		data->irq_wake = false;
 	}
 
@@ -1215,7 +1225,7 @@ static int __maybe_unused elan_resume(struct device *dev)
 		dev_err(dev, "initialize when resuming failed: %d\n", error);
 
 err:
-	enable_irq(data->client->irq);
+	enable_irq(data->irq);
 	return error;
 }
 
-- 
2.7.4
