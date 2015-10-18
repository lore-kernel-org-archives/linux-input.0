From: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RFC V3 2/3] Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
Date: Sun, 18 Oct 2015 17:52:58 +0200
Message-ID: <1445183579-29176-3-git-send-email-merker@debian.org>
References: <1445183579-29176-1-git-send-email-merker@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445183579-29176-1-git-send-email-merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver uses a "rotated_screen" flag for
systems on which the touchscreen is mounted rotated by 180
degrees with respect to the display.  With the addition of
support for the dt properties "touchscreen-inverted-x" and
"touchscreen-inverted-y", a separate "rotated_screen" flag
is not necessary anymore. This patch replaces it by setting
the inverted_x and inverted_y flags instead.

Signed-off-by: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Reviewed-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Acked-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b585123..22eff28 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
