From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: touchscreen: ads7846 - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 00:10:14 +0530
Message-ID: <1480358414-2820-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: imre.deak@nokia.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1ce3ecb..b1a5a6c 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -58,7 +58,7 @@
  * files.
  */
 
-#define TS_POLL_DELAY	1	/* ms delay before the first sample */
+#define TS_POLL_DELAY	1000	/* us delay before the first sample */
 #define TS_POLL_PERIOD	5	/* ms delay between samples */
 
 /* this driver doesn't aim at the peak continuous sample rate */
@@ -857,7 +857,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 	struct ads7846 *ts = handle;
 
 	/* Start with a small delay before checking pendown state */
-	msleep(TS_POLL_DELAY);
+	usleep_range(TS_POLL_DELAY, TS_POLL_DELAY + 100);
 
 	while (!ts->stopped && get_pendown_state(ts)) {
 
-- 
2.6.2
