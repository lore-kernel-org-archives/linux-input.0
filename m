From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] Input: wm831x-ts - Ensure the controller is in a known state on open
Date: Mon, 14 Mar 2011 22:45:00 +0000
Message-ID: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35946 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756698Ab1CNWoq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 18:44:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

Explicitly set all the enable bits when opening the device just in case
something left the device in an unexpected state.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 3db0c29..6ae054f 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -167,7 +167,9 @@ static int wm831x_ts_input_open(struct input_dev *idev)
 	struct wm831x *wm831x = wm831x_ts->wm831x;
 
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
-			WM831X_TCH_ENA, WM831X_TCH_ENA);
+			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
+			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
+			WM831X_TCH_Z_ENA, WM831X_TCH_ENA);
 
 	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
 			WM831X_TCH_CVT_ENA, WM831X_TCH_CVT_ENA);
-- 
1.7.4.1

