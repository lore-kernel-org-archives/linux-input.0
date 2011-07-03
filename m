From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 2/3] input: touchscreen: wm97xx: refactor channel selection in poll_sample()
Date: Sun,  3 Jul 2011 19:09:29 +0200
Message-ID: <1309712970-5829-3-git-send-email-w.sang@pengutronix.de>
References: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58731 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab1GCRIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2011 13:08:30 -0400
In-Reply-To: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dp@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>

The current implementation of poll_sample() has the problem that one of
its arguments, the channel to be selected, differs from wm9713 to other
variants. This parameter gets passed to the (currently unused)
mach-specific functions pre_sample() and post_sample() which thus have
to deal with codec-specific differences. Refactor the routine so that
the argument to poll_sample() is generic for all codecs and do necessary
conversions only in the codec-specific driver. The outcome even uses
less code and removes the non-standard use of the PEN_DOWN bit to mark
the AUX-channels.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm9705.c |   14 ++++++--------
 drivers/input/touchscreen/wm9712.c |   14 ++++++--------
 drivers/input/touchscreen/wm9713.c |   18 +++++++++---------
 include/linux/wm97xx.h             |   10 ++++------
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/wm9705.c b/drivers/input/touchscreen/wm9705.c
index 98e6117..363d61d 100644
--- a/drivers/input/touchscreen/wm9705.c
+++ b/drivers/input/touchscreen/wm9705.c
@@ -224,13 +224,10 @@ static int wm9705_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 	}
 
 	/* set up digitiser */
-	if (adcsel & 0x8000)
-		adcsel = ((adcsel & 0x7fff) + 3) << 12;
-
 	if (wm->mach_ops && wm->mach_ops->pre_sample)
 		wm->mach_ops->pre_sample(adcsel);
-	wm97xx_reg_write(wm, AC97_WM97XX_DIGITISER1,
-			 adcsel | WM97XX_POLL | WM97XX_DELAY(delay));
+	wm97xx_reg_write(wm, AC97_WM97XX_DIGITISER1, (adcsel & WM97XX_ADCSEL_MASK)
+				| WM97XX_POLL | WM97XX_DELAY(delay));
 
 	/* wait 3 AC97 time slots + delay for conversion */
 	poll_delay(delay);
@@ -256,9 +253,10 @@ static int wm9705_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		wm->mach_ops->post_sample(adcsel);
 
 	/* check we have correct sample */
-	if ((*sample & WM97XX_ADCSEL_MASK) != adcsel) {
-		dev_dbg(wm->dev, "adc wrong sample, read %x got %x", adcsel,
-		*sample & WM97XX_ADCSEL_MASK);
+	if ((*sample ^ adcsel) & WM97XX_ADCSEL_MASK) {
+		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x",
+			adcsel & WM97XX_ADCSEL_MASK,
+			*sample & WM97XX_ADCSEL_MASK);
 		return RC_PENUP;
 	}
 
diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index 2bc2fb8..d26093f 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -264,13 +264,10 @@ static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 	}
 
 	/* set up digitiser */
-	if (adcsel & 0x8000)
-		adcsel = ((adcsel & 0x7fff) + 3) << 12;
-
 	if (wm->mach_ops && wm->mach_ops->pre_sample)
 		wm->mach_ops->pre_sample(adcsel);
-	wm97xx_reg_write(wm, AC97_WM97XX_DIGITISER1,
-			 adcsel | WM97XX_POLL | WM97XX_DELAY(delay));
+	wm97xx_reg_write(wm, AC97_WM97XX_DIGITISER1, (adcsel & WM97XX_ADCSEL_MASK)
+				| WM97XX_POLL | WM97XX_DELAY(delay));
 
 	/* wait 3 AC97 time slots + delay for conversion */
 	poll_delay(delay);
@@ -296,9 +293,10 @@ static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		wm->mach_ops->post_sample(adcsel);
 
 	/* check we have correct sample */
-	if ((*sample & WM97XX_ADCSEL_MASK) != adcsel) {
-		dev_dbg(wm->dev, "adc wrong sample, read %x got %x", adcsel,
-		*sample & WM97XX_ADCSEL_MASK);
+	if ((*sample ^ adcsel) & WM97XX_ADCSEL_MASK) {
+		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x",
+			adcsel & WM97XX_ADCSEL_MASK,
+			*sample & WM97XX_ADCSEL_MASK);
 		return RC_PENUP;
 	}
 
diff --git a/drivers/input/touchscreen/wm9713.c b/drivers/input/touchscreen/wm9713.c
index 13cd9d1..a755801 100644
--- a/drivers/input/touchscreen/wm9713.c
+++ b/drivers/input/touchscreen/wm9713.c
@@ -270,15 +270,14 @@ static int wm9713_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 	}
 
 	/* set up digitiser */
-	if (adcsel & 0x8000)
-		adcsel = 1 << ((adcsel & 0x7fff) + 3);
-
 	dig1 = wm97xx_reg_read(wm, AC97_WM9713_DIG1);
 	dig1 &= ~WM9713_ADCSEL_MASK;
+	/* WM97XX_ADCSEL_* channels need to be converted to WM9713 format */
+	dig1 |= 1 << ((adcsel & WM97XX_ADCSEL_MASK) >> 12);
 
 	if (wm->mach_ops && wm->mach_ops->pre_sample)
 		wm->mach_ops->pre_sample(adcsel);
-	wm97xx_reg_write(wm, AC97_WM9713_DIG1, dig1 | adcsel | WM9713_POLL);
+	wm97xx_reg_write(wm, AC97_WM9713_DIG1, dig1 | WM9713_POLL);
 
 	/* wait 3 AC97 time slots + delay for conversion */
 	poll_delay(delay);
@@ -304,8 +303,9 @@ static int wm9713_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		wm->mach_ops->post_sample(adcsel);
 
 	/* check we have correct sample */
-	if ((*sample & WM97XX_ADCSEL_MASK) != ffs(adcsel >> 1) << 12) {
-		dev_dbg(wm->dev, "adc wrong sample, read %x got %x", adcsel,
+	if ((*sample ^ adcsel) & WM97XX_ADCSEL_MASK) {
+		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x",
+			adcsel & WM97XX_ADCSEL_MASK,
 			*sample & WM97XX_ADCSEL_MASK);
 		return RC_PENUP;
 	}
@@ -400,14 +400,14 @@ static int wm9713_poll_touch(struct wm97xx *wm, struct wm97xx_data *data)
 		if (rc != RC_VALID)
 			return rc;
 	} else {
-		rc = wm9713_poll_sample(wm, WM9713_ADCSEL_X, &data->x);
+		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_X, &data->x);
 		if (rc != RC_VALID)
 			return rc;
-		rc = wm9713_poll_sample(wm, WM9713_ADCSEL_Y, &data->y);
+		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_Y, &data->y);
 		if (rc != RC_VALID)
 			return rc;
 		if (pil) {
-			rc = wm9713_poll_sample(wm, WM9713_ADCSEL_PRES,
+			rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_PRES,
 						&data->p);
 			if (rc != RC_VALID)
 				return rc;
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 10b9e61..fd98bb9 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -38,6 +38,10 @@
 #define WM97XX_ADCSEL_X		0x1000	/* x coord measurement */
 #define WM97XX_ADCSEL_Y		0x2000	/* y coord measurement */
 #define WM97XX_ADCSEL_PRES	0x3000	/* pressure measurement */
+#define WM97XX_AUX_ID1		0x4000
+#define WM97XX_AUX_ID2		0x5000
+#define WM97XX_AUX_ID3		0x6000
+#define WM97XX_AUX_ID4		0x7000
 #define WM97XX_ADCSEL_MASK	0x7000	/* ADC selection mask */
 #define WM97XX_COO		0x0800	/* enable coordinate mode */
 #define WM97XX_CTC		0x0400	/* enable continuous mode */
@@ -62,12 +66,6 @@
 #define WM97XX_RPR		0x2000	/* wake up on pen down */
 #define WM97XX_PEN_DOWN		0x8000	/* pen is down */
 
-#define WM97XX_AUX_ID1		0x8001
-#define WM97XX_AUX_ID2		0x8002
-#define WM97XX_AUX_ID3		0x8003
-#define WM97XX_AUX_ID4		0x8004
-
-
 /* WM9712 Bits */
 #define WM9712_45W		0x1000	/* set for 5-wire touchscreen */
 #define WM9712_PDEN		0x0800	/* measure only when pen down */
-- 
1.7.2.5

