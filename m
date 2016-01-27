From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend 2/4] touchscreen: ft5x06: Add support for axis inversion / swapping
Date: Wed, 27 Jan 2016 19:25:22 +0100
Message-ID: <1453919124-3840-3-git-send-email-hdegoede@redhat.com>
References: <1453919124-3840-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453919124-3840-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add support for axis inversion / swapping using the new
touchscreen_parse_properties and touchscreen_apply_prop_to_x_y
functionality.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index a97b54a..6fe8d51 100644
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
@@ -966,7 +969,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
-	touchscreen_parse_properties(input, true, NULL);
+	touchscreen_parse_properties(input, true, &tsdata->prop);
 
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
