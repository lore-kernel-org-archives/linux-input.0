From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 4/4] touchscreen: pixcir_ts: Add support for axis inversion / swapping
Date: Tue, 29 Mar 2016 10:29:29 +0200
Message-ID: <1459240169-11531-5-git-send-email-hdegoede@redhat.com>
References: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41537 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbcC2I3v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 04:29:51 -0400
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
2.7.3

