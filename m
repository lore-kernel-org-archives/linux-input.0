From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 08/14] HID: wiimote: Add register/eeprom memory support
Date: Mon, 29 Aug 2011 15:38:05 +0200
Message-ID: <1314625091-1405-9-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab1H2Nim (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:42 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:41 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

The wiimote allows direct access to its memory mapped registers and
internal eeprom. This adds support to access this memory and handle
memory events.

There are two macros which wrap up the memory access functions to avoid
accidentally overwriting sensitive eeprom data because a boolean value
was wrongly set.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index a99e058..c811a7d 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -71,7 +71,10 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_RUMBLE = 0x10,
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
+	WIIPROTO_REQ_WMEM = 0x16,
+	WIIPROTO_REQ_RMEM = 0x17,
 	WIIPROTO_REQ_STATUS = 0x20,
+	WIIPROTO_REQ_DATA = 0x21,
 	WIIPROTO_REQ_RETURN = 0x22,
 	WIIPROTO_REQ_DRM_K = 0x30,
 	WIIPROTO_REQ_DRM_KA = 0x31,
@@ -306,6 +309,37 @@ static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
 }
 
+#define wiiproto_req_wreg(wdata, os, buf, sz) \
+			wiiproto_req_wmem((wdata), false, (os), (buf), (sz))
+
+#define wiiproto_req_weeprom(wdata, os, buf, sz) \
+			wiiproto_req_wmem((wdata), true, (os), (buf), (sz))
+
+static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
+				__u32 offset, const __u8 *buf, __u8 size)
+{
+	__u8 cmd[22];
+
+	if (size > 16 || size == 0) {
+		hid_warn(wdata->hdev, "Invalid length %d wmem request\n", size);
+		return;
+	}
+
+	memset(cmd, 0, sizeof(cmd));
+	cmd[0] = WIIPROTO_REQ_WMEM;
+	cmd[2] = (offset >> 16) & 0xff;
+	cmd[3] = (offset >> 8) & 0xff;
+	cmd[4] = offset & 0xff;
+	cmd[5] = size;
+	memcpy(&cmd[6], buf, size);
+
+	if (!eeprom)
+		cmd[1] |= 0x04;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static enum led_brightness wiimote_leds_get(struct led_classdev *led_dev)
 {
 	struct wiimote_data *wdata;
@@ -535,6 +569,11 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
 }
 
+static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+}
+
 static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 {
 	__u8 err = payload[3];
@@ -647,6 +686,7 @@ struct wiiproto_handler {
 
 static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
+	{ .id = WIIPROTO_REQ_DATA, .size = 21, .func = handler_data },
 	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
-- 
1.7.6.1

