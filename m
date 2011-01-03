From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/32] input/tps6507x-ts: use system_wq instead of dedicated workqueue
Date: Mon,  3 Jan 2011 14:49:33 +0100
Message-ID: <1294062595-30097-11-git-send-email-tj@kernel.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294062595-30097-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Todd Fischer <todd.fischer@ridgerun.com>
List-Id: linux-input@vger.kernel.org

With cmwq, there's no reason to use a separate workqueue.  Drop
tps6507x_ts->wq and use system_wq instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>
---
Only compile tested.  Please feel free to take it into the subsystem
tree or simply ack - I'll route it through the wq tree.

Thanks.

 drivers/input/touchscreen/tps6507x-ts.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index c8c136c..4303149 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -43,7 +43,6 @@ struct tps6507x_ts {
 	struct input_dev	*input_dev;
 	struct device		*dev;
 	char			phys[32];
-	struct workqueue_struct *wq;
 	struct delayed_work	work;
 	unsigned		polling;	/* polling is active */
 	struct ts_event		tc;
@@ -220,8 +219,8 @@ done:
 	poll = 1;
 
 	if (poll) {
-		schd = queue_delayed_work(tsc->wq, &tsc->work,
-					  msecs_to_jiffies(tsc->poll_period));
+		schd = schedule_delayed_work(&tsc->work,
+					msecs_to_jiffies(tsc->poll_period));
 		if (schd)
 			tsc->polling = 1;
 		else {
@@ -303,7 +302,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	tsc->input_dev = input_dev;
 
 	INIT_DELAYED_WORK(&tsc->work, tps6507x_ts_handler);
-	tsc->wq = create_workqueue("TPS6507x Touchscreen");
 
 	if (init_data) {
 		tsc->poll_period = init_data->poll_period;
@@ -325,8 +323,8 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	if (error)
 		goto err2;
 
-	schd = queue_delayed_work(tsc->wq, &tsc->work,
-				  msecs_to_jiffies(tsc->poll_period));
+	schd = schedule_delayed_work(&tsc->work,
+				     msecs_to_jiffies(tsc->poll_period));
 
 	if (schd)
 		tsc->polling = 1;
@@ -341,7 +339,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 err2:
 	cancel_delayed_work_sync(&tsc->work);
-	destroy_workqueue(tsc->wq);
 	input_free_device(input_dev);
 err1:
 	kfree(tsc);
@@ -357,7 +354,6 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
 	struct input_dev *input_dev = tsc->input_dev;
 
 	cancel_delayed_work_sync(&tsc->work);
-	destroy_workqueue(tsc->wq);
 
 	input_unregister_device(input_dev);
 
-- 
1.7.1
