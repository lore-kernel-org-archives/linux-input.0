From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 07/16] HID: wiimote: Parse accelerometer data
Date: Thu, 28 Jul 2011 18:08:27 +0200
Message-ID: <1311869316-17128-8-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab1G1QJN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:13 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:12 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add parser functions for accelerometer data reported by the wiimote. The data is
almost always reported in the same format, so we can use a single handler.
However, an own handler function is created for each DRM-mode because when IR
and extension support is added, each of them is parsed differently.

Also set the appropriate DRM including accelerometer data on DRM requests to
actually retrieve the accelerometer data.

Data is reported to userspace as ABS_X/Y/Z values. The values are between -500
and 500 and 0 means no acceleration. See also userspace xwiimote library for
data parsing.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  102 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 13c27b7..6947c2d 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -30,6 +30,7 @@ struct wiimote_buf {
 struct wiimote_state {
 	spinlock_t lock;
 	__u8 flags;
+	__u8 accel_split[2];
 };
 
 struct wiimote_data {
@@ -63,6 +64,12 @@ enum wiiproto_reqs {
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
@@ -240,7 +247,10 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
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
@@ -434,6 +444,32 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 							!!(payload[1] & 0x80));
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
+	 * Buttons data contains LSBs
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
+	input_event(wdata->input, EV_ABS, ABS_X, x - 0x200);
+	input_event(wdata->input, EV_ABS, ABS_Y, y - 0x200);
+	input_event(wdata->input, EV_ABS, ABS_Z, z - 0x200);
+}
+
+
 static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
@@ -454,6 +490,56 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
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
@@ -464,6 +550,12 @@ static struct wiiproto_handler handlers[] = {
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
 
@@ -528,6 +620,14 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	for (i = 0; i < WIIPROTO_KEY_COUNT; ++i)
 		set_bit(wiiproto_keymap[i], wdata->input->keybit);
 
+	set_bit(EV_ABS, wdata->input->evbit);
+	set_bit(ABS_X, wdata->input->absbit);
+	set_bit(ABS_Y, wdata->input->absbit);
+	set_bit(ABS_Z, wdata->input->absbit);
+	input_set_abs_params(wdata->input, ABS_X, -500, 500, 2, 4);
+	input_set_abs_params(wdata->input, ABS_Y, -500, 500, 2, 4);
+	input_set_abs_params(wdata->input, ABS_Z, -500, 500, 2, 4);
+
 	spin_lock_init(&wdata->qlock);
 	INIT_WORK(&wdata->worker, wiimote_worker);
 
-- 
1.7.6

