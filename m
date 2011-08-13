From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 7/7] HID: wiimote: Add status and return request handlers
Date: Sat, 13 Aug 2011 15:29:15 +0200
Message-ID: <1313242155-3620-8-git-send-email-dh.herrmann@googlemail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1HMN3l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:41 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2801615fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:41 -0700 (PDT)
In-Reply-To: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

The wiimote resets the current drm when an extension is plugged in.
Fortunately, it also sends a status report in this situation so we just
reset the drm on every status report to keep the drm consistent.

Also handle return reports from the wiimote which indicate success and
failure of requests that we've sent.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 3efc126..65d61fa 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -63,6 +63,8 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
+	WIIPROTO_REQ_STATUS = 0x20,
+	WIIPROTO_REQ_RETURN = 0x22,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -405,6 +407,26 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 	input_sync(wdata->input);
 }
 
+static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+
+	/* on status reports the drm is reset so we need to resend the drm */
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+}
+
+static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
+{
+	__u8 err = payload[3];
+	__u8 cmd = payload[2];
+
+	handler_keys(wdata, payload);
+
+	if (err)
+		hid_warn(wdata->hdev, "Remote error %hhu on req %hhu\n", err,
+									cmd);
+}
+
 struct wiiproto_handler {
 	__u8 id;
 	size_t size;
@@ -412,6 +434,8 @@ struct wiiproto_handler {
 };
 
 static struct wiiproto_handler handlers[] = {
+	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
+	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = 0 }
 };
-- 
1.7.6

