From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/4] input: twl6040-vibra: remove mutex
Date: Thu, 21 Apr 2016 13:43:48 +0200
Message-ID: <ed892994166c2cdc051b636e39dca648df8d326d.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

The mutex does not seem to be needed. twl4030-vibra doesn't
use one either.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index ad15498..f7e0d17 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -46,7 +46,7 @@ struct vibra_info {
 	struct device *dev;
 	struct input_dev *input_dev;
 	struct work_struct play_work;
-	struct mutex mutex;
+
 	int irq;
 
 	bool enabled;
@@ -182,8 +182,6 @@ static void vibra_play_work(struct work_struct *work)
 	struct vibra_info *info = container_of(work,
 				struct vibra_info, play_work);
 
-	mutex_lock(&info->mutex);
-
 	if (info->weak_speed || info->strong_speed) {
 		if (!info->enabled)
 			twl6040_vibra_enable(info);
@@ -192,7 +190,6 @@ static void vibra_play_work(struct work_struct *work)
 	} else if (info->enabled)
 		twl6040_vibra_disable(info);
 
-	mutex_unlock(&info->mutex);
 }
 
 static int vibra_play(struct input_dev *input, void *data,
@@ -223,12 +220,8 @@ static void twl6040_vibra_close(struct input_dev *input)
 
 	cancel_work_sync(&info->play_work);
 
-	mutex_lock(&info->mutex);
-
 	if (info->enabled)
 		twl6040_vibra_disable(info);
-
-	mutex_unlock(&info->mutex);
 }
 
 static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
@@ -236,13 +229,11 @@ static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
-	mutex_lock(&info->mutex);
+	cancel_work_sync(&info->play_work);
 
 	if (info->enabled)
 		twl6040_vibra_disable(info);
 
-	mutex_unlock(&info->mutex);
-
 	return 0;
 }
 
@@ -301,8 +292,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	mutex_init(&info->mutex);
-
 	error = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
 					  twl6040_vib_irq_handler,
 					  IRQF_ONESHOT,
-- 
2.7.3
