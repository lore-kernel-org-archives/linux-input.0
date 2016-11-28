From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: touchscreen: zylonite_wm97xx - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 00:14:55 +0530
Message-ID: <1480358695-3024-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34963 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbcK1SfW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 13:35:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, pyro@f2s.com, zap@homelink.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/touchscreen/zylonite-wm97xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
index e2ccd68..cebd3a8 100644
--- a/drivers/input/touchscreen/zylonite-wm97xx.c
+++ b/drivers/input/touchscreen/zylonite-wm97xx.c
@@ -81,7 +81,7 @@ static void wm97xx_acc_pen_up(struct wm97xx *wm)
 {
 	int i;
 
-	msleep(1);
+	usleep_range(1000, 1100);
 
 	for (i = 0; i < 16; i++)
 		MODR;
@@ -98,7 +98,7 @@ static int wm97xx_acc_pen_down(struct wm97xx *wm)
 	 * for samples.  The controller can't have a suitably low
 	 * threshold set to use the notifications it gives.
 	 */
-	msleep(1);
+	usleep_range(1000, 1100);
 
 	if (tries > 5) {
 		tries = 0;
-- 
2.6.2

