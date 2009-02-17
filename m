From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] Input: wm97xx: add BTN_TOUCH event to wm97xx to use it with Android
Date: Tue, 17 Feb 2009 11:43:33 +0200
Message-ID: <1234863813-12211-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:47023 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZBQMIT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 07:08:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: linux-input@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Please CC me, I'm not subscribed to linux-input

Android expects BTN_TOUCH events when pen state changes. Add BTN_TOUCH
event reporting to allow use of wm97xx touchscreen controller wiht
Android devices.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
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

