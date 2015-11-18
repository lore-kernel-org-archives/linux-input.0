From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v10 8/8] Input: goodix - add runtime power management support
Date: Wed, 18 Nov 2015 18:31:41 +0200
Message-ID: <1447864301-1261-9-git-send-email-irina.tirdea@intel.com>
References: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Add support for runtime power management so that the device is
turned off when not used (when the userspace holds no open
handles of the input device). The device uses autosuspend with a
default delay of 2 seconds, so the device will suspend if no
handles to it are open for 2 seconds.

The runtime management support is only available if the gpio pins
are properly initialized from ACPI/DT.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 159 +++++++++++++++++++++++++++++++++----
 1 file changed, 145 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index ea5042f..a793b8c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
@@ -48,6 +49,10 @@ struct goodix_ts_data {
 	unsigned long irq_flags;
 	atomic_t esd_timeout;
 	struct delayed_work esd_work;
+	bool suspended;
+	atomic_t open_count;
+	/* Protects power management calls and access to suspended flag */
+	struct mutex mutex;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
@@ -78,6 +83,8 @@ struct goodix_ts_data {
 #define MAX_CONTACTS_LOC	5
 #define TRIGGER_LOC		6
 
+#define GOODIX_AUTOSUSPEND_DELAY_MS	2000
+
 static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_EDGE_RISING,
 	IRQ_TYPE_EDGE_FALLING,
@@ -193,6 +200,29 @@ static int goodix_get_cfg_len(u16 id)
 	}
 }
 
+static int goodix_set_power_state(struct goodix_ts_data *ts, bool on)
+{
+	int error;
+
+	if (on) {
+		error = pm_runtime_get_sync(&ts->client->dev);
+	} else {
+		pm_runtime_mark_last_busy(&ts->client->dev);
+		error = pm_runtime_put_autosuspend(&ts->client->dev);
+	}
+
+	if (error < 0) {
+		dev_err(&ts->client->dev,
+			"failed to change power state to %d\n", on);
+		if (on)
+			pm_runtime_put_noidle(&ts->client->dev);
+
+		return error;
+	}
+
+	return 0;
+}
+
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -501,11 +531,13 @@ static ssize_t goodix_esd_timeout_store(struct device *dev,
 		return error;
 
 	esd_timeout = atomic_read(&ts->esd_timeout);
-	if (esd_timeout && !new_esd_timeout)
+	if (esd_timeout && !new_esd_timeout &&
+	    pm_runtime_active(&ts->client->dev))
 		goodix_disable_esd(ts);
 
 	atomic_set(&ts->esd_timeout, new_esd_timeout);
-	if (!esd_timeout && new_esd_timeout)
+	if (!esd_timeout && new_esd_timeout &&
+	    pm_runtime_active(&ts->client->dev))
 		goodix_enable_esd(ts);
 
 	return count;
@@ -518,17 +550,23 @@ static ssize_t goodix_dump_config_show(struct device *dev,
 	u8 config[GOODIX_CONFIG_MAX_LENGTH];
 	int error, count = 0, i;
 
+	error = goodix_set_power_state(ts, true);
+	if (error)
+		return error;
 	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
 				config, ts->cfg_len);
 	if (error) {
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d)\n",  error);
+		goodix_set_power_state(ts, false);
 		return error;
 	}
+	goodix_set_power_state(ts, false);
 
 	for (i = 0; i < ts->cfg_len; i++)
 		count += scnprintf(buf + count, PAGE_SIZE - count, "%02x ",
 				   config[i]);
+
 	return count;
 }
 
@@ -547,6 +585,34 @@ static const struct attribute_group goodix_attr_group = {
 	.attrs = goodix_attrs,
 };
 
+static int goodix_open(struct input_dev *input_dev)
+{
+	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
+	int error;
+
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return 0;
+
+	wait_for_completion(&ts->firmware_loading_complete);
+
+	error = goodix_set_power_state(ts, true);
+	if (error)
+		return error;
+	atomic_inc(&ts->open_count);
+	return 0;
+}
+
+static void goodix_close(struct input_dev *input_dev)
+{
+	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
+
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return;
+
+	goodix_set_power_state(ts, false);
+	atomic_dec(&ts->open_count);
+}
+
 /**
  * goodix_get_gpio_config - Get GPIO config from ACPI/DT
  *
@@ -718,6 +784,9 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	ts->input_dev->id.vendor = 0x0416;
 	ts->input_dev->id.product = ts->id;
 	ts->input_dev->id.version = ts->version;
+	ts->input_dev->open = goodix_open;
+	ts->input_dev->close = goodix_close;
+	input_set_drvdata(ts->input_dev, ts);
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
@@ -765,7 +834,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
  * @ts: our goodix_ts_data pointer
  *
  * request_firmware_wait callback that finishes
- * initialization of the device.
+ * initialization of the device. This will only be called
+ * when ts->gpiod_int and ts->gpiod_rst are properly initialized.
  */
 static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 {
@@ -784,6 +854,19 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 
 	goodix_enable_esd(ts);
 
+	pm_runtime_set_autosuspend_delay(&ts->client->dev,
+					 GOODIX_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&ts->client->dev);
+	error = pm_runtime_set_active(&ts->client->dev);
+	if (error) {
+		dev_err(&ts->client->dev, "failed to set active: %d\n", error);
+		goto err_release_cfg;
+	}
+	pm_runtime_enable(&ts->client->dev);
+	/* Must not suspend immediately after device initialization */
+	pm_runtime_mark_last_busy(&ts->client->dev);
+	pm_request_autosuspend(&ts->client->dev);
+
 err_release_cfg:
 	release_firmware(cfg);
 	complete_all(&ts->firmware_loading_complete);
@@ -810,6 +893,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ts);
 	init_completion(&ts->firmware_loading_complete);
 	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
+	mutex_init(&ts->mutex);
 
 	error = goodix_get_gpio_config(ts);
 	if (error)
@@ -894,6 +978,11 @@ static int goodix_ts_remove(struct i2c_client *client)
 		return 0;
 
 	wait_for_completion(&ts->firmware_loading_complete);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
 	sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
 	goodix_disable_esd(ts);
 	kfree(ts->cfg_name);
@@ -901,11 +990,11 @@ static int goodix_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused goodix_suspend(struct device *dev)
+static int __maybe_unused goodix_sleep(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
-	int error;
+	int error = 0;
 
 	/* We need gpio pins to suspend/resume */
 	if (!ts->gpiod_int || !ts->gpiod_rst)
@@ -913,6 +1002,11 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 
 	wait_for_completion(&ts->firmware_loading_complete);
 
+	mutex_lock(&ts->mutex);
+
+	if (ts->suspended)
+		goto out_error;
+
 	goodix_disable_esd(ts);
 	/* Free IRQ as IRQ pin is used as output in the suspend sequence */
 	goodix_free_irq(ts);
@@ -920,7 +1014,7 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 	error = gpiod_direction_output(ts->gpiod_int, 0);
 	if (error) {
 		goodix_request_irq(ts);
-		return error;
+		goto out_error;
 	}
 	usleep_range(5000, 6000);
 
@@ -930,7 +1024,8 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 		dev_err(&ts->client->dev, "Screen off command failed\n");
 		gpiod_direction_input(ts->gpiod_int);
 		goodix_request_irq(ts);
-		return -EAGAIN;
+		error = -EAGAIN;
+		goto out_error;
 	}
 
 	/*
@@ -939,39 +1034,75 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 	 * sooner, delay 58ms here.
 	 */
 	msleep(58);
+	ts->suspended = true;
+	mutex_unlock(&ts->mutex);
 	return 0;
+
+out_error:
+	mutex_unlock(&ts->mutex);
+	return error;
 }
 
-static int __maybe_unused goodix_resume(struct device *dev)
+static int __maybe_unused goodix_wakeup(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
-	int error;
+	int error = 0;
 
 	if (!ts->gpiod_int || !ts->gpiod_rst)
 		return 0;
 
+	mutex_lock(&ts->mutex);
+
+	if (!ts->suspended)
+		goto out_error;
+
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
 	 * for 2ms~5ms.
 	 */
 	error = gpiod_direction_output(ts->gpiod_int, 1);
 	if (error)
-		return error;
+		goto out_error;
 	usleep_range(2000, 5000);
 
 	error = goodix_int_sync(ts);
 	if (error)
-		return error;
+		goto out_error;
 
 	error = goodix_request_irq(ts);
 	if (error)
-		return error;
+		goto out_error;
+
+	error = goodix_enable_esd(ts);
+	if (error)
+		goto out_error;
+
+	ts->suspended = false;
+	mutex_unlock(&ts->mutex);
+
+	return 0;
+
+out_error:
+	mutex_unlock(&ts->mutex);
+	return error;
+}
 
-	return goodix_enable_esd(ts);
+static int __maybe_unused goodix_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+
+	if (!atomic_read(&ts->open_count))
+		return 0;
+
+	return goodix_wakeup(dev);
 }
 
-static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
+static const struct dev_pm_ops goodix_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(goodix_sleep, goodix_resume)
+	SET_RUNTIME_PM_OPS(goodix_sleep, goodix_wakeup, NULL)
+};
 
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", 0 },
-- 
1.9.1
