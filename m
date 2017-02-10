From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5 2/2] HID: i2c-hid: support regulator power on/off
Date: Thu,  9 Feb 2017 18:03:57 -0800
Message-ID: <20170210020357.10679-2-briannorris@chromium.org>
References: <20170210020357.10679-1-briannorris@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35314 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdBJCED (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2017 21:04:03 -0500
Received: by mail-pg0-f54.google.com with SMTP id 194so5685444pgd.2
        for <linux-input@vger.kernel.org>; Thu, 09 Feb 2017 18:04:03 -0800 (PST)
In-Reply-To: <20170210020357.10679-1-briannorris@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

On some boards, we need to enable a regulator before using the HID, and
it's also nice to save power in suspend by disabling it. Support an
optional "vdd-supply" and a companion initialization delay.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
---
v2:
 * support compatible property for wacom, with specific "vdd-supply"
 * name
 * support the 100ms delay needed for this digitizer
 * target regulator support only at specific device

v3:
 * drop Wacom specifics and allow this to be used generically
 * add "init-delay-ms" property support

v4:
 * use devm_regulator_get() (with a 'dummy' regulator for most cases)
   instead of _optional() version, to make code less conditional (Dmitry)
 * fix but where 'init_delay_ms' wasn't getting assigned properly
 * disable regulator in probe() failure path

v5:
 * rebase
 * use 'post-power-on-delay-ms' name
---
 drivers/hid/i2c-hid/i2c-hid.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/i2c/i2c-hid.h   |  6 ++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ea3c3546cef7..a3f6daf0886b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -994,6 +994,11 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	}
 	pdata->hid_descriptor_address = val;
 
+	ret = of_property_read_u32(dev->of_node, "post-power-on-delay-ms",
+				   &val);
+	if (!ret)
+		pdata->post_power_delay_ms = val;
+
 	return 0;
 }
 
@@ -1053,6 +1058,24 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
+	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(ihid->pdata.supply)) {
+		ret = PTR_ERR(ihid->pdata.supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev, "Failed to get regulator: %d\n",
+				ret);
+		return ret;
+	}
+
+	ret = regulator_enable(ihid->pdata.supply);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to enable regulator: %d\n",
+			ret);
+		goto err;
+	}
+	if (ihid->pdata.post_power_delay_ms)
+		msleep(ihid->pdata.post_power_delay_ms);
+
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1068,7 +1091,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 	 * real computation later. */
 	ret = i2c_hid_alloc_buffers(ihid, HID_MIN_BUFFER_SIZE);
 	if (ret < 0)
-		goto err;
+		goto err_regulator;
 
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
@@ -1125,6 +1148,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 
+err_regulator:
+	regulator_disable(ihid->pdata.supply);
+
 err:
 	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
@@ -1149,6 +1175,8 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
+	regulator_disable(ihid->pdata.supply);
+
 	kfree(ihid);
 
 	return 0;
@@ -1199,6 +1227,10 @@ static int i2c_hid_suspend(struct device *dev)
 		else
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
+	} else {
+		ret = regulator_disable(ihid->pdata.supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to disable supply: %d\n", ret);
 	}
 
 	return 0;
@@ -1212,7 +1244,13 @@ static int i2c_hid_resume(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int wake_status;
 
-	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
+	if (!device_may_wakeup(&client->dev)) {
+		ret = regulator_enable(ihid->pdata.supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to enable supply: %d\n", ret);
+		if (ihid->pdata.post_power_delay_ms)
+			msleep(ihid->pdata.post_power_delay_ms);
+	} else if (ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(client->irq);
 		if (!wake_status)
 			ihid->irq_wake_enabled = false;
diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/i2c/i2c-hid.h
index 7aa901d92058..1fb088239d12 100644
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
+ * @post_power_delay_ms: delay after powering on before device is usable.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
  * driver, or the flattened device tree) to setup the irq related to the gpio in
@@ -31,6 +35,8 @@
  */
 struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
+	struct regulator *supply;
+	int post_power_delay_ms;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
2.11.0.483.g087da7b7c-goog

