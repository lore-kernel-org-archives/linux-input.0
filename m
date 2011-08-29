From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 06/14] HID: wiimote: Parse IR data
Date: Mon, 29 Aug 2011 15:38:03 +0200
Message-ID: <1314625091-1405-7-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab1H2Nij (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:39 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:38 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

Parse IR data and report it to IR input-device. IR data is sent in 3 different
formats, but we only support the basic format as there is no way to send the
additional information to userspace.
All three formats are compatible with the basic IR data format so we need only
one parser.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   73 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 4cdaaf6..3a7dec0 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -479,6 +479,50 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	input_sync(wdata->accel);
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
+	/*
+	 * Basic IR data is encoded into 3 bytes. The first two bytes are the
+	 * upper 8 bit of the X/Y data, the 3rd byte contains the lower 2 bits
+	 * of both.
+	 * If data is packed, then the 3rd byte is put first and slightly
+	 * reordered. This allows to interleave packed and non-packed data to
+	 * have two IR sets in 5 bytes instead of 6.
+	 * The resulting 10bit X/Y values are passed to the ABS_HATXY input dev.
+	 */
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
+	input_report_abs(wdata->ir, xid, x);
+	input_report_abs(wdata->ir, yid, y);
+}
 
 static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 {
@@ -510,6 +554,21 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
+	ir_to_input0(wdata, &payload[5], false);
+	ir_to_input1(wdata, &payload[8], false);
+	ir_to_input2(wdata, &payload[11], false);
+	ir_to_input3(wdata, &payload[14], false);
+	input_sync(wdata->ir);
+}
+
+static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	ir_to_input0(wdata, &payload[2], false);
+	ir_to_input1(wdata, &payload[4], true);
+	ir_to_input2(wdata, &payload[7], false);
+	ir_to_input3(wdata, &payload[9], true);
+	input_sync(wdata->ir);
 }
 
 static void handler_drm_KAE(struct wiimote_data *wdata, const __u8 *payload)
@@ -522,6 +581,11 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
+	ir_to_input0(wdata, &payload[5], false);
+	ir_to_input1(wdata, &payload[7], true);
+	ir_to_input2(wdata, &payload[10], false);
+	ir_to_input3(wdata, &payload[12], true);
+	input_sync(wdata->ir);
 }
 
 static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
@@ -531,6 +595,10 @@ static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
 	wdata->state.accel_split[0] = payload[2];
 	wdata->state.accel_split[1] = (payload[0] >> 1) & (0x10 | 0x20);
 	wdata->state.accel_split[1] |= (payload[1] << 1) & (0x40 | 0x80);
+
+	ir_to_input0(wdata, &payload[3], false);
+	ir_to_input1(wdata, &payload[12], false);
+	input_sync(wdata->ir);
 }
 
 static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
@@ -548,6 +616,10 @@ static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
 	buf[3] = payload[2];
 	buf[4] = wdata->state.accel_split[1];
 	handler_accel(wdata, buf);
+
+	ir_to_input2(wdata, &payload[3], false);
+	ir_to_input3(wdata, &payload[12], false);
+	input_sync(wdata->ir);
 }
 
 struct wiiproto_handler {
@@ -563,6 +635,7 @@ static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
 	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 17, .func = handler_drm_KAI },
 	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 21, .func = handler_drm_KAE },
+	{ .id = WIIPROTO_REQ_DRM_KIE, .size = 21, .func = handler_drm_KIE },
 	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 21, .func = handler_drm_KAIE },
 	{ .id = WIIPROTO_REQ_DRM_SKAI1, .size = 21, .func = handler_drm_SKAI1 },
 	{ .id = WIIPROTO_REQ_DRM_SKAI2, .size = 21, .func = handler_drm_SKAI2 },
-- 
1.7.6.1

