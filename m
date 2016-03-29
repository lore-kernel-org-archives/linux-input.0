From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 2/4] touchscreen: ft5x06: Add support for axis inversion / swapping
Date: Tue, 29 Mar 2016 10:29:27 +0200
Message-ID: <1459240169-11531-3-git-send-email-hdegoede@redhat.com>
References: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbcC2I3t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 04:29:49 -0400
In-Reply-To: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Add support for axis inversion / swapping using the new
touchscreen_parse_properties and touchscreen_apply_prop_to_x_y
functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e8825e5..864a7e0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -86,6 +86,7 @@ struct edt_reg_addr {
 struct edt_ft5x06_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct touchscreen_properties prop;
 	u16 num_x;
 	u16 num_y;
 
@@ -173,7 +174,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	struct device *dev = &tsdata->client->dev;
 	u8 cmd;
 	u8 rdbuf[63];
-	int i, type, x, y, id;
+	s16 x, y;
+	int i, type, id;
 	int offset, tplen, datalen, crclen;
 	int error;
 
@@ -246,6 +248,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		if (!down)
 			continue;
 
+		touchscreen_apply_prop_to_x_y(&tsdata->prop, &x, &y);
 		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
 		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
 	}
@@ -972,7 +975,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
-	touchscreen_parse_properties(input, true, NULL);
+	touchscreen_parse_properties(input, true, &tsdata->prop);
 
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
-- 
2.7.3

