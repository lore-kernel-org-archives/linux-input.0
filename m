From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH RESEND] Input: wm97xx: add BTN_TOUCH event to wm97xx to use
 it with Android
Date: Mon, 02 Mar 2009 16:12:08 +0200
Message-ID: <49ABE938.8040502@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:57545 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZCBOMO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 09:12:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input <linux-input@vger.kernel.org>

Android expects BTN_TOUCH events when pen state changes. Add BTN_TOUCH
event reporting to allow use of wm97xx touchscreen controller with
Android devices.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
 drivers/input/touchscreen/wm97xx-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index d15aa11..4551f88 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -409,6 +409,7 @@ static int wm97xx_read_samples(struct wm97xx *wm)
 			wm->pen_is_down = 0;
 			dev_dbg(wm->dev, "pen up\n");
 			input_report_abs(wm->input_dev, ABS_PRESSURE, 0);
+			input_report_key(wm->input_dev, BTN_TOUCH, 0);
 			input_sync(wm->input_dev);
 		} else if (!(rc & RC_AGAIN)) {
 			/* We need high frequency updates only while
@@ -433,6 +434,7 @@ static int wm97xx_read_samples(struct wm97xx *wm)
 		input_report_abs(wm->input_dev, ABS_X, data.x & 0xfff);
 		input_report_abs(wm->input_dev, ABS_Y, data.y & 0xfff);
 		input_report_abs(wm->input_dev, ABS_PRESSURE, data.p & 0xfff);
+		input_report_key(wm->input_dev, BTN_TOUCH, 1);
 		input_sync(wm->input_dev);
 		wm->pen_is_down = 1;
 		wm->ts_reader_interval = wm->ts_reader_min_interval;
@@ -629,9 +631,11 @@ static int wm97xx_probe(struct device *dev)
 	wm->input_dev->open = wm97xx_ts_input_open;
 	wm->input_dev->close = wm97xx_ts_input_close;
 	set_bit(EV_ABS, wm->input_dev->evbit);
+	set_bit(EV_KEY, wm->input_dev->evbit);
 	set_bit(ABS_X, wm->input_dev->absbit);
 	set_bit(ABS_Y, wm->input_dev->absbit);
 	set_bit(ABS_PRESSURE, wm->input_dev->absbit);
+	set_bit(BTN_TOUCH, wm->input_dev->keybit);
 	input_set_abs_params(wm->input_dev, ABS_X, abs_x[0], abs_x[1],
 			     abs_x[2], 0);
 	input_set_abs_params(wm->input_dev, ABS_Y, abs_y[0], abs_y[1],
-- 
1.5.6.4


-- 
Sincerely yours,
Mike.

