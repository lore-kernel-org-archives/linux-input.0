From: Dudley Du <dudl@cypress.com>
Subject: [PATCH] input: cyapa: fix update suspend scanrate set to max 1000 issue
Date: Mon, 20 Apr 2015 13:43:14 +0800
Message-ID: <1429508594-24255-1-git-send-email-dudl@cypress.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix update suspend scareate always set to max 1000 issue, the root cause is
the missed using max_t as min_t.
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 58f4f6f..efe1484 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -723,7 +723,7 @@ static ssize_t cyapa_update_suspend_scanrate(struct device *dev,
 	} else if (sysfs_streq(buf, OFF_MODE_NAME)) {
 		cyapa->suspend_power_mode = PWR_MODE_OFF;
 	} else if (!kstrtou16(buf, 10, &sleep_time)) {
-		cyapa->suspend_sleep_time = max_t(u16, sleep_time, 1000);
+		cyapa->suspend_sleep_time = min_t(u16, sleep_time, 1000);
 		cyapa->suspend_power_mode =
 			cyapa_sleep_time_to_pwr_cmd(cyapa->suspend_sleep_time);
 	} else {
@@ -840,7 +840,7 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
 	if (error)
 		return error;
 
-	cyapa->runtime_suspend_sleep_time = max_t(u16, time, 1000);
+	cyapa->runtime_suspend_sleep_time = min_t(u16, time, 1000);
 	cyapa->runtime_suspend_power_mode =
 		cyapa_sleep_time_to_pwr_cmd(cyapa->runtime_suspend_sleep_time);
 
-- 
1.9.1
