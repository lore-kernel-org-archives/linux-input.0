From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] [v2] Input: touchscreen: Fix a missing check on regmap_bulk_read
Date: Sun,  6 Jan 2019 12:17:27 -0600
Message-ID: <20190106181727.11815-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

regmap_bulk_read() can return a non zero value on failure. The fix
checks if the function call succeeded before calling mod_timer. The
issue was identified by a static analysis tool.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/input/touchscreen/ad7879.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6fa714c587b4..8c908572c1f2 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -246,11 +246,14 @@ static void ad7879_timer(struct timer_list *t)
 static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
+	int error;
 
-	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
-			 ts->conversion_data, AD7879_NR_SENSE);
-
-	if (!ad7879_report(ts))
+	error = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
+					ts->conversion_data, AD7879_NR_SENSE);
+	if (error)
+		dev_err_ratelimited(ts->dev, "failed to read %#02x: %d\n",
+					AD7879_REG_XPLUS, error);
+	else if (!ad7879_report(ts))
 		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
-- 
2.17.1
