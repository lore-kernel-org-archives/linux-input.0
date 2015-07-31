From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v4 2/8] Input: goodix - use actual config length for each device type
Date: Fri, 31 Jul 2015 20:42:06 +0300
Message-ID: <1438364532-27150-3-git-send-email-irina.tirdea@intel.com>
References: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438364532-27150-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Each of the Goodix devices supported by this driver has a fixed size for
the configuration information registers. The size varies depending on the
device and is specified in the datasheet.

Use the proper configuration length as specified in the datasheet for
each device model, so we do not read more than the actual size of the
configuration registers.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index d039643..79b948c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -39,6 +39,7 @@ struct goodix_ts_data {
 	bool rotated_screen;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
+	int cfg_len;
 };
 
 #define GOODIX_MAX_HEIGHT		4096
@@ -48,6 +49,8 @@ struct goodix_ts_data {
 #define GOODIX_MAX_CONTACTS		10
 
 #define GOODIX_CONFIG_MAX_LENGTH	240
+#define GOODIX_CONFIG_911_LENGTH	186
+#define GOODIX_CONFIG_967_LENGTH	228
 
 /* Register defines */
 #define GOODIX_READ_COOR_ADDR		0x814E
@@ -142,6 +145,23 @@ static int goodix_i2c_read(struct i2c_client *client,
 	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
 }
 
+static int goodix_get_cfg_len(u16 id)
+{
+	switch (id) {
+	case 911:
+	case 9271:
+	case 9110:
+	case 927:
+	case 928:
+		return GOODIX_CONFIG_911_LENGTH;
+	case 912:
+	case 967:
+		return GOODIX_CONFIG_967_LENGTH;
+	default:
+		return GOODIX_CONFIG_MAX_LENGTH;
+	}
+}
+
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -353,8 +373,7 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	int error;
 
 	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
-				config,
-				GOODIX_CONFIG_MAX_LENGTH);
+				config, ts->cfg_len);
 	if (error) {
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d), using defaults\n",
@@ -521,6 +540,8 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	ts->cfg_len = goodix_get_cfg_len(id_info);
+
 	error = goodix_get_gpio_config(ts, id);
 	if (error)
 		return error;
-- 
1.9.1
