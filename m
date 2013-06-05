From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 46/53] Input: atmel_mxt_ts - Handle reports from T47 Stylus object
Date: Wed,  5 Jun 2013 18:37:39 +0100
Message-ID: <1370453866-16534-47-git-send-email-nick.dyer@itdev.co.uk>
References: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6631ef1..cd8f3e0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -128,6 +128,9 @@ struct t9_range {
 /* Define for MXT_PROCI_TOUCHSUPPRESSION_T42 */
 #define MXT_T42_MSG_TCHSUP	(1 << 0)
 
+/* T47 Stylus */
+#define MXT_TOUCH_MAJOR_T47_STYLUS	1
+
 /* T63 Stylus */
 #define MXT_STYLUS_PRESS	(1 << 0)
 #define MXT_STYLUS_RELEASE	(1 << 1)
@@ -698,6 +701,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 	int area;
 	int amplitude;
 	u8 vector;
+	int tool;
 
 	/* do not report events if input device not yet registered */
 	if (!data->enable_reporting)
@@ -715,6 +719,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 		y >>= 2;
 
 	area = message[5];
+
 	amplitude = message[6];
 	vector = message[7];
 
@@ -743,8 +748,17 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 			mxt_input_sync(input_dev);
 		}
 
+		/* A reported size of zero indicates that the reported touch
+		 * is a stylus from a linked Stylus T47 object. */
+		if (area == 0) {
+			area = MXT_TOUCH_MAJOR_T47_STYLUS;
+			tool = MT_TOOL_PEN;
+		} else {
+			tool = MT_TOOL_FINGER;
+		}
+
 		/* Touch active */
-		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 1);
+		input_mt_report_slot_state(input_dev, tool, 1);
 		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
 		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
 		input_report_abs(input_dev, ABS_MT_PRESSURE, amplitude);
-- 
1.7.10.4
