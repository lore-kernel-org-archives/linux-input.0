From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/4] input: misc: gp2a: Enable device tree
Date: Fri, 25 Jan 2019 18:50:44 +0100
Message-ID: <20190125175045.22576-4-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Enable probing of gp2a via device tree via a simple of_match table

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/gp2ap002a00f.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 090c8c313295..01a7d44ae921 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -21,6 +21,8 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/input/gp2ap002a00f.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 struct gp2a_data {
 	struct iio_channel *channel;
@@ -140,6 +142,35 @@ static int gp2a_initialize(struct gp2a_data *dt)
 	return error;
 }
 
+static struct gp2a_platform_data *gp2a_parse_dt_pdata(struct device *dev)
+{
+	struct gp2a_platform_data *pdata;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->wakeup = of_property_read_bool(dev->of_node, "wakeup");
+
+	pdata->vout_gpio = of_get_named_gpio(dev->of_node, "vout-gpio", 0);
+	if (pdata->vout_gpio < 0) {
+		dev_err(dev, "failed to find vout-gpio");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ret = device_property_read_u32(dev, "light-adc-max",
+				       &pdata->light_adc_max);
+	if (ret)
+		pdata->light_adc_max = 4096;
+	ret = device_property_read_u32(dev, "light-adc-fuzz",
+				       &pdata->light_adc_fuzz);
+	if (ret)
+		pdata->light_adc_fuzz = 80;
+
+	return pdata;
+}
+
 static int gp2a_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -147,6 +178,12 @@ static int gp2a_probe(struct i2c_client *client,
 	struct gp2a_data *dt;
 	int error, value;
 
+	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
+		pdata = gp2a_parse_dt_pdata(&client->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	if (!pdata)
 		return -EINVAL;
 
@@ -317,6 +354,14 @@ static int __maybe_unused gp2a_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gp2a_pm, gp2a_suspend, gp2a_resume);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id gp2a_of_match[] = {
+	{ .compatible = "sharp,gp2ap002a00f" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gp2a_of_match);
+#endif
+
 static const struct i2c_device_id gp2a_i2c_id[] = {
 	{ GP2A_I2C_NAME, 0 },
 	{ }
@@ -326,6 +371,7 @@ MODULE_DEVICE_TABLE(i2c, gp2a_i2c_id);
 static struct i2c_driver gp2a_i2c_driver = {
 	.driver = {
 		.name	= GP2A_I2C_NAME,
+		.of_match_table = of_match_ptr(gp2a_of_match),
 		.pm	= &gp2a_pm,
 	},
 	.probe		= gp2a_probe,
-- 
2.17.1
