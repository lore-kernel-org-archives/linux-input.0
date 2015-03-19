From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Support Alps Touchpad SS4 device
Date: Fri, 20 Mar 2015 05:35:15 +0800
Message-ID: <1426800915-6020-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34738 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbCSVf1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 17:35:27 -0400
Received: by pdbni2 with SMTP id ni2so87874524pdb.1
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 14:35:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, hdegoede@redhat.com
Cc: linux-input@vger.kernel.org, 012nexus@gmail.com, Masaki Ota <masaki.ota@jp.alps.com>

>From Masaki Ota <masaki.ota@jo.alps.com>

<ChangePoint>
- Support SS4 device as ALPS_PROT_V8
- SS4 device has two types. One is a button type, the other is a buttonless type.
- SS4 supports four-finger data.
---
Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/input/mouse/alps.c | 472 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/input/mouse/alps.h |  94 ++++++++-
 2 files changed, 554 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index d28726a..57b7cbd 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -153,6 +153,10 @@ static const struct alps_protocol_info alps_v7_protocol_data = {
 	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
 };
 
+static const struct alps_protocol_info alps_v8_protocol_data = {
+	ALPS_PROTO_V8, 0x18, 0x18, 0
+};
+
 static void alps_set_abs_params_st(struct alps_data *priv,
 				   struct input_dev *dev1);
 static void alps_set_abs_params_mt(struct alps_data *priv,
@@ -436,12 +440,15 @@ static int alps_process_bitmap(struct alps_data *priv,
 	return fingers;
 }
 
-static void alps_set_slot(struct input_dev *dev, int slot, int x, int y)
+static void alps_set_slot(struct input_dev *dev, int slot, bool active,
+			  int x, int y)
 {
 	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
-	input_report_abs(dev, ABS_MT_POSITION_X, x);
-	input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
+	if (active) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	}
 }
 
 static void alps_report_mt_data(struct psmouse *psmouse, int n)
@@ -453,7 +460,7 @@ static void alps_report_mt_data(struct psmouse *psmouse, int n)
 
 	input_mt_assign_slots(dev, slot, f->mt, n, 0);
 	for (i = 0; i < n; i++)
-		alps_set_slot(dev, slot[i], f->mt[i].x, f->mt[i].y);
+		alps_set_slot(dev, slot[i], 1, f->mt[i].x, f->mt[i].y);
 
 	input_mt_sync_frame(dev);
 }
@@ -1085,6 +1092,325 @@ static void alps_process_packet_v7(struct psmouse *psmouse)
 		alps_process_touchpad_packet_v7(psmouse);
 }
 
+unsigned char alps_get_pkt_id_ss4_v2(char *byte)
+{
+	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
+
+	if (((byte[0] & 0xFF) == 0x18) && ((byte[1] & 0xFF) == 0x10) &&
+	     ((byte[2] & 0xFF) == 0x00) && ((byte[3] & 0x88) == 0x08) &&
+	     ((byte[4] & 0xFF) == 0x10) && ((byte[5] & 0xFF) == 0x00)) {
+		pkt_id = SS4_PACKET_ID_IDLE;
+	} else if (!(byte[3] & 0x10)) {
+		pkt_id = SS4_PACKET_ID_ONE;
+	} else {
+		if (!(byte[3] & 0x20))
+			pkt_id = SS4_PACKET_ID_TWO;
+		else
+			pkt_id = SS4_PACKET_ID_MULTI;
+	}
+
+	return pkt_id;
+}
+
+static void alps_process_btnless_click(struct psmouse *psmouse,
+			struct alps_fields *f)
+{
+	struct alps_data *priv = psmouse->private;
+
+	if (!f->left)
+		return;
+
+	/* Clear button flag */
+	f->left = 0;
+
+	switch (f->fingers) {
+	case 1:
+		/* In Left Resting Area */
+		if (PT_IN_LEFT_BTN_AREA(f->mt[0].x, f->mt[0].y,
+			priv->x_max, priv->y_max)) {
+			f->left = 1;
+		/* In Right Resting Area */
+		} else if (PT_IN_RIGHT_BTN_AREA(f->mt[0].x, f->mt[0].y,
+			priv->x_max, priv->y_max)) {
+			f->right = 1;
+		/* In Normal area */
+		} else {
+			f->left = 1;
+		}
+		break;
+
+	case 2:
+		/* Both two fingers are in Normal area */
+		if (!PT_IN_BTN_AREA(f->mt[0].x, f->mt[0].y,
+			priv->x_max, priv->y_max) &&
+			!PT_IN_BTN_AREA(f->mt[1].x, f->mt[1].y,
+			priv->x_max, priv->y_max)) {
+			f->right = 1;
+		/* Either one finger is in Right Area */
+		} else if (PT_IN_RIGHT_BTN_AREA(f->mt[0].x, f->mt[0].y,
+			priv->x_max, priv->y_max) ||
+			PT_IN_RIGHT_BTN_AREA(f->mt[1].x, f->mt[1].y,
+			priv->x_max, priv->y_max)) {
+			f->right = 1;
+		} else {
+			f->left = 1;
+		}
+		break;
+
+	case 3:
+		f->middle = 1;
+		break;
+
+	case 0:
+	default:
+		break;
+	}
+}
+
+static void alps_process_resting_finger(struct psmouse *psmouse,
+	struct alps_fields *f, struct input_mt_pos *output,
+	unsigned char *p_fn)
+{
+	struct alps_data *priv = psmouse->private;
+	static struct input_mt_pos prev_data[10];
+	static unsigned char is_moved[10];
+	static unsigned char prev_fn;
+	unsigned char in_resting_area[10];
+	unsigned char i, index;
+	unsigned char output_fn = 0;
+
+	memset(in_resting_area, 0, sizeof(in_resting_area));
+
+	/* Simulate finger lift when finger number changed */
+	if (f->fingers != prev_fn) {
+		memset(is_moved, 0, sizeof(is_moved));
+		output_fn = 0;
+		goto end;
+	}
+
+	/* Calculate output finger */
+	for (i = 0, index = 0; i < f->fingers; i++) {
+		if (is_moved[i] == 0 &&
+			(abs(f->mt[i].x - prev_data[i].x)
+			> RESTING_FN_LARGE_MOVEMENT)) {
+			is_moved[i] = 1;
+		}
+
+		/* Check if in resting area */
+		if (PT_IN_BTN_AREA(f->mt[i].x, f->mt[i].y,
+			priv->x_max, priv->y_max)) {
+			in_resting_area[i] = 1;
+		}
+
+		if (!in_resting_area[i] ||
+			(in_resting_area[i] && is_moved[i])) {
+			memcpy(&output[index++], &f->mt[i],
+				sizeof(struct input_mt_pos));
+			output_fn++;
+		}
+	}
+
+end:
+	memcpy(prev_data, f->mt, sizeof(f->mt));
+	prev_fn = f->fingers;
+	*p_fn = output_fn;
+}
+
+static int alps_decode_ss4_v2(struct alps_fields *f,
+			unsigned char *p, struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char pkt_id;
+	unsigned int no_data_x, no_data_y;
+
+	if (!psmouse || !f || !p)
+		return 0;
+
+	pkt_id = alps_get_pkt_id_ss4_v2(p);
+
+	/* Current packet is 1Finger coordinate packet */
+	switch (pkt_id) {
+	case SS4_PACKET_ID_ONE:
+		f->mt[0].x = SS4_1F_X_V2(p);
+		f->mt[0].y = SS4_1F_Y_V2(p);
+		f->pressure = ((SS4_1F_Z_V2(p)) * 2) & 0x7f;
+		f->fingers = 1;
+		f->first_mp = 0;
+		f->is_mp = 0;
+		break;
+
+	case SS4_PACKET_ID_TWO:
+		if (priv->flags & ALPS_BUTTONPAD) {
+			f->mt[0].x = SS4_BTL_MF_X_V2(p, 0);
+			f->mt[0].y = SS4_BTL_MF_Y_V2(p, 0);
+			f->mt[1].x = SS4_BTL_MF_X_V2(p, 1);
+			f->mt[1].y = SS4_BTL_MF_Y_V2(p, 1);
+		} else {
+			f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
+			f->mt[0].y = SS4_STD_MF_Y_V2(p, 0);
+			f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
+			f->mt[1].y = SS4_STD_MF_Y_V2(p, 1);
+		}
+		f->pressure = SS4_MF_Z_V2(p, 0) ? 0x30 : 0;
+
+		if (SS4_IS_MF_CONTINUE(p)) {
+			f->first_mp = 1;
+		} else {
+			f->fingers = 2;
+			f->first_mp = 0;
+		}
+		f->is_mp = 0;
+
+		break;
+
+	case SS4_PACKET_ID_MULTI:
+		if (priv->flags & ALPS_BUTTONPAD) {
+			f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
+			f->mt[2].y = SS4_BTL_MF_Y_V2(p, 0);
+			f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
+			f->mt[3].y = SS4_BTL_MF_Y_V2(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX_BL;
+			no_data_y = SS4_MFPACKET_NO_AY_BL;
+		} else {
+			f->mt[2].x = SS4_STD_MF_X_V2(p, 0);
+			f->mt[2].y = SS4_STD_MF_Y_V2(p, 0);
+			f->mt[3].x = SS4_STD_MF_X_V2(p, 1);
+			f->mt[3].y = SS4_STD_MF_Y_V2(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX;
+			no_data_y = SS4_MFPACKET_NO_AY;
+		}
+
+		f->first_mp = 0;
+		f->is_mp = 1;
+
+		if (SS4_IS_5F_DETECTED(p)) {
+			f->fingers = 5;
+		} else if (f->mt[3].x == no_data_x &&
+			     f->mt[3].y == no_data_y) {
+			f->mt[3].x = 0;
+			f->mt[3].y = 0;
+			f->fingers = 3;
+		} else {
+			f->fingers = 4;
+		}
+		break;
+
+	case SS4_PACKET_ID_IDLE:
+	default:
+		memset(f, 0, sizeof(struct alps_fields));
+		break;
+	}
+
+	f->left = !!(SS4_BTN_V2(p) & 0x01);
+	if (!(priv->flags & ALPS_BUTTONPAD)) {
+		f->right = !!(SS4_BTN_V2(p) & 0x02);
+		f->middle = !!(SS4_BTN_V2(p) & 0x04);
+	}
+
+	return 0;
+}
+
+static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = psmouse->dev;
+	struct alps_fields f;
+	struct input_mt_pos output_data[5];
+	unsigned char output_fn;
+	int i;
+
+	memset(&f, 0, sizeof(struct alps_fields));
+	priv->decode_fields(&f, packet, psmouse);
+
+	if (priv->multi_packet) {
+		/*
+		 * Sometimes the first packet will indicate a multi-packet
+		 * sequence, but sometimes the next multi-packet would not come.
+		 * Check for this, and when it happens process the
+		 * position packet as usual.
+		 */
+		if (f.is_mp) {
+			/* Now process the 1st packet */
+			priv->decode_fields(&f, priv->multi_data, psmouse);
+		} else {
+			priv->multi_packet = 0;
+		}
+	}
+
+	/*
+	 * "f.is_mp" would always be '0' after merging the 1st and 2nd packet.
+	 * When it is set, it means 2nd packet comes without 1st packet come.
+	 */
+	if (f.is_mp)
+		return;
+
+	/* Save the first packet */
+	if (!priv->multi_packet && f.first_mp) {
+		priv->multi_packet = 1;
+		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
+		return;
+	}
+
+	priv->multi_packet = 0;
+
+	/* Set "output_data" and "output_fn" */
+	memset(&output_data[0], 0, sizeof(output_data));
+
+	if (priv->flags & ALPS_BUTTONPAD) {
+		alps_process_resting_finger(psmouse, &f,
+			output_data, &output_fn);
+		alps_process_btnless_click(psmouse, &f);
+	} else {
+		memcpy(&output_data[0], &f.mt[0],
+			sizeof(struct input_mt_pos) * f.fingers);
+		output_fn = f.fingers;
+	}
+
+	f.x = output_data[0].x;
+	f.y = output_data[0].y;
+	if (f.x && f.y)
+		f.z = f.pressure;
+
+	if (f.pressure)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+	for (i = 0; i < 4; i++) {
+		if (!output_data[i].x || !output_data[i].y) {
+			alps_set_slot(dev, i, 0,
+				output_data[i].x, output_data[i].y);
+		} else {
+			alps_set_slot(dev, i, 1,
+				output_data[i].x, output_data[i].y);
+		}
+	}
+
+	input_mt_report_finger_count(dev, output_fn);
+
+	input_report_key(dev, BTN_LEFT, f.left);
+	input_report_key(dev, BTN_RIGHT, f.right);
+	input_report_key(dev, BTN_MIDDLE, f.middle);
+
+	if (f.z > 0) {
+		input_report_abs(dev, ABS_X, f.x);
+		input_report_abs(dev, ABS_Y, f.y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, f.z);
+
+	input_sync(dev);
+}
+
+static bool alps_is_valid_package_ss4_v2(struct psmouse *psmouse)
+{
+	if (psmouse->pktcnt == 4 && ((psmouse->packet[3] & 0x08) != 0x08))
+		return false;
+	if (psmouse->pktcnt == 6 && ((psmouse->packet[5] & 0x10) != 0x0))
+		return false;
+	return true;
+}
+
 static DEFINE_MUTEX(alps_mutex);
 
 static void alps_register_bare_ps2_mouse(struct work_struct *work)
@@ -1287,8 +1613,10 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	 * a device connected to the external PS/2 port. Because bare PS/2
 	 * protocol does not have enough constant bits to self-synchronize
 	 * properly we only do this if the device is fully synchronized.
+	 * Can not distinguish V8's first byte from PS/2 packet's
 	 */
-	if (!psmouse->out_of_sync_cnt && (psmouse->packet[0] & 0xc8) == 0x08) {
+	if (!psmouse->out_of_sync_cnt && (psmouse->packet[0] & 0xc8) == 0x08 &&
+		priv->proto_version != ALPS_PROTO_V8) {
 
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (unlikely(!priv->dev3))
@@ -1345,8 +1673,10 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_BAD_DATA;
 	}
 
-	if (priv->proto_version == ALPS_PROTO_V7 &&
-	    !alps_is_valid_package_v7(psmouse)) {
+	if ((priv->proto_version == ALPS_PROTO_V7 &&
+		!alps_is_valid_package_v7(psmouse)) ||
+	    (priv->proto_version == ALPS_PROTO_V8 &&
+		!alps_is_valid_package_ss4_v2(psmouse))) {
 		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
 			    psmouse->pktcnt - 1,
 			    psmouse->packet[psmouse->pktcnt - 1]);
@@ -2121,6 +2451,77 @@ error:
 	return -1;
 }
 
+static int alps_get_otp_values_ss4_v2(struct psmouse *psmouse,
+			unsigned char index, unsigned char otp[])
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	switch (index) {
+	case 0:
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
+		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
+			return -1;
+
+		break;
+
+	case 1:
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
+		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
+			return -1;
+
+		break;
+	}
+
+	return 0;
+}
+
+int alps_update_device_area_ss4_v2(unsigned char otp[][4],
+			struct alps_data *priv)
+{
+	int	num_x_electrode;
+	int	num_y_electrode;
+
+	num_x_electrode = SS4_NUMSENSOR_XOFFSET + (otp[1][0]		& 0x0F);
+	num_y_electrode = SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
+
+	priv->x_max = (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+	priv->y_max = (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+	return 0;
+}
+
+int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
+{
+
+	unsigned char is_btnless = 0;
+
+	is_btnless = (otp[1][1] >> 3) &  0x01;
+
+	if (is_btnless)
+		priv->flags |= ALPS_BUTTONPAD;
+
+	return 0;
+}
+
+static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
+			struct alps_data *priv)
+{
+	unsigned char otp[2][4];
+
+	memset(otp, 0, sizeof(otp));
+
+	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
+	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
+		return -1;
+
+	alps_update_device_area_ss4_v2(otp, priv);
+
+	alps_update_btn_info_ss4_v2(otp, priv);
+
+	return 0;
+}
+
 static int alps_dolphin_get_device_area(struct psmouse *psmouse,
 					struct alps_data *priv)
 {
@@ -2213,6 +2614,37 @@ error:
 	return ret;
 }
 
+static int alps_hw_init_ss4_v2(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	char param[2] = {0x64, 0x28};
+	int ret = -1;
+
+	/* enter absolute mode */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE)) {
+		goto error;
+	}
+
+#if 1
+	/* T.B.D. Decread noise packet number, delete in the future */
+	if (alps_exit_command_mode(psmouse) ||
+	    alps_enter_command_mode(psmouse) ||
+	    alps_command_mode_write_reg(psmouse, 0x001D, 0x20)) {
+		goto error;
+	}
+	alps_exit_command_mode(psmouse);
+#endif
+
+	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+error:
+	alps_exit_command_mode(psmouse);
+	return ret;
+}
+
 static int alps_set_protocol(struct psmouse *psmouse,
 			     struct alps_data *priv,
 			     const struct alps_protocol_info *protocol)
@@ -2311,6 +2743,20 @@ static int alps_set_protocol(struct psmouse *psmouse,
 			priv->flags |= ALPS_BUTTONPAD;
 
 		break;
+
+	case ALPS_PROTO_V8:
+		priv->hw_init = alps_hw_init_ss4_v2;
+		priv->process_packet = alps_process_packet_ss4_v2;
+		priv->decode_fields = alps_decode_ss4_v2;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->x_max = 0xfff;
+		priv->y_max = 0x7ff;
+		if (alps_set_defaults_ss4_v2(psmouse, priv))
+			return -EIO;
+
+		break;
 	}
 
 	return 0;
@@ -2379,6 +2825,9 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
 			   ec[2] >= 0x90 && ec[2] <= 0x9d) {
 			protocol = &alps_v3_protocol_data;
+		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
+				e7[2] == 0x14 && ec[1] == 0x02) {
+					protocol = &alps_v8_protocol_data;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
@@ -2444,8 +2893,9 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
 	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
 
-	/* V7 is real multi-touch */
-	if (priv->proto_version == ALPS_PROTO_V7)
+	/* V7,V8 is real multi-touch */
+	if (priv->proto_version == ALPS_PROTO_V7 ||
+		priv->proto_version == ALPS_PROTO_V8)
 		clear_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
 }
 
@@ -2498,7 +2948,7 @@ int alps_init(struct psmouse *psmouse)
 		dev1->keybit[BIT_WORD(BTN_1)] |= BIT_MASK(BTN_1);
 		dev1->keybit[BIT_WORD(BTN_2)] |= BIT_MASK(BTN_2);
 		dev1->keybit[BIT_WORD(BTN_3)] |= BIT_MASK(BTN_3);
-	} else if (priv->flags & ALPS_BUTTONPAD) {
+	} else if (priv->proto_version == ALPS_PROTO_V7) {
 		set_bit(INPUT_PROP_BUTTONPAD, dev1->propbit);
 		clear_bit(BTN_RIGHT, dev1->keybit);
 	} else {
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 02513c0..fd913f2 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -22,14 +22,103 @@
 #define ALPS_PROTO_V5		0x500
 #define ALPS_PROTO_V6		0x600
 #define ALPS_PROTO_V7		0x700	/* t3btl t4s */
+#define ALPS_PROTO_V8		0x800	/* SS4btl SS4s */
 
-#define MAX_TOUCHES	2
+#define MAX_TOUCHES	4
 
 #define DOLPHIN_COUNT_PER_ELECTRODE	64
 #define DOLPHIN_PROFILE_XOFFSET		8	/* x-electrode offset */
 #define DOLPHIN_PROFILE_YOFFSET		1	/* y-electrode offset */
 
 /*
+ * enum SS4_PACKET_ID - defines the packet type for V8
+ * SS4_PACKET_ID_IDLE: There's no finger and no button activity.
+ * SS4_PACKET_ID_ONE: There's one finger on touchpad
+ *  or there's button activities.
+ * SS4_PACKET_ID_TWO: There's two or more fingers on touchpad
+ * SS4_PACKET_ID_MULTI: There's three or more fingers on touchpad
+*/
+enum SS4_PACKET_ID {
+	SS4_PACKET_ID_IDLE = 0,
+	SS4_PACKET_ID_ONE,
+	SS4_PACKET_ID_TWO,
+	SS4_PACKET_ID_MULTI,
+};
+
+#define SS4_COUNT_PER_ELECTRODE			256
+#define SS4_NUMSENSOR_XOFFSET			7
+#define SS4_NUMSENSOR_YOFFSET			7
+
+#define SS4_MASK_NORMAL_BUTTONS	0x07
+
+#define SS4_1F_X_V2(_b)	((_b[0] & 0x0007) | \
+		((_b[1] << 3) & 0x0078) | \
+		((_b[1] << 2) & 0x0380) | \
+		((_b[2] << 5) & 0x1C00) \
+		)
+
+#define SS4_1F_Y_V2(_b)	(((_b[2]) & 0x000F) | \
+		((_b[3] >> 2) & 0x0030) | \
+		((_b[4] << 6) & 0x03C0) | \
+		((_b[4] << 5) & 0x0C00) \
+		)
+
+#define SS4_1F_Z_V2(_b)	(((_b[5]) & 0x0F) | \
+		((_b[5] >> 1) & 0x70) | \
+		((_b[4]) & 0x80) \
+		)
+
+#define	SS4_1F_LFB_V2(_b)	(((_b[2] >> 4) & 0x01) == 0x01)
+
+#define	SS4_MF_LF_V2(_b, _i)	((_b[1 + _i * 3] & 0x0004) == 0x0004)
+
+#define SS4_BTN_V2(_b)		((_b[0] >> 5) & SS4_MASK_NORMAL_BUTTONS)
+
+#define SS4_STD_MF_X_V2(_b, _i)	(((_b[0 + _i * 3]  << 5) & 0x00E0) | \
+		((_b[1 + _i * 3]  << 5) & 0x1F00) \
+		)
+
+#define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + _i * 3] << 3) & 0x0010) | \
+		((_b[2 + _i * 3] << 5) & 0x01E0) | \
+		((_b[2 + _i * 3] << 4) & 0x0E00) \
+		)
+
+#define SS4_BTL_MF_X_V2(_b, _i)	(SS4_STD_MF_X_V2(_b, _i) | \
+		((_b[0 + _i * 3] >> 3) & 0x0010))
+
+#define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
+		((_b[0 + _i * 3] >> 3) & 0x0008))
+
+#define SS4_MF_Z_V2(_b, _i)	(((_b[1 + _i * 3]) & 0x0001) | \
+		((_b[1 + _i * 3] >> 1) & 0x0002) \
+		)
+
+#define SS4_IS_MF_CONTINUE(_b)	((_b[2] & 0x10) == 0x10)
+#define SS4_IS_5F_DETECTED(_b)	((_b[2] & 0x10) == 0x10)
+
+
+#define SS4_MFPACKET_NO_AX		8160	/* X-Coordinate value */
+#define SS4_MFPACKET_NO_AY		4080	/* Y-Coordinate value */
+#define SS4_MFPACKET_NO_AX_BL	8176	/* Buttonless X-Coordinate value */
+#define SS4_MFPACKET_NO_AY_BL	4088	/* Buttonless Y-Coordinate value */
+
+/* Threshold for resting finger's large movement */
+#define RESTING_FN_LARGE_MOVEMENT	50
+
+#define PT_IN_LEFT_BTN_AREA(_x, _y, _x_max, _y_max) ( \
+	((_x) < (_x_max) / 2) && ((_y) > (_y_max) * 4 / 5) \
+	)
+
+#define PT_IN_RIGHT_BTN_AREA(_x, _y, _x_max, _y_max) ( \
+	((_x) >= (_x_max) / 2) && ((_y) > (_y_max) * 4 / 5) \
+	)
+
+#define PT_IN_BTN_AREA(_x, _y, _x_max, _y_max) ( \
+	PT_IN_LEFT_BTN_AREA(_x, _y, _x_max, _y_max) || \
+	PT_IN_RIGHT_BTN_AREA(_x, _y, _x_max, _y_max) \
+	)
+
+/*
  * enum V7_PACKET_ID - defines the packet type for V7
  * V7_PACKET_ID_IDLE: There's no finger and no button activity.
  * V7_PACKET_ID_TWO: There's one or two non-resting fingers on touchpad
@@ -122,6 +211,9 @@ struct alps_fields {
 	unsigned int x_map;
 	unsigned int y_map;
 	unsigned int fingers;
+	unsigned int x;
+	unsigned int y;
+	unsigned int z;
 
 	int pressure;
 	struct input_mt_pos st;
-- 
2.1.0

