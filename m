From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v4 1/2] elantech: Add support for trackpoint found
 on some v3 models
Date: Sun, 24 Aug 2014 15:14:24 -0700
Message-ID: <20140824221424.GA15090@core.coreip.homeip.net>
References: <1408558692-11736-1-git-send-email-ulrik.debie-os@e2big.org>
 <1408558692-11736-2-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43595 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaHXWO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Aug 2014 18:14:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so19094024pdj.21
        for <linux-input@vger.kernel.org>; Sun, 24 Aug 2014 15:14:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408558692-11736-2-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

Hi Ulrik,

On Wed, Aug 20, 2014 at 08:18:11PM +0200, Ulrik De Bie wrote:
> +
> +	t = (((u32)packet[0] & 0xF8) << 24) | ((u32)packet[1] << 16)
> +		| (u32)packet[2] << 8 | (u32)packet[3];

Majority of devices with Elantech will be little-endian devices, so if we use
get_unaligned_le32() we'll save a few ops. Does the version of patch below
still work for you?

Thanks!

-- 
Dmitry


Input: elantech - add support for trackpoint found on some v3 models

From: Ulrik De Bie <ulrik.debie-os@e2big.org>

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

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c |  136 +++++++++++++++++++++++++++++++++++++---
 drivers/input/mouse/elantech.h |    3 +
 2 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ee2a04d..b4d645a 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -18,6 +18,7 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <asm/unaligned.h>
 #include "psmouse.h"
 #include "elantech.h"
 
@@ -403,6 +404,68 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void elantech_report_trackpoint(struct psmouse *psmouse,
+				       int packet_type)
+{
+	/*
+	 * byte 0:  0   0 ~sx ~sy   0   M   R   L
+	 * byte 1: sx   0   0   0   0   0   0   0
+	 * byte 2: sy   0   0   0   0   0   0   0
+	 * byte 3:  0   0  sy  sx   0   1   1   0
+	 * byte 4: x7  x6  x5  x4  x3  x2  x1  x0
+	 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
+	 *
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
+	u32 t;
+
+	if (dev_WARN_ONCE(&psmouse->ps2dev.serio->dev,
+			  !tp_dev,
+			  psmouse_fmt("Unexpected trackpoint message\n"))) {
+		if (etd->debug == 1)
+			elantech_packet_dump(psmouse);
+		return;
+	}
+
+	t = get_unaligned_le32(&packet[0]);
+
+	switch (t & ~7U) {
+	case 0x06000030U:
+	case 0x16008020U:
+	case 0x26800010U:
+	case 0x36808000U:
+		x = packet[4] - (int)(packet[1] << 1);
+		y = (int)(packet[2] << 1) - packet[5];
+
+		input_report_key(tp_dev, BTN_LEFT, packet[0] & 0x01);
+		input_report_key(tp_dev, BTN_RIGHT, packet[0] & 0x02);
+		input_report_key(tp_dev, BTN_MIDDLE, packet[0] & 0x04);
+
+		input_report_rel(tp_dev, REL_X, x);
+		input_report_rel(tp_dev, REL_Y, y);
+
+		input_sync(tp_dev);
+
+		break;
+
+	default:
+		/* Dump unexpected packet sequences if debug=1 (default) */
+		if (etd->debug == 1)
+			elantech_packet_dump(psmouse);
+
+		break;
+	}
+}
+
 /*
  * Interpret complete data packets and report absolute mode input events for
  * hardware version 3. (12 byte packets for two fingers)
@@ -715,6 +778,8 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
 
 		if ((packet[0] & 0x0c) == 0x0c && (packet[3] & 0xce) == 0x0c)
 			return PACKET_V3_TAIL;
+		if ((packet[3] & 0x0f) == 0x06)
+			return PACKET_TRACKPOINT;
 	}
 
 	return PACKET_UNKNOWN;
@@ -791,14 +856,23 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 
 	case 3:
 		packet_type = elantech_packet_check_v3(psmouse);
-		/* ignore debounce */
-		if (packet_type == PACKET_DEBOUNCE)
-			return PSMOUSE_FULL_PACKET;
-
-		if (packet_type == PACKET_UNKNOWN)
+		switch (packet_type) {
+		case PACKET_UNKNOWN:
 			return PSMOUSE_BAD_DATA;
 
-		elantech_report_absolute_v3(psmouse, packet_type);
+		case PACKET_DEBOUNCE:
+			/* ignore debounce */
+			break;
+
+		case PACKET_TRACKPOINT:
+			elantech_report_trackpoint(psmouse, packet_type);
+			break;
+
+		default:
+			elantech_report_absolute_v3(psmouse, packet_type);
+			break;
+		}
+
 		break;
 
 	case 4:
@@ -1018,8 +1092,10 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
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
@@ -1029,6 +1105,8 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Samsung RF710           0x450f00        ?               2 hw buttons
  * System76 Pangolin       0x250f01        ?               2 hw buttons
  * (*) + 3 trackpoint buttons
+ * (**) + 0 trackpoint buttons
+ * Note: Lenovo L430 and Lenovo L430 have the same fw_version/caps
  */
 static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 {
@@ -1324,6 +1402,10 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
  */
 static void elantech_disconnect(struct psmouse *psmouse)
 {
+	struct elantech_data *etd = psmouse->private;
+
+	if (etd->tp_dev)
+		input_unregister_device(etd->tp_dev);
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
 			   &elantech_attr_group);
 	kfree(psmouse->private);
@@ -1438,8 +1520,10 @@ static int elantech_set_properties(struct elantech_data *etd)
 int elantech_init(struct psmouse *psmouse)
 {
 	struct elantech_data *etd;
-	int i, error;
+	int i;
+	int error = -EINVAL;
 	unsigned char param[3];
+	struct input_dev *tp_dev;
 
 	psmouse->private = etd = kzalloc(sizeof(struct elantech_data), GFP_KERNEL);
 	if (!etd)
@@ -1498,14 +1582,48 @@ int elantech_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
+	/* The MSB indicates the presence of the trackpoint */
+	if ((etd->capabilities[0] & 0x80) == 0x80) {
+		tp_dev = input_allocate_device();
+
+		if (!tp_dev) {
+			error = -ENOMEM;
+			goto init_fail_tp_alloc;
+		}
+
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
+		tp_dev->relbit[BIT_WORD(REL_X)] =
+			BIT_MASK(REL_X) | BIT_MASK(REL_Y);
+		tp_dev->keybit[BIT_WORD(BTN_LEFT)] =
+			BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) |
+			BIT_MASK(BTN_RIGHT);
+		error = input_register_device(etd->tp_dev);
+		if (error < 0)
+			goto init_fail_tp_reg;
+	}
+
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
 	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
 
 	return 0;
-
+ init_fail_tp_reg:
+	input_free_device(tp_dev);
+ init_fail_tp_alloc:
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
+			   &elantech_attr_group);
  init_fail:
 	kfree(etd);
-	return -1;
+	return error;
 }
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 9e0e2a1..6f3afec 100644
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
+	struct input_dev *tp_dev;	/* Relative device for trackpoint */
+	char tp_phys[32];
 	unsigned char reg_07;
 	unsigned char reg_10;
 	unsigned char reg_11;
