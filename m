From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 4/4] Input: atmel_mxt_ts: implement device tree parsing
Date: Tue,  6 May 2014 16:13:12 -0600
Message-ID: <1399414392-32572-5-git-send-email-swarren@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51642 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaEFWN2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:13:28 -0400
In-Reply-To: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

FIXME:

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 47 +++++++++++++++++++++++++++++++-
 include/linux/i2c/atmel_mxt_ts.h         |  5 +++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c7ab14cf84b7..6080f28637d2 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -18,6 +18,7 @@
 #include <linux/i2c/atmel_mxt_ts.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
 /* Version */
@@ -879,7 +880,8 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		goto err_free_object_table;
 
-	mxt_handle_pdata(data);
+	if (!data->pdata->skip_hw_config)
+		mxt_handle_pdata(data);
 
 	/* Backup to memory */
 	error = mxt_write_object(data, MXT_GEN_COMMAND_T6,
@@ -1158,6 +1160,44 @@ static void mxt_input_close(struct input_dev *dev)
 	mxt_stop(data);
 }
 
+static const struct of_device_id mxt_of_match[] = {
+	{ .compatible = "atmel,mxt-tp", },
+	{ .compatible = "atmel,mxt-tp-bootloader", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mxt_of_match);
+
+static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
+{
+	struct mxt_platform_data *pdata;
+	int i, ret;
+	u32 keycode;
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	/*
+	 * Later, we could add some optional properties to allow the HW
+	 * configuation fields and IRQ configuration to be set in device tree.
+	 */
+	pdata->skip_hw_config = true;
+	pdata->irqflags = IRQF_TRIGGER_FALLING;
+
+	/* This can be sourced from mxt_of_match[].data if it varies */
+	pdata->is_tp = true;
+
+	for (i = 0; i < MXT_NUM_GPIO; i++) {
+		ret = of_property_read_u32_index(client->dev.of_node,
+				"linux,gpio-keymap", i, &keycode);
+		if (ret)
+			continue;
+		pdata->key_map[i] = keycode;
+	}
+
+	return pdata;
+}
+
 static int mxt_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -1167,6 +1207,10 @@ static int mxt_probe(struct i2c_client *client,
 	int error;
 	unsigned int num_mt_slots;
 
+#if IS_ENABLED(CONFIG_OF)
+	if (!pdata && client->dev.of_node)
+		pdata = mxt_parse_dt(client);
+#endif
 	if (!pdata)
 		return -EINVAL;
 
@@ -1356,6 +1400,7 @@ static struct i2c_driver mxt_driver = {
 	.driver = {
 		.name	= "atmel_mxt_ts",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mxt_of_match),
 		.pm	= &mxt_pm_ops,
 	},
 	.probe		= mxt_probe,
diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
index 99e379b74398..30c5fa067baa 100644
--- a/include/linux/i2c/atmel_mxt_ts.h
+++ b/include/linux/i2c/atmel_mxt_ts.h
@@ -33,6 +33,8 @@ struct mxt_platform_data {
 	const u8 *config;
 	size_t config_length;
 
+	/* true if x_line..orient are not set */
+	bool skip_hw_config;
 	unsigned int x_line;
 	unsigned int y_line;
 	unsigned int x_size;
@@ -41,9 +43,10 @@ struct mxt_platform_data {
 	unsigned int threshold;
 	unsigned int voltage;
 	unsigned char orient;
+
 	unsigned long irqflags;
 	bool is_tp;
-	const unsigned int key_map[MXT_NUM_GPIO];
+	unsigned int key_map[MXT_NUM_GPIO];
 };
 
 #endif /* __LINUX_ATMEL_MXT_TS_H */
-- 
1.8.1.5

