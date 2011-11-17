From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 06/17] HID: wiimote: Add extension initializers
Date: Thu, 17 Nov 2011 14:12:03 +0100
Message-ID: <1321535534-7950-7-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNM7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:12:59 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:12:59 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

The wiimote extension registers are not fully understood, so we always disable
all extensions on extension-port events. Then we reinitialize and reidentify
them and activate all requested extensions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |   81 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 3e3e1fc..233bdfe 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -37,30 +37,107 @@ enum wiiext_type {
 static void ext_disable(struct wiimote_ext *ext)
 {
 	unsigned long flags;
+	__u8 wmem = 0x55;
+
+	if (!wiimote_cmd_acquire(ext->wdata)) {
+		wiimote_cmd_write(ext->wdata, 0xa400f0, &wmem, sizeof(wmem));
+		wiimote_cmd_release(ext->wdata);
+	}
 
 	spin_lock_irqsave(&ext->wdata->state.lock, flags);
 	ext->motionp = false;
 	ext->ext_type = WIIEXT_NONE;
+	wiiproto_req_drm(ext->wdata, WIIPROTO_REQ_NULL);
 	spin_unlock_irqrestore(&ext->wdata->state.lock, flags);
 }
 
 static bool motionp_read(struct wiimote_ext *ext)
 {
-	return false;
+	__u8 rmem[2], wmem;
+	ssize_t ret;
+	bool avail = false;
+
+	if (wiimote_cmd_acquire(ext->wdata))
+		return false;
+
+	/* initialize motion plus */
+	wmem = 0x55;
+	ret = wiimote_cmd_write(ext->wdata, 0xa600f0, &wmem, sizeof(wmem));
+	if (ret)
+		goto error;
+
+	/* read motion plus ID */
+	ret = wiimote_cmd_read(ext->wdata, 0xa600fe, rmem, 2);
+	if (ret == 2 || rmem[1] == 0x5)
+		avail = true;
+
+error:
+	wiimote_cmd_release(ext->wdata);
+	return avail;
 }
 
 static __u8 ext_read(struct wiimote_ext *ext)
 {
-	return WIIEXT_NONE;
+	ssize_t ret;
+	__u8 rmem[2], wmem;
+	__u8 type = WIIEXT_NONE;
+
+	if (!ext->plugged)
+		return WIIEXT_NONE;
+
+	if (wiimote_cmd_acquire(ext->wdata))
+		return WIIEXT_NONE;
+
+	/* initialize extension */
+	wmem = 0x55;
+	ret = wiimote_cmd_write(ext->wdata, 0xa400f0, &wmem, sizeof(wmem));
+	if (!ret) {
+		/* disable encryption */
+		wmem = 0x0;
+		wiimote_cmd_write(ext->wdata, 0xa400fb, &wmem, sizeof(wmem));
+	}
+
+	/* read extension ID */
+	ret = wiimote_cmd_read(ext->wdata, 0xa400fe, rmem, 2);
+	if (ret == 2) {
+		if (rmem[0] == 0 && rmem[1] == 0)
+			type = WIIEXT_NUNCHUCK;
+		else if (rmem[0] == 0x01 && rmem[1] == 0x01)
+			type = WIIEXT_CLASSIC;
+	}
+
+	wiimote_cmd_release(ext->wdata);
+
+	return type;
 }
 
 static void ext_enable(struct wiimote_ext *ext, bool motionp, __u8 ext_type)
 {
 	unsigned long flags;
+	__u8 wmem;
+	int ret;
+
+	if (motionp) {
+		if (wiimote_cmd_acquire(ext->wdata))
+			return;
+
+		if (ext_type == WIIEXT_CLASSIC)
+			wmem = 0x07;
+		else if (ext_type == WIIEXT_NUNCHUCK)
+			wmem = 0x05;
+		else
+			wmem = 0x04;
+
+		ret = wiimote_cmd_write(ext->wdata, 0xa600fe, &wmem, sizeof(wmem));
+		wiimote_cmd_release(ext->wdata);
+		if (ret)
+			return;
+	}
 
 	spin_lock_irqsave(&ext->wdata->state.lock, flags);
 	ext->motionp = motionp;
 	ext->ext_type = ext_type;
+	wiiproto_req_drm(ext->wdata, WIIPROTO_REQ_NULL);
 	spin_unlock_irqrestore(&ext->wdata->state.lock, flags);
 }
 
-- 
1.7.7.3

