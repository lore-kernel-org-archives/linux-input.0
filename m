From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 04/15] HID: wiimote: Parse accelerometer data
Date: Tue,  6 Sep 2011 13:50:29 +0200
Message-ID: <1315309840-4664-5-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1IFLvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:15 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:15 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add parser functions for accelerometer data reported by the wiimote. The data is
almost always reported in the same format, so we can use a single handler.
However, an own handler function is created for each DRM-mode because when IR
and extension support is added, each of them is parsed differently.

Also set the appropriate DRM including accelerometer data on DRM requests to
actually retrieve the accelerometer data.

Data is reported to userspace as ABS_RX/Y/Z values. The values are between -500
and 500 and 0 means no acceleration. See also userspace xwiimote library for
data parsing.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  102 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 9fb7bd6..de9aadf 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -30,6 +30,7 @@ struct wiimote_buf {
 struct wiimote_state {
 	spinlock_t lock;
 	__u8 flags;
+	__u8 accel_split[2];
 };
 
 struct wiimote_data {
@@ -67,6 +68,12 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_STATUS = 0x20,
 	WIIPROTO_REQ_RETURN = 0x22,
 	WIIPROTO_REQ_DRM_K = 0x30,
+	WIIPROTO_REQ_DRM_KA = 0x31,
+	WIIPROTO_REQ_DRM_KAI = 0x33,
+	WIIPROTO_REQ_DRM_KAE = 0x35,
+	WIIPROTO_REQ_DRM_KAIE = 0x37,
+	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
+	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
 };
 
 enum wiiproto_keys {
@@ -241,7 +248,10 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
  */
 static __u8 select_drm(struct wiimote_data *wdata)
 {
-	return WIIPROTO_REQ_DRM_K;
+	if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
+		return WIIPROTO_REQ_DRM_KA;
+	else
+		return WIIPROTO_REQ_DRM_K;
 }
 
 static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
@@ -416,6 +426,40 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 	input_sync(wdata->input);
 }
 
+static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
+{
+	__u16 x, y, z;
+
+	if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
+		return;
+
+	/*
+	 * payload is: BB BB XX YY ZZ
+	 * Accelerometer data is encoded into 3 10bit values. XX, YY and ZZ
+	 * contain the upper 8 bits of each value. The lower 2 bits are
+	 * contained in the buttons data BB BB.
+	 * Bits 6 and 7 of the first buttons byte BB is the lower 2 bits of the
+	 * X accel value. Bit 5 of the second buttons byte is the 2nd bit of Y
+	 * accel value and bit 6 is the second bit of the Z value.
+	 * The first bit of Y and Z values is not available and always set to 0.
+	 * 0x200 is returned on no movement.
+	 */
+
+	x = payload[2] << 2;
+	y = payload[3] << 2;
+	z = payload[4] << 2;
+
+	x |= (payload[0] >> 5) & 0x3;
+	y |= (payload[1] >> 4) & 0x2;
+	z |= (payload[1] >> 5) & 0x2;
+
+	input_report_abs(wdata->accel, ABS_RX, x - 0x200);
+	input_report_abs(wdata->accel, ABS_RY, y - 0x200);
+	input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
+	input_sync(wdata->accel);
+}
+
+
 static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
@@ -436,6 +480,56 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 									cmd);
 }
 
+static void handler_drm_KA(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	handler_accel(wdata, payload);
+}
+
+static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	handler_accel(wdata, payload);
+}
+
+static void handler_drm_KAE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	handler_accel(wdata, payload);
+}
+
+static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+	handler_accel(wdata, payload);
+}
+
+static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+
+	wdata->state.accel_split[0] = payload[2];
+	wdata->state.accel_split[1] = (payload[0] >> 1) & (0x10 | 0x20);
+	wdata->state.accel_split[1] |= (payload[1] << 1) & (0x40 | 0x80);
+}
+
+static void handler_drm_SKAI2(struct wiimote_data *wdata, const __u8 *payload)
+{
+	__u8 buf[5];
+
+	handler_keys(wdata, payload);
+
+	wdata->state.accel_split[1] |= (payload[0] >> 5) & (0x01 | 0x02);
+	wdata->state.accel_split[1] |= (payload[1] >> 3) & (0x04 | 0x08);
+
+	buf[0] = 0;
+	buf[1] = 0;
+	buf[2] = wdata->state.accel_split[0];
+	buf[3] = payload[2];
+	buf[4] = wdata->state.accel_split[1];
+	handler_accel(wdata, buf);
+}
+
 struct wiiproto_handler {
 	__u8 id;
 	size_t size;
@@ -446,6 +540,12 @@ static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
 	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
+	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
+	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 17, .func = handler_drm_KAI },
+	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 21, .func = handler_drm_KAE },
+	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 21, .func = handler_drm_KAIE },
+	{ .id = WIIPROTO_REQ_DRM_SKAI1, .size = 21, .func = handler_drm_SKAI1 },
+	{ .id = WIIPROTO_REQ_DRM_SKAI2, .size = 21, .func = handler_drm_SKAI2 },
 	{ .id = 0 }
 };
 
-- 
1.7.6.1

