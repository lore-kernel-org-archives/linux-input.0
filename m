From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 1/3] input: touchscreen: wm97xx: remove redundant define
Date: Sun,  3 Jul 2011 19:09:28 +0200
Message-ID: <1309712970-5829-2-git-send-email-w.sang@pengutronix.de>
References: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58729 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1GCRI3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2011 13:08:29 -0400
In-Reply-To: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dp@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/atmel-wm97xx.c     |    2 +-
 drivers/input/touchscreen/mainstone-wm97xx.c |    6 +++---
 drivers/input/touchscreen/wm9713.c           |    4 ++--
 drivers/input/touchscreen/zylonite-wm97xx.c  |    6 +++---
 include/linux/wm97xx.h                       |    3 +--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
index fa8e56b..e0d2b08 100644
--- a/drivers/input/touchscreen/atmel-wm97xx.c
+++ b/drivers/input/touchscreen/atmel-wm97xx.c
@@ -164,7 +164,7 @@ static irqreturn_t atmel_wm97xx_channel_b_interrupt(int irq, void *dev_id)
 
 		data = ac97c_readl(atmel_wm97xx, CBRHR);
 		value = data & 0x0fff;
-		source = data & WM97XX_ADCSRC_MASK;
+		source = data & WM97XX_ADCSEL_MASK;
 		pen_down = (data & WM97XX_PEN_DOWN) >> 8;
 
 		if (source == WM97XX_ADCSEL_X)
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index 3242e70..e966c29 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -157,9 +157,9 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 			x, y, p);
 
 		/* are samples valid */
-		if ((x & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_X ||
-		    (y & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_Y ||
-		    (p & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_PRES)
+		if ((x & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_X ||
+		    (y & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_Y ||
+		    (p & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_PRES)
 			goto up;
 
 		/* coordinate is good */
diff --git a/drivers/input/touchscreen/wm9713.c b/drivers/input/touchscreen/wm9713.c
index 73ec995..13cd9d1 100644
--- a/drivers/input/touchscreen/wm9713.c
+++ b/drivers/input/touchscreen/wm9713.c
@@ -304,9 +304,9 @@ static int wm9713_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		wm->mach_ops->post_sample(adcsel);
 
 	/* check we have correct sample */
-	if ((*sample & WM97XX_ADCSRC_MASK) != ffs(adcsel >> 1) << 12) {
+	if ((*sample & WM97XX_ADCSEL_MASK) != ffs(adcsel >> 1) << 12) {
 		dev_dbg(wm->dev, "adc wrong sample, read %x got %x", adcsel,
-			*sample & WM97XX_ADCSRC_MASK);
+			*sample & WM97XX_ADCSEL_MASK);
 		return RC_PENUP;
 	}
 
diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
index 5b0f15e..f6328c0 100644
--- a/drivers/input/touchscreen/zylonite-wm97xx.c
+++ b/drivers/input/touchscreen/zylonite-wm97xx.c
@@ -122,9 +122,9 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 			x, y, p);
 
 		/* are samples valid */
-		if ((x & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_X ||
-		    (y & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_Y ||
-		    (p & WM97XX_ADCSRC_MASK) != WM97XX_ADCSEL_PRES)
+		if ((x & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_X ||
+		    (y & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_Y ||
+		    (p & WM97XX_ADCSEL_MASK) != WM97XX_ADCSEL_PRES)
 			goto up;
 
 		/* coordinate is good */
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 38e8c4d..10b9e61 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -38,7 +38,7 @@
 #define WM97XX_ADCSEL_X		0x1000	/* x coord measurement */
 #define WM97XX_ADCSEL_Y		0x2000	/* y coord measurement */
 #define WM97XX_ADCSEL_PRES	0x3000	/* pressure measurement */
-#define WM97XX_ADCSEL_MASK	0x7000
+#define WM97XX_ADCSEL_MASK	0x7000	/* ADC selection mask */
 #define WM97XX_COO		0x0800	/* enable coordinate mode */
 #define WM97XX_CTC		0x0400	/* enable continuous mode */
 #define WM97XX_CM_RATE_93	0x0000	/* 93.75Hz continuous rate */
@@ -61,7 +61,6 @@
 #define WM97XX_PRP_DET_DIG	0xc000	/* setect on, digitise on */
 #define WM97XX_RPR		0x2000	/* wake up on pen down */
 #define WM97XX_PEN_DOWN		0x8000	/* pen is down */
-#define WM97XX_ADCSRC_MASK	0x7000	/* ADC source mask */
 
 #define WM97XX_AUX_ID1		0x8001
 #define WM97XX_AUX_ID2		0x8002
-- 
1.7.2.5

