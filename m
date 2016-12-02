From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] HID: i2c-hid: support regulator power on/off
Date: Fri,  2 Dec 2016 14:19:00 -0800
Message-ID: <1480717140-14558-2-git-send-email-briannorris@chromium.org>
References: <1480717140-14558-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1480717140-14558-1-git-send-email-briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On some boards, we need to enable a regulator before using the HID, and
it's also nice to save power in suspend by disabling it. Support an
optional "vdd-supply" and a companion initialization delay.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
---
 drivers/hid/i2c-hid/i2c-hid.c | 44 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/i2c/i2c-hid.h   |  6 ++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2de875..5c6e037613d7 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -38,6 +38,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -937,6 +938,10 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	}
 	pdata->hid_descriptor_address = val;
 
+	ret = of_property_read_u32(dev->of_node, "init-delay-ms", &val);
+	if (!ret)
+		pdata->init_delay_ms = val;
+
 	return 0;
 }
 
@@ -983,6 +988,15 @@ static int i2c_hid_probe(struct i2c_client *client,
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
 	if (client->irq > 0) {
 		ihid->irq = client->irq;
 	} else if (ACPI_COMPANION(&client->dev)) {
@@ -1000,6 +1014,15 @@ static int i2c_hid_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = regulator_enable(ihid->pdata.supply);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to enable regulator: %d\n",
+			ret);
+		goto err;
+	}
+	if (ihid->pdata.init_delay_ms)
+		msleep(ihid->pdata.init_delay_ms);
+
 	i2c_set_clientdata(client, ihid);
 
 	ihid->client = client;
@@ -1015,7 +1038,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 	 * real computation later. */
 	ret = i2c_hid_alloc_buffers(ihid, HID_MIN_BUFFER_SIZE);
 	if (ret < 0)
-		goto err;
+		goto err_regulator;
 
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
@@ -1070,6 +1093,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 
+err_regulator:
+	regulator_disable(ihid->pdata.supply);
+
 err:
 	if (ihid->desc)
 		gpiod_put(ihid->desc);
@@ -1100,6 +1126,8 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->desc)
 		gpiod_put(ihid->desc);
 
+	regulator_disable(ihid->pdata.supply);
+
 	kfree(ihid);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
@@ -1152,6 +1180,11 @@ static int i2c_hid_suspend(struct device *dev)
 		else
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
+	} else {
+		ret = regulator_disable(ihid->pdata.supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to disable supply: %d\n",
+				 ret);
 	}
 
 	return 0;
@@ -1165,7 +1198,14 @@ static int i2c_hid_resume(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int wake_status;
 
-	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
+	if (!device_may_wakeup(&client->dev)) {
+		ret = regulator_enable(ihid->pdata.supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to enable supply: %d\n",
+				 ret);
+		if (ihid->pdata.init_delay_ms)
+			msleep(ihid->pdata.init_delay_ms);
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
