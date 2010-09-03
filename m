From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: tps6507x-ts - call input_unregister_device instead
	of input_free_device in tps6507x_ts_remove
Date: Fri, 03 Sep 2010 09:08:07 +0800
Message-ID: <1283476087.5439.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 7286209..c8c136c 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -359,7 +359,7 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&tsc->work);
 	destroy_workqueue(tsc->wq);
 
-	input_free_device(input_dev);
+	input_unregister_device(input_dev);
 
 	tps6507x_dev->ts = NULL;
 	kfree(tsc);
-- 
1.7.2
