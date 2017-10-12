From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Thu, 12 Oct 2017 17:04:42 +0200
Message-ID: <20171012150443.27542-1-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Support was added based on Goodix GitHub repo [1]. There are two major
differences between gt1151 and currently supported devices (gt9x):
 * CONFIG_DATA register has 0x8050 address instead of 0x8047,
 * config data checksum has 16-bit width instead of 8-bit.

Also update goodix_i2c_test() function, so it reads ID register (which
has the same address for all devices) instead of CONFIG_DATA (because
its address is known only after reading ID of the device).

[1] https://github.com/goodix/gt1x_driver_generic

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
---
Patch was developed and tested on top of 4.14-rc4 using custom board.

 .../bindings/input/touchscreen/goodix.txt          |  3 +-
 drivers/input/touchscreen/goodix.c                 | 88 +++++++++++++++++-----
 2 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c98757a69110..0c369d8ebcab 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -2,7 +2,8 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 
 Required properties:
 
- - compatible		: Should be "goodix,gt911"
+ - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
 				 or "goodix,gt927"
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 32d2762448aa..9d50d9688975 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -41,6 +41,7 @@ struct goodix_ts_data {
 	bool inverted_y;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	u16 reg_config_data;
 	int cfg_len;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
@@ -69,7 +70,8 @@ struct goodix_ts_data {
 #define GOODIX_CMD_SCREEN_OFF		0x05
 
 #define GOODIX_READ_COOR_ADDR		0x814E
-#define GOODIX_REG_CONFIG_DATA		0x8047
+#define GOODIX_GT1X_REG_CONFIG_DATA	0x8050
+#define GOODIX_GT9X_REG_CONFIG_DATA	0x8047
 #define GOODIX_REG_ID			0x8140
 
 #define RESOLUTION_LOC		1
@@ -193,6 +195,16 @@ static int goodix_get_cfg_len(u16 id)
 	}
 }
 
+static int goodix_get_reg_config_data(u16 id)
+{
+	switch (id) {
+	case 1151:
+		return GOODIX_GT1X_REG_CONFIG_DATA;
+	default:
+		return GOODIX_GT9X_REG_CONFIG_DATA;
+	}
+}
+
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -311,25 +323,12 @@ static int goodix_request_irq(struct goodix_ts_data *ts)
 					 ts->irq_flags, ts->client->name, ts);
 }
 
-/**
- * goodix_check_cfg - Checks if config fw is valid
- *
- * @ts: goodix_ts_data pointer
- * @cfg: firmware config data
- */
-static int goodix_check_cfg(struct goodix_ts_data *ts,
-			    const struct firmware *cfg)
+static int goodix_check_cfg_8(struct goodix_ts_data *ts,
+			const struct firmware *cfg)
 {
-	int i, raw_cfg_len;
+	int i, raw_cfg_len = cfg->size - 2;
 	u8 check_sum = 0;
 
-	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
-		dev_err(&ts->client->dev,
-			"The length of the config fw is not correct");
-		return -EINVAL;
-	}
-
-	raw_cfg_len = cfg->size - 2;
 	for (i = 0; i < raw_cfg_len; i++)
 		check_sum += cfg->data[i];
 	check_sum = (~check_sum) + 1;
@@ -348,6 +347,53 @@ static int goodix_check_cfg(struct goodix_ts_data *ts,
 	return 0;
 }
 
+static int goodix_check_cfg_16(struct goodix_ts_data *ts,
+			const struct firmware *cfg)
+{
+	int i, raw_cfg_len = cfg->size - 3;
+	u16 check_sum = 0;
+
+	for (i = 0; i < raw_cfg_len; i += 2)
+		check_sum += get_unaligned_be16(&cfg->data[i]);
+	check_sum = (~check_sum) + 1;
+	if (check_sum != get_unaligned_be16(&cfg->data[raw_cfg_len])) {
+		dev_err(&ts->client->dev,
+			"The checksum of the config fw is not correct");
+		return -EINVAL;
+	}
+
+	if (cfg->data[raw_cfg_len + 2] != 1) {
+		dev_err(&ts->client->dev,
+			"Config fw must have Config_Fresh register set");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * goodix_check_cfg - Checks if config fw is valid
+ *
+ * @ts: goodix_ts_data pointer
+ * @cfg: firmware config data
+ */
+static int goodix_check_cfg(struct goodix_ts_data *ts,
+			    const struct firmware *cfg)
+{
+	if (cfg->size > GOODIX_CONFIG_MAX_LENGTH) {
+		dev_err(&ts->client->dev,
+			"The length of the config fw is not correct");
+		return -EINVAL;
+	}
+
+	switch (ts->id) {
+	case 1151:
+		return goodix_check_cfg_16(ts, cfg);
+	default:
+		return goodix_check_cfg_8(ts, cfg);
+	}
+}
+
 /**
  * goodix_send_cfg - Write fw config to device
  *
@@ -363,7 +409,7 @@ static int goodix_send_cfg(struct goodix_ts_data *ts,
 	if (error)
 		return error;
 
-	error = goodix_i2c_write(ts->client, GOODIX_REG_CONFIG_DATA, cfg->data,
+	error = goodix_i2c_write(ts->client, ts->reg_config_data, cfg->data,
 				 cfg->size);
 	if (error) {
 		dev_err(&ts->client->dev, "Failed to write config data: %d",
@@ -490,7 +536,7 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	u8 config[GOODIX_CONFIG_MAX_LENGTH];
 	int error;
 
-	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
+	error = goodix_i2c_read(ts->client, ts->reg_config_data,
 				config, ts->cfg_len);
 	if (error) {
 		dev_warn(&ts->client->dev,
@@ -571,7 +617,7 @@ static int goodix_i2c_test(struct i2c_client *client)
 	u8 test;
 
 	while (retry++ < 2) {
-		error = goodix_i2c_read(client, GOODIX_REG_CONFIG_DATA,
+		error = goodix_i2c_read(client, GOODIX_REG_ID,
 					&test, 1);
 		if (!error)
 			return 0;
@@ -741,6 +787,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	ts->reg_config_data = goodix_get_reg_config_data(ts->id);
 	ts->cfg_len = goodix_get_cfg_len(ts->id);
 
 	if (ts->gpiod_int && ts->gpiod_rst) {
@@ -870,6 +917,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
+	{ .compatible = "goodix,gt1151" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
