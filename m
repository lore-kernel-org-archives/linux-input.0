From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 16/16 v2] Input: atmel_mxt_ts - parse T6 reports
Date: Fri, 30 Mar 2012 00:49:26 +0800
Message-ID: <1333039766-8617-17-git-send-email-djkurtz@chromium.org>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

The normal messages sent after boot or NVRAM update are T6 reports,
containing a status, and the config memory checksum.  Parse them and dump
a useful info message.

This patch tested on an MXT224E.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d8b23ad..f3dfb4f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -247,6 +247,7 @@ struct mxt_data {
 	unsigned int max_y;
 
 	/* Cached parameters from object table */
+	u8 T6_reportid;
 	u8 T9_reportid_min;
 	u8 T9_reportid_max;
 };
@@ -552,6 +553,12 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 		    message.reportid <= data->T9_reportid_max) {
 			mxt_input_touch(data, &message);
 			update_input = true;
+		} else if (message.reportid == data->T6_reportid) {
+			unsigned csum = message.message[1] |
+					(message.message[2] << 8) |
+					(message.message[3] << 16);
+			dev_info(dev, "Status: %02x Config Checksum: %06x\n",
+				 message.message[0], csum);
 		} else {
 			mxt_dump_message(dev, &message);
 		}
@@ -723,6 +730,9 @@ static int mxt_get_object_table(struct mxt_data *data)
 			 object->instances, min_id, max_id);
 
 		switch (object->type) {
+		case MXT_GEN_COMMAND_T6:
+			data->T6_reportid = min_id;
+			break;
 		case MXT_TOUCH_MULTI_T9:
 			data->T9_reportid_min = min_id;
 			data->T9_reportid_max = max_id;
-- 
1.7.7.3
