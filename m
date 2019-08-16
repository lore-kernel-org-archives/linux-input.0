From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 56/63] Input: atmel_mxt_ts: Use complete when in_bootloader true
Date: Fri, 16 Aug 2019 17:38:23 +0900
Message-ID: <20190816083830.19553-2-jiada_wang@mentor.com>
References: <20190816083830.19553-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083830.19553-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

In mxt_interrupt(), complete(&data->chg_completion) was
called everytime mxt_interrupt() ran which is unnecessary.

mxt_regulator_enable() sets data->in_bootloader to true and
waits for the completion indication for data->chg_completion
to be set by mxt_interrupt().

mxt_interrupt() already has a test for data->in_bootloader
being true so move complete(&data->chg_completion) inside
that test.

Here is some analysis of some old commits relating to the
usage of complete(&data->chg_completion):

e6c4b6160d2 ("Input: atmel_mxt_ts - rename bl_completion to
chg_completion")

This old commit moved the "complete" statement from inside a
test for data->in_bootloader being true to run everytime
mxt_interrupt() executed. It is unclear why this was done.

This new commit reverses that modification back to the original
implementation.

4c814dd5c6ae ("Input: atmel_mxt_ts - make bootloader interrupt
driven")

This old commit modified mxt_load_fw() to no longer use the
data->chg_completion solution so only mxt_regulator_enable()
uses the data->chg_completion solution.

Therefore, only mxt_regulator_enable() now needs to be
supported by the data->chg_completion solution.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 40263ef79e8e..64a1a6815d56 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1631,9 +1631,9 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 	struct mxt_data *data = dev_id;
 	int ret;
 
-	complete(&data->chg_completion);
-
 	if (data->in_bootloader) {
+		complete(&data->chg_completion);
+
 		if (data->flash && &data->flash->work)
 			cancel_delayed_work_sync(&data->flash->work);
 
-- 
2.19.2
