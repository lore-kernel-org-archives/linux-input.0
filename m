From: Karsten Merker <merker@debian.org>
Subject: [PATCH 2/2] Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
Date: Thu,  1 Oct 2015 00:29:55 +0200
Message-ID: <1443652195-7104-3-git-send-email-merker@debian.org>
References: <1443652195-7104-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443652195-7104-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver uses a "rotated_screen" flag for
systems on which the touchscreen is mounted rotated by 180
degrees with respect to the display.  With the addition of
support for the dt properties "touchscreen-inverted-x" and
"touchscreen-inverted-y", a separate "rotated_screen" flag
is not necessary any more. This patch replaces it by setting
the inverted-x and inverted-x flags instead.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 drivers/input/touchscreen/goodix.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2b1590..6ce909c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -39,7 +39,6 @@ struct goodix_ts_data {
 	int abs_y_max;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
-	bool rotated_screen;
 	int cfg_len;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
@@ -261,11 +260,6 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
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
@@ -705,10 +699,12 @@ static void goodix_read_config(struct goodix_ts_data *ts)
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
