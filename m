From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] INPUT: tps6507x-ts, remove unneeded NULL test
Date: Tue, 22 Jun 2010 13:41:02 +0200
Message-ID: <1277206862-27146-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, jirislaby@gmail.com, Jiri Slaby <jslaby@suse.cz>, Todd Fischer <todd.fischer@ridgerun.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Stanse found that tsc is dereferenced earlier than checked for being
NULL in tps6507x_ts_remove. Remove the test because I see no way, how
tsc can be NULL there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/tps6507x-ts.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 5b70a14..a644d18 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -355,9 +355,6 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
 	struct tps6507x_ts *tsc = tps6507x_dev->ts;
 	struct input_dev *input_dev = tsc->input_dev;
 
-	if (!tsc)
-		return 0;
-
 	cancel_delayed_work_sync(&tsc->work);
 	destroy_workqueue(tsc->wq);
 
-- 
1.7.1
