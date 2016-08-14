From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 2/3] Input: touchscreen: mc13783_ts:  Remove deprecated
 create_singletheread_workqueue
Date: Sun, 14 Aug 2016 10:55:30 +0530
Message-ID: <0fec13b74998216009d338fad3e143a3488e0b4a.1471151622.git.bhaktipriya96@gmail.com>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The workqueue "workqueue" has a single workitem(&priv->work) and hence
doesn't require ordering. Also, it is not being used on a memory reclaim
path. Hence, the singlethreaded workqueue has been replaced with the use
of system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Workitem is sync cancelled in mc13783_ts_remove() to ensure that there
are no workitems pending when the driver is disconnected.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/input/touchscreen/mc13783_ts.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 913e25a..3b19035 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -37,7 +37,6 @@ struct mc13783_ts_priv {
 	struct input_dev *idev;
 	struct mc13xxx *mc13xxx;
 	struct delayed_work work;
-	struct workqueue_struct *workq;
 	unsigned int sample[4];
 	struct mc13xxx_ts_platform_data *touch;
 };
@@ -54,7 +53,7 @@ static irqreturn_t mc13783_ts_handler(int irq, void *data)
 	 * be rescheduled for immediate execution here. However the rearm
 	 * delay is HZ / 50 which is acceptable.
 	 */
-	queue_delayed_work(priv->workq, &priv->work, 0);
+	schedule_delayed_work(&priv->work, 0);

 	return IRQ_HANDLED;
 }
@@ -106,7 +105,7 @@ static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)

 			dev_dbg(&idev->dev, "report (%d, %d, %d)\n",
 					x1, y1, 0x1000 - cr0);
-			queue_delayed_work(priv->workq, &priv->work, HZ / 50);
+			schedule_delayed_work(&priv->work, HZ / 50);
 		} else
 			dev_dbg(&idev->dev, "report release\n");

@@ -189,14 +188,6 @@ static int __init mc13783_ts_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}

-	/*
-	 * We need separate workqueue because mc13783_adc_do_conversion
-	 * uses keventd and thus would deadlock.
-	 */
-	priv->workq = create_singlethread_workqueue("mc13783_ts");
-	if (!priv->workq)
-		goto err_free_mem;
-
 	idev->name = MC13783_TS_NAME;
 	idev->dev.parent = &pdev->dev;

@@ -215,14 +206,12 @@ static int __init mc13783_ts_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"register input device failed with %d\n", ret);
-		goto err_destroy_wq;
+		goto err_free_mem;
 	}

 	platform_set_drvdata(pdev, priv);
 	return 0;

-err_destroy_wq:
-	destroy_workqueue(priv->workq);
 err_free_mem:
 	input_free_device(idev);
 	kfree(priv);
@@ -233,7 +222,7 @@ static int mc13783_ts_remove(struct platform_device *pdev)
 {
 	struct mc13783_ts_priv *priv = platform_get_drvdata(pdev);

-	destroy_workqueue(priv->workq);
+	cancel_delayed_work_sync(&priv->work);
 	input_unregister_device(priv->idev);
 	kfree(priv);

--
2.1.4
