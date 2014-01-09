From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bqreaders.com>
Subject: [PATCH 3/3] Input: zforce: add devicetree support
Date: Thu, 09 Jan 2014 22:22:36 +0100
Message-ID: <6407177.kpp4aUtUkm@phil>
References: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34306 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757234AbaAIVWx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jan 2014 16:22:53 -0500
In-Reply-To: <2587208.XYbbI8xJiH@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

This makes the zforce driver usable on devicetree-based platforms too.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 drivers/input/touchscreen/zforce_ts.c |   57 +++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 5a1a93b..a33e173 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -29,6 +29,8 @@
 #include <linux/sysfs.h>
 #include <linux/input/mt.h>
 #include <linux/platform_data/zforce_ts.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #define WAIT_TIMEOUT		msecs_to_jiffies(1000)
 
@@ -684,6 +686,45 @@ static void zforce_reset(void *data)
 	gpio_set_value(ts->pdata->gpio_rst, 0);
 }
 
+static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
+{
+	struct zforce_ts_platdata *pdata;
+	struct device_node *np = dev->of_node;
+
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "failed to allocate platform data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->gpio_int = of_get_gpio(np, 0);
+	if (!gpio_is_valid(pdata->gpio_int)) {
+		dev_err(dev, "failed to get interrupt gpio\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata->gpio_rst = of_get_gpio(np, 1);
+	if (!gpio_is_valid(pdata->gpio_rst)) {
+		dev_err(dev, "failed to get reset gpio\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
+		dev_err(dev, "failed to get x-size property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "y-size", &pdata->y_max)) {
+		dev_err(dev, "failed to get y-size property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pdata;
+}
+
 static int zforce_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -692,8 +733,11 @@ static int zforce_probe(struct i2c_client *client,
 	struct input_dev *input_dev;
 	int ret;
 
-	if (!pdata)
-		return -EINVAL;
+	if (!pdata) {
+		pdata = zforce_parse_dt(&client->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
 
 	ts = devm_kzalloc(&client->dev, sizeof(struct zforce_ts), GFP_KERNEL);
 	if (!ts)
@@ -829,11 +873,20 @@ static struct i2c_device_id zforce_idtable[] = {
 };
 MODULE_DEVICE_TABLE(i2c, zforce_idtable);
 
+#ifdef CONFIG_OF
+static struct of_device_id zforce_dt_idtable[] = {
+	{ .compatible = "neonode,zforce" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, zforce_dt_idtable);
+#endif
+
 static struct i2c_driver zforce_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "zforce-ts",
 		.pm	= &zforce_pm_ops,
+		.of_match_table	= of_match_ptr(zforce_dt_idtable),
 	},
 	.probe		= zforce_probe,
 	.id_table	= zforce_idtable,
-- 
1.7.10.4


