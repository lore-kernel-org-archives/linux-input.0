From: "DusonLin" <dusonlin@emc.com.tw>
Subject: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event trigger
Date: Mon, 11 Apr 2016 08:58:24 +0800
Message-ID: <000301d1938d$431f4690$c95dd3b0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:30350 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbcDKA6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Apr 2016 20:58:35 -0400
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Linux-kernel@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'jeff' <jeff.chuang@emc.com.tw>, 'Phoenix' <phoenix@emc.com.tw>

Only ABS_DISTANCE is not enough for upper OS to distingiush hover event
be triggered from object from faraway to and close touchpad surface or
from object prepare to leave the touchpad surface. Add BTN_TOOL_FINGER
flag to help it.

                 object_from_faraway    object_inside_hover_area
object_touch_surface
BTN_TOUCH                 0                          0
1
BTN_TOOL_FINGER           0                          1
1
ABS_DISTANCE              0                          1
0

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/hid/hid-magicmouse.c             |  2 +-
 drivers/input/input-mt.c                 |  7 +++++--
 drivers/input/mouse/elan_i2c_core.c      | 15 +++++++++------
 drivers/input/mouse/elantech.c           |  2 +-
 drivers/input/mouse/focaltech.c          |  2 +-
 drivers/input/mouse/synaptics.c          |  2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c   |  2 +-
 drivers/input/touchscreen/egalax_ts.c    |  2 +-
 drivers/input/touchscreen/ili210x.c      |  2 +-
 drivers/input/touchscreen/mms114.c       |  4 ++--
 drivers/input/touchscreen/penmount.c     |  2 +-
 drivers/input/touchscreen/rohm_bu21023.c |  2 +-
 drivers/input/touchscreen/wacom_w8001.c  |  2 +-
 include/linux/input/mt.h                 |  3 ++-
 15 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.=
c
index d6fa496..584e98b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -353,7 +353,7 @@ static int magicmouse_raw_event(struct hid_device *=
hdev,
 		input_report_rel(input, REL_Y, y);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		input_report_key(input, BTN_MOUSE, clicks & 1);
-		input_mt_report_pointer_emulation(input, true);
+		input_mt_report_pointer_emulation(input, true, false);
 	}
=20
 	input_sync(input);
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 54fce56..30855a5 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -184,6 +184,7 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
  * input_mt_report_pointer_emulation() - common pointer emulation
  * @dev: input device with allocated MT slots
  * @use_count: report number of active contacts as finger count
+ * @hover: report ABS_DISTANCE as hover event
  *
  * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
  * ABS_PRESSURE. Touchpad finger count is emulated if use_count is tru=
e.
@@ -191,7 +192,8 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
  * The input core ensures only the KEY and ABS axes already setup for
  * this device will produce output.
  */
-void input_mt_report_pointer_emulation(struct input_dev *dev, bool
use_count)
+void input_mt_report_pointer_emulation(struct input_dev *dev, bool
use_count,
+					bool hover)
 {
 	struct input_mt *mt =3D dev->mt;
 	struct input_mt_slot *oldest;
@@ -220,6 +222,7 @@ void input_mt_report_pointer_emulation(struct input=
_dev
*dev, bool use_count)
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
 	if (use_count)
 		input_mt_report_finger_count(dev, count);
+	input_event(dev, EV_ABS, ABS_DISTANCE, hover);
=20
 	if (oldest) {
 		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X);
@@ -290,7 +293,7 @@ void input_mt_sync_frame(struct input_dev *dev)
 	if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags &
INPUT_MT_SEMI_MT))
 		use_count =3D true;
=20
-	input_mt_report_pointer_emulation(dev, use_count);
+	input_mt_report_pointer_emulation(dev, use_count, false);
=20
 	mt->frame++;
 }
diff --git a/drivers/input/mouse/elan_i2c_core.c
b/drivers/input/mouse/elan_i2c_core.c
index 2f58985..8b5e75a 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =AAL=ACF=BA=FB (Duson Lin) <dusonlin@emc.com.tw>
- * Version: 1.6.0
+ * Version: 1.6.2
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +40,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.1"
+#define ELAN_DRIVER_VERSION	"1.6.2"
 #define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -845,7 +845,7 @@ static void elan_report_absolute(struct elan_tp_dat=
a
*data, u8 *packet)
 {
 	struct input_dev *input =3D data->input;
 	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
-	int i;
+	int i, valid_count =3D 0;
 	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
 	u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
 	bool contact_valid, hover_event;
@@ -855,13 +855,16 @@ static void elan_report_absolute(struct elan_tp_d=
ata
*data, u8 *packet)
 		contact_valid =3D tp_info & (1U << (3 + i));
 		elan_report_contact(data, i, contact_valid, finger_data);
=20
-		if (contact_valid)
+		if (contact_valid) {
 			finger_data +=3D ETP_FINGER_DATA_LEN;
+			valid_count++;
+		}
 	}
=20
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);
-	input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
-	input_mt_report_pointer_emulation(input, true);
+	input_report_key(input, BTN_TOOL_FINGER,
+			((hover_event !=3D 0) || (valid_count > 0)));
+	input_mt_report_pointer_emulation(input, false, hover_event !=3D 0);
 	input_sync(input);
 }
=20
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 78f93cf..cc13e12 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -558,7 +558,7 @@ static void elantech_input_sync_v4(struct psmouse
*psmouse)
 		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
 	}
=20
-	input_mt_report_pointer_emulation(dev, true);
+	input_mt_report_pointer_emulation(dev, true, false);
 	input_sync(dev);
 }
=20
diff --git a/drivers/input/mouse/focaltech.c
b/drivers/input/mouse/focaltech.c
index c8c6a8c..f4339ac 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -144,7 +144,7 @@ static void focaltech_report_state(struct psmouse
*psmouse)
 			input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
 		}
 	}
-	input_mt_report_pointer_emulation(dev, true);
+	input_mt_report_pointer_emulation(dev, true, false);
=20
 	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
 	input_sync(psmouse->dev);
diff --git a/drivers/input/mouse/synaptics.c
b/drivers/input/mouse/synaptics.c
index a41d832..09fa835 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -944,7 +944,7 @@ static void synaptics_report_mt_data(struct psmouse
*psmouse,
 	input_mt_drop_unused(dev);
=20
 	/* Don't use active slot count to generate BTN_TOOL events. */
-	input_mt_report_pointer_emulation(dev, false);
+	input_mt_report_pointer_emulation(dev, false, false);
=20
 	/* Send the number of fingers reported by touchpad itself. */
 	input_mt_report_finger_count(dev, num_fingers);
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2160512..0ab0d53 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -683,7 +683,7 @@ static void mxt_input_button(struct mxt_data *data,=
 u8
*message)
 static void mxt_input_sync(struct mxt_data *data)
 {
 	input_mt_report_pointer_emulation(data->input_dev,
-					  data->pdata->t19_num_keys);
+					  data->pdata->t19_num_keys, false);
 	input_sync(data->input_dev);
 }
=20
diff --git a/drivers/input/touchscreen/edt-ft5x06.c
b/drivers/input/touchscreen/edt-ft5x06.c
index 23fbe38..6533d8e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -250,7 +250,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void
*dev_id)
 		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
 	}
=20
-	input_mt_report_pointer_emulation(tsdata->input, true);
+	input_mt_report_pointer_emulation(tsdata->input, true, false);
 	input_sync(tsdata->input);
=20
 out:
diff --git a/drivers/input/touchscreen/egalax_ts.c
b/drivers/input/touchscreen/egalax_ts.c
index 1afc08b..c420336 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -113,7 +113,7 @@ static irqreturn_t egalax_ts_interrupt(int irq, voi=
d
*dev_id)
 		input_report_abs(input_dev, ABS_MT_PRESSURE, z);
 	}
=20
-	input_mt_report_pointer_emulation(input_dev, true);
+	input_mt_report_pointer_emulation(input_dev, true, false);
 	input_sync(input_dev);
=20
 	return IRQ_HANDLED;
diff --git a/drivers/input/touchscreen/ili210x.c
b/drivers/input/touchscreen/ili210x.c
index ddf694b..5301e2b 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -99,7 +99,7 @@ static void ili210x_report_events(struct input_dev *i=
nput,
 		}
 	}
=20
-	input_mt_report_pointer_emulation(input, false);
+	input_mt_report_pointer_emulation(input, false, false);
 	input_sync(input);
 }
=20
diff --git a/drivers/input/touchscreen/mms114.c
b/drivers/input/touchscreen/mms114.c
index 1fafc9f..4f7b20a 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -221,7 +221,7 @@ static irqreturn_t mms114_interrupt(int irq, void
*dev_id)
 	for (index =3D 0; index < touch_size; index++)
 		mms114_process_mt(data, touch + index);
=20
-	input_mt_report_pointer_emulation(data->input_dev, true);
+	input_mt_report_pointer_emulation(data->input_dev, true, false);
 	input_sync(data->input_dev);
=20
 out:
@@ -528,7 +528,7 @@ static int __maybe_unused mms114_suspend(struct dev=
ice
*dev)
 		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
false);
 	}
=20
-	input_mt_report_pointer_emulation(input_dev, true);
+	input_mt_report_pointer_emulation(input_dev, true, false);
 	input_sync(input_dev);
=20
 	mutex_lock(&input_dev->mutex);
diff --git a/drivers/input/touchscreen/penmount.c
b/drivers/input/touchscreen/penmount.c
index 417d873..ceaf1ee 100644
--- a/drivers/input/touchscreen/penmount.c
+++ b/drivers/input/touchscreen/penmount.c
@@ -81,7 +81,7 @@ static void pm_mtevent(struct pm *pm, struct input_de=
v
*input)
 		}
 	}
=20
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_report_pointer_emulation(input, true, false);
 	input_sync(input);
 }
=20
diff --git a/drivers/input/touchscreen/rohm_bu21023.c
b/drivers/input/touchscreen/rohm_bu21023.c
index 611156a..aecd457 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -627,7 +627,7 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void
*dev_id)
 		}
=20
 		input_mt_sync_frame(input_dev);
-		input_mt_report_pointer_emulation(input_dev, true);
+		input_mt_report_pointer_emulation(input_dev, true, false);
 		input_sync(input_dev);
=20
 		ts->finger_count =3D finger_count;
diff --git a/drivers/input/touchscreen/wacom_w8001.c
b/drivers/input/touchscreen/wacom_w8001.c
index bab3c6a..05164b1 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -176,7 +176,7 @@ static void parse_multi_touch(struct w8001 *w8001)
 	if (w8001->type !=3D BTN_TOOL_PEN &&
 			    w8001->type !=3D BTN_TOOL_RUBBER) {
 		w8001->type =3D count =3D=3D 1 ? BTN_TOOL_FINGER : KEY_RESERVED;
-		input_mt_report_pointer_emulation(dev, true);
+		input_mt_report_pointer_emulation(dev, true, false);
 	}
=20
 	input_sync(dev);
diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
index d7188de..67c7bdd 100644
--- a/include/linux/input/mt.h
+++ b/include/linux/input/mt.h
@@ -104,7 +104,8 @@ void input_mt_report_slot_state(struct input_dev *d=
ev,
 				unsigned int tool_type, bool active);
=20
 void input_mt_report_finger_count(struct input_dev *dev, int count);
-void input_mt_report_pointer_emulation(struct input_dev *dev, bool
use_count);
+void input_mt_report_pointer_emulation(struct input_dev *dev, bool
use_count,
+					bool hover);
 void input_mt_drop_unused(struct input_dev *dev);
=20
 void input_mt_sync_frame(struct input_dev *dev);
--=20
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
