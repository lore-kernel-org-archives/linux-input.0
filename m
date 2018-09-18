From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 10/20] Input: iforce - update formatting of switch statements
Date: Mon, 17 Sep 2018 17:47:22 -0700
Message-ID: <20180918004732.9875-10-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to our coding style case labels in switch statements should
be aligned with the switch keyword.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-ff.c     |  18 +--
 drivers/input/joystick/iforce/iforce-main.c   |  70 +++++------
 .../input/joystick/iforce/iforce-packets.c    | 112 +++++++++---------
 3 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joystick/iforce/iforce-ff.c
index 3536d5f5ad18..56973dd97fd6 100644
--- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -384,12 +384,12 @@ int iforce_upload_periodic(struct iforce *iforce, struct ff_effect *effect, stru
 	}
 
 	switch (effect->u.periodic.waveform) {
-		case FF_SQUARE:		wave_code = 0x20; break;
-		case FF_TRIANGLE:	wave_code = 0x21; break;
-		case FF_SINE:		wave_code = 0x22; break;
-		case FF_SAW_UP:		wave_code = 0x23; break;
-		case FF_SAW_DOWN:	wave_code = 0x24; break;
-		default:		wave_code = 0x20; break;
+	case FF_SQUARE:		wave_code = 0x20; break;
+	case FF_TRIANGLE:	wave_code = 0x21; break;
+	case FF_SINE:		wave_code = 0x22; break;
+	case FF_SAW_UP:		wave_code = 0x23; break;
+	case FF_SAW_DOWN:	wave_code = 0x24; break;
+	default:		wave_code = 0x20; break;
 	}
 
 	if (!old || need_core(old, effect)) {
@@ -488,9 +488,9 @@ int iforce_upload_condition(struct iforce *iforce, struct ff_effect *effect, str
 	int core_err = 0;
 
 	switch (effect->type) {
-		case FF_SPRING:	type = 0x40; break;
-		case FF_DAMPER:	type = 0x41; break;
-		default: return -1;
+	case FF_SPRING:	type = 0x40; break;
+	case FF_DAMPER:	type = 0x41; break;
+	default: return -1;
 	}
 
 	if (!old || need_condition_modifier(iforce, old, effect)) {
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 3a0698327c42..9964aa8b3cdc 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -132,22 +132,21 @@ static int iforce_upload_effect(struct input_dev *dev, struct ff_effect *effect,
  * Upload the effect
  */
 	switch (effect->type) {
+	case FF_PERIODIC:
+		ret = iforce_upload_periodic(iforce, effect, old);
+		break;
 
-		case FF_PERIODIC:
-			ret = iforce_upload_periodic(iforce, effect, old);
-			break;
+	case FF_CONSTANT:
+		ret = iforce_upload_constant(iforce, effect, old);
+		break;
 
-		case FF_CONSTANT:
-			ret = iforce_upload_constant(iforce, effect, old);
-			break;
+	case FF_SPRING:
+	case FF_DAMPER:
+		ret = iforce_upload_condition(iforce, effect, old);
+		break;
 
-		case FF_SPRING:
-		case FF_DAMPER:
-			ret = iforce_upload_condition(iforce, effect, old);
-			break;
-
-		default:
-			return -EINVAL;
+	default:
+		return -EINVAL;
 	}
 
 	if (ret == 0) {
@@ -351,34 +350,29 @@ int iforce_init_device(struct device *parent, u16 bustype,
 		signed short t = iforce->type->abs[i];
 
 		switch (t) {
+		case ABS_X:
+		case ABS_Y:
+		case ABS_WHEEL:
+			input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
+			set_bit(t, input_dev->ffbit);
+			break;
 
-			case ABS_X:
-			case ABS_Y:
-			case ABS_WHEEL:
-
-				input_set_abs_params(input_dev, t, -1920, 1920, 16, 128);
-				set_bit(t, input_dev->ffbit);
-				break;
-
-			case ABS_THROTTLE:
-			case ABS_GAS:
-			case ABS_BRAKE:
-
-				input_set_abs_params(input_dev, t, 0, 255, 0, 0);
-				break;
-
-			case ABS_RUDDER:
-
-				input_set_abs_params(input_dev, t, -128, 127, 0, 0);
-				break;
+		case ABS_THROTTLE:
+		case ABS_GAS:
+		case ABS_BRAKE:
+			input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+			break;
 
-			case ABS_HAT0X:
-			case ABS_HAT0Y:
-		        case ABS_HAT1X:
-		        case ABS_HAT1Y:
+		case ABS_RUDDER:
+			input_set_abs_params(input_dev, t, -128, 127, 0, 0);
+			break;
 
-				input_set_abs_params(input_dev, t, -1, 1, 0, 0);
-				break;
+		case ABS_HAT0X:
+		case ABS_HAT0Y:
+		case ABS_HAT1X:
+		case ABS_HAT1Y:
+			input_set_abs_params(input_dev, t, -1, 1, 0, 0);
+			break;
 		}
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 70db273e5045..7aba2966454a 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -142,66 +142,72 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 
 	switch (HI(cmd)) {
 
-		case 0x01:	/* joystick position data */
-		case 0x03:	/* wheel position data */
-			if (HI(cmd) == 1) {
-				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-				input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-				if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-					input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-			} else {
-				input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_GAS,   255 - data[2]);
-				input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
-			}
+	case 0x01:	/* joystick position data */
+	case 0x03:	/* wheel position data */
+		if (HI(cmd) == 1) {
+			input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+			input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+			input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
+			if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+				input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+		} else {
+			input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
+			input_report_abs(dev, ABS_GAS,   255 - data[2]);
+			input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+		}
 
-			input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
-			input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
-
-			for (i = 0; iforce->type->btn[i] >= 0; i++)
-				input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
-
-			/* If there are untouched bits left, interpret them as the second hat */
-			if (i <= 8) {
-				int btns = data[6];
-				if (test_bit(ABS_HAT1X, dev->absbit)) {
-					if (btns & 8) input_report_abs(dev, ABS_HAT1X, -1);
-					else if (btns & 2) input_report_abs(dev, ABS_HAT1X, 1);
-					else input_report_abs(dev, ABS_HAT1X, 0);
-				}
-				if (test_bit(ABS_HAT1Y, dev->absbit)) {
-					if (btns & 1) input_report_abs(dev, ABS_HAT1Y, -1);
-					else if (btns & 4) input_report_abs(dev, ABS_HAT1Y, 1);
-					else input_report_abs(dev, ABS_HAT1Y, 0);
-				}
+		input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
+		input_report_abs(dev, ABS_HAT0Y, iforce_hat_to_axis[data[6] >> 4].y);
+
+		for (i = 0; iforce->type->btn[i] >= 0; i++)
+			input_report_key(dev, iforce->type->btn[i], data[(i >> 3) + 5] & (1 << (i & 7)));
+
+		/* If there are untouched bits left, interpret them as the second hat */
+		if (i <= 8) {
+			int btns = data[6];
+			if (test_bit(ABS_HAT1X, dev->absbit)) {
+				if (btns & 8)
+					input_report_abs(dev, ABS_HAT1X, -1);
+				else if (btns & 2)
+					input_report_abs(dev, ABS_HAT1X, 1);
+				else
+					input_report_abs(dev, ABS_HAT1X, 0);
 			}
+			if (test_bit(ABS_HAT1Y, dev->absbit)) {
+				if (btns & 1)
+					input_report_abs(dev, ABS_HAT1Y, -1);
+				else if (btns & 4)
+					input_report_abs(dev, ABS_HAT1Y, 1);
+				else
+					input_report_abs(dev, ABS_HAT1Y, 0);
+			}
+		}
 
-			input_sync(dev);
+		input_sync(dev);
 
-			break;
+		break;
 
-		case 0x02:	/* status report */
-			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
-			input_sync(dev);
+	case 0x02:	/* status report */
+		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
+		input_sync(dev);
 
-			/* Check if an effect was just started or stopped */
-			i = data[1] & 0x7f;
-			if (data[1] & 0x80) {
-				if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-					/* Report play event */
-					input_report_ff_status(dev, i, FF_STATUS_PLAYING);
-				}
-			} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-				/* Report stop event */
-				input_report_ff_status(dev, i, FF_STATUS_STOPPED);
+		/* Check if an effect was just started or stopped */
+		i = data[1] & 0x7f;
+		if (data[1] & 0x80) {
+			if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
+				/* Report play event */
+				input_report_ff_status(dev, i, FF_STATUS_PLAYING);
 			}
-			if (LO(cmd) > 3) {
-				int j;
-				for (j = 3; j < LO(cmd); j += 2)
-					mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
-			}
-			break;
+		} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
+			/* Report stop event */
+			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
+		}
+		if (LO(cmd) > 3) {
+			int j;
+			for (j = 3; j < LO(cmd); j += 2)
+				mark_core_as_ready(iforce, data[j] | (data[j+1]<<8));
+		}
+		break;
 	}
 }
 EXPORT_SYMBOL(iforce_process_packet);
-- 
2.19.0.397.gdd90340f6a-goog
