From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 7/9] Input: goodix - add support for ESD
Date: Mon,  7 Sep 2015 17:36:21 +0300
Message-ID: <1441636583-14188-8-git-send-email-irina.tirdea@intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441636583-14188-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add ESD (Electrostatic Discharge) protection mechanism.

The driver enables ESD protection in HW and checks a register
to determine if ESD occurred. If ESD is signalled by the HW,
the driver will reset the device.

The ESD poll time (in ms) can be set through the sysfs property
esd_timeout. If it is set to 0, ESD protection is disabled.
Recommended value is 2000 ms. The initial value for ESD timeout
can be set through esd-recovery-timeout-ms ACPI/DT property.
If there is no such property defined, ESD protection is disabled.
For ACPI 5.1, the property can be specified using _DSD properties:
 Device (STAC)
 {
     Name (_HID, "GDIX1001")
     ...

     Name (_DSD,  Package ()
     {
         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
         Package ()
         {
             Package (2) { "esd-recovery-timeout-ms", Package(1) { 2000 }},
             ...
         }
     })
 }

The ESD protection mechanism is only available if the gpio pins
are properly initialized from ACPI/DT.

This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
driver gt9xx.c for Android (publicly available in Android kernel
trees for various devices).

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../bindings/input/touchscreen/goodix.txt          |   6 +
 drivers/input/touchscreen/goodix.c                 | 174 ++++++++++++++++++++-
 2 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c0715f8..5891ad1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -14,6 +14,12 @@ Required properties:
  - interrupts		: Interrupt to which the chip is connected
  - gpios		: GPIOS the chip is connected to: first one is the
 			  interrupt gpio and second one the reset gpio.
+Optional properties:
+
+ - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
+                            check if ESD occurred and in that case reset the
+                            device. ESD is disabled if this property is not set
+                            or is set to 0.
 
 Example:
 
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 03f3968..33a7b81 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -45,8 +45,12 @@ struct goodix_ts_data {
 	u16 version;
 	char *cfg_name;
 	unsigned long irq_flags;
+	atomic_t esd_timeout;
+	struct delayed_work esd_work;
 };
 
+#define GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY     "esd-recovery-timeout-ms"
+
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
@@ -60,6 +64,8 @@ struct goodix_ts_data {
 /* Register defines */
 #define GOODIX_REG_COMMAND		0x8040
 #define GOODIX_CMD_SCREEN_OFF		0x05
+#define GOODIX_CMD_ESD_ENABLED		0xAA
+#define GOODIX_REG_ESD_CHECK		0x8041
 
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
@@ -426,6 +432,117 @@ static int goodix_reset(struct goodix_ts_data *ts)
 	return goodix_int_sync(ts);
 }
 
+static void goodix_disable_esd(struct goodix_ts_data *ts)
+{
+	if (!atomic_read(&ts->esd_timeout))
+		return;
+	cancel_delayed_work_sync(&ts->esd_work);
+}
+
+static int goodix_enable_esd(struct goodix_ts_data *ts)
+{
+	int error, esd_timeout;
+
+	esd_timeout = atomic_read(&ts->esd_timeout);
+	if (!esd_timeout)
+		return 0;
+
+	error = goodix_i2c_write_u8(ts->client, GOODIX_REG_ESD_CHECK,
+				    GOODIX_CMD_ESD_ENABLED);
+	if (error) {
+		dev_err(&ts->client->dev, "Failed to enable ESD: %d\n", error);
+		return error;
+	}
+
+	schedule_delayed_work(&ts->esd_work, round_jiffies_relative(
+			      msecs_to_jiffies(esd_timeout)));
+	return 0;
+}
+
+static void goodix_esd_work(struct work_struct *work)
+{
+	struct goodix_ts_data *ts = container_of(work, struct goodix_ts_data,
+						 esd_work.work);
+	int retries = 3, error;
+	u8 esd_data[2];
+	const struct firmware *cfg = NULL;
+
+	while (--retries) {
+		error = goodix_i2c_read(ts->client, GOODIX_REG_COMMAND,
+					esd_data, sizeof(esd_data));
+		if (error)
+			continue;
+		if (esd_data[0] != GOODIX_CMD_ESD_ENABLED &&
+		    esd_data[1] == GOODIX_CMD_ESD_ENABLED) {
+			/* feed the watchdog */
+			goodix_i2c_write_u8(ts->client,
+					    GOODIX_REG_COMMAND,
+					    GOODIX_CMD_ESD_ENABLED);
+			break;
+		}
+	}
+
+	if (!retries) {
+		dev_dbg(&ts->client->dev, "Performing ESD recovery.\n");
+		goodix_free_irq(ts);
+		goodix_reset(ts);
+		error = request_firmware(&cfg, ts->cfg_name, &ts->client->dev);
+		if (!error) {
+			goodix_send_cfg(ts, cfg);
+			release_firmware(cfg);
+		}
+		goodix_request_irq(ts);
+		goodix_enable_esd(ts);
+		return;
+	}
+
+	schedule_delayed_work(&ts->esd_work, round_jiffies_relative(
+			      msecs_to_jiffies(atomic_read(&ts->esd_timeout))));
+}
+
+static ssize_t goodix_esd_timeout_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct goodix_ts_data *ts = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&ts->esd_timeout));
+}
+
+static ssize_t goodix_esd_timeout_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct goodix_ts_data *ts = dev_get_drvdata(dev);
+	int error, esd_timeout, new_esd_timeout;
+
+	error = kstrtouint(buf, 10, &new_esd_timeout);
+	if (error)
+		return error;
+
+	esd_timeout = atomic_read(&ts->esd_timeout);
+	if (esd_timeout && !new_esd_timeout)
+		goodix_disable_esd(ts);
+
+	atomic_set(&ts->esd_timeout, new_esd_timeout);
+	if (!esd_timeout && new_esd_timeout)
+		goodix_enable_esd(ts);
+
+	return count;
+}
+
+/* ESD timeout in ms. Default disabled (0). Recommended 2000 ms. */
+static DEVICE_ATTR(esd_timeout, S_IRUGO | S_IWUSR, goodix_esd_timeout_show,
+		   goodix_esd_timeout_store);
+
+static struct attribute *goodix_attrs[] = {
+	&dev_attr_esd_timeout.attr,
+	NULL
+};
+
+static const struct attribute_group goodix_attr_group = {
+	.attrs = goodix_attrs,
+};
+
 /**
  * goodix_get_gpio_config - Get GPIO config from ACPI/DT
  *
@@ -647,6 +764,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 		return error;
 	}
 
+	goodix_enable_esd(ts);
+
 	return 0;
 }
 
@@ -672,7 +791,6 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	goodix_configure_dev(ts);
 
 err_release_cfg:
-	kfree(ts->cfg_name);
 	release_firmware(cfg);
 }
 
@@ -680,7 +798,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	int error;
+	int error, esd_timeout;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -695,6 +813,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
+	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
 
 	error = goodix_i2c_test(client);
 	if (error) {
@@ -722,11 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
 			return error;
 		}
 
+		error = device_property_read_u32(&ts->client->dev,
+					GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY,
+					&esd_timeout);
+		if (!error)
+			atomic_set(&ts->esd_timeout, esd_timeout);
+
+		error = sysfs_create_group(&client->dev.kobj,
+					   &goodix_attr_group);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to create sysfs group: %d\n",
+				error);
+			return error;
+		}
+
 		/* update device config */
 		ts->cfg_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin",
 					 ts->id);
-		if (!ts->cfg_name)
-			return -ENOMEM;
+		if (!ts->cfg_name) {
+			error = -ENOMEM;
+			goto err_sysfs_remove_group;
+		}
 
 		error = request_firmware_nowait(THIS_MODULE, true, ts->cfg_name,
 						&client->dev, GFP_KERNEL, ts,
@@ -735,14 +871,32 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			kfree(ts->cfg_name);
-			return error;
+			goto err_free_cfg_name;
 		}
 
 		return 0;
 	}
 
 	return goodix_configure_dev(ts);
+
+err_free_cfg_name:
+	if (ts->gpiod_int && ts->gpiod_rst)
+		kfree(ts->cfg_name);
+err_sysfs_remove_group:
+	if (ts->gpiod_int && ts->gpiod_rst)
+		sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
+	return error;
+}
+
+static int goodix_ts_remove(struct i2c_client *client)
+{
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+
+	if (ts->gpiod_int && ts->gpiod_rst)
+		sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
+	goodix_disable_esd(ts);
+	kfree(ts->cfg_name);
+	return 0;
 }
 
 static int __maybe_unused goodix_suspend(struct device *dev)
@@ -755,6 +909,7 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 	if (!ts->gpiod_int || !ts->gpiod_rst)
 		return 0;
 
+	goodix_disable_esd(ts);
 	/* Free IRQ as IRQ pin is used as output in the suspend sequence */
 	goodix_free_irq(ts);
 	/* Output LOW on the INT pin for 5 ms */
@@ -805,7 +960,11 @@ static int __maybe_unused goodix_resume(struct device *dev)
 	if (error)
 		return error;
 
-	return goodix_request_irq(ts);
+	error = goodix_request_irq(ts);
+	if (error)
+		return error;
+
+	return goodix_enable_esd(ts);
 }
 
 static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
@@ -839,6 +998,7 @@ MODULE_DEVICE_TABLE(of, goodix_of_match);
 
 static struct i2c_driver goodix_ts_driver = {
 	.probe = goodix_ts_probe,
+	.remove = goodix_ts_remove,
 	.id_table = goodix_ts_id,
 	.driver = {
 		.name = "Goodix-TS",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
