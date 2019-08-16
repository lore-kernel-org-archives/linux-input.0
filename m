From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 55/63] Input: atmel_mxt_ts: Use msecs_to_jiffies() instead of HZ
Date: Fri, 16 Aug 2019 17:38:22 +0900
Message-ID: <20190816083830.19553-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

Replace HZ / 10 with msecs_to_jiffies(100) in the
schedule_delayed_work() calls in mxt_fw_work() and
mxt_check_bootloader() because it is cleaner.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 35d92751e49f..40263ef79e8e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -842,7 +842,7 @@ static int mxt_check_bootloader(struct mxt_data *data)
 	f->previous = state;
 
 	/* Poll after 0.1s if no interrupt received */
-	schedule_delayed_work(&f->work, HZ / 10);
+	schedule_delayed_work(&f->work, msecs_to_jiffies(100));
 
 	return 0;
 
@@ -3773,7 +3773,7 @@ static int mxt_load_fw(struct device *dev)
 		goto release_firmware;
 
 	/* Poll after 0.1s if no interrupt received */
-	schedule_delayed_work(&data->flash->work, HZ / 10);
+	schedule_delayed_work(&data->flash->work, msecs_to_jiffies(100));
 
 	/* Wait for flash. */
 	ret = mxt_wait_for_completion(data, &data->flash->flash_completion,
-- 
2.19.2
