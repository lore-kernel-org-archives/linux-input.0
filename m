From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] Input: cyttsp4_core: Delete an unnecessary return
 statement in three functions
Date: Sun, 21 Jan 2018 21:29:20 +0100
Message-ID: <fd2239f0-ec16-ee88-5418-a7ae3efa1e21@users.sourceforge.net>
References: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ferruh Yigit <fery@cypress.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 21:13:21 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/cyttsp4_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index f0bf3cc20e9d..35f48b66ff36 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -956,8 +956,6 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	cyttsp4_final_sync(md->input, si->si_ofs.tch_abs[CY_TCH_T].max, ids);
 
 	md->num_prv_tch = num_cur_tch;
-
-	return;
 }
 
 /* read xy_data for all current touches */
@@ -1272,8 +1270,6 @@ static void cyttsp4_watchdog_timer(struct timer_list *t)
 	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
 
 	schedule_work(&cd->watchdog_work);
-
-	return;
 }
 
 static int cyttsp4_request_exclusive(struct cyttsp4 *cd, void *ownptr,
@@ -1492,7 +1488,6 @@ static void cyttsp4_watchdog_work(struct work_struct *work)
 	cyttsp4_start_wd_timer(cd);
 cyttsp4_timer_watchdog_exit_error:
 	mutex_unlock(&cd->system_lock);
-	return;
 }
 
 static int cyttsp4_core_sleep_(struct cyttsp4 *cd)
-- 
2.16.0
