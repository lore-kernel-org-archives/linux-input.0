From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH v2 5/5] tsc2007: Add X, Y and Z fuzz factors to platform data.
Date: Tue, 17 May 2011 10:56:12 +0200
Message-ID: <1305622572-3154-5-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58173 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1EQI4S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 04:56:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwangwoo.lee@gmail.com>

These new platform-specific values can be used to set the fuzz parameter
passed to the input_set_abs_params() function for the ABS_X, ABS_Y and
ABS_PRESSURE axes.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    7 ++++---
 include/linux/i2c/tsc2007.h         |    3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 87c40c7..fadc115 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -310,9 +310,10 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, pdata->fuzzx, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, pdata->fuzzy, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
+			pdata->fuzzz, 0);
 
 	if (pdata->init_platform_hw)
 		pdata->init_platform_hw();
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index a51dac0..591427a 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -10,6 +10,9 @@ struct tsc2007_platform_data {
 	unsigned long poll_delay; /* delay (in ms) after pen-down event
 				     before polling starts */
 	unsigned long poll_period; /* time (in ms) between samples */
+	int	fuzzx; /* fuzz factor for X, Y and pressure axes */
+	int	fuzzy;
+	int	fuzzz;
 
 	int	(*get_pendown_state)(void);
 	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-- 
1.7.5.1

