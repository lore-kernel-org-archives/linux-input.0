From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] Input: elan_i2c - add Host Notify support
Date: Wed, 28 Sep 2016 16:34:03 +0200
Message-ID: <1475073244-23068-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Thinkpad series 13 uses Host Notify to report the interrupt.
Add elan_smb_alert() to handle those interrupts and disable the irq
handling on this case.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_core.c | 100 ++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 22 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2de1f75..11671c7 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -96,6 +96,34 @@ struct elan_tp_data {
 	bool			baseline_ready;
 };
 
+static inline void elan_enable_irq(struct elan_tp_data *tp)
+{
+	if (tp->client->irq)
+		enable_irq(tp->client->irq);
+}
+
+static inline void elan_disable_irq(struct elan_tp_data *tp)
+{
+	if (tp->client->irq)
+		disable_irq(tp->client->irq);
+}
+
+static inline int elan_enable_irq_wake(struct elan_tp_data *tp)
+{
+	if (tp->client->irq)
+		return enable_irq_wake(tp->client->irq);
+
+	return 0;
+}
+
+static inline int elan_disable_irq_wake(struct elan_tp_data *tp)
+{
+	if (tp->client->irq)
+		return disable_irq_wake(tp->client->irq);
+
+	return 0;
+}
+
 static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 			   u16 *signature_address)
 {
@@ -457,7 +485,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
 
 	dev_dbg(&client->dev, "Starting firmware update....\n");
 
-	disable_irq(client->irq);
+	elan_disable_irq(data);
 	data->in_fw_update = true;
 
 	retval = __elan_update_firmware(data, fw);
@@ -471,7 +499,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
 	}
 
 	data->in_fw_update = false;
-	enable_irq(client->irq);
+	elan_enable_irq(data);
 
 	return retval;
 }
@@ -599,7 +627,7 @@ static ssize_t calibrate_store(struct device *dev,
 	if (retval)
 		return retval;
 
-	disable_irq(client->irq);
+	elan_disable_irq(data);
 
 	data->mode |= ETP_ENABLE_CALIBRATE;
 	retval = data->ops->set_mode(client, data->mode);
@@ -645,7 +673,7 @@ out_disable_calibrate:
 			retval = error;
 	}
 out:
-	enable_irq(client->irq);
+	elan_enable_irq(data);
 	mutex_unlock(&data->sysfs_mutex);
 	return retval ?: count;
 }
@@ -711,7 +739,7 @@ static ssize_t acquire_store(struct device *dev, struct device_attribute *attr,
 	if (retval)
 		return retval;
 
-	disable_irq(client->irq);
+	elan_disable_irq(data);
 
 	data->baseline_ready = false;
 
@@ -753,7 +781,7 @@ out_disable_calibrate:
 			retval = error;
 	}
 out:
-	enable_irq(client->irq);
+	elan_enable_irq(data);
 	mutex_unlock(&data->sysfs_mutex);
 	return retval ?: count;
 }
@@ -943,6 +971,23 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void elan_smb_alert(struct i2c_client *client,
+			   enum i2c_alert_protocol type, unsigned int data)
+{
+	struct elan_tp_data *tp_data = i2c_get_clientdata(client);
+
+	if (type != I2C_PROTOCOL_SMBUS_HOST_NOTIFY)
+		return;
+
+	if (!tp_data) {
+		dev_err(&client->dev,
+			"Something went wrong, driver data is NULL.\n");
+		return;
+	}
+
+	elan_isr(0, tp_data);
+}
+
 /*
  ******************************************************************
  * Elan initialization functions
@@ -1036,6 +1081,13 @@ static int elan_probe(struct i2c_client *client,
 						I2C_FUNC_SMBUS_BLOCK_DATA |
 						I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		transport_ops = &elan_smbus_ops;
+
+		if (!client->irq &&
+		    !i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_HOST_NOTIFY)) {
+			dev_err(dev, "no Host Notify support\n");
+			return -ENODEV;
+		}
 	} else {
 		dev_err(dev, "not a supported I2C/SMBus adapter\n");
 		return -EIO;
@@ -1115,19 +1167,22 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	/*
-	 * Systems using device tree should set up interrupt via DTS,
-	 * the rest will use the default falling edge interrupts.
-	 */
-	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+	if (client->irq) {
+		/*
+		 * Systems using device tree should set up interrupt via DTS,
+		 * the rest will use the default falling edge interrupts.
+		 */
+		irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, elan_isr,
-					  irqflags | IRQF_ONESHOT,
-					  client->name, data);
-	if (error) {
-		dev_err(&client->dev, "cannot register irq=%d\n", client->irq);
-		return error;
+		error = devm_request_threaded_irq(&client->dev, client->irq,
+						  NULL, elan_isr,
+						  irqflags | IRQF_ONESHOT,
+						  client->name, data);
+		if (error) {
+			dev_err(&client->dev, "cannot register irq=%d\n",
+				client->irq);
+			return error;
+		}
 	}
 
 	error = sysfs_create_groups(&client->dev.kobj, elan_sysfs_groups);
@@ -1179,12 +1234,12 @@ static int __maybe_unused elan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	disable_irq(client->irq);
+	elan_disable_irq(data);
 
 	if (device_may_wakeup(dev)) {
 		ret = elan_sleep(data);
 		/* Enable wake from IRQ */
-		data->irq_wake = (enable_irq_wake(client->irq) == 0);
+		data->irq_wake = (elan_enable_irq_wake(data) == 0);
 	} else {
 		ret = elan_disable_power(data);
 	}
@@ -1200,7 +1255,7 @@ static int __maybe_unused elan_resume(struct device *dev)
 	int error;
 
 	if (device_may_wakeup(dev) && data->irq_wake) {
-		disable_irq_wake(client->irq);
+		elan_disable_irq_wake(data);
 		data->irq_wake = false;
 	}
 
@@ -1215,7 +1270,7 @@ static int __maybe_unused elan_resume(struct device *dev)
 		dev_err(dev, "initialize when resuming failed: %d\n", error);
 
 err:
-	enable_irq(data->client->irq);
+	elan_enable_irq(data);
 	return error;
 }
 
@@ -1256,6 +1311,7 @@ static struct i2c_driver elan_driver = {
 	},
 	.probe		= elan_probe,
 	.id_table	= elan_id,
+	.alert		= elan_smb_alert,
 };
 
 module_i2c_driver(elan_driver);
-- 
2.7.4
