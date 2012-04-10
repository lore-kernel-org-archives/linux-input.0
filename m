From: George Pantalos <gpantalos@gmail.com>
Subject: ALPS v4 Semi-mt Support
Date: Tue, 10 Apr 2012 17:02:41 +0300
Message-ID: <1364401.K99JIOKFyb@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33256 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2DJOAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 10:00:49 -0400
Received: by bkcik5 with SMTP id ik5so4242028bkc.19
        for <linux-input@vger.kernel.org>; Tue, 10 Apr 2012 07:00:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--- drivers/input/mouse/alps.c	2012-03-19 01:15:34.000000000 +0200
+++ drivers/input/mouse/alps.c.new	2012-04-09 17:14:25.193621808 +0300
@@ -604,11 +604,59 @@
 
 static void alps_process_packet_v4(struct psmouse *psmouse)
 {
+        struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
 	int x, y, z;
 	int left, right;
+	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
+	int fingers = 0, bmap_fingers;
+	unsigned int x_bitmap, y_bitmap;
+
+	if (priv->multi_packet) {
+          if (packet[6] != 0x00) { 
+		priv->multi_data_v4[2] = packet[6];
+		priv->multi_data_v4[3] = packet[7];
+		priv->multi_packet = 1;
+		if (priv->last_fingers > 1)
+		return;
+          } else {
+		priv->multi_data_v4[4] = packet[6];
+		priv->multi_data_v4[5] = packet[7];
+
+		fingers = 0;
+		priv->multi_packet = 0;
+		x_bitmap = ((priv->multi_data_v4[2] & 0x1f) << 10) | /*0x1f*/
+			   ((priv->multi_data_v4[3] & 0x60) << 3) |
+			   ((priv->multi_data_v4[0] & 0x3f) << 2) |
+			   ((priv->multi_data_v4[1] & 0x60) >> 5);
+		y_bitmap = ((priv->multi_data_v4[5] & 0x01) << 10) |
+			   ((priv->multi_data_v4[3] & 0x1f) << 5) |
+			    (priv->multi_data_v4[1] & 0x1f);
+	  
+		bmap_fingers = alps_process_bitmap(x_bitmap, y_bitmap,
+						  &x1, &y1, &x2, &y2);
+		if (bmap_fingers > 1) {
+			fingers = bmap_fingers;
+		}
+	  
+		priv->last_fingers = fingers;
 
+          /*packet = priv->multi_data;*/
+          /*packet = packet;*/
+	  }
+	}
+
+	if (!priv->multi_packet && (packet[6] & 0x40)) {
+		priv->multi_packet = 1;
+		priv->multi_data_v4[0] = packet[6];
+		priv->multi_data_v4[1] = packet[7];
+		if (priv->last_fingers > 1)
+		return;
+	}
+	
+        /*priv->multi_packet = 0;*/
+        
 	left = packet[4] & 0x01;
 	right = packet[4] & 0x02;
 
@@ -617,21 +665,33 @@
 	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
 	z = packet[5] & 0x7f;
 
+	if (!fingers) {
+		x1 = x;
+		y1 = y;
+		fingers = z > 0 ? 1 : 0;
+	}
+
 	if (z >= 64)
 		input_report_key(dev, BTN_TOUCH, 1);
 	else
 		input_report_key(dev, BTN_TOUCH, 0);
 
+	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
+	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
+	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
+	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+
 	if (z > 0) {
 		input_report_abs(dev, ABS_X, x);
 		input_report_abs(dev, ABS_Y, y);
 	}
 	input_report_abs(dev, ABS_PRESSURE, z);
 
-	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-
 	input_sync(dev);
 }
 
@@ -1567,8 +1627,18 @@
 		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
 		/* fall through */
 	case ALPS_PROTO_V4:
-		input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
-		input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+		input_mt_init_slots(dev1, 2);
+                input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
+                input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+
+		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, 
ALPS_V3_X_MAX, 0, 0);
+		input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, 
ALPS_V3_Y_MAX, 0, 0);
+
+		set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
+		set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
+		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
+		/* fall through */
 		break;
 	}
 
--- drivers/input/mouse/alps.h	2012-03-19 01:15:34.000000000 +0200
+++ drivers/input/mouse/alps.h.new	2012-04-09 17:17:32.733618703 +0300
@@ -39,6 +39,8 @@
 	int prev_fin;			/* Finger bit from previous packet */
 	int multi_packet;		/* Multi-packet data in progress */
 	unsigned char multi_data[6];	/* Saved multi-packet data */
+	unsigned char multi_data_v4[6];
+	int last_fingers;
 	u8 quirks;
 	struct timer_list timer;
 };

