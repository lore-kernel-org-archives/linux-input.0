From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 2/3] Input: goodix - fix simultaneous axes inversion and swap
Date: Tue, 14 Nov 2017 13:42:16 +0100
Message-ID: <20171114124217.2863-3-m.niestroj@grinn-global.com>
References: <20171114124217.2863-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:49891 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbdKNMmd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 07:42:33 -0500
In-Reply-To: <20171114124217.2863-1-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>

goodix_ts_data structure contains abs_x_max and abs_y_max members,
which contain already swapped maximum ranges. That causes reporting
touch events with invalid position (out of range values).

Take into account that abs_x_max and abs_y_max are already swapped
in goodix_ts_report_touch(), so position for inverted axes will be
calculated correctly.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
Fixes: ad48cf5e9597 ("Input: goodix - add axis swapping and axis inversion support")
---
Changes v1 -> v2: patch splitted off from patch 3 (suggested by Bastien)

 drivers/input/touchscreen/goodix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 7896097ca69b..dc832890f6d3 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -296,12 +296,18 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 	int input_w = get_unaligned_le16(&coor_data[5]);
 
 	/* Inversions have to happen before axis swapping */
-	if (ts->inverted_x)
-		input_x = ts->abs_x_max - input_x;
-	if (ts->inverted_y)
-		input_y = ts->abs_y_max - input_y;
-	if (ts->swapped_x_y)
+	if (!ts->swapped_x_y) {
+		if (ts->inverted_x)
+			input_x = ts->abs_x_max - input_x;
+		if (ts->inverted_y)
+			input_y = ts->abs_y_max - input_y;
+	} else {
+		if (ts->inverted_x)
+			input_x = ts->abs_y_max - input_x;
+		if (ts->inverted_y)
+			input_y = ts->abs_x_max - input_y;
 		swap(input_x, input_y);
+	}
 
 	input_mt_slot(ts->input_dev, id);
 	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
-- 
2.15.0

