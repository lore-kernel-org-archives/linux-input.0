From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 24/49] Input: atmel_mxt_ts - rename bl_completion to chg_completion
Date: Tue, 27 Aug 2019 15:28:45 +0900
Message-ID: <20190827062910.20598-5-jiada_wang@mentor.com>
References: <20190827062910.20598-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827062910.20598-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit dda8453bfb44216645ede798918a314d4fca2481)
[gdavis: Resolve forward port conflicts due to applying upstream
	 commit 96a938aa214e ("Input: atmel_mxt_ts - remove platform
	 data support").]
Signed-off-by: George G. Davis <george_davis@mentor.com>
[jiada: call complete(&data->chg_completion) only when in_bootloader is TRUE]
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4e7f82e2fc0c..e5843cb9a35e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -381,9 +381,6 @@ struct mxt_data {
 	u8 T100_reportid_max;
 	u16 T107_address;
 
-	/* for fw update in bootloader */
-	struct completion bl_completion;
-
 	/* for reset handling */
 	struct completion reset_completion;
 
@@ -395,6 +392,9 @@ struct mxt_data {
 
 	enum mxt_suspend_mode suspend_mode;
 
+	/* for power up handling */
+	struct completion chg_completion;
+
 	/* Indicates whether device is in suspend */
 	bool suspended;
 
@@ -611,7 +611,7 @@ static int mxt_check_bootloader(struct mxt_data *data, struct mxt_flash *f)
 	 * CHG assertion before reading the status byte.
 	 * Once the status byte has been read, the line is deasserted.
 	 */
-	ret = mxt_wait_for_completion(data, &data->bl_completion,
+	ret = mxt_wait_for_completion(data, &data->chg_completion,
 				      MXT_FW_CHG_TIMEOUT);
 	if (ret) {
 		/*
@@ -1402,8 +1402,7 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 	struct mxt_data *data = dev_id;
 
 	if (data->in_bootloader) {
-		/* bootloader state transition completion */
-		complete(&data->bl_completion);
+		complete(&data->chg_completion);
 		return IRQ_HANDLED;
 	}
 
@@ -2167,9 +2166,9 @@ static void mxt_regulator_enable(struct mxt_data *data)
 	msleep(MXT_CHG_DELAY);
 
 retry_wait:
-	reinit_completion(&data->bl_completion);
+	reinit_completion(&data->chg_completion);
 	data->in_bootloader = true;
-	error = mxt_wait_for_completion(data, &data->bl_completion,
+	error = mxt_wait_for_completion(data, &data->chg_completion,
 					MXT_POWERON_DELAY);
 	if (error == -EINTR)
 		goto retry_wait;
@@ -3334,7 +3333,7 @@ static int mxt_enter_bootloader(struct mxt_data *data)
 		enable_irq(data->irq);
 	}
 
-	reinit_completion(&data->bl_completion);
+	reinit_completion(&data->chg_completion);
 
 	return 0;
 }
@@ -3370,7 +3369,7 @@ static int mxt_load_fw(struct device *dev)
 	}
 
 	/* Wait for flash. */
-	ret = mxt_wait_for_completion(data, &data->bl_completion,
+	ret = mxt_wait_for_completion(data, &data->chg_completion,
 				      MXT_FW_RESET_TIME);
 	if (ret)
 		goto disable_irq;
@@ -3381,7 +3380,7 @@ static int mxt_load_fw(struct device *dev)
 	 * the CHG line after bootloading has finished, so ignore potential
 	 * errors.
 	 */
-	mxt_wait_for_completion(data, &data->bl_completion, MXT_FW_RESET_TIME);
+	mxt_wait_for_completion(data, &data->chg_completion, MXT_FW_RESET_TIME);
 
 	data->in_bootloader = false;
 disable_irq:
@@ -3803,7 +3802,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	data->irq = client->irq;
 	i2c_set_clientdata(client, data);
 
-	init_completion(&data->bl_completion);
+	init_completion(&data->chg_completion);
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
 
-- 
2.19.2
