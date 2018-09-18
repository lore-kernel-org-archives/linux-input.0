From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 11/20] Input: iforce - factor out hat handling when parsing packets
Date: Mon, 17 Sep 2018 17:47:23 -0700
Message-ID: <20180918004732.9875-11-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This makes code clearer a bit.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 101 ++++++++++--------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 7aba2966454a..ffd1dd65deb8 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -130,11 +130,47 @@ static int mark_core_as_ready(struct iforce *iforce, unsigned short addr)
 	return -1;
 }
 
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+static void iforce_report_hats_buttons(struct iforce *iforce, u8 *data)
 {
 	struct input_dev *dev = iforce->dev;
 	int i;
 
+	input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
+	input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
+
+	for (i = 0; iforce->type->btn[i] >= 0; i++)
+		input_report_key(dev, iforce->type->btn[i],
+				 data[(i >> 3) + 5] & (1 << (i & 7)));
+
+	/* If there are untouched bits left, interpret them as the second hat */
+	if (i <= 8) {
+		u8 btns = data[6];
+
+		if (test_bit(ABS_HAT1X, dev->absbit)) {
+			if (btns & BIT(3))
+				input_report_abs(dev, ABS_HAT1X, -1);
+			else if (btns & BIT(1))
+				input_report_abs(dev, ABS_HAT1X, 1);
+			else
+				input_report_abs(dev, ABS_HAT1X, 0);
+		}
+
+		if (test_bit(ABS_HAT1Y, dev->absbit)) {
+			if (btns & BIT(0))
+				input_report_abs(dev, ABS_HAT1Y, -1);
+			else if (btns & BIT(2))
+				input_report_abs(dev, ABS_HAT1Y, 1);
+			else
+				input_report_abs(dev, ABS_HAT1Y, 0);
+		}
+	}
+}
+
+void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+{
+	struct input_dev *dev = iforce->dev;
+	int i, j;
+
 	wake_up(&iforce->wait);
 
 	if (!iforce->type)
@@ -143,48 +179,26 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	switch (HI(cmd)) {
 
 	case 0x01:	/* joystick position data */
-	case 0x03:	/* wheel position data */
-		if (HI(cmd) == 1) {
-			input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-			input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-			input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-			if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-				input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-		} else {
-			input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
-			input_report_abs(dev, ABS_GAS,   255 - data[2]);
-			input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
-		}
+		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
-		input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
-		input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
-
-		for (i = 0; iforce->type->btn[i] >= 0; i++)
-			input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
-
-		/* If there are untouched bits left, interpret them as the second hat */
-		if (i <= 8) {
-			int btns = data[6];
-			if (test_bit(ABS_HAT1X, dev->absbit)) {
-				if (btns & 8)
-					input_report_abs(dev, ABS_HAT1X, -1);
-				else if (btns & 2)
-					input_report_abs(dev, ABS_HAT1X, 1);
-				else
-					input_report_abs(dev, ABS_HAT1X, 0);
-			}
-			if (test_bit(ABS_HAT1Y, dev->absbit)) {
-				if (btns & 1)
-					input_report_abs(dev, ABS_HAT1Y, -1);
-				else if (btns & 4)
-					input_report_abs(dev, ABS_HAT1Y, 1);
-				else
-					input_report_abs(dev, ABS_HAT1Y, 0);
-			}
-		}
+		if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+			input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+
+		iforce_report_hats_buttons(iforce, data);
 
 		input_sync(dev);
+		break;
 
+	case 0x03:	/* wheel position data */
+		input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+		input_report_abs(dev, ABS_GAS,   255 - data[2]);
+		input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+
+		iforce_report_hats_buttons(iforce, data);
+
+		input_sync(dev);
 		break;
 
 	case 0x02:	/* status report */
@@ -202,11 +216,10 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			/* Report stop event */
 			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
-		if (LO(cmd) > 3) {
-			int j;
-			for (j = 3; j < LO(cmd); j += 2)
-				mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
-		}
+
+		for (j = 3; j < LO(cmd); j += 2)
+			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
+
 		break;
 	}
 }
-- 
2.19.0.397.gdd90340f6a-goog
