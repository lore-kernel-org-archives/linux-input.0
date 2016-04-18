From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 3/5] input: twl6040-vibra: fix NULL pointer dereference by removing workqueue
Date: Mon, 18 Apr 2016 21:55:39 +0200
Message-ID: <d07616ce9098dde03f2aa8b54368714313557e38.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

commit 21fb9f0d5e91 ("Input: twl6040-vibra - use system workqueue")

says that it switches to use the system workqueue but it did neither

- remove the workqueue struct variable
- replace code to really use the system workqueue

Instead it calls queue_work() on uninitialized info->workqueue.

The result is a NULL pointer dereference in vibra_play().

Solution: use schedule_work

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 1e9902d..3805129 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -45,7 +45,6 @@
 struct vibra_info {
 	struct device *dev;
 	struct input_dev *input_dev;
-	struct workqueue_struct *workqueue;
 	struct work_struct play_work;
 	struct mutex mutex;
 	int irq;
@@ -213,7 +212,7 @@ static int vibra_play(struct input_dev *input, void *data,
 	info->strong_speed = effect->u.rumble.strong_magnitude;
 	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
 
-	ret = queue_work(info->workqueue, &info->play_work);
+	ret = schedule_work(&info->play_work);
 	if (!ret) {
 		dev_info(&input->dev, "work is already on queue\n");
 		return ret;
-- 
2.7.3
