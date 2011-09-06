From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 07/15] HID: wiimote: Add missing extension DRM handlers
Date: Tue,  6 Sep 2011 13:50:32 +0200
Message-ID: <1315309840-4664-8-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1IFLvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:18 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:18 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

If an extension is connected the wiimote may report data though DRMs that
contain extension data. This adds handlers for these DRMs but discards extension
data since we do not support it, yet.
It prints a warning to kernel log if an unhandled report is catched. Since we
handle all requests now, this should never happen, though.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 3a7dec0..a99e058 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -75,10 +75,13 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_RETURN = 0x22,
 	WIIPROTO_REQ_DRM_K = 0x30,
 	WIIPROTO_REQ_DRM_KA = 0x31,
+	WIIPROTO_REQ_DRM_KE = 0x32,
 	WIIPROTO_REQ_DRM_KAI = 0x33,
+	WIIPROTO_REQ_DRM_KEE = 0x34,
 	WIIPROTO_REQ_DRM_KAE = 0x35,
 	WIIPROTO_REQ_DRM_KIE = 0x36,
 	WIIPROTO_REQ_DRM_KAIE = 0x37,
+	WIIPROTO_REQ_DRM_E = 0x3d,
 	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
 	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
 };
@@ -550,6 +553,11 @@ static void handler_drm_KA(struct wiimote_data *wdata, const __u8 *payload)
 	handler_accel(wdata, payload);
 }
 
+static void handler_drm_KE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+}
+
 static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
@@ -561,6 +569,11 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 	input_sync(wdata->ir);
 }
 
+static void handler_drm_KEE(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+}
+
 static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
@@ -588,6 +601,10 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 	input_sync(wdata->ir);
 }
 
+static void handler_drm_E(struct wiimote_data *wdata, const __u8 *payload)
+{
+}
+
 static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
@@ -633,10 +650,13 @@ static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
+	{ .id = WIIPROTO_REQ_DRM_KE, .size = 10, .func = handler_drm_KE },
 	{ .id = WIIPROTO_REQ_DRM_KAI, .size = 17, .func = handler_drm_KAI },
+	{ .id = WIIPROTO_REQ_DRM_KEE, .size = 21, .func = handler_drm_KEE },
 	{ .id = WIIPROTO_REQ_DRM_KAE, .size = 21, .func = handler_drm_KAE },
 	{ .id = WIIPROTO_REQ_DRM_KIE, .size = 21, .func = handler_drm_KIE },
 	{ .id = WIIPROTO_REQ_DRM_KAIE, .size = 21, .func = handler_drm_KAIE },
+	{ .id = WIIPROTO_REQ_DRM_E, .size = 21, .func = handler_drm_E },
 	{ .id = WIIPROTO_REQ_DRM_SKAI1, .size = 21, .func = handler_drm_SKAI1 },
 	{ .id = WIIPROTO_REQ_DRM_SKAI2, .size = 21, .func = handler_drm_SKAI2 },
 	{ .id = 0 }
@@ -649,6 +669,7 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	struct wiiproto_handler *h;
 	int i;
 	unsigned long flags;
+	bool handled = false;
 
 	if (size < 1)
 		return -EINVAL;
@@ -657,10 +678,16 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 
 	for (i = 0; handlers[i].id; ++i) {
 		h = &handlers[i];
-		if (h->id == raw_data[0] && h->size < size)
+		if (h->id == raw_data[0] && h->size < size) {
 			h->func(wdata, &raw_data[1]);
+			handled = true;
+		}
 	}
 
+	if (!handled)
+		hid_warn(hdev, "Unhandled report %hhu size %d\n", raw_data[0],
+									size);
+
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	return 0;
-- 
1.7.6.1

