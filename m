From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/2] HID: i2c-hid: support the regulator
Date: Mon,  5 Sep 2016 06:11:56 +0800
Message-ID: <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1473027116-13892-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Guohua Zhong <ghzhong-COaM65pZ/3cNIbNsV2NXlwC/G2K4zDHf@public.gmane.org>, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Zhonghui\"" <zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

In order to allow supporting the HID based devices that need power on/off
the regulator. We try to get a power-supply property from the
device tree.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---

 drivers/hid/i2c-hid/i2c-hid.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2..07cc7aa 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -38,6 +38,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/i2c/i2c-hid.h>
 
@@ -152,6 +153,7 @@ struct i2c_hid {
 
 	bool			irq_wake_enabled;
 	struct mutex		reset_lock;
+	struct regulator	*supply;
 };
 
 static int __i2c_hid_command(struct i2c_client *client,
@@ -968,6 +970,21 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (!ihid)
 		return -ENOMEM;
 
+	ihid->supply = devm_regulator_get(&client->dev, "power");
+	if (IS_ERR(ihid->supply)) {
+		ret = PTR_ERR(ihid->supply);
+		dev_err(&client->dev, "Failed to get power regulator: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = regulator_enable(ihid->supply);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to enable power regulator: %d\n",
+			ret);
+		return ret;
+	}
+
 	if (client->dev.of_node) {
 		ret = i2c_hid_of_probe(client, &ihid->pdata);
 		if (ret)
@@ -1100,6 +1117,8 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->desc)
 		gpiod_put(ihid->desc);
 
+	regulator_disable(ihid->supply);
+
 	kfree(ihid);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
@@ -1152,6 +1171,11 @@ static int i2c_hid_suspend(struct device *dev)
 		else
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
+	} else {
+		ret = regulator_disable(ihid->supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to disable power supply: %d\n",
+				 ret);
 	}
 
 	return 0;
@@ -1165,7 +1189,12 @@ static int i2c_hid_resume(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int wake_status;
 
-	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
+	if (!device_may_wakeup(&client->dev)) {
+		ret = regulator_enable(ihid->supply);
+		if (ret < 0)
+			hid_warn(hid, "Failed to enable power supply: %d\n",
+				 ret);
+	} else if (ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(ihid->irq);
 		if (!wake_status)
 			ihid->irq_wake_enabled = false;
-- 
1.9.1
