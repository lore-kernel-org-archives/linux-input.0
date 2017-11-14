From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 1/3] Input: goodix - fix reported range
Date: Tue, 14 Nov 2017 13:42:15 +0100
Message-ID: <20171114124217.2863-2-m.niestroj@grinn-global.com>
References: <20171114124217.2863-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:35669 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbdKNMmb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 07:42:31 -0500
In-Reply-To: <20171114124217.2863-1-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>

Touchscreen with x and y resolution should report (0:x-1), (0:y-1) as
it's range. Fix driver to do that.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
Fixes: ca96ea86eed4 ("Input: add driver for the Goodix touchpanel")
---
Changes v1 -> v2: patch splitted off from patch 3 (suggested by Bastien)

 drivers/input/touchscreen/goodix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 69d0b8cbc71f..7896097ca69b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -587,8 +587,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d), using defaults\n",
 			 error);
-		ts->abs_x_max = GOODIX_MAX_WIDTH;
-		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		ts->abs_x_max = GOODIX_MAX_WIDTH - 1;
+		ts->abs_y_max = GOODIX_MAX_HEIGHT - 1;
 		if (ts->swapped_x_y)
 			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->int_trigger_type = GOODIX_INT_TRIGGER;
@@ -596,8 +596,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		return;
 	}
 
-	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
-	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
+	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]) - 1;
+	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]) - 1;
 	if (ts->swapped_x_y)
 		swap(ts->abs_x_max, ts->abs_y_max);
 	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
@@ -605,8 +605,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
 		dev_err(&ts->client->dev,
 			"Invalid config, using defaults\n");
-		ts->abs_x_max = GOODIX_MAX_WIDTH;
-		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		ts->abs_x_max = GOODIX_MAX_WIDTH - 1;
+		ts->abs_y_max = GOODIX_MAX_HEIGHT - 1;
 		if (ts->swapped_x_y)
 			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
-- 
2.15.0

