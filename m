From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 2/9] Input: goodix - use actual config length for each device type
Date: Mon,  7 Sep 2015 17:36:16 +0300
Message-ID: <1441636583-14188-3-git-send-email-irina.tirdea@intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441636583-14188-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Each of the Goodix devices supported by this driver has a fixed size for
the configuration information registers. The size varies depending on the
device and is specified in the datasheet.

Use the proper configuration length as specified in the datasheet for
each device model, so we do not read more than the actual size of the
configuration registers.

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 6ae28c5..7be6eab 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -36,6 +36,7 @@ struct goodix_ts_data {
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
 	bool rotated_screen;
+	int cfg_len;
 };
 
 #define GOODIX_MAX_HEIGHT		4096
@@ -45,6 +46,8 @@ struct goodix_ts_data {
 #define GOODIX_MAX_CONTACTS		10
 
 #define GOODIX_CONFIG_MAX_LENGTH	240
+#define GOODIX_CONFIG_911_LENGTH	186
+#define GOODIX_CONFIG_967_LENGTH	228
 
 /* Register defines */
 #define GOODIX_READ_COOR_ADDR		0x814E
@@ -115,6 +118,23 @@ static int goodix_i2c_read(struct i2c_client *client,
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
@@ -230,8 +250,7 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	int error;
 
 	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
-				config,
-				GOODIX_CONFIG_MAX_LENGTH);
+				config, ts->cfg_len);
 	if (error) {
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d), using defaults\n",
@@ -398,6 +417,8 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	ts->cfg_len = goodix_get_cfg_len(id_info);
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts, version_info, id_info);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
