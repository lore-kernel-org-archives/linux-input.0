From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
Subject: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event trigger
Date: Mon, 16 May 2016 19:27:25 +0800
Message-ID: <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw>
References: <C2DEC699-8A1A-484D-83F2-637F5EF94C7B@emc.com.tw> <006901d1acea$8207d090$861771b0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00BF_01D1AFA8.FA5C1400"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:10298 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcEPLjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 07:39:45 -0400
In-Reply-To: <006901d1acea$8207d090$861771b0$@emc.com.tw>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry.torokhov@gmail.com
Cc: zac.hsieh@emc.com.tw, =?big5?B?tsClQMRQILhnsno=?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>

This is a multipart message in MIME format.

------=_NextPart_000_00BF_01D1AFA8.FA5C1400
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable


Only ABS_DISTANCE is not enough for upper OS to distingiush hover event =
be
triggered from object from faraway to and close touchpad surface or from
object prepare to leave the touchpad surface. Add BTN_TOOL_FINGER flag =
to
help it.

                 object_from_faraway    object_inside_hover_area
object_touch_surface
BTN_TOUCH                 0                          0             1
BTN_TOOL_FINGER           0                          1              1
ABS_DISTANCE               0                           1             0

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

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d6fa496..584e98b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -353,7 +353,7 @@ static int magicmouse_raw_event(struct hid_device =
*hdev,
 		input_report_rel(input, REL_Y, y);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		input_report_key(input, BTN_MOUSE, clicks & 1);
-		input_mt_report_pointer_emulation(input, true);
+		input_mt_report_pointer_emulation(input, true, false);
 	}
=20
 	input_sync(input);
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c index
54fce56..30855a5 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -184,6 +184,7 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
  * input_mt_report_pointer_emulation() - common pointer emulation
  * @dev: input device with allocated MT slots
  * @use_count: report number of active contacts as finger count
+ * @hover: report ABS_DISTANCE as hover event
  *
  * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
  * ABS_PRESSURE. Touchpad finger count is emulated if use_count is =
true.
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
@@ -220,6 +222,7 @@ void input_mt_report_pointer_emulation(struct =
input_dev
*dev, bool use_count)
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
 	if (use_count)
 		input_mt_report_finger_count(dev, count);
+	input_event(dev, EV_ABS, ABS_DISTANCE, hover);
=20
 	if (oldest) {
 		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X); @@
-290,7 +293,7 @@ void input_mt_sync_frame(struct input_dev *dev)
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
@@ -845,7 +845,7 @@ static void elan_report_absolute(struct elan_tp_data
*data, u8 *packet)  {
 	struct input_dev *input =3D data->input;
 	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
-	int i;
+	int i, valid_count =3D 0;
 	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
 	u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
 	bool contact_valid, hover_event;
@@ -855,13 +855,16 @@ static void elan_report_absolute(struct =
elan_tp_data
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
diff --git a/drivers/input/mouse/elantech.c =
b/drivers/input/mouse/elantech.c
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
b/drivers/input/mouse/focaltech.c index c8c6a8c..f4339ac 100644
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
b/drivers/input/mouse/synaptics.c index a41d832..09fa835 100644
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
 	input_mt_report_finger_count(dev, num_fingers); diff --git
a/drivers/input/touchscreen/atmel_mxt_ts.c
b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2160512..0ab0d53 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -683,7 +683,7 @@ static void mxt_input_button(struct mxt_data *data, =
u8
*message)  static void mxt_input_sync(struct mxt_data *data)  {
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
@@ -113,7 +113,7 @@ static irqreturn_t egalax_ts_interrupt(int irq, void
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
@@ -99,7 +99,7 @@ static void ili210x_report_events(struct input_dev =
*input,
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
@@ -528,7 +528,7 @@ static int __maybe_unused mms114_suspend(struct =
device
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
@@ -81,7 +81,7 @@ static void pm_mtevent(struct pm *pm, struct input_dev
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
diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h index
d7188de..67c7bdd 100644
--- a/include/linux/input/mt.h
+++ b/include/linux/input/mt.h
@@ -104,7 +104,8 @@ void input_mt_report_slot_state(struct input_dev =
*dev,
 				unsigned int tool_type, bool active);
=20
 void input_mt_report_finger_count(struct input_dev *dev, int count); =
-void
input_mt_report_pointer_emulation(struct input_dev *dev, bool =
use_count);
+void input_mt_report_pointer_emulation(struct input_dev *dev, bool
use_count,
+					bool hover);
 void input_mt_drop_unused(struct input_dev *dev);
=20
 void input_mt_sync_frame(struct input_dev *dev);
--
2.1.4






------=_NextPart_000_00BF_01D1AFA8.FA5C1400
Content-Type: application/octet-stream;
	name="0001-Input-Change-BTN_TOOL_FINGER-flag-when-hover-event-t.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Input-Change-BTN_TOOL_FINGER-flag-when-hover-event-t.patch"

IFrom 7ab46f3f3560b404c07f89632e2fbfacfa447afb Mon Sep 17 00:00:00 2001=0A=
From: Duson Lin <dusonlin@emc.com.tw>=0A=
Date: Sat, 2 Apr 2016 21:26:18 -0700=0A=
Subject: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event =
trigger=0A=
=0A=
Only ABS_DISTANCE is not enough for upper OS to distingiush hover event=0A=
be triggered from object from faraway to and close touchpad surface or=0A=
from object prepare to leave the touchpad surface. Add BTN_TOOL_FINGER=0A=
flag to help it.=0A=
=0A=
                 object_from_faraway    object_inside_hover_area  =
object_touch_surface=0A=
BTN_TOUCH                 0                          0                   =
     1=0A=
BTN_TOOL_FINGER           0                          1                   =
     1=0A=
ABS_DISTANCE              0                          1                   =
     0=0A=
=0A=
Signed-off by: Duson Lin <dusonlin@emc.com.tw>=0A=
---=0A=
 drivers/hid/hid-magicmouse.c             |  2 +-=0A=
 drivers/input/input-mt.c                 |  7 +++++--=0A=
 drivers/input/mouse/elan_i2c_core.c      | 15 +++++++++------=0A=
 drivers/input/mouse/elantech.c           |  2 +-=0A=
 drivers/input/mouse/focaltech.c          |  2 +-=0A=
 drivers/input/mouse/synaptics.c          |  2 +-=0A=
 drivers/input/touchscreen/atmel_mxt_ts.c |  2 +-=0A=
 drivers/input/touchscreen/edt-ft5x06.c   |  2 +-=0A=
 drivers/input/touchscreen/egalax_ts.c    |  2 +-=0A=
 drivers/input/touchscreen/ili210x.c      |  2 +-=0A=
 drivers/input/touchscreen/mms114.c       |  4 ++--=0A=
 drivers/input/touchscreen/penmount.c     |  2 +-=0A=
 drivers/input/touchscreen/rohm_bu21023.c |  2 +-=0A=
 drivers/input/touchscreen/wacom_w8001.c  |  2 +-=0A=
 include/linux/input/mt.h                 |  3 ++-=0A=
 15 files changed, 29 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c=0A=
index d6fa496..584e98b 100644=0A=
--- a/drivers/hid/hid-magicmouse.c=0A=
+++ b/drivers/hid/hid-magicmouse.c=0A=
@@ -353,7 +353,7 @@ static int magicmouse_raw_event(struct hid_device =
*hdev,=0A=
 		input_report_rel(input, REL_Y, y);=0A=
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */=0A=
 		input_report_key(input, BTN_MOUSE, clicks & 1);=0A=
-		input_mt_report_pointer_emulation(input, true);=0A=
+		input_mt_report_pointer_emulation(input, true, false);=0A=
 	}=0A=
 =0A=
 	input_sync(input);=0A=
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c=0A=
index 54fce56..30855a5 100644=0A=
--- a/drivers/input/input-mt.c=0A=
+++ b/drivers/input/input-mt.c=0A=
@@ -184,6 +184,7 @@ EXPORT_SYMBOL(input_mt_report_finger_count);=0A=
  * input_mt_report_pointer_emulation() - common pointer emulation=0A=
  * @dev: input device with allocated MT slots=0A=
  * @use_count: report number of active contacts as finger count=0A=
+ * @hover: report ABS_DISTANCE as hover event=0A=
  *=0A=
  * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and=0A=
  * ABS_PRESSURE. Touchpad finger count is emulated if use_count is true.=0A=
@@ -191,7 +192,8 @@ EXPORT_SYMBOL(input_mt_report_finger_count);=0A=
  * The input core ensures only the KEY and ABS axes already setup for=0A=
  * this device will produce output.=0A=
  */=0A=
-void input_mt_report_pointer_emulation(struct input_dev *dev, bool =
use_count)=0A=
+void input_mt_report_pointer_emulation(struct input_dev *dev, bool =
use_count,=0A=
+					bool hover)=0A=
 {=0A=
 	struct input_mt *mt =3D dev->mt;=0A=
 	struct input_mt_slot *oldest;=0A=
@@ -220,6 +222,7 @@ void input_mt_report_pointer_emulation(struct =
input_dev *dev, bool use_count)=0A=
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);=0A=
 	if (use_count)=0A=
 		input_mt_report_finger_count(dev, count);=0A=
+	input_event(dev, EV_ABS, ABS_DISTANCE, hover);=0A=
 =0A=
 	if (oldest) {=0A=
 		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X);=0A=
@@ -290,7 +293,7 @@ void input_mt_sync_frame(struct input_dev *dev)=0A=
 	if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags & INPUT_MT_SEMI_MT))=0A=
 		use_count =3D true;=0A=
 =0A=
-	input_mt_report_pointer_emulation(dev, use_count);=0A=
+	input_mt_report_pointer_emulation(dev, use_count, false);=0A=
 =0A=
 	mt->frame++;=0A=
 }=0A=
diff --git a/drivers/input/mouse/elan_i2c_core.c =
b/drivers/input/mouse/elan_i2c_core.c=0A=
index 2f58985..8b5e75a 100644=0A=
--- a/drivers/input/mouse/elan_i2c_core.c=0A=
+++ b/drivers/input/mouse/elan_i2c_core.c=0A=
@@ -4,7 +4,7 @@=0A=
  * Copyright (c) 2013 ELAN Microelectronics Corp.=0A=
  *=0A=
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.tw>=0A=
- * Version: 1.6.0=0A=
+ * Version: 1.6.2=0A=
  *=0A=
  * Based on cyapa driver:=0A=
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.=0A=
@@ -40,7 +40,7 @@=0A=
 #include "elan_i2c.h"=0A=
 =0A=
 #define DRIVER_NAME		"elan_i2c"=0A=
-#define ELAN_DRIVER_VERSION	"1.6.1"=0A=
+#define ELAN_DRIVER_VERSION	"1.6.2"=0A=
 #define ELAN_VENDOR_ID		0x04f3=0A=
 #define ETP_MAX_PRESSURE	255=0A=
 #define ETP_FWIDTH_REDUCE	90=0A=
@@ -845,7 +845,7 @@ static void elan_report_absolute(struct elan_tp_data =
*data, u8 *packet)=0A=
 {=0A=
 	struct input_dev *input =3D data->input;=0A=
 	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];=0A=
-	int i;=0A=
+	int i, valid_count =3D 0;=0A=
 	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];=0A=
 	u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];=0A=
 	bool contact_valid, hover_event;=0A=
@@ -855,13 +855,16 @@ static void elan_report_absolute(struct =
elan_tp_data *data, u8 *packet)=0A=
 		contact_valid =3D tp_info & (1U << (3 + i));=0A=
 		elan_report_contact(data, i, contact_valid, finger_data);=0A=
 =0A=
-		if (contact_valid)=0A=
+		if (contact_valid) {=0A=
 			finger_data +=3D ETP_FINGER_DATA_LEN;=0A=
+			valid_count++;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);=0A=
-	input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);=0A=
-	input_mt_report_pointer_emulation(input, true);=0A=
+	input_report_key(input, BTN_TOOL_FINGER,=0A=
+			((hover_event !=3D 0) || (valid_count > 0)));=0A=
+	input_mt_report_pointer_emulation(input, false, hover_event !=3D 0);=0A=
 	input_sync(input);=0A=
 }=0A=
 =0A=
diff --git a/drivers/input/mouse/elantech.c =
b/drivers/input/mouse/elantech.c=0A=
index 78f93cf..cc13e12 100644=0A=
--- a/drivers/input/mouse/elantech.c=0A=
+++ b/drivers/input/mouse/elantech.c=0A=
@@ -558,7 +558,7 @@ static void elantech_input_sync_v4(struct psmouse =
*psmouse)=0A=
 		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(dev, true);=0A=
+	input_mt_report_pointer_emulation(dev, true, false);=0A=
 	input_sync(dev);=0A=
 }=0A=
 =0A=
diff --git a/drivers/input/mouse/focaltech.c =
b/drivers/input/mouse/focaltech.c=0A=
index c8c6a8c..f4339ac 100644=0A=
--- a/drivers/input/mouse/focaltech.c=0A=
+++ b/drivers/input/mouse/focaltech.c=0A=
@@ -144,7 +144,7 @@ static void focaltech_report_state(struct psmouse =
*psmouse)=0A=
 			input_report_abs(dev, ABS_TOOL_WIDTH, state->width);=0A=
 		}=0A=
 	}=0A=
-	input_mt_report_pointer_emulation(dev, true);=0A=
+	input_mt_report_pointer_emulation(dev, true, false);=0A=
 =0A=
 	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);=0A=
 	input_sync(psmouse->dev);=0A=
diff --git a/drivers/input/mouse/synaptics.c =
b/drivers/input/mouse/synaptics.c=0A=
index a41d832..09fa835 100644=0A=
--- a/drivers/input/mouse/synaptics.c=0A=
+++ b/drivers/input/mouse/synaptics.c=0A=
@@ -944,7 +944,7 @@ static void synaptics_report_mt_data(struct psmouse =
*psmouse,=0A=
 	input_mt_drop_unused(dev);=0A=
 =0A=
 	/* Don't use active slot count to generate BTN_TOOL events. */=0A=
-	input_mt_report_pointer_emulation(dev, false);=0A=
+	input_mt_report_pointer_emulation(dev, false, false);=0A=
 =0A=
 	/* Send the number of fingers reported by touchpad itself. */=0A=
 	input_mt_report_finger_count(dev, num_fingers);=0A=
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c =
b/drivers/input/touchscreen/atmel_mxt_ts.c=0A=
index 2160512..0ab0d53 100644=0A=
--- a/drivers/input/touchscreen/atmel_mxt_ts.c=0A=
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c=0A=
@@ -683,7 +683,7 @@ static void mxt_input_button(struct mxt_data *data, =
u8 *message)=0A=
 static void mxt_input_sync(struct mxt_data *data)=0A=
 {=0A=
 	input_mt_report_pointer_emulation(data->input_dev,=0A=
-					  data->pdata->t19_num_keys);=0A=
+					  data->pdata->t19_num_keys, false);=0A=
 	input_sync(data->input_dev);=0A=
 }=0A=
 =0A=
diff --git a/drivers/input/touchscreen/edt-ft5x06.c =
b/drivers/input/touchscreen/edt-ft5x06.c=0A=
index 23fbe38..6533d8e 100644=0A=
--- a/drivers/input/touchscreen/edt-ft5x06.c=0A=
+++ b/drivers/input/touchscreen/edt-ft5x06.c=0A=
@@ -250,7 +250,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void =
*dev_id)=0A=
 		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(tsdata->input, true);=0A=
+	input_mt_report_pointer_emulation(tsdata->input, true, false);=0A=
 	input_sync(tsdata->input);=0A=
 =0A=
 out:=0A=
diff --git a/drivers/input/touchscreen/egalax_ts.c =
b/drivers/input/touchscreen/egalax_ts.c=0A=
index 1afc08b..c420336 100644=0A=
--- a/drivers/input/touchscreen/egalax_ts.c=0A=
+++ b/drivers/input/touchscreen/egalax_ts.c=0A=
@@ -113,7 +113,7 @@ static irqreturn_t egalax_ts_interrupt(int irq, void =
*dev_id)=0A=
 		input_report_abs(input_dev, ABS_MT_PRESSURE, z);=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(input_dev, true);=0A=
+	input_mt_report_pointer_emulation(input_dev, true, false);=0A=
 	input_sync(input_dev);=0A=
 =0A=
 	return IRQ_HANDLED;=0A=
diff --git a/drivers/input/touchscreen/ili210x.c =
b/drivers/input/touchscreen/ili210x.c=0A=
index ddf694b..5301e2b 100644=0A=
--- a/drivers/input/touchscreen/ili210x.c=0A=
+++ b/drivers/input/touchscreen/ili210x.c=0A=
@@ -99,7 +99,7 @@ static void ili210x_report_events(struct input_dev =
*input,=0A=
 		}=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(input, false);=0A=
+	input_mt_report_pointer_emulation(input, false, false);=0A=
 	input_sync(input);=0A=
 }=0A=
 =0A=
diff --git a/drivers/input/touchscreen/mms114.c =
b/drivers/input/touchscreen/mms114.c=0A=
index 1fafc9f..4f7b20a 100644=0A=
--- a/drivers/input/touchscreen/mms114.c=0A=
+++ b/drivers/input/touchscreen/mms114.c=0A=
@@ -221,7 +221,7 @@ static irqreturn_t mms114_interrupt(int irq, void =
*dev_id)=0A=
 	for (index =3D 0; index < touch_size; index++)=0A=
 		mms114_process_mt(data, touch + index);=0A=
 =0A=
-	input_mt_report_pointer_emulation(data->input_dev, true);=0A=
+	input_mt_report_pointer_emulation(data->input_dev, true, false);=0A=
 	input_sync(data->input_dev);=0A=
 =0A=
 out:=0A=
@@ -528,7 +528,7 @@ static int __maybe_unused mms114_suspend(struct =
device *dev)=0A=
 		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, false);=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(input_dev, true);=0A=
+	input_mt_report_pointer_emulation(input_dev, true, false);=0A=
 	input_sync(input_dev);=0A=
 =0A=
 	mutex_lock(&input_dev->mutex);=0A=
diff --git a/drivers/input/touchscreen/penmount.c =
b/drivers/input/touchscreen/penmount.c=0A=
index 417d873..ceaf1ee 100644=0A=
--- a/drivers/input/touchscreen/penmount.c=0A=
+++ b/drivers/input/touchscreen/penmount.c=0A=
@@ -81,7 +81,7 @@ static void pm_mtevent(struct pm *pm, struct input_dev =
*input)=0A=
 		}=0A=
 	}=0A=
 =0A=
-	input_mt_report_pointer_emulation(input, true);=0A=
+	input_mt_report_pointer_emulation(input, true, false);=0A=
 	input_sync(input);=0A=
 }=0A=
 =0A=
diff --git a/drivers/input/touchscreen/rohm_bu21023.c =
b/drivers/input/touchscreen/rohm_bu21023.c=0A=
index 611156a..aecd457 100644=0A=
--- a/drivers/input/touchscreen/rohm_bu21023.c=0A=
+++ b/drivers/input/touchscreen/rohm_bu21023.c=0A=
@@ -627,7 +627,7 @@ static irqreturn_t rohm_ts_soft_irq(int irq, void =
*dev_id)=0A=
 		}=0A=
 =0A=
 		input_mt_sync_frame(input_dev);=0A=
-		input_mt_report_pointer_emulation(input_dev, true);=0A=
+		input_mt_report_pointer_emulation(input_dev, true, false);=0A=
 		input_sync(input_dev);=0A=
 =0A=
 		ts->finger_count =3D finger_count;=0A=
diff --git a/drivers/input/touchscreen/wacom_w8001.c =
b/drivers/input/touchscreen/wacom_w8001.c=0A=
index bab3c6a..05164b1 100644=0A=
--- a/drivers/input/touchscreen/wacom_w8001.c=0A=
+++ b/drivers/input/touchscreen/wacom_w8001.c=0A=
@@ -176,7 +176,7 @@ static void parse_multi_touch(struct w8001 *w8001)=0A=
 	if (w8001->type !=3D BTN_TOOL_PEN &&=0A=
 			    w8001->type !=3D BTN_TOOL_RUBBER) {=0A=
 		w8001->type =3D count =3D=3D 1 ? BTN_TOOL_FINGER : KEY_RESERVED;=0A=
-		input_mt_report_pointer_emulation(dev, true);=0A=
+		input_mt_report_pointer_emulation(dev, true, false);=0A=
 	}=0A=
 =0A=
 	input_sync(dev);=0A=
diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h=0A=
index d7188de..67c7bdd 100644=0A=
--- a/include/linux/input/mt.h=0A=
+++ b/include/linux/input/mt.h=0A=
@@ -104,7 +104,8 @@ void input_mt_report_slot_state(struct input_dev =
*dev,=0A=
 				unsigned int tool_type, bool active);=0A=
 =0A=
 void input_mt_report_finger_count(struct input_dev *dev, int count);=0A=
-void input_mt_report_pointer_emulation(struct input_dev *dev, bool =
use_count);=0A=
+void input_mt_report_pointer_emulation(struct input_dev *dev, bool =
use_count,=0A=
+					bool hover);=0A=
 void input_mt_drop_unused(struct input_dev *dev);=0A=
 =0A=
 void input_mt_sync_frame(struct input_dev *dev);=0A=
-- =0A=
2.1.4=0A=
=0A=

------=_NextPart_000_00BF_01D1AFA8.FA5C1400--

