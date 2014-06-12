From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v2 1/1] elantech: Add support for trackpoint found on some v3 models
Date: Thu, 12 Jun 2014 20:15:01 +0200
Message-ID: <1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
References: <20140214205126.GB15526@lantern>
 <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org
List-Id: linux-input@vger.kernel.org

Some elantech v3 touchpad equipped laptops also have a trackpoint, before
this commit, these give sync errors. With this patch, the trackpoint is
provided as another input device: 'Elantech PS/2 TrackPoint'

The patch will also output messages that do not follow the expected pattern.
In the mean time I've seen 2 unknown packets occasionally:
0x04 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00
0x00 , 0x00 , 0x00 , 0x02 , 0x00 , 0x00
I don't know what those are for, but they can be safely ignored.

Currently all packets that are not known to v3 touchpad and where
packet[3] (the fourth byte) lowest nibble is 6 are now recognized as
PACKET_TRACKPOINT and processed by the new elantech_report_trackpoint.

This has been verified to work on a laptop Lenovo L530 where the
touchpad/trackpoint combined identify themselves as:
psmouse serio1: elantech: assuming hardware version 3 (with firmware version 0x350f02)
psmouse serio1: elantech: Synaptics capabilities query result 0xb9, 0x15, 0x0c.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 104 +++++++++++++++++++++++++++++++++++++++--
 drivers/input/mouse/elantech.h |   4 ++
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ee2a04d..7faec12 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -403,6 +403,63 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void elantech_report_trackpoint(struct psmouse *psmouse,
+				       int packet_type)
+{
+	/* byte 0:  0   0 ~sx ~sy   0   M   R   L */
+	/* byte 1: sx   0   0   0   0   0   0   0 */
+	/* byte 2: sy   0   0   0   0   0   0   0 */
+	/* byte 3:  0   0  sy  sx   0   1   1   0 */
+	/* byte 4: x7  x6  x5  x4  x3  x2  x1  x0 */
+	/* byte 5: y7  y6  y5  y4  y3  y2  y1  y0 */
+
+	/*
+	 * x and y are written in two's complement spread
+	 * over 9 bits with sx/sy the relative top bit and
+	 * x7..x0 and y7..y0 the lower bits.
+	 * The sign of y is opposite to what the input driver
+	 * expects for a relative movement
+	 */
+
+	struct elantech_data *etd = psmouse->private;
+	struct input_dev *tp_dev = etd->tp_dev;
+	unsigned char *packet = psmouse->packet;
+	int x, y;
+
+	if (!etd->trackpoint_present) {
+		psmouse_err(psmouse, "Unexpected trackpoint message\n");
+		if (etd->debug == 1)
+			elantech_packet_dump(psmouse);
+		return;
+	}
+
+	input_report_key(tp_dev, BTN_LEFT, packet[0] & 0x01);
+	input_report_key(tp_dev, BTN_RIGHT, packet[0] & 0x02);
+	input_report_key(tp_dev, BTN_MIDDLE, packet[0] & 0x04);
+	x = (s32) ((u32) ((packet[1] & 0x80) ? 0UL : 0xFFFFFF00UL) | (u32)
+		   packet[4]);
+	y = -(s32) ((u32) ((packet[2] & 0x80) ? 0UL : 0xFFFFFF00UL) | (u32)
+		    packet[5]);
+	input_report_rel(tp_dev, REL_X, x);
+	input_report_rel(tp_dev, REL_Y, y);
+
+	switch ((((u32) packet[0] & 0xF8) << 24) | ((u32) packet[1] << 16)
+		| (u32) packet[2] << 8 | (u32) packet[3]) {
+	case 0x00808036UL:
+	case 0x10008026UL:
+	case 0x20800016UL:
+	case 0x30000006UL:
+		break;
+	default:
+		/* Dump unexpected packet sequences if debug=1 (default) */
+		if (etd->debug == 1)
+			elantech_packet_dump(psmouse);
+		break;
+	}
+
+	input_sync(tp_dev);
+}
+
 /*
  * Interpret complete data packets and report absolute mode input events for
  * hardware version 3. (12 byte packets for two fingers)
@@ -715,6 +772,8 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
 
 		if ((packet[0] & 0x0c) == 0x0c && (packet[3] & 0xce) == 0x0c)
 			return PACKET_V3_TAIL;
+		if ((packet[3]&0x0f) == 0x06)
+			return PACKET_TRACKPOINT;
 	}
 
 	return PACKET_UNKNOWN;
@@ -798,7 +857,10 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 		if (packet_type == PACKET_UNKNOWN)
 			return PSMOUSE_BAD_DATA;
 
-		elantech_report_absolute_v3(psmouse, packet_type);
+		if (packet_type == PACKET_TRACKPOINT)
+			elantech_report_trackpoint(psmouse, packet_type);
+		else
+			elantech_report_absolute_v3(psmouse, packet_type);
 		break;
 
 	case 4:
@@ -1018,8 +1080,10 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
  * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
  * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
+ * Lenovo L530             0x350f02        b9, 15, 0c      2 hw buttons (*) 
  * Samsung NF210           0x150b00        78, 14, 0a      2 hw buttons
  * Samsung NP770Z5E        0x575f01        10, 15, 0f      clickpad
  * Samsung NP700Z5B        0x361f06        21, 15, 0f      clickpad
@@ -1029,6 +1093,8 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Samsung RF710           0x450f00        ?               2 hw buttons
  * System76 Pangolin       0x250f01        ?               2 hw buttons
  * (*) + 3 trackpoint buttons
+ * (**) + 0 trackpoint buttons
+ * Note: Lenovo L430 and Lenovo L430 have the same fw_version/caps
  */
 static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 {
@@ -1324,6 +1390,11 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
  */
 static void elantech_disconnect(struct psmouse *psmouse)
 {
+	struct elantech_data *etd = psmouse->private;
+	struct input_dev *tp_dev = etd->tp_dev;
+
+	if (etd->trackpoint_present && tp_dev) 
+		input_unregister_device(tp_dev);
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
 			   &elantech_attr_group);
 	kfree(psmouse->private);
@@ -1440,11 +1511,11 @@ int elantech_init(struct psmouse *psmouse)
 	struct elantech_data *etd;
 	int i, error;
 	unsigned char param[3];
+	struct input_dev *tp_dev;
 
 	psmouse->private = etd = kzalloc(sizeof(struct elantech_data), GFP_KERNEL);
 	if (!etd)
 		return -ENOMEM;
-
 	psmouse_reset(psmouse);
 
 	etd->parity[0] = 1;
@@ -1497,6 +1568,28 @@ int elantech_init(struct psmouse *psmouse)
 			    error);
 		goto init_fail;
 	}
+	etd->trackpoint_present = ((etd->capabilities[0] & 0x80) == 0x80);
+	if (etd->trackpoint_present) {
+		tp_dev = input_allocate_device();
+		if (!tp_dev)
+			goto init_fail_tp_alloc;
+		etd->tp_dev = tp_dev;
+		snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
+			psmouse->ps2dev.serio->phys);
+		tp_dev->phys = etd->tp_phys;
+		tp_dev->name = "Elantech PS/2 TrackPoint";
+		tp_dev->id.bustype = BUS_I8042;
+		tp_dev->id.vendor  = 0x0002;
+		tp_dev->id.product = PSMOUSE_ELANTECH;
+		tp_dev->id.version = 0x0000;
+		tp_dev->dev.parent = &psmouse->ps2dev.serio->dev;
+		tp_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
+		tp_dev->relbit[BIT_WORD(REL_X)] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
+		tp_dev->keybit[BIT_WORD(BTN_LEFT)] =
+			BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
+		if (input_register_device(etd->tp_dev))
+			goto init_fail_tp_reg;
+	}
 
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
@@ -1504,8 +1597,13 @@ int elantech_init(struct psmouse *psmouse)
 	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
 
 	return 0;
-
+ init_fail_tp_reg:
+	input_free_device(tp_dev);
+ init_fail_tp_alloc:
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
+			   &elantech_attr_group);
  init_fail:
+        psmouse_reset(psmouse);
 	kfree(etd);
 	return -1;
 }
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 9e0e2a1..25cbc8c 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -94,6 +94,7 @@
 #define PACKET_V4_HEAD			0x05
 #define PACKET_V4_MOTION		0x06
 #define PACKET_V4_STATUS		0x07
+#define PACKET_TRACKPOINT		0x08
 
 /*
  * track up to 5 fingers for v4 hardware
@@ -114,6 +115,8 @@ struct finger_pos {
 };
 
 struct elantech_data {
+	struct input_dev *tp_dev;		/* Relative device */
+	char	tp_phys[32];
 	unsigned char reg_07;
 	unsigned char reg_10;
 	unsigned char reg_11;
@@ -130,6 +133,7 @@ struct elantech_data {
 	bool jumpy_cursor;
 	bool reports_pressure;
 	bool crc_enabled;
+	bool trackpoint_present;
 	bool set_hw_resolution;
 	unsigned char hw_version;
 	unsigned int fw_version;
-- 
2.0.0.rc2
