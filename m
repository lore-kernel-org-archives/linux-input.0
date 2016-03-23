From: duson <dusonlin@emc.com.tw>
Subject: [PATCH] Input: Change BTN_TOOL_FINGER falg when HOVER event trigger
Date: Wed, 23 Mar 2016 13:43:00 +0800
Message-ID: <B7757601-8BD3-457E-998D-D6D636789E3F@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:46143 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcCWFxd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 01:53:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: duson <dusonlin@emc.com.tw>, Charles Mooney <charliemooney@google.com>, =?big5?B?tsClQMRQ?= <phoenix@emc.com.tw>

Only ABS_DISTANCE is not enough for upper OS  to distiguish hover event
be triggered from object form faraway to and close touchpad surface or =
from
object prepare to leave the touchpad surface. We add BNT_TOOL_FINGER to=
 help
it.

                                         Object_at_faraway   object_at_=
hover_area  object_touch_touchpad
             BTN_TOUCH              0                                0 =
                                    1
BTN_TOOL_FINGER              0                               1         =
                             1
        ABS_DISTANCE              0                               1    =
                                  0

Signed-off by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 2f58985..9392a8c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =AAL=ACF=BA=FB (Duson Lin) <dusonlin@emc.com.tw>
- * Version: 1.6.0
+ * Version: 1.6.1
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -845,23 +845,27 @@ static void elan_report_absolute(struct elan_tp_d=
ata *data, u8 *packet)
 {
 	struct input_dev *input =3D data->input;
 	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
-	int i;
+	int i, valid_count =3D 0;
 	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
 	u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
 	bool contact_valid, hover_event;
=20
-	hover_event =3D hover_info & 0x40;
+	hover_event =3D (hover_info & 0x40);
 	for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
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
+	input_report_key(input, BTN_TOOL_FINGER,
+			((hover_event !=3D 0) | (valid_count > 0)));
 	input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_report_pointer_emulation(input, false);
 	input_sync(input);
 }
=20
--=20
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
