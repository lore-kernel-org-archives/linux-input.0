From: John Sung <penmount.touch@gmail.com>
Subject: [PATCH 1/3] Input: penmount - add PenMount 6000 support
Date: Fri,  9 Sep 2011 16:07:45 +0800
Message-ID: <1315555667-5893-1-git-send-email-penmount.touch@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, John Sung <penmount.touch@gmail.com>
List-Id: linux-input@vger.kernel.org

Add support for PenMount 6000 touch controller.

Signed-off-by: John Sung <penmount.touch@gmail.com>
---
 drivers/input/touchscreen/penmount.c |   64 +++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/penmount.c b/drivers/input/touchscreen/penmount.c
index 3342c6d..240f6a2 100644
--- a/drivers/input/touchscreen/penmount.c
+++ b/drivers/input/touchscreen/penmount.c
@@ -33,7 +33,7 @@ MODULE_LICENSE("GPL");
  * Definitions & global arrays.
  */
 
-#define	PM_MAX_LENGTH	5
+#define	PM_MAX_LENGTH	6
 
 /*
  * Per-touchscreen data.
@@ -45,8 +45,25 @@ struct pm {
 	int idx;
 	unsigned char data[PM_MAX_LENGTH];
 	char phys[32];
+	unsigned char packetsize;
 };
 
+/*
+ * pm_checkpacket() checks if data packet is valid
+ */
+
+static int pm_checkpacket(unsigned char *packet) {
+	int i = 0;
+	int total = 0;
+	for (i = 0; i < 5; i++)
+		total += packet[i];
+
+	if (packet[5] == (unsigned char)~(total & 0xff))
+		return 1;
+
+	return 0;
+}
+
 static irqreturn_t pm_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
@@ -55,14 +72,33 @@ static irqreturn_t pm_interrupt(struct serio *serio,
 
 	pm->data[pm->idx] = data;
 
-	if (pm->data[0] & 0x80) {
-		if (PM_MAX_LENGTH == ++pm->idx) {
-			input_report_abs(dev, ABS_X, pm->data[1] * 128 + pm->data[2]);
-			input_report_abs(dev, ABS_Y, pm->data[3] * 128 + pm->data[4]);
-			input_report_key(dev, BTN_TOUCH, !!(pm->data[0] & 0x40));
-			input_sync(dev);
-			pm->idx = 0;
+	switch (pm->dev->id.product) {
+	case 0x9000:
+		if (pm->data[0] & 0x80) {
+			if (pm->packetsize == ++pm->idx) {
+				input_report_abs(dev, ABS_X, pm->data[1] * 128 + pm->data[2]);
+				input_report_abs(dev, ABS_Y, pm->data[3] * 128 + pm->data[4]);
+				input_report_key(dev, BTN_TOUCH, !!(pm->data[0] & 0x40));
+				input_sync(dev);
+				pm->idx = 0;
+			}
+		}
+		break;
+	case 0x6000:
+		if ((pm->data[0] & 0xbf) == 0x30) {
+			if (pm->packetsize == ++pm->idx) {
+				if (pm_checkpacket(pm->data)) {
+					input_report_abs(dev, ABS_X,
+							pm->data[2] * 256 + pm->data[1]);
+					input_report_abs(dev, ABS_Y,
+							pm->data[4] * 256 + pm->data[3]);
+					input_report_key(dev, BTN_TOUCH, !!(pm->data[0] & 0x40));
+					input_sync(dev);
+				}
+				pm->idx = 0;
+			}
 		}
+		break;
 	}
 
 	return IRQ_HANDLED;
@@ -120,6 +156,18 @@ static int pm_connect(struct serio *serio, struct serio_driver *drv)
         input_set_abs_params(pm->dev, ABS_X, 0, 0x3ff, 0, 0);
         input_set_abs_params(pm->dev, ABS_Y, 0, 0x3ff, 0, 0);
 
+	switch (serio->id.id) {
+	default:
+	case 0:
+		pm->packetsize = 5;
+		input_dev->id.product = 0x9000;
+		break;
+	case 1:
+		pm->packetsize = 6;
+		input_dev->id.product = 0x6000;
+		break;
+	}
+
 	serio_set_drvdata(serio, pm);
 
 	err = serio_open(serio, drv);
-- 
1.7.4.1
