From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2] HID: i2c-hid: Add vddl regulator control
Date: Thu, 21 Jun 2018 16:41:38 -0700
Message-ID: <20180621234138.30537-1-swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some wacom w9013 devices have a vddl supply for "low valtage"
requirements. Add support in this driver to turn on this low voltage
supply. We can also drop a handful of error messages because the
regulator core is already printing an error when bulk regulators fail to
enable or disable.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Use the bulk regulator APIs instead of open coding it (Dmitry)

 .../bindings/input/hid-over-i2c.txt           |  3 +-
 drivers/hid/i2c-hid/i2c-hid.c                 | 62 +++++++++----------
 include/linux/platform_data/i2c-hid.h         |  7 +--
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 4d3da9d91de4..89e6ab89ba38 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -26,7 +26,8 @@ device-specific compatible properties, which should be used in addition to the
 
 - compatible:
   * "wacom,w9013" (Wacom W9013 digitizer). Supports:
-    - vdd-supply
+    - vdd-supply (3.3V)
+    - vddl-supply (1.8V)
     - post-power-on-delay-ms
 
 - vdd-supply: phandle of the regulator that provides the supply voltage.
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c1652bb7bd15..1d83531454c5 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1002,18 +1002,21 @@ static int i2c_hid_probe(struct i2c_client *client,
 		return client->irq;
 	}
 
-	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
+	ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
 
 	if (client->dev.of_node) {
 		ret = i2c_hid_of_probe(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else if (!platform_data) {
 		ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
-		if (ret)
-			goto err;
+		if (ret) {
+			dev_err(&client->dev,
+				"HID register address not provided\n");
+			return ret;
+		}
 	} else {
 		ihid->pdata = *platform_data;
 	}
@@ -1021,21 +1024,20 @@ static int i2c_hid_probe(struct i2c_client *client,
 	/* Parse platform agnostic common properties from ACPI / device tree */
 	i2c_hid_fwnode_probe(client, &ihid->pdata);
 
-	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(ihid->pdata.supply)) {
-		ret = PTR_ERR(ihid->pdata.supply);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "Failed to get regulator: %d\n",
-				ret);
-		goto err;
-	}
+	ihid->pdata.supplies[0].supply = "vdd";
+	ihid->pdata.supplies[1].supply = "vddl";
+
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(ihid->pdata.supplies),
+				      ihid->pdata.supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ihid->pdata.supplies),
+				    ihid->pdata.supplies);
+	if (ret < 0)
+		return ret;
 
-	ret = regulator_enable(ihid->pdata.supply);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to enable regulator: %d\n",
-			ret);
-		goto err;
-	}
 	if (ihid->pdata.post_power_delay_ms)
 		msleep(ihid->pdata.post_power_delay_ms);
 
@@ -1122,11 +1124,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_disable(&client->dev);
 
 err_regulator:
-	regulator_disable(ihid->pdata.supply);
-
-err:
+	regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+			       ihid->pdata.supplies);
 	i2c_hid_free_buffers(ihid);
-	kfree(ihid);
 	return ret;
 }
 
@@ -1148,9 +1148,8 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
-	regulator_disable(ihid->pdata.supply);
-
-	kfree(ihid);
+	regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+			       ihid->pdata.supplies);
 
 	return 0;
 }
@@ -1201,9 +1200,8 @@ static int i2c_hid_suspend(struct device *dev)
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
 	} else {
-		ret = regulator_disable(ihid->pdata.supply);
-		if (ret < 0)
-			hid_warn(hid, "Failed to disable supply: %d\n", ret);
+		regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+				       ihid->pdata.supplies);
 	}
 
 	return 0;
@@ -1218,9 +1216,11 @@ static int i2c_hid_resume(struct device *dev)
 	int wake_status;
 
 	if (!device_may_wakeup(&client->dev)) {
-		ret = regulator_enable(ihid->pdata.supply);
-		if (ret < 0)
-			hid_warn(hid, "Failed to enable supply: %d\n", ret);
+		ret = regulator_bulk_enable(ARRAY_SIZE(ihid->pdata.supplies),
+					    ihid->pdata.supplies);
+		if (ret)
+			hid_warn(hid, "Failed to enable supplies: %d\n", ret);
+
 		if (ihid->pdata.post_power_delay_ms)
 			msleep(ihid->pdata.post_power_delay_ms);
 	} else if (ihid->irq_wake_enabled) {
diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
index 1fb088239d12..c628bb5e1061 100644
--- a/include/linux/platform_data/i2c-hid.h
+++ b/include/linux/platform_data/i2c-hid.h
@@ -12,14 +12,13 @@
 #ifndef __LINUX_I2C_HID_H
 #define __LINUX_I2C_HID_H
 
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
-struct regulator;
-
 /**
  * struct i2chid_platform_data - used by hid over i2c implementation.
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
- * @supply: regulator for powering on the device.
+ * @supplies: regulators for powering on the device.
  * @post_power_delay_ms: delay after powering on before device is usable.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
@@ -35,7 +34,7 @@ struct regulator;
  */
 struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
-	struct regulator *supply;
+	struct regulator_bulk_data supplies[2];
 	int post_power_delay_ms;
 };
 
-- 
Sent by a computer through tubes
