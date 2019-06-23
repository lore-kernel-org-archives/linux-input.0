From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: edt-ft5x06 - simplify event reporting code
Date: Sat, 22 Jun 2019 23:31:53 -0700
Message-ID: <20190623063153.261546-2-dmitry.torokhov@gmail.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, Benoit Parrot <bparrot@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now that input_mt_report_slot_state() returns true if slot is active we no
longer need a temporary for the slot state.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ec770226e119..3cc4341bbdff 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -229,7 +229,6 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 
 	for (i = 0; i < tsdata->max_support_points; i++) {
 		u8 *buf = &rdbuf[i * tplen + offset];
-		bool down;
 
 		type = buf[0] >> 6;
 		/* ignore Reserved events */
@@ -247,16 +246,12 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 			swap(x, y);
 
 		id = (buf[2] >> 4) & 0x0f;
-		down = type != TOUCH_EVENT_UP;
 
 		input_mt_slot(tsdata->input, id);
-		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
-
-		if (!down)
-			continue;
-
-		touchscreen_report_pos(tsdata->input, &tsdata->prop, x, y,
-				       true);
+		if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,
+					       type != TOUCH_EVENT_UP))
+			touchscreen_report_pos(tsdata->input, &tsdata->prop,
+					       x, y, true);
 	}
 
 	input_mt_report_pointer_emulation(tsdata->input, true);
-- 
2.22.0.410.gd8fdbe21b5-goog
