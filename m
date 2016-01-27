From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend 4/4] touchscreen: pixcir_ts: Add support for axis inversion / swapping
Date: Wed, 27 Jan 2016 19:25:24 +0100
Message-ID: <1453919124-3840-5-git-send-email-hdegoede@redhat.com>
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
Changes in v2:
-Add a fix which actually makes this patch compile, which accidentally ended
 up in a later commit in my tree
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index f58784d..0321be3 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -41,13 +41,14 @@ struct pixcir_i2c_ts_data {
 	struct gpio_desc *gpio_enable;
 	struct gpio_desc *gpio_wake;
 	const struct pixcir_i2c_chip_data *chip;
+	struct touchscreen_properties prop;
 	int max_fingers;	/* Max fingers supported in this instance */
 	bool running;
 };
 
 struct pixcir_touch {
-	int x;
-	int y;
+	s16 x;
+	s16 y;
 	int id;
 };
 
@@ -100,6 +101,9 @@ static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
 	for (i = 0; i < touch; i++) {
 		report->touches[i].x = (bufptr[1] << 8) | bufptr[0];
 		report->touches[i].y = (bufptr[3] << 8) | bufptr[2];
+		touchscreen_apply_prop_to_x_y(&tsdata->prop,
+					      &report->touches[i].x,
+					      &report->touches[i].y);
 
 		if (chip->has_hw_ids) {
 			report->touches[i].id = bufptr[4];
@@ -515,7 +519,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	} else {
 		input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
 		input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
-		touchscreen_parse_properties(input, true, NULL);
+		touchscreen_parse_properties(input, true, &tsdata->prop);
 		if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
 		    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
 			dev_err(dev, "Touchscreen size is not specified\n");
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
