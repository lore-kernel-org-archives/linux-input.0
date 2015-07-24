From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v3] Input: goodix - Fix touch coords on WinBook TW100 and
 TW700
Date: Fri, 24 Jul 2015 13:18:14 +0200
Message-ID: <1437736694.2863.30.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchscreen on the WinBook TW100 and TW700 don't match the default
display, with 0,0 touches being reported when touching at the bottom
right of the screen.

  1280,800             0,800
         +-------------+
         |             |
         |             |
         |             |
         +-------------+
    1280,0             0,0

It's unfortunately impossible to detect this problem with data from the
DSDT, or other auxiliary metadata, so fallback to quirking this specific
model of tablet instead.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b4d12e2..50bf6b1 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/dmi.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -34,6 +35,7 @@ struct goodix_ts_data {
 	int abs_y_max;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	bool rotated_screen;
 };
 
 #define GOODIX_MAX_HEIGHT		4096
@@ -60,6 +62,30 @@ static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_LEVEL_HIGH,
 };
 
+/*
+ * Those tablets have their coords origin at the bottom right
+ * of the tablet, as if rotated 180 degrees
+ */
+static const struct dmi_system_id rotated_screen[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.ident = "WinBook TW100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
+		}
+	},
+	{
+		.ident = "WinBook TW700",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW700")
+		},
+	},
+#endif
+	{}
+};
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -129,6 +155,11 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 	int input_y = get_unaligned_le16(&coor_data[3]);
 	int input_w = get_unaligned_le16(&coor_data[5]);
 
+	if (ts->rotated_screen) {
+		input_x = ts->abs_x_max - input_x;
+		input_y = ts->abs_y_max - input_y;
+	}
+
 	input_mt_slot(ts->input_dev, id);
 	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
 	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
@@ -223,6 +254,12 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 	}
+
+	ts->rotated_screen = dmi_check_system(rotated_screen);
+	if (ts->rotated_screen) {
+		dev_dbg(&ts->client->dev,
+			 "Applying '180 degrees rotated screen' quirk\n");
+	}
 }
 
 /**
-- 
2.4.3
