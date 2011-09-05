From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v5 7/8] Input: elantech - add v3 hardware support
Date: Mon,  5 Sep 2011 10:16:46 +0800
Message-ID: <1315189007-2179-8-git-send-email-jj_ding@emc.com.tw>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:65306 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab1IECOo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Sep 2011 22:14:44 -0400
In-Reply-To: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>

v3 hardware's packet format is almost identical to v2 (one/three finger=
 touch),
except when sensing two finger touch, the hardware sends 12 bytes of da=
ta.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Acked-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 Documentation/input/elantech.txt |  117 +++++++++++++++++++---
 drivers/input/mouse/elantech.c   |  204 ++++++++++++++++++++++++++++++=
++++---
 drivers/input/mouse/elantech.h   |   12 +++
 3 files changed, 304 insertions(+), 29 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/ela=
ntech.txt
index bce9941..cee08ee 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -16,15 +16,22 @@ Contents
=20
  1. Introduction
  2. Extra knobs
- 3. Hardware version 1
-    3.1 Registers
-    3.2 Native relative mode 4 byte packet format
-    3.3 Native absolute mode 4 byte packet format
- 4. Hardware version 2
+ 3. Differentiating hardware versions
+ 4. Hardware version 1
     4.1 Registers
-    4.2 Native absolute mode 6 byte packet format
-        4.2.1 One finger touch
-        4.2.2 Two finger touch
+    4.2 Native relative mode 4 byte packet format
+    4.3 Native absolute mode 4 byte packet format
+ 5. Hardware version 2
+    5.1 Registers
+    5.2 Native absolute mode 6 byte packet format
+        5.2.1 Parity checking and packet re-synchronization
+        5.2.2 One/Three finger touch
+        5.2.3 Two finger touch
+ 6. Hardware version 3
+    6.1 Registers
+    6.2 Native absolute mode 6 byte packet format
+        6.2.1 One/Three finger touch
+        6.2.2 Two finger touch
=20
=20
=20
@@ -375,7 +382,7 @@ For all the other ones, there are just a few consta=
nt bits:
=20
 In case an error is detected, all the packets are shifted by one (and =
packet[0] is discarded).
=20
-5.2.1 One/Three finger touch
+5.2.2 One/Three finger touch
       ~~~~~~~~~~~~~~~~
=20
 byte 0:
@@ -384,7 +391,7 @@ byte 0:
 	 n1  n0  w3  w2   .   .   R   L
=20
          L, R =3D 1 when Left, Right mouse button pressed
-         n1..n0 =3D numbers of fingers on touchpad
+         n1..n0 =3D number of fingers on touchpad
=20
 byte 1:
=20
@@ -432,7 +439,7 @@ byte 5:
          y11..y0 =3D absolute y value (vertical)
=20
=20
-4.2.2 Two finger touch
+5.2.3 Two finger touch
       ~~~~~~~~~~~~~~~~
=20
 Note that the two pairs of coordinates are not exactly the coordinates=
 of the
@@ -446,7 +453,7 @@ byte 0:
         n1  n0  ay8 ax8  .   .   R   L
=20
          L, R =3D 1 when Left, Right mouse button pressed
-         n1..n0 =3D numbers of fingers on touchpad
+         n1..n0 =3D number of fingers on touchpad
=20
 byte 1:
=20
@@ -480,3 +487,89 @@ byte 5:
         by7 by8 by5 by4 by3 by2 by1 by0
=20
          by8..by0 =3D upper-right finger absolute y value
+
+//////////////////////////////////////////////////////////////////////=
///////
+
+6. Hardware version 3
+   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+6.1 Registers
+    ~~~~~~~~~
+* reg_10
+
+   bit   7   6   5   4   3   2   1   0
+         0   0   0   0   0   0   0   A
+
+         A: 1 =3D enable absolute tracking
+
+6.2 Native absolute mode 6 byte packet format
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+1 and 3 finger touch shares the same 6-byte packet format, except that
+3 finger touch only reports the position of the center of all three fi=
ngers.
+
+Firmware would send 12 bytes of data for 2 finger touch.
+
+Note on debounce:
+In case the box has unstable power supply or other electricity issues,=
 or
+when number of finger changes, F/W would send "debounce packet" to inf=
orm
+driver that the hardware is in debounce status.
+The debouce packet has the following signature:
+    byte 0: 0xc4
+    byte 1: 0xff
+    byte 2: 0xff
+    byte 3: 0x02
+    byte 4: 0xff
+    byte 5: 0xff
+When we encounter this kind of packet, we just ignore it.
+
+6.2.1 One/Three finger touch
+      ~~~~~~~~~~~~~~~~~~~~~~
+
+byte 0:
+
+   bit   7   6   5   4   3   2   1   0
+        n1  n0  w3  w2   0   1   R   L
+
+        L, R =3D 1 when Left, Right mouse button pressed
+        n1..n0 =3D number of fingers on touchpad
+
+byte 1:
+
+   bit   7   6   5   4   3   2   1   0
+        p7  p6  p5  p4 x11 x10  x9  x8
+
+byte 2:
+
+   bit   7   6   5   4   3   2   1   0
+        x7  x6  x5  x4  x3  x2  x1  x0
+
+        x11..x0 =3D absolute x value (horizontal)
+
+byte 3:
+
+   bit   7   6   5   4   3   2   1   0
+         0   0  w1  w0   0   0   1   0
+
+         w3..w0 =3D width of the finger touch
+
+byte 4:
+
+   bit   7   6   5   4   3   2   1   0
+        p3  p1  p2  p0  y11 y10 y9  y8
+
+        p7..p0 =3D pressure
+
+byte 5:
+
+   bit   7   6   5   4   3   2   1   0
+        y7  y6  y5  y4  y3  y2  y1  y0
+
+        y11..y0 =3D absolute y value (vertical)
+
+6.2.2 Two finger touch
+      ~~~~~~~~~~~~~~~~
+
+The packet format is exactly the same for two finger touch, except the=
 hardware
+sends two 6 byte packets. The first packet contains data for the first=
 finger,
+the second packet has data for the second finger. So for two finger to=
uch a
+total of 12 bytes are sent.
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 2ae7c49..c4ceefd 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -108,6 +108,16 @@ static int elantech_read_reg(struct psmouse *psmou=
se, unsigned char reg,
 			rc =3D -1;
 		}
 		break;
+
+	case 3:
+		if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+		    elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
+		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+		    elantech_ps2_command(psmouse, NULL, reg) ||
+		    elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO)) {
+			rc =3D -1;
+		}
+		break;
 	}
=20
 	if (rc)
@@ -154,6 +164,18 @@ static int elantech_write_reg(struct psmouse *psmo=
use, unsigned char reg,
 			rc =3D -1;
 		}
 		break;
+
+	case 3:
+		if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+		    elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
+		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+		    elantech_ps2_command(psmouse, NULL, reg) ||
+		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+		    elantech_ps2_command(psmouse, NULL, val) ||
+		    elantech_ps2_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11)) {
+			rc =3D -1;
+		}
+		break;
 	}
=20
 	if (rc)
@@ -350,6 +372,84 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 	input_sync(dev);
 }
=20
+/*
+ * Interpret complete data packets and report absolute mode input even=
ts for
+ * hardware version 3. (12 byte packets for two fingers)
+ */
+static void elantech_report_absolute_v3(struct psmouse *psmouse,
+					int packet_type)
+{
+	struct input_dev *dev =3D psmouse->dev;
+	struct elantech_data *etd =3D psmouse->private;
+	unsigned char *packet =3D psmouse->packet;
+	unsigned int fingers =3D 0, x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0;
+	unsigned int width =3D 0, pres =3D 0;
+
+	/* byte 0: n1  n0   .   .   .   .   R   L */
+	fingers =3D (packet[0] & 0xc0) >> 6;
+
+	switch (fingers) {
+	case 3:
+	case 1:
+		/*
+		 * byte 1:  .   .   .   .  x11 x10 x9  x8
+		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
+		 */
+		x1 =3D ((packet[1] & 0x0f) << 8) | packet[2];
+		/*
+		 * byte 4:  .   .   .   .  y11 y10 y9  y8
+		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
+		 */
+		y1 =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+		break;
+
+	case 2:
+		if (packet_type =3D=3D PACKET_V3_HEAD) {
+			/*
+			 * byte 1:   .    .    .    .  ax11 ax10 ax9  ax8
+			 * byte 2: ax7  ax6  ax5  ax4  ax3  ax2  ax1  ax0
+			 */
+			etd->prev_x =3D ((packet[1] & 0x0f) << 8) | packet[2];
+			/*
+			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
+			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
+			 */
+			etd->prev_y =3D etd->y_max -
+				(((packet[4] & 0x0f) << 8) | packet[5]);
+			/*
+			 * wait for next packet
+			 */
+			return;
+		}
+
+		/* packet_type =3D=3D PACKET_V3_TAIL */
+		x1 =3D etd->prev_x;
+		y1 =3D etd->prev_y;
+		x2 =3D ((packet[1] & 0x0f) << 8) | packet[2];
+		y2 =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
+		break;
+	}
+
+	pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
+	width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
+
+	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
+	if (fingers !=3D 0) {
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
+	}
+	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
+	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
+	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
+	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
+	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	input_report_abs(dev, ABS_PRESSURE, pres);
+	input_report_abs(dev, ABS_TOOL_WIDTH, width);
+
+	input_sync(dev);
+}
+
 static int elantech_packet_check_v1(struct psmouse *psmouse)
 {
 	struct elantech_data *etd =3D psmouse->private;
@@ -403,11 +503,37 @@ static int elantech_packet_check_v2(struct psmous=
e *psmouse)
 }
=20
 /*
+ * We check the constant bits to determine what packet type we get,
+ * so packet checking is mandatory for v3 hardware.
+ */
+static int elantech_packet_check_v3(struct psmouse *psmouse)
+{
+	const u8 debounce_packet[] =3D { 0xc4, 0xff, 0xff, 0x02, 0xff, 0xff }=
;
+	unsigned char *packet =3D psmouse->packet;
+
+	/*
+	 * check debounce first, it has the same signature in byte 0
+	 * and byte 3 as PACKET_V3_HEAD.
+	 */
+	if (!memcmp(packet, debounce_packet, sizeof(debounce_packet)))
+		return PACKET_DEBOUNCE;
+
+	if ((packet[0] & 0x0c) =3D=3D 0x04 && (packet[3] & 0xcf) =3D=3D 0x02)
+		return PACKET_V3_HEAD;
+
+	if ((packet[0] & 0x0c) =3D=3D 0x0c && (packet[3] & 0xce) =3D=3D 0x0c)
+		return PACKET_V3_TAIL;
+
+	return PACKET_UNKNOWN;
+}
+
+/*
  * Process byte stream from mouse and handle complete packets
  */
 static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 {
 	struct elantech_data *etd =3D psmouse->private;
+	int packet_type;
=20
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
@@ -429,6 +555,18 @@ static psmouse_ret_t elantech_process_byte(struct =
psmouse *psmouse)
=20
 		elantech_report_absolute_v2(psmouse);
 		break;
+
+	case 3:
+		packet_type =3D elantech_packet_check_v3(psmouse);
+		/* ignore debounce */
+		if (packet_type =3D=3D PACKET_DEBOUNCE)
+			return PSMOUSE_FULL_PACKET;
+
+		if (packet_type =3D=3D PACKET_UNKNOWN)
+			return PSMOUSE_BAD_DATA;
+
+		elantech_report_absolute_v3(psmouse, packet_type);
+		break;
 	}
=20
 	return PSMOUSE_FULL_PACKET;
@@ -463,8 +601,15 @@ static int elantech_set_absolute_mode(struct psmou=
se *psmouse)
 		    elantech_write_reg(psmouse, 0x11, etd->reg_11) ||
 		    elantech_write_reg(psmouse, 0x21, etd->reg_21)) {
 			rc =3D -1;
-			break;
 		}
+		break;
+
+	case 3:
+		etd->reg_10 =3D 0x0b;
+		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
+			rc =3D -1;
+
+		break;
 	}
=20
 	if (rc =3D=3D 0) {
@@ -498,11 +643,12 @@ static int elantech_set_absolute_mode(struct psmo=
use *psmouse)
 	return rc;
 }
=20
-static void set_range(struct psmouse *psmouse, unsigned int *x_min,
+static int set_range(struct psmouse *psmouse, unsigned int *x_min,
 		     unsigned int *y_min, unsigned int *x_max,
 		     unsigned int *y_max)
 {
 	struct elantech_data *etd =3D psmouse->private;
+	unsigned char param[3];
 	int i;
=20
 	switch (etd->hw_version) {
@@ -530,19 +676,30 @@ static void set_range(struct psmouse *psmouse, un=
signed int *x_min,
 			*y_max =3D (etd->capabilities[2] - i) * 64;
 		}
 		break;
+
+	case 3:
+		if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+			return -1;
+
+		*x_max =3D (0x0f & param[0]) << 8 | param[1];
+		*y_max =3D (0xf0 & param[0]) << 4 | param[2];
+		break;
 	}
+
+	return 0;
 }
=20
 /*
  * Set the appropriate event bits for the input subsystem
  */
-static void elantech_set_input_params(struct psmouse *psmouse)
+static int elantech_set_input_params(struct psmouse *psmouse)
 {
 	struct input_dev *dev =3D psmouse->dev;
 	struct elantech_data *etd =3D psmouse->private;
 	unsigned int x_min =3D 0, y_min =3D 0, x_max =3D 0, y_max =3D 0;
=20
-	set_range(psmouse, &x_min, &y_min, &x_max, &y_max);
+	if (set_range(psmouse, &x_min, &y_min, &x_max, &y_max))
+		return -1;
=20
 	__set_bit(EV_KEY, dev->evbit);
 	__set_bit(EV_ABS, dev->evbit);
@@ -570,6 +727,9 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
=20
 	case 2:
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
+		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
+		/* fall through */
+	case 3:
 		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
 		if (etd->reports_pressure) {
@@ -578,7 +738,6 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
 					     ETP_WMAX_V2, 0, 0);
 		}
-		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
 		input_mt_init_slots(dev, 2);
 		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
@@ -586,6 +745,8 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
 	}
=20
 	etd->y_max =3D y_max;
+
+	return 0;
 }
=20
 struct elantech_attr_data {
@@ -727,7 +888,8 @@ int elantech_detect(struct psmouse *psmouse, bool s=
et_properties)
 	 * Report this in case there are Elantech models that use a different
 	 * set of magic numbers
 	 */
-	if (param[0] !=3D 0x3c || param[1] !=3D 0x03 || param[2] !=3D 0xc8) {
+	if (param[0] !=3D 0x3c || param[1] !=3D 0x03 ||
+	    (param[2] !=3D 0xc8 && param[2] !=3D 0x00)) {
 		pr_debug("unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
 			 param[0], param[1], param[2]);
 		return -1;
@@ -793,16 +955,16 @@ static int elantech_reconnect(struct psmouse *psm=
ouse)
 /*
  * determine hardware version and set some properties according to it.
  */
-static void elantech_set_properties(struct elantech_data *etd)
+static int elantech_set_properties(struct elantech_data *etd)
 {
-	/*
-	 * Assume every version greater than 0x020030 is new EeePC style
-	 * hardware with 6 byte packets, except 0x020600
-	 */
 	if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x020600)
 		etd->hw_version =3D 1;
-	else
+	else if (etd->fw_version < 0x150600)
 		etd->hw_version =3D 2;
+	else if ((etd->fw_version & 0x0f0000) >> 16 =3D=3D 5)
+		etd->hw_version =3D 3;
+	else
+		return -1;
=20
 	/*
 	 * Turn on packet checking by default.
@@ -817,13 +979,15 @@ static void elantech_set_properties(struct elante=
ch_data *etd)
 	etd->jumpy_cursor =3D
 		(etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x020600)=
;
=20
-	if (etd->hw_version =3D=3D 2) {
+	if (etd->hw_version > 1) {
 		/* For now show extra debug information */
 		etd->debug =3D 1;
=20
 		if (etd->fw_version >=3D 0x020800)
 			etd->reports_pressure =3D true;
 	}
+
+	return 0;
 }
=20
 /*
@@ -850,9 +1014,12 @@ int elantech_init(struct psmouse *psmouse)
 		pr_err("failed to query firmware version.\n");
 		goto init_fail;
 	}
-
 	etd->fw_version =3D (param[0] << 16) | (param[1] << 8) | param[2];
-	elantech_set_properties(etd);
+
+	if (elantech_set_properties(etd)) {
+		pr_err("unknown hardware version, aborting...\n");
+		goto init_fail;
+	}
 	pr_info("assuming hardware version %d "
 		"(with firmware version 0x%02x%02x%02x)\n",
 		etd->hw_version, param[0], param[1], param[2]);
@@ -871,7 +1038,10 @@ int elantech_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
=20
-	elantech_set_input_params(psmouse);
+	if (elantech_set_input_params(psmouse)) {
+		pr_err("failed to query touchpad range.\n");
+		goto init_fail;
+	}
=20
 	error =3D sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
 				   &elantech_attr_group);
@@ -883,7 +1053,7 @@ int elantech_init(struct psmouse *psmouse)
 	psmouse->protocol_handler =3D elantech_process_byte;
 	psmouse->disconnect =3D elantech_disconnect;
 	psmouse->reconnect =3D elantech_reconnect;
-	psmouse->pktsize =3D etd->hw_version =3D=3D 2 ? 6 : 4;
+	psmouse->pktsize =3D etd->hw_version > 1 ? 6 : 4;
=20
 	return 0;
=20
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index d9e6144..236c33c 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -16,6 +16,7 @@
 /*
  * Command values for Synaptics style queries
  */
+#define ETP_FW_ID_QUERY			0x00
 #define ETP_FW_VERSION_QUERY		0x01
 #define ETP_CAPABILITIES_QUERY		0x02
=20
@@ -24,6 +25,7 @@
  */
 #define ETP_REGISTER_READ		0x10
 #define ETP_REGISTER_WRITE		0x11
+#define ETP_REGISTER_READWRITE		0x00
=20
 /*
  * Hardware version 2 custom PS/2 command value
@@ -79,6 +81,14 @@
 #define ETP_WMIN_V2			0
 #define ETP_WMAX_V2			15
=20
+/*
+ * v3 hardware has 2 kinds of packet types.
+ */
+#define PACKET_UNKNOWN			0x01
+#define PACKET_DEBOUNCE			0x02
+#define PACKET_V3_HEAD			0x03
+#define PACKET_V3_TAIL			0x04
+
 struct elantech_data {
 	unsigned char reg_10;
 	unsigned char reg_11;
@@ -98,6 +108,8 @@ struct elantech_data {
 	unsigned int fw_version;
 	unsigned int single_finger_reports;
 	unsigned int y_max;
+	unsigned int prev_x;
+	unsigned int prev_y;
 	unsigned char parity[256];
 };
=20
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
