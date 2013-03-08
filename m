From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 4/4] Input: wm9712: Fix dev_dbg newlines
Date: Fri,  8 Mar 2013 17:15:09 +0100
Message-ID: <1362759309-18782-5-git-send-email-mpa@pengutronix.de>
References: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55047 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933517Ab3CHQRl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Mar 2013 11:17:41 -0500
In-Reply-To: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

dev_dbg should end with a new line.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/input/touchscreen/wm9712.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index 3b4eed4..16b5211 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -162,14 +162,14 @@ static void wm9712_phy_init(struct wm97xx *wm)
 	if (rpu) {
 		dig2 &= 0xffc0;
 		dig2 |= WM9712_RPU(rpu);
-		dev_dbg(wm->dev, "setting pen detect pull-up to %d Ohms",
+		dev_dbg(wm->dev, "setting pen detect pull-up to %d Ohms\n",
 			64000 / rpu);
 	}
 
 	/* WM9712 five wire */
 	if (five_wire) {
 		dig2 |= WM9712_45W;
-		dev_dbg(wm->dev, "setting 5-wire touchscreen mode.");
+		dev_dbg(wm->dev, "setting 5-wire touchscreen mode.\n");
 
 		if (pil) {
 			dev_warn(wm->dev, "pressure measurement is not "
@@ -182,21 +182,21 @@ static void wm9712_phy_init(struct wm97xx *wm)
 	if (pil == 2) {
 		dig2 |= WM9712_PIL;
 		dev_dbg(wm->dev,
-			"setting pressure measurement current to 400uA.");
+			"setting pressure measurement current to 400uA.\n");
 	} else if (pil)
 		dev_dbg(wm->dev,
-			"setting pressure measurement current to 200uA.");
+			"setting pressure measurement current to 200uA.\n");
 	if (!pil)
 		pressure = 0;
 
 	/* polling mode sample settling delay */
 	if (delay < 0 || delay > 15) {
-		dev_dbg(wm->dev, "supplied delay out of range.");
+		dev_dbg(wm->dev, "supplied delay out of range.\n");
 		delay = 4;
 	}
 	dig1 &= 0xff0f;
 	dig1 |= WM97XX_DELAY(delay);
-	dev_dbg(wm->dev, "setting adc sample delay to %d u Secs.",
+	dev_dbg(wm->dev, "setting adc sample delay to %d u Secs.\n",
 		delay_table[delay]);
 
 	/* mask */
@@ -285,7 +285,7 @@ static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		if (is_pden(wm))
 			wm->pen_probably_down = 0;
 		else
-			dev_dbg(wm->dev, "adc sample timeout");
+			dev_dbg(wm->dev, "adc sample timeout\n");
 		return RC_PENUP;
 	}
 
@@ -295,7 +295,7 @@ static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 
 	/* check we have correct sample */
 	if ((*sample ^ adcsel) & WM97XX_ADCSEL_MASK) {
-		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x",
+		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x\n",
 			adcsel & WM97XX_ADCSEL_MASK,
 			*sample & WM97XX_ADCSEL_MASK);
 		return RC_AGAIN;
@@ -349,7 +349,7 @@ static int wm9712_poll_coord(struct wm97xx *wm, struct wm97xx_data *data)
 		if (is_pden(wm))
 			wm->pen_probably_down = 0;
 		else
-			dev_dbg(wm->dev, "adc sample timeout");
+			dev_dbg(wm->dev, "adc sample timeout\n");
 		return RC_PENUP;
 	}
 
-- 
1.8.1.4

