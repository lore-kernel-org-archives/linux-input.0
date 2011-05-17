From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH v2 2/5] tsc2007: Add max_rt parameter to platform data.
Date: Tue, 17 May 2011 10:56:09 +0200
Message-ID: <1305622572-3154-2-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:65484 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab1EQI4c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 04:56:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwangwoo.lee@gmail.com>

Finger touch events or very quick stylus events on low-quality panels
can cause the tsc2007 to read bogus values. Looking at oscilloscope
snapshots, this seems to be caused by the touch event disappearing
during the measurements. These bogus values result in misclicks, where
the X and Y values deviate from the real position.

Most of these misclicks can be filtered out by setting a low enough
threshold for the maximum resistance (which is loosely the inverse of
the pressure) allowed to consider a set of values valid. Since this
behaviour is largely dependent on the type and quality of the panel,
this commit introduces the max_rt parameter. The default value is kept
at MAX_12BIT.

Changes in v2:
  - Move max_rt parameter to platform data.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    4 +++-
 include/linux/i2c/tsc2007.h         |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index df4ae35..8c48a91 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -75,6 +75,7 @@ struct tsc2007 {
 
 	u16			model;
 	u16			x_plate_ohms;
+	u16			max_rt;
 
 	bool			pendown;
 	int			irq;
@@ -185,7 +186,7 @@ static void tsc2007_work(struct work_struct *work)
 	tsc2007_read_values(ts, &tc);
 
 	rt = tsc2007_calculate_pressure(ts, &tc);
-	if (rt > MAX_12BIT) {
+	if (rt > ts->max_rt) {
 		/*
 		 * Sample found inconsistent by debouncing or pressure is
 		 * beyond the maximum. Don't report it to user space,
@@ -294,6 +295,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
+	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
 
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index c6361fb..d95f113 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -6,6 +6,7 @@
 struct tsc2007_platform_data {
 	u16	model;				/* 2007. */
 	u16	x_plate_ohms;
+	u16	max_rt; /* max. resistance above which samples are ignored */
 
 	int	(*get_pendown_state)(void);
 	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-- 
1.7.5.1

