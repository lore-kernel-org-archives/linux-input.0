From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add auto recovery handle for absolute mode
Date: Tue,  8 Jan 2019 15:30:42 +0800
Message-ID: <1546932642-3621-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc: kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

Sometimes touchpad will be reset to mouse mode unexpectedly.
And cause invalid report detection.
I add a mouse report detection and send mode-switching command again.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2690a4b..56b5766 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -51,6 +51,7 @@
 
 #define ETP_MAX_FINGERS		5
 #define ETP_FINGER_DATA_LEN	5
+#define ETP_MOUSE_REPORT_ID	0x01
 #define ETP_REPORT_ID		0x5D
 #define ETP_TP_REPORT_ID	0x5E
 #define ETP_REPORT_ID_OFFSET	2
@@ -988,6 +989,14 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	case ETP_TP_REPORT_ID:
 		elan_report_trackpoint(data, report);
 		break;
+	case ETP_MOUSE_REPORT_ID:
+		dev_info(dev, "Mouse report now, mode switch again\n");
+		data->mode |= ETP_ENABLE_ABS;
+		error = data->ops->set_mode(data->client, data->mode);
+		if (error)
+			dev_err(dev, "fail to switch to absolute mode(%d)\n",
+					error);
+		break;
 	default:
 		dev_err(dev, "invalid report id data (%x)\n",
 			report[ETP_REPORT_ID_OFFSET]);
-- 
2.7.4
