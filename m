From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 00:11:54 +0530
Message-ID: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35598 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcK1ScX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 13:32:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de, daniel.wagener@kernelconcepts.de, LW@KARO-electronics.de, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 703e295..379dd31 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -67,7 +67,7 @@
 #define EDT_SWITCH_MODE_RETRIES		10
 #define EDT_SWITCH_MODE_DELAY		5 /* msec */
 #define EDT_RAW_DATA_RETRIES		100
-#define EDT_RAW_DATA_DELAY		1 /* msec */
+#define EDT_RAW_DATA_DELAY		1000 /* usec */
 
 enum edt_ver {
 	M06,
@@ -664,7 +664,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 	}
 
 	do {
-		msleep(EDT_RAW_DATA_DELAY);
+		usleep_range(EDT_RAW_DATA_DELAY, EDT_RAW_DATA_DELAY + 100);
 		val = edt_ft5x06_register_read(tsdata, 0x08);
 		if (val < 1)
 			break;
-- 
2.6.2

