From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 2/4] mfd: da9052: make touchscreen registration optional
Date: Tue, 18 Jul 2017 11:20:22 +0200
Message-ID: <20170718092024.22552-3-sebastian.reichel@collabora.co.uk>
References: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

If the touchscreen pins are used as general purpose analogue
input, the touchscreen driver should not be used. The pins
will be handled by the existing hwmon driver instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/da9052-core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 977418ca9117..433add43a0a9 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/core.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/property.h>
 
 #include <linux/mfd/da9052/da9052.h>
 #include <linux/mfd/da9052/pdata.h>
@@ -521,9 +522,6 @@ static const struct mfd_cell da9052_subdev_info[] = {
 		.name = "da9052-wled3",
 	},
 	{
-		.name = "da9052-tsi",
-	},
-	{
 		.name = "da9052-bat",
 	},
 	{
@@ -531,6 +529,10 @@ static const struct mfd_cell da9052_subdev_info[] = {
 	},
 };
 
+static const struct mfd_cell da9052_tsi_subdev_info[] = {
+	{ .name = "da9052-tsi" },
+};
+
 const struct regmap_config da9052_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -621,9 +623,27 @@ int da9052_device_init(struct da9052 *da9052, u8 chip_id)
 		goto err;
 	}
 
+	/*
+	 * Check if touchscreen pins are used are analogue input instead
+	 * of having a touchscreen connected to them. The analogue input
+	 * functionality will be provided by hwmon driver (if enabled).
+	 */
+	if (!device_property_read_bool(da9052->dev, "dlg,tsi-as-adc")) {
+		ret = mfd_add_devices(da9052->dev, PLATFORM_DEVID_AUTO,
+				      da9052_tsi_subdev_info,
+				      ARRAY_SIZE(da9052_tsi_subdev_info),
+				      NULL, 0, NULL);
+		if (ret) {
+			dev_err(da9052->dev, "failed to add TSI subdev: %d\n",
+				ret);
+			goto err;
+		}
+	}
+
 	return 0;
 
 err:
+	mfd_remove_devices(da9052->dev);
 	da9052_irq_exit(da9052);
 
 	return ret;
-- 
2.13.2
