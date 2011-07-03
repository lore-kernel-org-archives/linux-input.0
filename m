From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 3/3] input: touchscreen: wm97xx: mark channels which need pen_down
Date: Sun,  3 Jul 2011 19:09:30 +0200
Message-ID: <1309712970-5829-4-git-send-email-w.sang@pengutronix.de>
References: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1GCRIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2011 13:08:30 -0400
In-Reply-To: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dp@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>

Currently, battery drivers also use poll_sample() provided by the
wm97xx-core but this code always checks if the pen is down. Mark the
channels which really need this (i.e. for the touchscreen) with the
PEN_DOWN bit, and skip the checks otherwise. Now, the battery channels
can always be read.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm9705.c |   11 ++++++-----
 drivers/input/touchscreen/wm9712.c |   13 ++++++++-----
 drivers/input/touchscreen/wm9713.c |   11 ++++++-----
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/wm9705.c b/drivers/input/touchscreen/wm9705.c
index 363d61d..adc13a5 100644
--- a/drivers/input/touchscreen/wm9705.c
+++ b/drivers/input/touchscreen/wm9705.c
@@ -215,8 +215,9 @@ static inline int is_pden(struct wm97xx *wm)
 static int wm9705_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 {
 	int timeout = 5 * delay;
+	bool wants_pen = adcsel & WM97XX_PEN_DOWN;
 
-	if (!wm->pen_probably_down) {
+	if (wants_pen && !wm->pen_probably_down) {
 		u16 data = wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER_RD);
 		if (!(data & WM97XX_PEN_DOWN))
 			return RC_PENUP;
@@ -260,7 +261,7 @@ static int wm9705_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		return RC_PENUP;
 	}
 
-	if (!(*sample & WM97XX_PEN_DOWN)) {
+	if (wants_pen && !(*sample & WM97XX_PEN_DOWN)) {
 		wm->pen_probably_down = 0;
 		return RC_PENUP;
 	}
@@ -275,14 +276,14 @@ static int wm9705_poll_touch(struct wm97xx *wm, struct wm97xx_data *data)
 {
 	int rc;
 
-	rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_X, &data->x);
+	rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_X | WM97XX_PEN_DOWN, &data->x);
 	if (rc != RC_VALID)
 		return rc;
-	rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_Y, &data->y);
+	rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_Y | WM97XX_PEN_DOWN, &data->y);
 	if (rc != RC_VALID)
 		return rc;
 	if (pil) {
-		rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_PRES, &data->p);
+		rc = wm9705_poll_sample(wm, WM97XX_ADCSEL_PRES | WM97XX_PEN_DOWN, &data->p);
 		if (rc != RC_VALID)
 			return rc;
 	} else
diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index d26093f..6e743e3 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -255,8 +255,9 @@ static inline int is_pden(struct wm97xx *wm)
 static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 {
 	int timeout = 5 * delay;
+	bool wants_pen = adcsel & WM97XX_PEN_DOWN;
 
-	if (!wm->pen_probably_down) {
+	if (wants_pen && !wm->pen_probably_down) {
 		u16 data = wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER_RD);
 		if (!(data & WM97XX_PEN_DOWN))
 			return RC_PENUP;
@@ -300,7 +301,7 @@ static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		return RC_PENUP;
 	}
 
-	if (!(*sample & WM97XX_PEN_DOWN)) {
+	if (wants_pen && !(*sample & WM97XX_PEN_DOWN)) {
 		wm->pen_probably_down = 0;
 		return RC_PENUP;
 	}
@@ -385,16 +386,18 @@ static int wm9712_poll_touch(struct wm97xx *wm, struct wm97xx_data *data)
 		if (rc != RC_VALID)
 			return rc;
 	} else {
-		rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_X, &data->x);
+		rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_X | WM97XX_PEN_DOWN,
+					&data->x);
 		if (rc != RC_VALID)
 			return rc;
 
-		rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_Y, &data->y);
+		rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_Y | WM97XX_PEN_DOWN,
+					&data->y);
 		if (rc != RC_VALID)
 			return rc;
 
 		if (pil && !five_wire) {
-			rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_PRES,
+			rc = wm9712_poll_sample(wm, WM97XX_ADCSEL_PRES | WM97XX_PEN_DOWN,
 						&data->p);
 			if (rc != RC_VALID)
 				return rc;
diff --git a/drivers/input/touchscreen/wm9713.c b/drivers/input/touchscreen/wm9713.c
index a755801..7405353 100644
--- a/drivers/input/touchscreen/wm9713.c
+++ b/drivers/input/touchscreen/wm9713.c
@@ -261,8 +261,9 @@ static int wm9713_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 {
 	u16 dig1;
 	int timeout = 5 * delay;
+	bool wants_pen = adcsel & WM97XX_PEN_DOWN;
 
-	if (!wm->pen_probably_down) {
+	if (wants_pen && !wm->pen_probably_down) {
 		u16 data = wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER_RD);
 		if (!(data & WM97XX_PEN_DOWN))
 			return RC_PENUP;
@@ -310,7 +311,7 @@ static int wm9713_poll_sample(struct wm97xx *wm, int adcsel, int *sample)
 		return RC_PENUP;
 	}
 
-	if (!(*sample & WM97XX_PEN_DOWN)) {
+	if (wants_pen && !(*sample & WM97XX_PEN_DOWN)) {
 		wm->pen_probably_down = 0;
 		return RC_PENUP;
 	}
@@ -400,14 +401,14 @@ static int wm9713_poll_touch(struct wm97xx *wm, struct wm97xx_data *data)
 		if (rc != RC_VALID)
 			return rc;
 	} else {
-		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_X, &data->x);
+		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_X | WM97XX_PEN_DOWN, &data->x);
 		if (rc != RC_VALID)
 			return rc;
-		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_Y, &data->y);
+		rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_Y | WM97XX_PEN_DOWN, &data->y);
 		if (rc != RC_VALID)
 			return rc;
 		if (pil) {
-			rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_PRES,
+			rc = wm9713_poll_sample(wm, WM97XX_ADCSEL_PRES | WM97XX_PEN_DOWN,
 						&data->p);
 			if (rc != RC_VALID)
 				return rc;
-- 
1.7.2.5

