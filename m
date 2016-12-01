From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] HID: i2c-hid: support Wacom digitizer + regulator
Date: Wed, 30 Nov 2016 17:21:28 -0800
Message-ID: <1480555288-142791-2-git-send-email-briannorris@chromium.org>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-input@vger.kernel.org

We need to power on the digitizer before using it, and it's also nice to
save power in suspend by disabling it. Support an optional "vdd-supply"
and wire it up for the new Wacom device.

Wacom recommended waiting up to 100ms after powering on before trying to
access this device.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
---
v1 was a few months back. I finally got around to rewriting it based on
DT binding feedback.

v2:
 * support compatible property for wacom, with specific "vdd-supply" name
 * support the 100ms delay needed for this digitizer
 * target regulator support only at specific device

 Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
 drivers/hid/i2c-hid/i2c-hid.c | 70 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/i2c-hid.h   |  6 ++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2de875..1bc174f3a788 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -37,7 +37,9 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -918,10 +920,25 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
 #endif
 
 #ifdef CONFIG_OF
+
+/* of_device_id match data */
+struct i2c_hid_of_data {
+	/* Name of supply regulator. */
+	const char *supply_name;
+	/* Delay required after powering on device before it is usable. */
+	int init_delay_ms;
+};
+
+static const struct i2c_hid_of_data wacom_w9013_data = {
+	.supply_name		= "vdd",
+	.init_delay_ms		= 100,
+};
+
 static int i2c_hid_of_probe(struct i2c_client *client,
 		struct i2c_hid_platform_data *pdata)
 {
 	struct device *dev = &client->dev;
+	const struct i2c_hid_of_data *data = of_device_get_match_data(dev);
 	u32 val;
 	int ret;
 
@@ -937,10 +954,33 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	}
 	pdata->hid_descriptor_address = val;
 
+	if (data) {
+		pdata->init_delay_ms = data->init_delay_ms;
+		if (data->supply_name) {
+			pdata->supply = devm_regulator_get_optional(&client->dev,
+								    data->supply_name);
+			if (IS_ERR(pdata->supply)) {
+				ret = PTR_ERR(pdata->supply);
+				pdata->supply = NULL;
+				if (ret == -EPROBE_DEFER)
+					return ret;
+				if (ret == -ENODEV)
+					return 0;
+				dev_err(dev, "Failed to get %s regulator: %d\n",
+					data->supply_name, ret);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
 static const struct of_device_id i2c_hid_of_match[] = {
+	{
+		.compatible = "wacom,w9013",
+		.data = &wacom_w9013_data,
+	},
 	{ .compatible = "hid-over-i2c" },
 	{},
 };
@@ -983,6 +1023,17 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
+	if (ihid->pdata.supply) {
+		ret = regulator_enable(ihid->pdata.supply);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to enable regulator: %d\n",
+				ret);
+			return ret;
+		}
+		if (ihid->pdata.init_delay_ms)
+			msleep(ihid->pdata.init_delay_ms);
+	}
+
 	if (client->irq > 0) {
 		ihid->irq = client->irq;
 	} else if (ACPI_COMPANION(&client->dev)) {
@@ -1100,6 +1151,9 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->desc)
 		gpiod_put(ihid->desc);
 
+	if (ihid->pdata.supply)
+		regulator_disable(ihid->pdata.supply);
+
 	kfree(ihid);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
@@ -1152,6 +1206,11 @@ static int i2c_hid_suspend(struct device *dev)
 		else
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
+	} else if (ihid->pdata.supply) {
+		ret = regulator_disable(ihid->pdata.supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to disable supply: %d\n",
+				 ret);
 	}
 
 	return 0;
@@ -1165,7 +1224,16 @@ static int i2c_hid_resume(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int wake_status;
 
-	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
+	if (!device_may_wakeup(&client->dev)) {
+		if (ihid->pdata.supply) {
+			ret = regulator_enable(ihid->pdata.supply);
+			if (ret < 0)
+				hid_warn(hid, "Failed to enable supply: %d\n",
+					 ret);
+			if (ihid->pdata.init_delay_ms)
+				msleep(ihid->pdata.init_delay_ms);
+		}
+	} else if (ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(ihid->irq);
 		if (!wake_status)
 			ihid->irq_wake_enabled = false;
diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/i2c/i2c-hid.h
index 7aa901d92058..97688cde4a91 100644
--- a/include/linux/i2c/i2c-hid.h
+++ b/include/linux/i2c/i2c-hid.h
@@ -14,9 +14,13 @@
 
 #include <linux/types.h>
 
+struct regulator;
+
 /**
  * struct i2chid_platform_data - used by hid over i2c implementation.
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
+ * @supply: regulator for powering on the device.
+ * @init_delay_ms: delay after powering on before device is usable.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
  * driver, or the flattened device tree) to setup the irq related to the gpio in
@@ -31,6 +35,8 @@
  */
 struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
+	struct regulator *supply;
+	int init_delay_ms;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
2.8.0.rc3.226.g39d4020
