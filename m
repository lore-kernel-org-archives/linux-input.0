From: "DusonLin" <dusonlin@emc.com.tw>
Subject: [PATCH] Input: Change BTN_TOOL_FINGER falg when HOVER event trigger
Date: Wed, 30 Mar 2016 10:02:02 +0800
Message-ID: <002801d18a28$2a12dfe0$7e389fa0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:28372 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbcC3CCM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 22:02:12 -0400
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, Linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: 'Charles Mooney' <charliemooney@google.com>, 'jeff' <jeff.chuang@emc.com.tw>, 'Phoenix' <phoenix@emc.com.tw>

Only ABS_DISTANCE is not enough for upper OS  to distiguish hover event
be triggered from object form faraway to and close touchpad surface or =
from
object prepare to leave the touchpad surface. We add BNT_TOOL_FINGER to=
 help
it.

                 Object_at_faraway   object_at_hover_area  object_touch=
_touchpad
      BTN_TOUCH         0                      0                    1
BTN_TOOL_FINGER         0                      1                    1
   ABS_DISTANCE         0                      1                    0

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
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
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
-       int i;
+      int i, valid_count =3D 0;
      u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
      u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
      bool contact_valid, hover_event;

-       hover_event =3D hover_info & 0x40;
+      hover_event =3D (hover_info & 0x40);
      for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
              contact_valid =3D tp_info & (1U << (3 + i));
              elan_report_contact(data, i, contact_valid, finger_data);

-               if (contact_valid)
+              if (contact_valid) {
                      finger_data +=3D ETP_FINGER_DATA_LEN;
+                      valid_count++;
+              }
      }

       input_report_key(input, BTN_LEFT, tp_info & 0x01);
+      input_report_key(input, BTN_TOOL_FINGER,
+                      ((hover_event !=3D 0) | (valid_count > 0)));
      input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
-       input_mt_report_pointer_emulation(input, true);
+      input_mt_report_pointer_emulation(input, false);
      input_sync(input);
}

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
