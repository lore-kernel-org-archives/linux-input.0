From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-ts - Default pressure measurements on
Date: Wed,  9 Mar 2011 13:58:32 +0000
Message-ID: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60452 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932208Ab1CIN6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 08:58:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

tslib expects pressure measurements so enable them by default for better
compatibility.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 3c397c8..560200d 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -259,7 +259,10 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
 	else
 		wm831x_ts->pd_irq = platform_get_irq_byname(pdev, "TCHPD");
 
-	wm831x_ts->pressure = pdata && pdata->pressure;
+	if (pdata)
+		wm831x_ts->pressure = pdata->pressure;
+	else
+		wm831x_ts->pressure = true;
 
 	/* Five wire touchscreens can't report pressure */
 	if (pdata && pdata->fivewire) {
-- 
1.7.4.1

