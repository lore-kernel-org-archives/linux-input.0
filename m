From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC V2 2/3] Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
Date: Fri,  9 Oct 2015 19:55:51 +0200
Message-ID: <1444413352-24529-3-git-send-email-merker@debian.org>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444413352-24529-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver uses a "rotated_screen" flag for
systems on which the touchscreen is mounted rotated by 180
degrees with respect to the display.  With the addition of
support for the dt properties "touchscreen-inverted-x" and
"touchscreen-inverted-y", a separate "rotated_screen" flag
is not necessary any more. This patch replaces it by setting
the inverted_x and inverted_y flags instead.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 drivers/input/touchscreen/goodix.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a05bdad..d910b27 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -40,7 +40,6 @@ struct goodix_ts_data {
 	int abs_y_max;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
-	bool rotated_screen;
 	int cfg_len;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
@@ -270,11 +269,6 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 	int input_y = get_unaligned_le16(&coor_data[3]);
 	int input_w = get_unaligned_le16(&coor_data[5]);
 
-	if (ts->rotated_screen) {
-		input_x = ts->abs_x_max - input_x;
-		input_y = ts->abs_y_max - input_y;
-	}
-
 	/* Inversions have to happen before axis swapping */
 	if (ts->inverted_x)
 		input_x = ts->abs_x_max - input_x;
@@ -701,10 +695,12 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 	}
 
-	ts->rotated_screen = dmi_check_system(rotated_screen);
-	if (ts->rotated_screen)
+	if (dmi_check_system(rotated_screen)) {
+		ts->inverted_x = true;
+		ts->inverted_y = true;
 		dev_dbg(&ts->client->dev,
 			 "Applying '180 degrees rotated screen' quirk\n");
+	}
 }
 
 /**
-- 
2.1.4
