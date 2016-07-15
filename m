From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] touchscreen: ft5x06: Add support for axis inversion / swapping
Date: Fri, 15 Jul 2016 14:16:13 +0200
Message-ID: <1468584975-15970-3-git-send-email-hdegoede@redhat.com>
References: <1468584975-15970-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbcGOMQX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 08:16:23 -0400
In-Reply-To: <1468584975-15970-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Add support for axis inversion / swapping using the new
touchscreen_parse_properties and touchscreen_apply_prop_to_x_y
functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
Changes in v3:
-Use new touchscreen_report_pos helper
---
 drivers/input/touchscreen/edt-ft5x06.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e8825e5..703e295 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -86,6 +86,7 @@ struct edt_reg_addr {
 struct edt_ft5x06_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct touchscreen_properties prop;
 	u16 num_x;
 	u16 num_y;
 
@@ -246,8 +247,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		if (!down)
 			continue;
 
-		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
-		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
+		touchscreen_report_pos(tsdata->input, &tsdata->prop, x, y,
+				       true);
 	}
 
 	input_mt_report_pointer_emulation(tsdata->input, true);
@@ -972,7 +973,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
-	touchscreen_parse_properties(input, true, NULL);
+	touchscreen_parse_properties(input, true, &tsdata->prop);
 
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
-- 
2.7.4

