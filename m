From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when slot is closed
Date: Fri, 20 Jul 2018 22:51:21 +0100
Message-ID: <20180720215122.23558-9-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

input_mt_report_slot_state() ignores the tool when the slot is closed.
Remove the tool type from these function calls, which has caused a bit of
confusion.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d7023d261458..c31af790ef84 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -838,8 +838,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 		 * have happened.
 		 */
 		if (status & MXT_T9_RELEASE) {
-			input_mt_report_slot_state(input_dev,
-						   MT_TOOL_FINGER, 0);
+			input_mt_report_slot_state(input_dev, 0, 0);
 			mxt_input_sync(data);
 		}
 
@@ -855,7 +854,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
 	} else {
 		/* Touch no longer active, close out slot */
-		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
+		input_mt_report_slot_state(input_dev, 0, 0);
 	}
 
 	data->update_input = true;
-- 
2.17.1
