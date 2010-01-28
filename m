From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] input: Provide coordinate logs for accelerated WM97xx I/O
Date: Thu, 28 Jan 2010 14:32:20 +0000
Message-ID: <1264689140-10732-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56337 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752458Ab0A1OcX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2010 09:32:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

This aids debug of problematic systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/mainstone-wm97xx.c |    3 +++
 drivers/input/touchscreen/zylonite-wm97xx.c  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index 6cdcf2a..b6b8b1c 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -153,6 +153,9 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 		if (pressure)
 			p = MODR;
 
+		dev_dbg(wm->dev, "Raw coordinates: x=%x, y=%x, p=%x\n",
+			x, y, p);
+
 		/* are samples valid */
 		if ((x & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_X ||
 		    (y & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_Y ||
diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
index eca54db..0488498 100644
--- a/drivers/input/touchscreen/zylonite-wm97xx.c
+++ b/drivers/input/touchscreen/zylonite-wm97xx.c
@@ -118,6 +118,9 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 		if (pressure)
 			p = MODR;
 
+		dev_dbg(wm->dev, "Raw coordinates: x=%x, y=%x, p=%x\n",
+			x, y, p);
+
 		/* are samples valid */
 		if ((x & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_X ||
 		    (y & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_Y ||
-- 
1.6.6

