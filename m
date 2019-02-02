From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 3/5] input: misc: bma150: Add support for device tree
Date: Sat,  2 Feb 2019 16:18:04 +0100
Message-ID: <20190202151806.9064-4-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add of_match table to enable bma150 to be probed via DT

Changes from v1:
 - Add properties for all of bma150_cfg

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 64 ++++++++++++++++++++++++++++++++++++-
 include/linux/bma150.h      | 20 ++++++------
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 79acaaf86b7e..e86df79490ad 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/bma150.h>
@@ -146,7 +147,7 @@ struct bma150_data {
  * are stated and verified by Bosch Sensortec where they are configured
  * to provide a generic sensitivity performance.
  */
-static const struct bma150_cfg default_cfg = {
+static struct bma150_cfg default_cfg = {
 	.any_motion_int = 1,
 	.hg_int = 1,
 	.lg_int = 1,
@@ -518,6 +519,51 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	return 0;
 }
 
+int bma150_cfg_from_of(struct device_node *np)
+{
+	int error;
+
+	default_cfg.any_motion_int =
+			of_property_read_bool(np, "any-motion-int");
+	default_cfg.hg_int =
+			of_property_read_bool(np, "hg-int");
+	default_cfg.lg_int =
+			of_property_read_bool(np, "lg-int");
+
+	error = of_property_read_u32_array(np, "any-motion-cfg",
+			&default_cfg.any_motion_dur, 2);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32_array(np, "hg-cfg",
+			&default_cfg.hg_hyst, 3);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32_array(np, "lg-cfg",
+			&default_cfg.lg_hyst, 3);
+	if (error < 0 && error != -EINVAL)
+		return error;
+
+	error = of_property_read_u32(np, "range",
+			&default_cfg.range);
+	if (error < 0 && error != -EINVAL)
+		return error;
+	else if (default_cfg.range < BMA150_RANGE_2G ||
+			default_cfg.range > BMA150_RANGE_8G)
+		return -EINVAL;
+
+	error = of_property_read_u32(np, "bandwidth",
+			&default_cfg.bandwidth);
+	if (error < 0 && error != -EINVAL)
+		return error;
+	else if (default_cfg.bandwidth < BMA150_BW_25HZ ||
+			default_cfg.bandwidth > BMA150_BW_1500HZ)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
@@ -557,6 +603,13 @@ static int bma150_probe(struct i2c_client *client,
 			}
 		}
 		cfg = &pdata->cfg;
+	} else if (client->dev.of_node) {
+		error = bma150_cfg_from_of(client->dev.of_node);
+		if (error) {
+			dev_err(&client->dev, "Failed to parse of data\n");
+			return error;
+		}
+		cfg = &default_cfg;
 	} else {
 		cfg = &default_cfg;
 	}
@@ -620,6 +673,14 @@ static int bma150_resume(struct device *dev)
 
 static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id bma150_of_match[] = {
+	{ .compatible = "bosch,bma150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bma150_of_match);
+#endif
+
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
 	{ "smb380", 0 },
@@ -632,6 +693,7 @@ MODULE_DEVICE_TABLE(i2c, bma150_id);
 static struct i2c_driver bma150_driver = {
 	.driver = {
 		.name	= BMA150_DRIVER,
+		.of_match_table = of_match_ptr(bma150_of_match),
 		.pm	= &bma150_pm,
 	},
 	.class		= I2C_CLASS_HWMON,
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index b85266a9c35c..ad19dc7a30d7 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -29,16 +29,16 @@ struct bma150_cfg {
 	bool any_motion_int;		/* Set to enable any-motion interrupt */
 	bool hg_int;			/* Set to enable high-G interrupt */
 	bool lg_int;			/* Set to enable low-G interrupt */
-	unsigned char any_motion_dur;	/* Any-motion duration */
-	unsigned char any_motion_thres;	/* Any-motion threshold */
-	unsigned char hg_hyst;		/* High-G hysterisis */
-	unsigned char hg_dur;		/* High-G duration */
-	unsigned char hg_thres;		/* High-G threshold */
-	unsigned char lg_hyst;		/* Low-G hysterisis */
-	unsigned char lg_dur;		/* Low-G duration */
-	unsigned char lg_thres;		/* Low-G threshold */
-	unsigned char range;		/* one of BMA0150_RANGE_xxx */
-	unsigned char bandwidth;	/* one of BMA0150_BW_xxx */
+	u32 any_motion_dur;		/* Any-motion duration */
+	u32 any_motion_thres;		/* Any-motion threshold */
+	u32 hg_hyst;			/* High-G hysterisis */
+	u32 hg_dur;			/* High-G duration */
+	u32 hg_thres;			/* High-G threshold */
+	u32 lg_hyst;			/* Low-G hysterisis */
+	u32 lg_dur;			/* Low-G duration */
+	u32 lg_thres;			/* Low-G threshold */
+	u32 range;			/* one of BMA0150_RANGE_xxx */
+	u32 bandwidth;			/* one of BMA0150_BW_xxx */
 };
 
 struct bma150_platform_data {
-- 
2.17.1
