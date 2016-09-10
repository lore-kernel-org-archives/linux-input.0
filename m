From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v12 2/5] Input: goodix - add support for ESD
Date: Sat, 10 Sep 2016 20:57:34 +0300
Message-ID: <1473530257-7495-3-git-send-email-irina.tirdea@intel.com>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
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

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/touchscreen/goodix.txt          |   4 +
 drivers/input/touchscreen/goodix.c                 | 130 ++++++++++++++++++++-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c98757a..ef5f42d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -18,6 +18,10 @@ Optional properties:
  - irq-gpios		: GPIO pin used for IRQ. The driver uses the
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
+ - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
+                            check if ESD occurred and in that case reset the
+                            device. ESD is disabled if this property is not set
+                            or is set to 0.
 
  - touchscreen-inverted-x  : X axis is inverted (boolean)
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 2447b73..cf39dc4 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -49,10 +49,13 @@ struct goodix_ts_data {
 	const char *cfg_name;
 	struct completion firmware_loading_complete;
 	unsigned long irq_flags;
+	atomic_t esd_timeout;
+	struct delayed_work esd_work;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
 #define GOODIX_GPIO_RST_NAME		"reset"
+#define GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY     "esd-recovery-timeout-ms"
 
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
@@ -67,6 +70,8 @@ struct goodix_ts_data {
 /* Register defines */
 #define GOODIX_REG_COMMAND		0x8040
 #define GOODIX_CMD_SCREEN_OFF		0x05
+#define GOODIX_CMD_ESD_ENABLED		0xAA
+#define GOODIX_REG_ESD_CHECK		0x8041
 
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
@@ -453,10 +458,114 @@ static ssize_t goodix_dump_config_show(struct device *dev,
 	return count;
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
+	wait_for_completion(&ts->firmware_loading_complete);
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
 static DEVICE_ATTR(dump_config, S_IRUGO, goodix_dump_config_show, NULL);
+/* ESD timeout in ms. Default disabled (0). Recommended 2000 ms. */
+static DEVICE_ATTR(esd_timeout, S_IRUGO | S_IWUSR, goodix_esd_timeout_show,
+		   goodix_esd_timeout_store);
 
 static struct attribute *goodix_attrs[] = {
 	&dev_attr_dump_config.attr,
+	&dev_attr_esd_timeout.attr,
 	NULL
 };
 
@@ -713,7 +822,11 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 			goto err_release_cfg;
 	}
 
-	goodix_configure_dev(ts);
+	error = goodix_configure_dev(ts);
+	if (error)
+		goto err_release_cfg;
+
+	goodix_enable_esd(ts);
 
 err_release_cfg:
 	release_firmware(cfg);
@@ -724,7 +837,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	int error;
+	int error, esd_timeout;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -740,6 +853,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	i2c_set_clientdata(client, ts);
 	init_completion(&ts->firmware_loading_complete);
+	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
 
 	error = goodix_get_gpio_config(ts);
 	if (error)
@@ -769,6 +883,12 @@ static int goodix_ts_probe(struct i2c_client *client,
 	ts->cfg_len = goodix_get_cfg_len(ts->id);
 
 	if (ts->gpiod_int && ts->gpiod_rst) {
+		error = device_property_read_u32(&ts->client->dev,
+					GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY,
+					&esd_timeout);
+		if (!error)
+			atomic_set(&ts->esd_timeout, esd_timeout);
+
 		error = sysfs_create_group(&client->dev.kobj,
 					   &goodix_attr_group);
 		if (error) {
@@ -821,6 +941,7 @@ static int goodix_ts_remove(struct i2c_client *client)
 	wait_for_completion(&ts->firmware_loading_complete);
 
 	sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
+	goodix_disable_esd(ts);
 
 	return 0;
 }
@@ -836,6 +957,7 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 		return 0;
 
 	wait_for_completion(&ts->firmware_loading_complete);
+	goodix_disable_esd(ts);
 
 	/* Free IRQ as IRQ pin is used as output in the suspend sequence */
 	goodix_free_irq(ts);
@@ -894,6 +1016,10 @@ static int __maybe_unused goodix_resume(struct device *dev)
 	if (error)
 		return error;
 
+	error = goodix_enable_esd(ts);
+	if (error)
+		return error;
+
 	return 0;
 }
 
-- 
1.9.1
