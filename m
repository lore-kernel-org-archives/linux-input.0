From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v5 9/9] Input: goodix - add runtime power management support
Date: Mon,  7 Sep 2015 17:36:23 +0300
Message-ID: <1441636583-14188-10-git-send-email-irina.tirdea@intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48488 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbbIGOiG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Sep 2015 10:38:06 -0400
In-Reply-To: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

Add support for runtime power management so that the device is
turned off when not used (when the userspace holds no open
handles of the input device). The device uses autosuspend with a
default delay of 2 seconds, so the device will suspend if no
handles to it are open for 2 seconds.

The runtime management support is only available if the gpio pins
are properly initialized from ACPI/DT.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 57 +++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3179767..34c0183 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
@@ -75,6 +76,8 @@ struct goodix_ts_data {
 #define MAX_CONTACTS_LOC	5
 #define TRIGGER_LOC		6
 
+#define GOODIX_AUTOSUSPEND_DELAY_MS	2000
+
 static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_EDGE_RISING,
 	IRQ_TYPE_EDGE_FALLING,
@@ -566,6 +569,27 @@ static const struct attribute_group goodix_attr_group = {
 	.attrs = goodix_attrs,
 };
 
+static int goodix_open(struct input_dev *input_dev)
+{
+	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
+	int error;
+
+	error = pm_runtime_get_sync(&ts->client->dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(&ts->client->dev);
+		return error;
+	}
+	return 0;
+}
+
+static void goodix_close(struct input_dev *input_dev)
+{
+	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
+
+	pm_runtime_mark_last_busy(&ts->client->dev);
+	pm_runtime_put_autosuspend(&ts->client->dev);
+}
+
 /**
  * goodix_get_gpio_config - Get GPIO config from ACPI/DT
  *
@@ -751,6 +775,9 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	ts->input_dev->id.vendor = 0x0416;
 	ts->input_dev->id.product = ts->id;
 	ts->input_dev->id.version = ts->version;
+	ts->input_dev->open = goodix_open;
+	ts->input_dev->close = goodix_close;
+	input_set_drvdata(ts->input_dev, ts);
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
@@ -798,7 +825,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
  * @ts: our goodix_ts_data pointer
  *
  * request_firmware_wait callback that finishes
- * initialization of the device.
+ * initialization of the device. This will only be called
+ * when ts->gpiod_int and ts->gpiod_rst are properly initialized.
  */
 static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 {
@@ -811,7 +839,21 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 		if (error)
 			goto err_release_cfg;
 	}
-	goodix_configure_dev(ts);
+	error = goodix_configure_dev(ts);
+	if (error)
+		goto err_release_cfg;
+
+	error = pm_runtime_set_active(&ts->client->dev);
+	if (error) {
+		dev_err(&ts->client->dev, "failed to set active: %d\n", error);
+		goto err_release_cfg;
+	}
+	/* input_dev is a child of client->dev, ignore it for runtime pm */
+	pm_suspend_ignore_children(&ts->client->dev, true);
+	pm_runtime_enable(&ts->client->dev);
+	pm_runtime_set_autosuspend_delay(&ts->client->dev,
+					 GOODIX_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&ts->client->dev);
 
 err_release_cfg:
 	release_firmware(cfg);
@@ -915,8 +957,12 @@ static int goodix_ts_remove(struct i2c_client *client)
 {
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 
-	if (ts->gpiod_int && ts->gpiod_rst)
+	if (ts->gpiod_int && ts->gpiod_rst) {
+		pm_runtime_disable(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+		pm_runtime_put_noidle(&client->dev);
 		sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
+	}
 	goodix_disable_esd(ts);
 	kfree(ts->cfg_name);
 	return 0;
@@ -990,7 +1036,10 @@ static int __maybe_unused goodix_resume(struct device *dev)
 	return goodix_enable_esd(ts);
 }
 
-static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
+static const struct dev_pm_ops goodix_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(goodix_suspend, goodix_resume)
+	SET_RUNTIME_PM_OPS(goodix_suspend, goodix_resume, NULL)
+};
 
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", 0 },
-- 
1.9.1

