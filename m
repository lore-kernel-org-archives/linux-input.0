From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 2/5] tsc2007: Add max_rt module parameter.
Date: Mon, 16 May 2011 10:33:00 +0200
Message-ID: <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58189 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab1EPIdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 04:33:07 -0400
In-Reply-To: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>

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

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index df4ae35..95d619c 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -83,6 +83,10 @@ struct tsc2007 {
 	void			(*clear_penirq)(void);
 };
 
+static int max_rt = MAX_12BIT;
+module_param(max_rt, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(max_rt, "Maximum resistance above which samples are ignored");
+
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
 {
 	s32 data;
@@ -185,7 +189,7 @@ static void tsc2007_work(struct work_struct *work)
 	tsc2007_read_values(ts, &tc);
 
 	rt = tsc2007_calculate_pressure(ts, &tc);
-	if (rt > MAX_12BIT) {
+	if (rt > max_rt) {
 		/*
 		 * Sample found inconsistent by debouncing or pressure is
 		 * beyond the maximum. Don't report it to user space,
-- 
1.7.5.1

