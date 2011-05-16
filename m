From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 5/5] tsc2007: Add X, Y and Z fuzz factors to platform data.
Date: Mon, 16 May 2011 10:33:03 +0200
Message-ID: <1305534783-4917-5-git-send-email-thierry.reding@avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55033 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1EPIdJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 04:33:09 -0400
In-Reply-To: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>

These new platform-specific values can be used to set the fuzz parameter
passed to the input_set_abs_params() function for the ABS_X, ABS_Y and
ABS_PRESSURE axes.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    7 ++++---
 include/linux/i2c/tsc2007.h         |    3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index cdaf06f..8776999 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -316,9 +316,10 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
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
index c6361fb..003c8c8 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -6,6 +6,9 @@
 struct tsc2007_platform_data {
 	u16	model;				/* 2007. */
 	u16	x_plate_ohms;
+	int	fuzzx;				/* fuzz factor for X, Y and */
+	int	fuzzy;				/* pressure axes */
+	int	fuzzz;
 
 	int	(*get_pendown_state)(void);
 	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-- 
1.7.5.1

