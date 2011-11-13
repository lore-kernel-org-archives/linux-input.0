From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 03/16] HID: wiimote: Add read-mem helpers
Date: Sun, 13 Nov 2011 14:27:06 +0100
Message-ID: <1321190839-3517-4-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab1KMN17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:27:59 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:27:58 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add helper functions similar to the write-mem helpers but for reading wiimote
memory and eeprom.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c |   77 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h      |    4 ++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index c955d50..f7f8b7f 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -312,6 +312,37 @@ static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+#define wiiproto_req_rreg(wdata, os, sz) \
+				wiiproto_req_rmem((wdata), false, (os), (sz))
+
+#define wiiproto_req_reeprom(wdata, os, sz) \
+				wiiproto_req_rmem((wdata), true, (os), (sz))
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
 /* requries the cmd-mutex to be held */
 int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size)
@@ -331,6 +362,36 @@ int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 	return ret;
 }
 
+/* requries the cmd-mutex to be held */
+ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset, __u8 *rmem,
+								__u8 size)
+{
+	unsigned long flags;
+	ssize_t ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.cmd_read_size = size;
+	wdata->state.cmd_read_buf = rmem;
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, offset & 0xffff);
+	wiiproto_req_rreg(wdata, offset, size);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.cmd_read_buf = NULL;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	if (!ret) {
+		if (wdata->state.cmd_read_size == 0)
+			ret = -EIO;
+		else
+			ret = wdata->state.cmd_read_size;
+	}
+
+	return ret;
+}
+
 static int wiimote_battery_get_property(struct power_supply *psy,
 						enum power_supply_property psp,
 						union power_supply_propval *val)
@@ -742,7 +803,23 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 
 static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
 {
+	__u16 offset = payload[3] << 8 | payload[4];
+	__u8 size = (payload[2] >> 4) + 1;
+	__u8 err = payload[2] & 0x0f;
+
 	handler_keys(wdata, payload);
+
+	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_RMEM, offset)) {
+		if (err)
+			size = 0;
+		else if (size > wdata->state.cmd_read_size)
+			size = wdata->state.cmd_read_size;
+
+		wdata->state.cmd_read_size = size;
+		if (wdata->state.cmd_read_buf)
+			memcpy(wdata->state.cmd_read_buf, &payload[5], size);
+		wiimote_cmd_complete(wdata);
+	}
 }
 
 static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index d78f79c..865740d 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -62,6 +62,8 @@ struct wiimote_state {
 	/* results of synchronous requests */
 	__u8 cmd_battery;
 	__u8 cmd_err;
+	__u8 *cmd_read_buf;
+	__u8 cmd_read_size;
 };
 
 struct wiimote_data {
@@ -113,6 +115,8 @@ enum wiiproto_reqs {
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 						const __u8 *wmem, __u8 size);
+extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
+							__u8 *rmem, __u8 size);
 
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
-- 
1.7.7.3

