From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 1/2] Input: mcs_touchkey: add device tree support
Date: Wed, 21 May 2014 14:51:49 +0900
Message-ID: <537C3EF5.90000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35030 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaEUFvv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 01:51:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>, mark.rutland@arm.com
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Add device tree support for mcs touchkey driver.
Tested on exynos 4412 board.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |   73 +++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 1da8e0b..9bff47b 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/of_gpio.h>

 /* MCS5000 Touchkey */
 #define MCS5000_TOUCHKEY_STATUS		0x04
@@ -96,6 +97,60 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

+#ifdef CONFIG_OF
+static struct mcs_platform_data *mcs_touchkey_parse_dt(struct device *dev)
+{
+	struct mcs_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	unsigned int keymap[2];
+	unsigned int len;
+	int i = 0;
+	const __be32 *prop;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "Failed to allocate platform data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	prop = of_get_property(np, "linux,code", &len);
+	if (!prop) {
+		dev_err(dev, "Failed to get code\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (len % sizeof(u32)) {
+		dev_err(dev, "Malformed keycode property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata->keymap_size = len / sizeof(u32);
+
+	if (of_property_read_u32(np, "key_maxval", &pdata->key_maxval)) {
+		dev_err(dev, "Failed to get key max value data\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (pdata->keymap_size > pdata->key_maxval) {
+		dev_err(dev, "Key map size overflow\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (i = 0; i < pdata->keymap_size; i++) {
+		u32 code = be32_to_cpup(prop + i);
+		keymap[i] = MCS_KEY_MAP(i, code);
+	}
+	pdata->keymap = keymap;
+	return pdata;
+}
+#else
+static inline struct mcs_platform_data *mcs_touchkey_parse_dt
+						(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int mcs_touchkey_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -107,10 +162,14 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 	int error;
 	int i;

-	pdata = dev_get_platdata(&client->dev);
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data defined\n");
-		return -EINVAL;
+	if (&client->dev.of_node)
+		pdata = mcs_touchkey_parse_dt(&client->dev);
+	else
+		pdata = dev_get_platdata(&client->dev);
+
+	if (IS_ERR(pdata)) {
+		dev_err(&client->dev, "Failed to get platform data\n");
+		return PTR_ERR(pdata);
 	}

 	data = kzalloc(sizeof(struct mcs_touchkey_data) +
@@ -262,11 +321,17 @@ static const struct i2c_device_id mcs_touchkey_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcs_touchkey_id);

+static struct of_device_id mcs_touchkey_dt_match[] = {
+	{ .compatible = "mcs5000_touchkey", },
+	{ .compatible = "mcs5080_touchkey", },
+};
+
 static struct i2c_driver mcs_touchkey_driver = {
 	.driver = {
 		.name	= "mcs_touchkey",
 		.owner	= THIS_MODULE,
 		.pm	= &mcs_touchkey_pm_ops,
+		.of_match_table = of_match_ptr(mcs_touchkey_dt_match),
 	},
 	.probe		= mcs_touchkey_probe,
 	.remove		= mcs_touchkey_remove,
-- 
1.7.9.5
