From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v3 10/49] Input: atmel_mxt_ts - handle reports from T47 Stylus object
Date: Tue, 17 Sep 2019 18:36:25 +0900
Message-ID: <20190917093704.18439-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
(cherry picked from ndyer/linux/for-upstream commit 56405a5ea08eb34cfe83f3121867c9de0a5c48c1)
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1d738c488bdd..83dad225458e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -823,6 +823,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 	int area;
 	int amplitude;
 	u8 vector;
+	int tool;
 
 	id = message[0] - data->T9_reportid_min;
 	status = message[1];
@@ -836,6 +837,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 		y >>= 2;
 
 	area = message[5];
+
 	amplitude = message[6];
 	vector = message[7];
 
@@ -865,12 +867,20 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 			mxt_input_sync(data);
 		}
 
+		/* A size of zero indicates touch is from a linked T47 Stylus */
+		if (area == 0) {
+			area = MXT_TOUCH_MAJOR_DEFAULT;
+			tool = MT_TOOL_PEN;
+		} else {
+			tool = MT_TOOL_FINGER;
+		}
+
 		/* if active, pressure must be non-zero */
 		if (!amplitude)
 			amplitude = MXT_PRESSURE_DEFAULT;
 
 		/* Touch active */
-		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 1);
+		input_mt_report_slot_state(input_dev, tool, 1);
 		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
 		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
 		input_report_abs(input_dev, ABS_MT_PRESSURE, amplitude);
-- 
2.19.2
