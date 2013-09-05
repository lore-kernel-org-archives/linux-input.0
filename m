From: "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>
Subject: [PATCH 1/2] Input: ALPS Touchpad- Improve the performance of alps
 v5-protocol's touchpad
Date: Thu, 5 Sep 2013 05:50:48 +0000
Message-ID: <89B48266C4EEC447B3A3A031C8DE21870263AF88@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:39721
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000Ab3IEFux convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Sep 2013 01:50:53 -0400
Content-Language: zh-CN
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>

<Change list>
- Calculate the device's dimension in alps_identify().
- Change the logic of packet decoding.
- Add the new data process logic.
- Change the dev2's name from "PS/2 Mouse" to "ALPS Touchpad".

--- linux-3.11/drivers/input/mouse/alps.c.orig 2013-09-04 19:51:23.585085033 +0800
+++ linux-3.11/drivers/input/mouse/alps.c 2013-09-05 11:58:02.000000000 +0800
@@ -257,6 +257,74 @@ static void alps_process_packet_v1_v2(st
 }
 
 /*
+ * Process bitmap data for V5 protocols. Return value is null.
+ *
+ * The bitmaps don't have enough data to track fingers, so this function
+ * only generates points representing a bounding box of at most two contacts.
+ * These two points are returned in x1, y1, x2, and y2.
+ */
+static void alps_process_bitmap_dolphin(struct alps_data *priv, struct alps_fields *fields,
+          int *x1, int *y1, int *x2, int *y2)
+{
+ struct alps_palm_bitmap {
+  int start_bit;
+  int end_bit;
+ };
+
+ int i;
+ int box_middle_x, box_middle_y;
+ unsigned int x_map, y_map;
+ struct alps_palm_bitmap x_bitmap = {0}, y_bitmap = {0};
+
+ x_map = fields->x_map;
+ y_map = fields->y_map;
+
+ if (!x_map || !y_map)
+  return;
+
+ *x1 = *y1 = *x2 = *y2 = 0;
+
+ if (fields->fingers > 1) {
+  for (i = 0;  i < 32; i++) {
+   if (x_map & (1 << i)) {
+    x_bitmap.end_bit = priv->x_bits - i;
+    break;
+   }
+  }
+
+  for (i = 31; i >= 0; i--) {
+   if (x_map & (1 << i)) {
+    x_bitmap.start_bit = priv->x_bits - i;
+    break;
+   }
+  }
+
+  for (i = 0;  i < 32; i++) {
+   if (y_map & (1 << i)) {
+    y_bitmap.start_bit = i;
+    break;
+   }
+  }
+
+  for (i = 31; i >= 0; i--) {
+   if (y_map & (1 << i)) {
+    y_bitmap.end_bit = i;
+    break;
+   }
+  }
+
+  box_middle_x = (priv->x_max * (x_bitmap.start_bit + x_bitmap.end_bit)) /
+          (2 * (priv->x_bits - 1));
+  box_middle_y = (priv->y_max * (y_bitmap.start_bit + y_bitmap.end_bit)) /
+          (2 * (priv->y_bits - 1));
+  *x1 = fields->x;
+  *y1 = fields->y;
+  *x2 = 2 * box_middle_x - *x1;
+  *y2 = 2 * box_middle_y - *y1;
+ }
+}
+
+/*
  * Process bitmap data from v3 and v4 protocols. Returns the number of
  * fingers detected. A return value of 0 means at least one of the
  * bitmaps was empty.
@@ -461,7 +529,7 @@ static void alps_decode_buttons_v3(struc
  f->ts_middle = !!(p[3] & 0x40);
 }
 
-static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
+static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p, struct psmouse *psmouse)
 {
  f->first_mp = !!(p[4] & 0x40);
  f->is_mp = !!(p[0] & 0x40);
@@ -482,35 +550,65 @@ static void alps_decode_pinnacle(struct
  alps_decode_buttons_v3(f, p);
 }
 
-static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
+static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p, struct psmouse *psmouse)
 {
- alps_decode_pinnacle(f, p);
+ alps_decode_pinnacle(f, p, psmouse);
 
  f->x_map |= (p[5] & 0x10) << 11;
  f->y_map |= (p[5] & 0x20) << 6;
 }
 
-static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p)
+static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p, struct psmouse *psmouse)
 {
+ unsigned int palm_high = 0, palm_low = 0, palm_mask = 0;
+ int i, remain_xbits;
+ struct alps_data *priv = psmouse->private;
+
  f->first_mp = !!(p[0] & 0x02);
  f->is_mp = !!(p[0] & 0x20);
 
- f->fingers = ((p[0] & 0x6) >> 1 |
+ if (!f->is_mp) {
+  f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
+  f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
+  f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
+  alps_decode_buttons_v3(f, p);
+ } else {
+  f->fingers = ((p[0] & 0x6) >> 1 |
        (p[0] & 0x10) >> 2);
- f->x_map = ((p[2] & 0x60) >> 5) |
-     ((p[4] & 0x7f) << 2) |
-     ((p[5] & 0x7f) << 9) |
-     ((p[3] & 0x07) << 16) |
-     ((p[3] & 0x70) << 15) |
-     ((p[0] & 0x01) << 22);
- f->y_map = (p[1] & 0x7f) |
-     ((p[2] & 0x1f) << 7);
-
- f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
- f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
- f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
 
- alps_decode_buttons_v3(f, p);
+  palm_low = (p[1] & 0x7f) |
+      ((p[2] & 0x7f) << 7) |
+      ((p[4] & 0x7f) << 14) |
+      ((p[5] & 0x7f) << 21) |
+      ((p[3] & 0x07) << 28) | ((p[3] & 0x10) << 27);
+  palm_high = ((p[3] & 0x60) >> 5) | ((p[0] & 0x01) << 2);
+
+  for (i = 0; i < priv->y_bits; i++) {
+   palm_mask |= 1 << i;
+  }
+  /* Y-profile is stored in P(0) to p(n), n = y_bits; */
+  f->y_map = palm_low & palm_mask;
+
+  /* X-profile is stored in p(n) to p(n+x_bits). */
+  palm_mask = 0;
+  for (i = priv->y_bits; i < 32 && i < priv->y_bits + priv->x_bits; i++) {
+   palm_mask |= 1 << i;
+  }
+  f->x_map = ((palm_low & (palm_mask)) >> priv->y_bits);
+
+  /* 
+   * In some cases, palm_low's 32bit is not enough to save all X&Y-profiles,
+   * we need to use palm_high.
+   */
+  remain_xbits = priv->x_bits + priv->y_bits - 32;
+  if (remain_xbits > 0) {
+   palm_mask = 0;
+   for (i = 0; i < remain_xbits; i++) {
+    palm_mask |= 1 << i;
+   }
+   f->x_map |= ((palm_high & palm_mask) << (32- priv->y_bits));
+  }
+ }
 }
 
 static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
@@ -523,7 +621,7 @@ static void alps_process_touchpad_packet
  int fingers = 0, bmap_fingers;
  struct alps_fields f;
 
- priv->decode_fields(&f, packet);
+ priv->decode_fields(&f, packet, psmouse);
 
  /*
   * There's no single feature of touchpad position and bitmap packets
@@ -552,7 +650,7 @@ static void alps_process_touchpad_packet
     fingers = bmap_fingers;
 
    /* Now process position packet */
-   priv->decode_fields(&f, priv->multi_data);
+   priv->decode_fields(&f, priv->multi_data, psmouse);
   } else {
    priv->multi_packet = 0;
   }
@@ -742,6 +840,111 @@ static void alps_process_packet_v4(struc
  input_sync(dev);
 }
 
+
+static void alps_process_touchpad_packet_v5(struct psmouse *psmouse)
+{
+ struct alps_data *priv = psmouse->private;
+ unsigned char *packet = psmouse->packet;
+ struct input_dev *dev = psmouse->dev;
+ int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
+ int fingers = 0;
+ struct alps_fields f;
+
+ priv->decode_fields(&f, packet, psmouse);
+
+ /*
+  * There's no single feature of touchpad position and bitmap packets
+  * that can be used to distinguish between them. We rely on the fact
+  * that a bitmap packet should always follow a position packet with
+  * bit 6 of packet[4] set.
+  */
+ if (priv->multi_packet) {
+  /*
+   * Sometimes a position packet will indicate a multi-packet
+   * sequence, but then what follows is another position
+   * packet. Check for this, and when it happens process the
+   * position packet as usual.
+   */
+  if (f.is_mp) {
+   fingers = f.fingers;
+   priv->decode_fields(&f, priv->multi_data, psmouse);
+   alps_process_bitmap_dolphin(priv, &f, &x1, &y1, &x2, &y2);
+  } else {
+   priv->multi_packet = 0;
+  }
+ }
+
+ /*
+  * Bit 6 of byte 0 is not usually set in position packets. The only
+  * times it seems to be set is in situations where the data is
+  * suspect anyway, e.g. a palm resting flat on the touchpad. Given
+  * this combined with the fact that this bit is useful for filtering
+  * out misidentified bitmap packets, we reject anything with this
+  * bit set.
+  */
+ if (f.is_mp)
+  return;
+
+ if (!priv->multi_packet && f.first_mp) {
+  priv->multi_packet = 1;
+  memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
+  return;
+ }
+
+ priv->multi_packet = 0;
+
+ /*
+  * Sometimes the hardware sends a single packet with z = 0
+  * in the middle of a stream. Real releases generate packets
+  * with x, y, and z all zero, so these seem to be flukes.
+  * Ignore them.
+  */
+ if (f.x && f.y && !f.z)
+  return;
+
+ /*
+  * If we don't have MT data or the bitmaps were empty, we have
+  * to rely on ST data.
+  */
+ if (!fingers) {
+  x1 = f.x;
+  y1 = f.y;
+  fingers = f.z > 0 ? 1 : 0;
+ }
+
+ if (f.z >= 64)
+  input_report_key(dev, BTN_TOUCH, 1);
+ else
+  input_report_key(dev, BTN_TOUCH, 0);
+
+ alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+ input_mt_report_finger_count(dev, fingers);
+
+ input_report_key(dev, BTN_LEFT, f.left);
+ input_report_key(dev, BTN_RIGHT, f.right);
+ input_report_key(dev, BTN_MIDDLE, f.middle);
+
+ if (f.z > 0) {
+  input_report_abs(dev, ABS_X, f.x);
+  input_report_abs(dev, ABS_Y, f.y);
+ }
+ input_report_abs(dev, ABS_PRESSURE, f.z);
+
+ input_sync(dev);
+}
+
+static void alps_process_packet_v5(struct psmouse *psmouse)
+{
+ unsigned char *packet = psmouse->packet;
+
+ /* Ignore stick point data */
+ if (packet[0] == 0xD8)
+  return;
+
+ alps_process_touchpad_packet_v5(psmouse);
+}
+
 static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
      unsigned char packet[],
      bool report_buttons)
@@ -1519,6 +1722,40 @@ error:
  return -1;
 }
 
+static int alps_dolphin_get_device_area(struct psmouse *psmouse, struct alps_data *priv)
+{
+ struct ps2dev *ps2dev = &psmouse->ps2dev;
+ unsigned char param[4] = {0};
+ int num_x_electrode, num_y_electrode;
+
+ if (alps_enter_command_mode(psmouse))
+  return -1;
+
+ if (ps2_command(ps2dev, NULL, 0x00EC) ||
+     ps2_command(ps2dev, NULL, 0x00F0) ||
+     ps2_command(ps2dev, NULL, 0x00F0) ||
+     ps2_command(ps2dev, NULL, 0x00F3) ||
+     ps2_command(ps2dev, NULL, 0x000A) ||
+     ps2_command(ps2dev, NULL, 0x00F3) ||
+     ps2_command(ps2dev, NULL, 0x000A))
+  return -1;
+
+ if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+  return -1;
+
+ num_x_electrode = DOLPHIN_PROFILE_XOFFSET + ( param[2] & 0x0F );
+ num_y_electrode = DOLPHIN_PROFILE_YOFFSET + ( (param[2] >> 4) & 0x0F );
+ priv->x_bits = num_x_electrode;
+ priv->y_bits = num_y_electrode;
+ priv->x_max = (num_x_electrode - 1 ) * DOLPHIN_COUNT_PER_ELECTRODE;
+ priv->y_max = (num_y_electrode - 1 ) * DOLPHIN_COUNT_PER_ELECTRODE;
+
+ if (alps_exit_command_mode(psmouse))
+  return -1;
+
+ return 0;
+}
+
 static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
 {
  struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -1571,7 +1808,7 @@ static void alps_set_defaults(struct alp
   break;
  case ALPS_PROTO_V5:
   priv->hw_init = alps_hw_init_dolphin_v1;
-  priv->process_packet = alps_process_packet_v3;
+  priv->process_packet = alps_process_packet_v5;
   priv->decode_fields = alps_decode_dolphin;
   priv->set_abs_params = alps_set_abs_params_mt;
   priv->nibble_commands = alps_v3_nibble_commands;
@@ -1645,11 +1882,13 @@ static int alps_identify(struct psmouse
  if (alps_match_table(psmouse, priv, e7, ec) == 0) {
   return 0;
  } else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
-     ec[0] == 0x73 && ec[1] == 0x01) {
+     ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
   priv->proto_version = ALPS_PROTO_V5;
   alps_set_defaults(priv);
-
-  return 0;
+  if (alps_dolphin_get_device_area(psmouse, priv))
+   return -EIO;
+  else
+   return 0;
  } else if (ec[0] == 0x88 && ec[1] == 0x08) {
   priv->proto_version = ALPS_PROTO_V3;
   alps_set_defaults(priv);
@@ -1792,7 +2031,7 @@ int alps_init(struct psmouse *psmouse)
  snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
  dev2->phys = priv->phys;
  dev2->name = (priv->flags & ALPS_DUALPOINT) ?
-       "DualPoint Stick" : "PS/2 Mouse";
+       "DualPoint Stick" : "ALPS Touchpad";
  dev2->id.bustype = BUS_I8042;
  dev2->id.vendor  = 0x0002;
  dev2->id.product = PSMOUSE_ALPS;

-Tommy
