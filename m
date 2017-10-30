From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH] HID: i2c-hid: add reset gpio property
Date: Mon, 30 Oct 2017 10:49:49 +0800
Message-ID: <1509331789-1949-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:50205 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdJ3CuD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 29 Oct 2017 22:50:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, jani.nikula@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, Lin Huang <hl@rock-chips.com>

some i2c hid devices have reset gpio, need to control
it in the driver.

Change-Id: I87bca954bffc7eb7b35711406f522cb3d0fc2ded
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/hid/i2c-hid/i2c-hid.c         | 63 +++++++++++++++++++++++++++--------
 include/linux/platform_data/i2c-hid.h |  4 +++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 9145c21..a0e3a8e 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -38,6 +38,7 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/platform_data/i2c-hid.h>
@@ -793,6 +794,34 @@ struct hid_ll_driver i2c_hid_ll_driver = {
 };
 EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
 
+static int i2c_hid_hw_power_on(struct i2c_hid *ihid)
+{
+	int ret;
+
+	ret = regulator_enable(ihid->pdata.supply);
+	if (ret < 0)
+		return ret;
+
+	if (ihid->pdata.post_power_delay_ms)
+		msleep(ihid->pdata.post_power_delay_ms);
+
+	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
+	usleep_range(ihid->pdata.assert_reset_us,
+		     ihid->pdata.assert_reset_us);
+	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 0);
+	usleep_range(ihid->pdata.deassert_reset_us,
+		     ihid->pdata.deassert_reset_us);
+
+	return ret;
+}
+
+static int i2c_hid_hw_power_off(struct i2c_hid *ihid)
+{
+	gpiod_set_value_cansleep(ihid->pdata.reset_gpio, 1);
+
+	return regulator_disable(ihid->pdata.supply);
+}
+
 static int i2c_hid_init_irq(struct i2c_client *client)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
@@ -934,6 +963,12 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	if (!ret)
 		pdata->post_power_delay_ms = val;
 
+	ret = of_property_read_u32(dev->of_node, "assert-reset-us",
+				   &pdata->assert_reset_us);
+
+	ret = of_property_read_u32(dev->of_node, "deassert-reset-us",
+				   &pdata->deassert_reset_us);
+
 	return 0;
 }
 
@@ -1002,14 +1037,16 @@ static int i2c_hid_probe(struct i2c_client *client,
 		goto err;
 	}
 
-	ret = regulator_enable(ihid->pdata.supply);
+	ihid->pdata.reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+							 GPIOD_OUT_HIGH);
+	if (IS_ERR(ihid->pdata.reset_gpio))
+		goto err;
+
+	ret = i2c_hid_hw_power_on(ihid);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to enable regulator: %d\n",
-			ret);
+		dev_err(&client->dev, "Failed to power on: %d\n", ret);
 		goto err;
 	}
-	if (ihid->pdata.post_power_delay_ms)
-		msleep(ihid->pdata.post_power_delay_ms);
 
 	i2c_set_clientdata(client, ihid);
 
@@ -1086,7 +1123,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_disable(&client->dev);
 
 err_regulator:
-	regulator_disable(ihid->pdata.supply);
+	i2c_hid_hw_power_off(ihid);
 
 err:
 	i2c_hid_free_buffers(ihid);
@@ -1112,8 +1149,7 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
-	regulator_disable(ihid->pdata.supply);
-
+	i2c_hid_hw_power_off(ihid);
 	kfree(ihid);
 
 	return 0;
@@ -1165,9 +1201,10 @@ static int i2c_hid_suspend(struct device *dev)
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
 	} else {
-		ret = regulator_disable(ihid->pdata.supply);
+		ret = i2c_hid_hw_power_off(ihid);
 		if (ret < 0)
-			hid_warn(hid, "Failed to disable supply: %d\n", ret);
+			hid_warn(hid, "Failed to disable hw power: %d\n",
+				 ret);
 	}
 
 	return 0;
@@ -1182,11 +1219,9 @@ static int i2c_hid_resume(struct device *dev)
 	int wake_status;
 
 	if (!device_may_wakeup(&client->dev)) {
-		ret = regulator_enable(ihid->pdata.supply);
+		ret = i2c_hid_hw_power_on(ihid);
 		if (ret < 0)
-			hid_warn(hid, "Failed to enable supply: %d\n", ret);
-		if (ihid->pdata.post_power_delay_ms)
-			msleep(ihid->pdata.post_power_delay_ms);
+			hid_warn(hid, "Failed to enable hw power: %d\n", ret);
 	} else if (ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(client->irq);
 		if (!wake_status)
diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
index 1fb0882..3afc781 100644
--- a/include/linux/platform_data/i2c-hid.h
+++ b/include/linux/platform_data/i2c-hid.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 
+struct gpio_desc;
 struct regulator;
 
 /**
@@ -37,6 +38,9 @@ struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
 	struct regulator *supply;
 	int post_power_delay_ms;
+	struct gpio_desc *reset_gpio;
+	int assert_reset_us;
+	int deassert_reset_us;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
2.7.4

