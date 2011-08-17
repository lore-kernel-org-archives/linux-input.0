From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 5/5] HID: wiimote: Add status and return request handlers
Date: Wed, 17 Aug 2011 11:43:24 +0200
Message-ID: <1313574204-12664-6-git-send-email-dh.herrmann@googlemail.com>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1HQJoB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:44:01 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so525065fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:44:01 -0700 (PDT)
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

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
index 84c9eb9..85a02e5 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -60,6 +60,8 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_NULL = 0x0,
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
+	WIIPROTO_REQ_STATUS = 0x20,
+	WIIPROTO_REQ_RETURN = 0x22,
 	WIIPROTO_REQ_DRM_K = 0x30,
 };
 
@@ -313,6 +315,26 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
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
@@ -320,6 +342,8 @@ struct wiiproto_handler {
 };
 
 static struct wiiproto_handler handlers[] = {
+	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
+	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = 0 }
 };
-- 
1.7.6

