From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 1/5] tsc2007: Debounce pressure measurement.
Date: Mon, 16 May 2011 10:32:59 +0200
Message-ID: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57431 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1EPIdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 04:33:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>

When the controller signals a pen-down event via the platform-specific
GPIO, while the sample values indicate an invalid measurement, the
measurement needs to be repeated.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 80467f2..df4ae35 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -156,6 +156,7 @@ static void tsc2007_work(struct work_struct *work)
 {
 	struct tsc2007 *ts =
 		container_of(to_delayed_work(work), struct tsc2007, work);
+	bool debounced = false;
 	struct ts_event tc;
 	u32 rt;
 
@@ -191,6 +192,7 @@ static void tsc2007_work(struct work_struct *work)
 		 * repeat at least once more the measurement.
 		 */
 		dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
+		debounced = true;
 		goto out;
 
 	}
@@ -225,7 +227,7 @@ static void tsc2007_work(struct work_struct *work)
 	}
 
  out:
-	if (ts->pendown)
+	if (ts->pendown || debounced)
 		schedule_delayed_work(&ts->work,
 				      msecs_to_jiffies(TS_POLL_PERIOD));
 	else
-- 
1.7.5.1

