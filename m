From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] input: touchscreen: edt-ft5x06: Add support for softbuttons
Date: Sun, 31 Jul 2016 17:23:09 +0200
Message-ID: <1469978590-14081-4-git-send-email-hdegoede@redhat.com>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469978590-14081-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add support for softbuttons to the edt-ft5x06 driver.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 703e295..d19bf45 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -86,6 +86,7 @@ struct edt_reg_addr {
 struct edt_ft5x06_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct touchscreen_softbutton_info *buttons;
 	struct touchscreen_properties prop;
 	u16 num_x;
 	u16 num_y;
@@ -241,6 +242,9 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		id = (buf[2] >> 4) & 0x0f;
 		down = type != TOUCH_EVENT_UP;
 
+		if (touchscreen_handle_softbuttons(tsdata->buttons, x, y, down))
+			continue;
+
 		input_mt_slot(tsdata->input, id);
 		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
 
@@ -975,6 +979,10 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	touchscreen_parse_properties(input, true, &tsdata->prop);
 
+	tsdata->buttons = devm_touchscreen_alloc_softbuttons(input);
+	if (IS_ERR(tsdata->buttons))
+		return PTR_ERR(tsdata->buttons);
+
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
 	if (error) {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
