From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 10/16] HID: wiimote: Add register/eeprom memory support
Date: Thu, 28 Jul 2011 18:08:30 +0200
Message-ID: <1311869316-17128-11-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab1G1QJS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:18 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:17 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The wiimote allows direct access to its memory mapped registers and
internal eeprom. This adds support to access this memory and handle
memory events.

There are two macros which wrap up the memory access functions to avoid
accidentally overwriting sensitive eeprom data because a boolean value
was wrongly set.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   71 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 066beb5..7b59822 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -66,7 +66,10 @@ enum wiiproto_reqs {
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
@@ -303,6 +306,68 @@ static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
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
+#define wiiproto_req_rreg(wdata, os, sz) \
+			wiiproto_req_rmem((wdata), false, (os), (sz))
+
+#define wiiproto_req_reeprom(wdata, os, sz) \
+			wiiproto_req_rmem((wdata), true, (os), (sz))
+
+static void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom,
+						__u32 offset, __u16 size)
+{
+	__u8 cmd[7];
+
+	if (size == 0) {
+		hid_warn(wdata->hdev, "Invalid length %d rmem request\n", size);
+		return;
+	}
+
+	cmd[0] = WIIPROTO_REQ_RMEM;
+	cmd[1] = 0;
+	cmd[2] = (offset >> 16) & 0xff;
+	cmd[3] = (offset >> 8) & 0xff;
+	cmd[4] = offset & 0xff;
+	cmd[5] = (size >> 8) & 0xff;
+	cmd[6] = size & 0xff;
+
+	if (!eeprom)
+		cmd[1] |= 0x04;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
@@ -533,6 +598,11 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 	wiiproto_req_drm(wdata, 0);
 }
 
+static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
+{
+	handler_keys(wdata, payload);
+}
+
 static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 {
 	__u8 err = payload[3];
@@ -640,6 +710,7 @@ struct wiiproto_handler {
 
 static struct wiiproto_handler handlers[] = {
 	{ .id = WIIPROTO_REQ_STATUS, .size = 6, .func = handler_status },
+	{ .id = WIIPROTO_REQ_DATA, .size = 21, .func = handler_data },
 	{ .id = WIIPROTO_REQ_RETURN, .size = 4, .func = handler_return },
 	{ .id = WIIPROTO_REQ_DRM_K, .size = 2, .func = handler_keys },
 	{ .id = WIIPROTO_REQ_DRM_KA, .size = 5, .func = handler_drm_KA },
-- 
1.7.6

