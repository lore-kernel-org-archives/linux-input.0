From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] Input: wm831x-ts - Move BTN_TOUCH reporting to data transfer
Date: Tue, 19 Apr 2011 19:17:54 +0100
Message-ID: <1303237074-12878-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43454 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753445Ab1DSSRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 14:17:48 -0400
In-Reply-To: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

Don't report BTN_TOUCH until we've got data as some less robust applications
can be confused by getting a touch event by itself and it doesn't seem
unreasonable for them to expect coordinates along with a touch.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 78e8705..9175d49 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -148,6 +148,8 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
 		input_report_key(wm831x_ts->input_dev, BTN_TOUCH, 0);
 
 		schedule_work(&wm831x_ts->pd_data_work);
+	} else {
+		input_report_key(wm831x_ts->input_dev, BTN_TOUCH, 1);
 	}
 
 	input_sync(wm831x_ts->input_dev);
@@ -174,9 +176,6 @@ static irqreturn_t wm831x_ts_pen_down_irq(int irq, void *irq_data)
 			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA | WM831X_TCH_Z_ENA,
 			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA | ena);
 
-	input_report_key(wm831x_ts->input_dev, BTN_TOUCH, 1);
-	input_sync(wm831x_ts->input_dev);
-
 	wm831x_set_bits(wm831x, WM831X_INTERRUPT_STATUS_1,
 			WM831X_TCHPD_EINT, WM831X_TCHPD_EINT);
 
-- 
1.7.4.1

