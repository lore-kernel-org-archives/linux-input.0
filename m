From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 7/9] Input: synaptics - split device info into a separate structure
Date: Fri, 10 Mar 2017 15:01:12 -0800
Message-ID: <20170310230114.788-8-dmitry.torokhov@gmail.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35331 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbdCJXCR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 18:02:17 -0500
In-Reply-To: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

In preparation for SMBus/Intertouch device support, move static device
information that we query form the touchpad upon initialization into
separate structure. This will allow us to query the device without
allocating memory first.

Also stop using "unsigned long", everything fits into 32 bit chunks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 392 ++++++++++++++++++++++------------------
 drivers/input/mouse/synaptics.h |  28 +--
 2 files changed, 233 insertions(+), 187 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index da7719bf887a..0eb01d1e8802 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -127,9 +127,9 @@ static bool cr48_profile_sensor;
 struct min_max_quirk {
 	const char * const *pnp_ids;
 	struct {
-		unsigned long int min, max;
+		u32 min, max;
 	} board_id;
-	int x_min, x_max, y_min, y_max;
+	u32 x_min, x_max, y_min, y_max;
 };
 
 static const struct min_max_quirk min_max_pnpid_table[] = {
@@ -248,27 +248,31 @@ static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned
  * Read the model-id bytes from the touchpad
  * see also SYN_MODEL_* macros
  */
-static int synaptics_model_id(struct psmouse *psmouse)
+static int synaptics_model_id(struct psmouse *psmouse,
+			      struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char mi[3];
+	int error;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi))
-		return -1;
-	priv->model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
+	error = synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi);
+	if (error)
+		return error;
+
+	info->model_id = (mi[0] << 16) | (mi[1] << 8) | mi[2];
 	return 0;
 }
 
-static int synaptics_more_extended_queries(struct psmouse *psmouse)
+static int synaptics_more_extended_queries(struct psmouse *psmouse,
+					   struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char buf[3];
+	int error;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_MEXT_CAPAB_10, buf))
-		return -1;
-
-	priv->ext_cap_10 = (buf[0]<<16) | (buf[1]<<8) | buf[2];
+	error = synaptics_send_cmd(psmouse, SYN_QUE_MEXT_CAPAB_10, buf);
+	if (error)
+		return error;
 
+	info->ext_cap_10 = (buf[0] << 16) | (buf[1] << 8) | buf[2];
 	return 0;
 }
 
@@ -276,21 +280,24 @@ static int synaptics_more_extended_queries(struct psmouse *psmouse)
  * Read the board id and the "More Extended Queries" from the touchpad
  * The board id is encoded in the "QUERY MODES" response
  */
-static int synaptics_query_modes(struct psmouse *psmouse)
+static int synaptics_query_modes(struct psmouse *psmouse,
+				 struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char bid[3];
+	int error;
 
 	/* firmwares prior 7.5 have no board_id encoded */
-	if (SYN_ID_FULL(priv->identity) < 0x705)
+	if (SYN_ID_FULL(info->identity) < 0x705)
 		return 0;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_MODES, bid))
-		return -1;
-	priv->board_id = ((bid[0] & 0xfc) << 6) | bid[1];
+	error = synaptics_send_cmd(psmouse, SYN_QUE_MODES, bid);
+	if (error)
+		return error;
+
+	info->board_id = ((bid[0] & 0xfc) << 6) | bid[1];
 
 	if (SYN_MEXT_CAP_BIT(bid[0]))
-		return synaptics_more_extended_queries(psmouse);
+		return synaptics_more_extended_queries(psmouse, info);
 
 	return 0;
 }
@@ -298,14 +305,17 @@ static int synaptics_query_modes(struct psmouse *psmouse)
 /*
  * Read the firmware id from the touchpad
  */
-static int synaptics_firmware_id(struct psmouse *psmouse)
+static int synaptics_firmware_id(struct psmouse *psmouse,
+				 struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char fwid[3];
+	int error;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_FIRMWARE_ID, fwid))
-		return -1;
-	priv->firmware_id = (fwid[0] << 16) | (fwid[1] << 8) | fwid[2];
+	error = synaptics_send_cmd(psmouse, SYN_QUE_FIRMWARE_ID, fwid);
+	if (error)
+		return error;
+
+	info->firmware_id = (fwid[0] << 16) | (fwid[1] << 8) | fwid[2];
 	return 0;
 }
 
@@ -313,53 +323,57 @@ static int synaptics_firmware_id(struct psmouse *psmouse)
  * Read the capability-bits from the touchpad
  * see also the SYN_CAP_* macros
  */
-static int synaptics_capability(struct psmouse *psmouse)
+static int synaptics_capability(struct psmouse *psmouse,
+				struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char cap[3];
+	int error;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
-		return -1;
-	priv->capabilities = (cap[0] << 16) | (cap[1] << 8) | cap[2];
-	priv->ext_cap = priv->ext_cap_0c = 0;
+	error = synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap);
+	if (error)
+		return error;
+
+	info->capabilities = (cap[0] << 16) | (cap[1] << 8) | cap[2];
+	info->ext_cap = info->ext_cap_0c = 0;
 
 	/*
 	 * Older firmwares had submodel ID fixed to 0x47
 	 */
-	if (SYN_ID_FULL(priv->identity) < 0x705 &&
-	    SYN_CAP_SUBMODEL_ID(priv->capabilities) != 0x47) {
-		return -1;
+	if (SYN_ID_FULL(info->identity) < 0x705 &&
+	    SYN_CAP_SUBMODEL_ID(info->capabilities) != 0x47) {
+		return -ENXIO;
 	}
 
 	/*
 	 * Unless capExtended is set the rest of the flags should be ignored
 	 */
-	if (!SYN_CAP_EXTENDED(priv->capabilities))
-		priv->capabilities = 0;
+	if (!SYN_CAP_EXTENDED(info->capabilities))
+		info->capabilities = 0;
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 1) {
+	if (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 1) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
 			psmouse_warn(psmouse,
 				     "device claims to have extended capabilities, but I'm not able to read them.\n");
 		} else {
-			priv->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
+			info->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 
 			/*
 			 * if nExtBtn is greater than 8 it should be considered
 			 * invalid and treated as 0
 			 */
-			if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) > 8)
-				priv->ext_cap &= 0xff0fff;
+			if (SYN_CAP_MULTI_BUTTON_NO(info->ext_cap) > 8)
+				info->ext_cap &= 0xff0fff;
 		}
 	}
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 4) {
-		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB_0C, cap)) {
+	if (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 4) {
+		error = synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB_0C, cap);
+		if (error)
 			psmouse_warn(psmouse,
 				     "device claims to have extended capability 0x0c, but I'm not able to read it.\n");
-		} else {
-			priv->ext_cap_0c = (cap[0] << 16) | (cap[1] << 8) | cap[2];
-		}
+		else
+			info->ext_cap_0c =
+				(cap[0] << 16) | (cap[1] << 8) | cap[2];
 	}
 
 	return 0;
@@ -369,17 +383,18 @@ static int synaptics_capability(struct psmouse *psmouse)
  * Identify Touchpad
  * See also the SYN_ID_* macros
  */
-static int synaptics_identify(struct psmouse *psmouse)
+static int synaptics_identify(struct psmouse *psmouse,
+			      struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char id[3];
+	int error;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id))
-		return -1;
-	priv->identity = (id[0]<<16) | (id[1]<<8) | id[2];
-	if (SYN_ID_IS_SYNAPTICS(priv->identity))
-		return 0;
-	return -1;
+	error = synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id);
+	if (error)
+		return error;
+
+	info->identity = (id[0] << 16) | (id[1] << 8) | id[2];
+	return SYN_ID_IS_SYNAPTICS(info->identity) ? 0 : -ENXIO;
 }
 
 /*
@@ -387,52 +402,58 @@ static int synaptics_identify(struct psmouse *psmouse)
  * Resolution is left zero if touchpad does not support the query
  */
 
-static int synaptics_resolution(struct psmouse *psmouse)
+static int synaptics_resolution(struct psmouse *psmouse,
+				struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	unsigned char resp[3];
+	int error;
 
-	if (SYN_ID_MAJOR(priv->identity) < 4)
+	if (SYN_ID_MAJOR(info->identity) < 4)
 		return 0;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, resp) == 0) {
+	error = synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, resp);
+	if (!error) {
 		if (resp[0] != 0 && (resp[1] & 0x80) && resp[2] != 0) {
-			priv->x_res = resp[0]; /* x resolution in units/mm */
-			priv->y_res = resp[2]; /* y resolution in units/mm */
+			info->x_res = resp[0]; /* x resolution in units/mm */
+			info->y_res = resp[2]; /* y resolution in units/mm */
 		}
 	}
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
-	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
-		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MAX_COORDS, resp)) {
+	if (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 5 &&
+	    SYN_CAP_MAX_DIMENSIONS(info->ext_cap_0c)) {
+		error = synaptics_send_cmd(psmouse,
+					   SYN_QUE_EXT_MAX_COORDS, resp);
+		if (error) {
 			psmouse_warn(psmouse,
 				     "device claims to have max coordinates query, but I'm not able to read it.\n");
 		} else {
-			priv->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
-			priv->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
+			info->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
+			info->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
 			psmouse_info(psmouse,
 				     "queried max coordinates: x [..%d], y [..%d]\n",
-				     priv->x_max, priv->y_max);
+				     info->x_max, info->y_max);
 		}
 	}
 
-	if (SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c) &&
-	    (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
+	if (SYN_CAP_MIN_DIMENSIONS(info->ext_cap_0c) &&
+	    (SYN_EXT_CAP_REQUESTS(info->capabilities) >= 7 ||
 	     /*
 	      * Firmware v8.1 does not report proper number of extended
 	      * capabilities, but has been proven to report correct min
 	      * coordinates.
 	      */
-	     SYN_ID_FULL(priv->identity) == 0x801)) {
-		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
+	     SYN_ID_FULL(info->identity) == 0x801)) {
+		error = synaptics_send_cmd(psmouse,
+					   SYN_QUE_EXT_MIN_COORDS, resp);
+		if (error) {
 			psmouse_warn(psmouse,
 				     "device claims to have min coordinates query, but I'm not able to read it.\n");
 		} else {
-			priv->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
-			priv->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
+			info->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
+			info->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
 			psmouse_info(psmouse,
 				     "queried min coordinates: x [%d..], y [%d..]\n",
-				     priv->x_min, priv->y_min);
+				     info->x_min, info->y_min);
 		}
 	}
 
@@ -443,9 +464,9 @@ static int synaptics_resolution(struct psmouse *psmouse)
  * Apply quirk(s) if the hardware matches
  */
 
-static void synaptics_apply_quirks(struct psmouse *psmouse)
+static void synaptics_apply_quirks(struct psmouse *psmouse,
+				   struct synaptics_device_info *info)
 {
-	struct synaptics_data *priv = psmouse->private;
 	int i;
 
 	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
@@ -454,41 +475,53 @@ static void synaptics_apply_quirks(struct psmouse *psmouse)
 			continue;
 
 		if (min_max_pnpid_table[i].board_id.min != ANY_BOARD_ID &&
-		    priv->board_id < min_max_pnpid_table[i].board_id.min)
+		    info->board_id < min_max_pnpid_table[i].board_id.min)
 			continue;
 
 		if (min_max_pnpid_table[i].board_id.max != ANY_BOARD_ID &&
-		    priv->board_id > min_max_pnpid_table[i].board_id.max)
+		    info->board_id > min_max_pnpid_table[i].board_id.max)
 			continue;
 
-		priv->x_min = min_max_pnpid_table[i].x_min;
-		priv->x_max = min_max_pnpid_table[i].x_max;
-		priv->y_min = min_max_pnpid_table[i].y_min;
-		priv->y_max = min_max_pnpid_table[i].y_max;
+		info->x_min = min_max_pnpid_table[i].x_min;
+		info->x_max = min_max_pnpid_table[i].x_max;
+		info->y_min = min_max_pnpid_table[i].y_min;
+		info->y_max = min_max_pnpid_table[i].y_max;
 		psmouse_info(psmouse,
 			     "quirked min/max coordinates: x [%d..%d], y [%d..%d]\n",
-			     priv->x_min, priv->x_max,
-			     priv->y_min, priv->y_max);
+			     info->x_min, info->x_max,
+			     info->y_min, info->y_max);
 		break;
 	}
 }
 
-static int synaptics_query_hardware(struct psmouse *psmouse)
+static int synaptics_query_hardware(struct psmouse *psmouse,
+				    struct synaptics_device_info *info)
 {
-	if (synaptics_identify(psmouse))
-		return -1;
-	if (synaptics_model_id(psmouse))
-		return -1;
-	if (synaptics_firmware_id(psmouse))
-		return -1;
-	if (synaptics_query_modes(psmouse))
-		return -1;
-	if (synaptics_capability(psmouse))
-		return -1;
-	if (synaptics_resolution(psmouse))
-		return -1;
+	int error;
+
+	error = synaptics_identify(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_model_id(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_firmware_id(psmouse, info);
+	if (error)
+		return error;
 
-	synaptics_apply_quirks(psmouse);
+	error = synaptics_query_modes(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_capability(psmouse, info);
+	if (error)
+		return error;
+
+	error = synaptics_resolution(psmouse, info);
+	if (error)
+		return error;
 
 	return 0;
 }
@@ -498,8 +531,8 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 	static unsigned char param = 0xc8;
 	struct synaptics_data *priv = psmouse->private;
 
-	if (!(SYN_CAP_ADV_GESTURE(priv->ext_cap_0c) ||
-	      SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)))
+	if (!(SYN_CAP_ADV_GESTURE(priv->info.ext_cap_0c) ||
+	      SYN_CAP_IMAGE_SENSOR(priv->info.ext_cap_0c)))
 		return 0;
 
 	if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
@@ -509,7 +542,7 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 		return -1;
 
 	/* Advanced gesture mode also sends multi finger data */
-	priv->capabilities |= BIT(1);
+	priv->info.capabilities |= BIT(1);
 
 	return 0;
 }
@@ -525,7 +558,7 @@ static int synaptics_set_mode(struct psmouse *psmouse)
 		priv->mode |= SYN_BIT_DISABLE_GESTURE;
 	if (psmouse->rate >= 80)
 		priv->mode |= SYN_BIT_HIGH_RATE;
-	if (SYN_CAP_EXTENDED(priv->capabilities))
+	if (SYN_CAP_EXTENDED(priv->info.capabilities))
 		priv->mode |= SYN_BIT_W_MODE;
 
 	if (synaptics_mode_cmd(psmouse, priv->mode))
@@ -695,7 +728,7 @@ static void synaptics_parse_ext_buttons(const unsigned char buf[],
 					struct synaptics_hw_state *hw)
 {
 	unsigned int ext_bits =
-		(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
+		(SYN_CAP_MULTI_BUTTON_NO(priv->info.ext_cap) + 1) >> 1;
 	unsigned int ext_mask = GENMASK(ext_bits - 1, 0);
 
 	hw->ext_buttons = buf[4] & ext_mask;
@@ -708,13 +741,13 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 {
 	memset(hw, 0, sizeof(struct synaptics_hw_state));
 
-	if (SYN_MODEL_NEWABS(priv->model_id)) {
+	if (SYN_MODEL_NEWABS(priv->info.model_id)) {
 		hw->w = (((buf[0] & 0x30) >> 2) |
 			 ((buf[0] & 0x04) >> 1) |
 			 ((buf[3] & 0x04) >> 2));
 
-		if ((SYN_CAP_ADV_GESTURE(priv->ext_cap_0c) ||
-			SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) &&
+		if ((SYN_CAP_ADV_GESTURE(priv->info.ext_cap_0c) ||
+			SYN_CAP_IMAGE_SENSOR(priv->info.ext_cap_0c)) &&
 		    hw->w == 2) {
 			synaptics_parse_agm(buf, priv, hw);
 			return 1;
@@ -767,7 +800,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 
 			hw->left = priv->report_press;
 
-		} else if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
+		} else if (SYN_CAP_CLICKPAD(priv->info.ext_cap_0c)) {
 			/*
 			 * Clickpad's button is transmitted as middle button,
 			 * however, since it is primary button, we will report
@@ -775,18 +808,18 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 			 */
 			hw->left = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
 
-		} else if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
+		} else if (SYN_CAP_MIDDLE_BUTTON(priv->info.capabilities)) {
 			hw->middle = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
 			if (hw->w == 2)
 				hw->scroll = (signed char)(buf[1]);
 		}
 
-		if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+		if (SYN_CAP_FOUR_BUTTON(priv->info.capabilities)) {
 			hw->up   = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
 			hw->down = ((buf[0] ^ buf[3]) & 0x02) ? 1 : 0;
 		}
 
-		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) > 0 &&
+		if (SYN_CAP_MULTI_BUTTON_NO(priv->info.ext_cap) > 0 &&
 		    ((buf[0] ^ buf[3]) & 0x02)) {
 			synaptics_parse_ext_buttons(buf, priv, hw);
 		}
@@ -855,19 +888,19 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 {
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
-	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
+	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->info.ext_cap) + 1) >> 1;
 	int i;
 
-	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+	if (!SYN_CAP_MULTI_BUTTON_NO(priv->info.ext_cap))
 		return;
 
 	/* Bug in FW 8.1 & 8.2, buttons are reported only when ExtBit is 1 */
-	if ((SYN_ID_FULL(priv->identity) == 0x801 ||
-	     SYN_ID_FULL(priv->identity) == 0x802) &&
+	if ((SYN_ID_FULL(priv->info.identity) == 0x801 ||
+	     SYN_ID_FULL(priv->info.identity) == 0x802) &&
 	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
 		return;
 
-	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10)) {
+	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->info.ext_cap_10)) {
 		for (i = 0; i < ext_bits; i++) {
 			input_report_key(dev, BTN_0 + 2 * i,
 				hw->ext_buttons & (1 << i));
@@ -905,10 +938,10 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
 	input_report_key(dev, BTN_LEFT, hw->left);
 	input_report_key(dev, BTN_RIGHT, hw->right);
 
-	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+	if (SYN_CAP_MIDDLE_BUTTON(priv->info.capabilities))
 		input_report_key(dev, BTN_MIDDLE, hw->middle);
 
-	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+	if (SYN_CAP_FOUR_BUTTON(priv->info.capabilities)) {
 		input_report_key(dev, BTN_FORWARD, hw->up);
 		input_report_key(dev, BTN_BACK, hw->down);
 	}
@@ -933,7 +966,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		pos[i].y = synaptics_invert_y(hw[i]->y);
 	}
 
-	input_mt_assign_slots(dev, slot, pos, nsemi, DMAX * priv->x_res);
+	input_mt_assign_slots(dev, slot, pos, nsemi, DMAX * priv->info.x_res);
 
 	for (i = 0; i < nsemi; i++) {
 		input_mt_slot(dev, slot[i]);
@@ -1000,6 +1033,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
+	struct synaptics_device_info *info = &priv->info;
 	struct synaptics_hw_state hw;
 	int num_fingers;
 	int finger_width;
@@ -1007,7 +1041,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	if (synaptics_parse_hw_state(psmouse->packet, priv, &hw))
 		return;
 
-	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
+	if (SYN_CAP_IMAGE_SENSOR(info->ext_cap_0c)) {
 		synaptics_image_sensor_process(psmouse, &hw);
 		return;
 	}
@@ -1035,18 +1069,18 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	if (hw.z > 0 && hw.x > 1) {
 		num_fingers = 1;
 		finger_width = 5;
-		if (SYN_CAP_EXTENDED(priv->capabilities)) {
+		if (SYN_CAP_EXTENDED(info->capabilities)) {
 			switch (hw.w) {
 			case 0 ... 1:
-				if (SYN_CAP_MULTIFINGER(priv->capabilities))
+				if (SYN_CAP_MULTIFINGER(info->capabilities))
 					num_fingers = hw.w + 2;
 				break;
 			case 2:
-				if (SYN_MODEL_PEN(priv->model_id))
+				if (SYN_MODEL_PEN(info->model_id))
 					;   /* Nothing, treat a pen as a single finger */
 				break;
 			case 4 ... 15:
-				if (SYN_CAP_PALMDETECT(priv->capabilities))
+				if (SYN_CAP_PALMDETECT(info->capabilities))
 					finger_width = hw.w;
 				break;
 			}
@@ -1061,7 +1095,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 		return;
 	}
 
-	if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
+	if (SYN_CAP_ADV_GESTURE(info->ext_cap_0c))
 		synaptics_report_semi_mt_data(dev, &hw, &priv->agm,
 					      num_fingers);
 
@@ -1078,11 +1112,11 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
 
-	if (SYN_CAP_PALMDETECT(priv->capabilities))
+	if (SYN_CAP_PALMDETECT(info->capabilities))
 		input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
 
 	input_report_key(dev, BTN_TOOL_FINGER, num_fingers == 1);
-	if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
+	if (SYN_CAP_MULTIFINGER(info->capabilities)) {
 		input_report_key(dev, BTN_TOOL_DOUBLETAP, num_fingers == 2);
 		input_report_key(dev, BTN_TOOL_TRIPLETAP, num_fingers == 3);
 	}
@@ -1144,7 +1178,7 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
+		if (SYN_CAP_PASS_THROUGH(priv->info.capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
 			if (priv->pt_port)
 				synaptics_pass_pt_packet(priv->pt_port,
@@ -1163,26 +1197,27 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
  *	Driver initialization/cleanup functions
  ****************************************************************************/
 static void set_abs_position_params(struct input_dev *dev,
-				    struct synaptics_data *priv, int x_code,
-				    int y_code)
+				    struct synaptics_device_info *info,
+				    int x_code, int y_code)
 {
-	int x_min = priv->x_min ?: XMIN_NOMINAL;
-	int x_max = priv->x_max ?: XMAX_NOMINAL;
-	int y_min = priv->y_min ?: YMIN_NOMINAL;
-	int y_max = priv->y_max ?: YMAX_NOMINAL;
-	int fuzz = SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c) ?
+	int x_min = info->x_min ?: XMIN_NOMINAL;
+	int x_max = info->x_max ?: XMAX_NOMINAL;
+	int y_min = info->y_min ?: YMIN_NOMINAL;
+	int y_max = info->y_max ?: YMAX_NOMINAL;
+	int fuzz = SYN_CAP_REDUCED_FILTERING(info->ext_cap_0c) ?
 			SYN_REDUCED_FILTER_FUZZ : 0;
 
 	input_set_abs_params(dev, x_code, x_min, x_max, fuzz, 0);
 	input_set_abs_params(dev, y_code, y_min, y_max, fuzz, 0);
-	input_abs_set_res(dev, x_code, priv->x_res);
-	input_abs_set_res(dev, y_code, priv->y_res);
+	input_abs_set_res(dev, x_code, info->x_res);
+	input_abs_set_res(dev, y_code, info->y_res);
 }
 
 static void set_input_params(struct psmouse *psmouse,
 			     struct synaptics_data *priv)
 {
 	struct input_dev *dev = psmouse->dev;
+	struct synaptics_device_info *info = &priv->info;
 	int i;
 
 	/* Things that apply to both modes */
@@ -1191,7 +1226,7 @@ static void set_input_params(struct psmouse *psmouse,
 	__set_bit(BTN_LEFT, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 
-	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+	if (SYN_CAP_MIDDLE_BUTTON(info->capabilities))
 		__set_bit(BTN_MIDDLE, dev->keybit);
 
 	if (!priv->absolute_mode) {
@@ -1204,15 +1239,15 @@ static void set_input_params(struct psmouse *psmouse,
 
 	/* Absolute mode */
 	__set_bit(EV_ABS, dev->evbit);
-	set_abs_position_params(dev, priv, ABS_X, ABS_Y);
+	set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
 	if (cr48_profile_sensor)
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 
-	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
-		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
-					ABS_MT_POSITION_Y);
+	if (SYN_CAP_IMAGE_SENSOR(info->ext_cap_0c)) {
+		set_abs_position_params(dev, info,
+					ABS_MT_POSITION_X, ABS_MT_POSITION_Y);
 		/* Image sensors can report per-contact pressure */
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
@@ -1220,9 +1255,9 @@ static void set_input_params(struct psmouse *psmouse,
 		/* Image sensors can signal 4 and 5 finger clicks */
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		__set_bit(BTN_TOOL_QUINTTAP, dev->keybit);
-	} else if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
-		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
-					ABS_MT_POSITION_Y);
+	} else if (SYN_CAP_ADV_GESTURE(info->ext_cap_0c)) {
+		set_abs_position_params(dev, info,
+					ABS_MT_POSITION_X, ABS_MT_POSITION_Y);
 		/*
 		 * Profile sensor in CR-48 tracks contacts reasonably well,
 		 * other non-image sensors with AGM use semi-mt.
@@ -1233,35 +1268,35 @@ static void set_input_params(struct psmouse *psmouse,
 					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
 	}
 
-	if (SYN_CAP_PALMDETECT(priv->capabilities))
+	if (SYN_CAP_PALMDETECT(info->capabilities))
 		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 
 	__set_bit(BTN_TOUCH, dev->keybit);
 	__set_bit(BTN_TOOL_FINGER, dev->keybit);
 
-	if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
+	if (SYN_CAP_MULTIFINGER(info->capabilities)) {
 		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
 		__set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
 	}
 
-	if (SYN_CAP_FOUR_BUTTON(priv->capabilities) ||
-	    SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
+	if (SYN_CAP_FOUR_BUTTON(info->capabilities) ||
+	    SYN_CAP_MIDDLE_BUTTON(info->capabilities)) {
 		__set_bit(BTN_FORWARD, dev->keybit);
 		__set_bit(BTN_BACK, dev->keybit);
 	}
 
-	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10))
-		for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+	if (!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
+		for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(info->ext_cap); i++)
 			__set_bit(BTN_0 + i, dev->keybit);
 
 	__clear_bit(EV_REL, dev->evbit);
 	__clear_bit(REL_X, dev->relbit);
 	__clear_bit(REL_Y, dev->relbit);
 
-	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
+	if (SYN_CAP_CLICKPAD(info->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
-		    !SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10))
+		    !SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
 			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
@@ -1315,7 +1350,8 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
-	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity))
+	if (!priv->absolute_mode &&
+			SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
 		device_remove_file(&psmouse->ps2dev.serio->dev,
 				   &psmouse_attr_disable_gesture.dattr);
 
@@ -1327,7 +1363,7 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 static int synaptics_reconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
-	struct synaptics_data old_priv = *priv;
+	struct synaptics_device_info info;
 	unsigned char param[2];
 	int retry = 0;
 	int error;
@@ -1354,7 +1390,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 	if (retry > 1)
 		psmouse_dbg(psmouse, "reconnected after %d tries\n", retry);
 
-	if (synaptics_query_hardware(psmouse)) {
+	if (synaptics_query_hardware(psmouse, &info)) {
 		psmouse_err(psmouse, "Unable to query device.\n");
 		return -1;
 	}
@@ -1364,16 +1400,16 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return -1;
 	}
 
-	if (old_priv.identity != priv->identity ||
-	    old_priv.model_id != priv->model_id ||
-	    old_priv.capabilities != priv->capabilities ||
-	    old_priv.ext_cap != priv->ext_cap) {
+	if (info.identity != priv->info.identity ||
+	    info.model_id != priv->info.model_id ||
+	    info.capabilities != priv->info.capabilities ||
+	    info.ext_cap != priv->info.ext_cap) {
 		psmouse_err(psmouse,
-			    "hardware appears to be different: id(%ld-%ld), model(%ld-%ld), caps(%lx-%lx), ext(%lx-%lx).\n",
-			    old_priv.identity, priv->identity,
-			    old_priv.model_id, priv->model_id,
-			    old_priv.capabilities, priv->capabilities,
-			    old_priv.ext_cap, priv->ext_cap);
+			    "hardware appears to be different: id(%u-%u), model(%u-%u), caps(%x-%x), ext(%x-%x).\n",
+			    priv->info.identity, info.identity,
+			    priv->info.model_id, info.model_id,
+			    priv->info.capabilities, info.capabilities,
+			    priv->info.ext_cap, info.ext_cap);
 		return -1;
 	}
 
@@ -1457,6 +1493,7 @@ void __init synaptics_module_init(void)
 static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 {
 	struct synaptics_data *priv;
+	struct synaptics_device_info *info;
 	int err = -1;
 
 	/*
@@ -1475,15 +1512,19 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	if (!priv)
 		return -ENOMEM;
 
+	info = &priv->info;
+
 	psmouse_reset(psmouse);
 
-	if (synaptics_query_hardware(psmouse)) {
+	if (synaptics_query_hardware(psmouse, info)) {
 		psmouse_err(psmouse, "Unable to query device.\n");
 		goto init_fail;
 	}
 
+	synaptics_apply_quirks(psmouse, info);
+
 	priv->absolute_mode = absolute_mode;
-	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+	if (SYN_ID_DISGEST_SUPPORTED(info->identity))
 		priv->disable_gesture = true;
 
 	/*
@@ -1497,15 +1538,16 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		goto init_fail;
 	}
 
-	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
+	priv->pkt_type = SYN_MODEL_NEWABS(info->model_id) ?
+					SYN_NEWABS : SYN_OLDABS;
 
 	psmouse_info(psmouse,
-		     "Touchpad model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx/%#lx, board id: %lu, fw id: %lu\n",
-		     SYN_ID_MODEL(priv->identity),
-		     SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
-		     priv->model_id,
-		     priv->capabilities, priv->ext_cap, priv->ext_cap_0c,
-		     priv->ext_cap_10, priv->board_id, priv->firmware_id);
+		     "Touchpad model: %u, fw: %u.%u, id: %#x, caps: %#x/%#x/%#x/%#x, board id: %u, fw id: %u\n",
+		     SYN_ID_MODEL(info->identity),
+		     SYN_ID_MAJOR(info->identity), SYN_ID_MINOR(info->identity),
+		     info->model_id,
+		     info->capabilities, info->ext_cap, info->ext_cap_0c,
+		     info->ext_cap_10, info->board_id, info->firmware_id);
 
 	set_input_params(psmouse, priv);
 
@@ -1516,8 +1558,8 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	 * Hardware info bits seem to be good candidates as they
 	 * are documented to be for Synaptics corp. internal use.
 	 */
-	psmouse->model = ((priv->model_id & 0x00ff0000) >> 8) |
-			  (priv->model_id & 0x000000ff);
+	psmouse->model = ((info->model_id & 0x00ff0000) >> 8) |
+			  (info->model_id & 0x000000ff);
 
 	if (absolute_mode) {
 		psmouse->protocol_handler = synaptics_process_byte;
@@ -1535,7 +1577,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;
 
-	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+	if (SYN_CAP_PASS_THROUGH(info->capabilities))
 		synaptics_pt_create(psmouse);
 
 	/*
@@ -1550,7 +1592,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		psmouse->rate = 40;
 	}
 
-	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity)) {
+	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(info->identity)) {
 		err = device_create_file(&psmouse->ps2dev.serio->dev,
 					 &psmouse_attr_disable_gesture.dattr);
 		if (err) {
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 116ae2546ace..4d1452718cbc 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -161,19 +161,23 @@ struct synaptics_hw_state {
 	signed char scroll;
 };
 
+/* Data read from the touchpad */
+struct synaptics_device_info {
+	u32 model_id;		/* Model-ID */
+	u32 firmware_id;	/* Firmware-ID */
+	u32 board_id;		/* Board-ID */
+	u32 capabilities;	/* Capabilities */
+	u32 ext_cap;		/* Extended Capabilities */
+	u32 ext_cap_0c;		/* Ext Caps from 0x0c query */
+	u32 ext_cap_10;		/* Ext Caps from 0x10 query */
+	u32 identity;		/* Identification */
+	u32 x_res, y_res;	/* X/Y resolution in units/mm */
+	u32 x_max, y_max;	/* Max coordinates (from FW) */
+	u32 x_min, y_min;	/* Min coordinates (from FW) */
+};
+
 struct synaptics_data {
-	/* Data read from the touchpad */
-	unsigned long int model_id;		/* Model-ID */
-	unsigned long int firmware_id;		/* Firmware-ID */
-	unsigned long int board_id;		/* Board-ID */
-	unsigned long int capabilities;		/* Capabilities */
-	unsigned long int ext_cap;		/* Extended Capabilities */
-	unsigned long int ext_cap_0c;		/* Ext Caps from 0x0c query */
-	unsigned long int ext_cap_10;		/* Ext Caps from 0x10 query */
-	unsigned long int identity;		/* Identification */
-	unsigned int x_res, y_res;		/* X/Y resolution in units/mm */
-	unsigned int x_max, y_max;		/* Max coordinates (from FW) */
-	unsigned int x_min, y_min;		/* Min coordinates (from FW) */
+	struct synaptics_device_info info;
 
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
-- 
2.12.0.246.ga2ecc84866-goog

