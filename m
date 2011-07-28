From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 08/16] HID: wiimote: Parse IR input and report to userspace
Date: Thu, 28 Jul 2011 18:08:28 +0200
Message-ID: <1311869316-17128-9-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab1G1QJO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:14 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:13 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

A wiimote sends IR pointing information for up to 4 trackable IR lights. If less
lights are visible, the missing lights report max value. This patch adds parser
functions for IR input and reports this via ABS_HAT*XY values to the input
subsystem.

The IR cam can be in four states: off, basic, extended, full
The DRM chooser automatically chosses an DRM that matches the current IR cam
state so no information is lost.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  101 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 6947c2d..ed7feb2 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -53,8 +53,13 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED4		0x08
 #define WIIPROTO_FLAG_RUMBLE		0x10
 #define WIIPROTO_FLAG_ACCEL		0x20
+#define WIIPROTO_FLAG_IR_BASIC		0x40
+#define WIIPROTO_FLAG_IR_EXT		0x80
+#define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
+#define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT | \
+							WIIPROTO_FLAG_IR_FULL)
 
 enum wiiproto_reqs {
 	WIIPROTO_REQ_NULL = 0x0,
@@ -67,6 +72,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_DRM_KA = 0x31,
 	WIIPROTO_REQ_DRM_KAI = 0x33,
 	WIIPROTO_REQ_DRM_KAE = 0x35,
+	WIIPROTO_REQ_DRM_KIE = 0x36,
 	WIIPROTO_REQ_DRM_KAIE = 0x37,
 	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
 	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
@@ -247,10 +253,22 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
  */
 static __u8 select_drm(struct wiimote_data *wdata)
 {
-	if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
-		return WIIPROTO_REQ_DRM_KA;
-	else
-		return WIIPROTO_REQ_DRM_K;
+	__u8 ir = wdata->state.flags & WIIPROTO_FLAGS_IR;
+	if (ir == WIIPROTO_FLAG_IR_BASIC) {
+		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
+			return WIIPROTO_REQ_DRM_KAIE;
+		else
+			return WIIPROTO_REQ_DRM_KIE;
+	} else if (ir == WIIPROTO_FLAG_IR_EXT) {
+		return WIIPROTO_REQ_DRM_KAI;
+	} else if (ir == WIIPROTO_FLAG_IR_FULL) {
+		return WIIPROTO_REQ_DRM_SKAI1;
+	} else {
+		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
+			return WIIPROTO_REQ_DRM_KA;
+		else
+			return WIIPROTO_REQ_DRM_K;
+	}
 }
 
 static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
@@ -469,6 +487,40 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	input_event(wdata->input, EV_ABS, ABS_Z, z - 0x200);
 }
 
+#define ir_to_input0(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
+							ABS_HAT0X, ABS_HAT0Y)
+#define ir_to_input1(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
+							ABS_HAT1X, ABS_HAT1Y)
+#define ir_to_input2(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
+							ABS_HAT2X, ABS_HAT2Y)
+#define ir_to_input3(wdata, ir, packed) __ir_to_input((wdata), (ir), (packed), \
+							ABS_HAT3X, ABS_HAT3Y)
+
+static void __ir_to_input(struct wiimote_data *wdata, const __u8 *ir,
+						bool packed, __u8 xid, __u8 yid)
+{
+	__u16 x, y;
+
+	if (!(wdata->state.flags & WIIPROTO_FLAGS_IR))
+		return;
+
+	if (packed) {
+		x = ir[1] << 2;
+		y = ir[2] << 2;
+
+		x |= ir[0] & 0x3;
+		y |= (ir[0] >> 2) & 0x3;
+	} else {
+		x = ir[0] << 2;
+		y = ir[1] << 2;
+
+		x |= (ir[2] >> 4) & 0x3;
+		y |= (ir[2] >> 6) & 0x3;
+	}
+
+	input_event(wdata->input, EV_ABS, xid, x);
+	input_event(wdata->input, EV_ABS, yid, y);
+}
 
 static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 {
@@ -500,6 +552,19 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
+	ir_to_input0(wdata, &payload[5], false);
+	ir_to_input1(wdata, &payload[8], false);
+	ir_to_input2(wdata, &payload[11], false);
+	ir_to_input3(wdata, &payload[14], false);
+}
+
+static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	ir_to_input0(wdata, &payload[2], false);
+	ir_to_input1(wdata, &payload[4], true);
+	ir_to_input2(wdata, &payload[7], false);
+	ir_to_input3(wdata, &payload[9], true);
 }
 
 static void handler_drm_KAE(struct wiimote_data *wdata, const __u8 *payload)
@@ -512,6 +577,10 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
+	ir_to_input0(wdata, &payload[5], false);
+	ir_to_input1(wdata, &payload[7], true);
+	ir_to_input2(wdata, &payload[10], false);
+	ir_to_input3(wdata, &payload[12], true);
 }
 
 static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
@@ -521,6 +590,9 @@ static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
 	wdata->state.accel_split[0] = payload[2];
 	wdata->state.accel_split[1] = (payload[0] >> 1) & (0x10 | 0x20);
 	wdata->state.accel_split[1] |= (payload[1] << 1) & (0x40 | 0x80);
+
+	ir_to_input0(wdata, &payload[3], false);
+	ir_to_input1(wdata, &payload[12], false);
 }
 
 static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
@@ -538,6 +610,9 @@ static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
 	buf[3] = payload[2];
 	buf[4] = wdata->state.accel_split[1];
 	handler_accel(wdata, buf);
+
+	ir_to_input2(wdata, &payload[3], false);
+	ir_to_input3(wdata, &payload[12], false);
 }
 
 struct wiiproto_handler {
@@ -553,6 +628,7 @@ static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
 	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 17, .func = handler_drm_KAI },
 	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 21, .func = handler_drm_KAE },
+	{ .id = WIIPROTO_REQ_DRM_KIE, .size = 21, .func = handler_drm_KIE },
 	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 21, .func = handler_drm_KAIE },
 	{ .id = WIIPROTO_REQ_DRM_SKAI1, .size = 21, .func = handler_drm_SKAI1 },
 	{ .id = WIIPROTO_REQ_DRM_SKAI2, .size = 21, .func = handler_drm_SKAI2 },
@@ -628,6 +704,23 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	input_set_abs_params(wdata->input, ABS_Y, -500, 500, 2, 4);
 	input_set_abs_params(wdata->input, ABS_Z, -500, 500, 2, 4);
 
+	set_bit(ABS_HAT0X, wdata->input->absbit);
+	set_bit(ABS_HAT0Y, wdata->input->absbit);
+	set_bit(ABS_HAT1X, wdata->input->absbit);
+	set_bit(ABS_HAT1Y, wdata->input->absbit);
+	set_bit(ABS_HAT2X, wdata->input->absbit);
+	set_bit(ABS_HAT2Y, wdata->input->absbit);
+	set_bit(ABS_HAT3X, wdata->input->absbit);
+	set_bit(ABS_HAT3Y, wdata->input->absbit);
+	input_set_abs_params(wdata->input, ABS_HAT0X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT0Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT1X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT1Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT2X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT2Y, 0, 767, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT3X, 0, 1023, 2, 4);
+	input_set_abs_params(wdata->input, ABS_HAT3Y, 0, 767, 2, 4);
+
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
-- 
1.7.6

