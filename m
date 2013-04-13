From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 19/21] HID: wiimote: lock DRM mode during debugfs overwrite
Date: Sat, 13 Apr 2013 12:48:00 +0200
Message-ID: <1365850082-3585-20-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:53670 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3DMKtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:49:01 -0400
Received: by mail-ea0-f178.google.com with SMTP id o10so1605609eaj.9
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:49:00 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

If we write a DRM mode via debugfs, we shouldn't allow normal operations
to overwrite this DRM mode. This is important if we want to debug
3rd-party devices and we want to see what data is sent on each mode.

If we write NULL/0 as DRM, the lock is removed again so the best matching
DRM is chosen by wiimote core.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c  | 4 +++-
 drivers/hid/hid-wiimote-debug.c | 3 +++
 drivers/hid/hid-wiimote.h       | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 6f930f1..126c9d9 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -234,7 +234,9 @@ void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 {
 	__u8 cmd[3];
 
-	if (drm == WIIPROTO_REQ_NULL)
+	if (wdata->state.flags & WIIPROTO_FLAG_DRM_LOCKED)
+		drm = wdata->state.drm;
+	else if (drm == WIIPROTO_REQ_NULL)
 		drm = select_drm(wdata);
 
 	cmd[0] = WIIPROTO_REQ_DRM;
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 0c0deaa..6e76a2c 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -154,7 +154,10 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 		i = simple_strtoul(buf, NULL, 10);
 
 	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
+	dbg->wdata->state.flags &= ~WIIPROTO_FLAG_DRM_LOCKED;
 	wiiproto_req_drm(dbg->wdata, (__u8) i);
+	if (i != WIIPROTO_REQ_NULL)
+		dbg->wdata->state.flags |= WIIPROTO_FLAG_DRM_LOCKED;
 	spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
 
 	return len;
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 46457f6..6700853 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -43,6 +43,7 @@
 #define WIIPROTO_FLAG_MP_USED		0x1000
 #define WIIPROTO_FLAG_MP_ACTIVE		0x2000
 #define WIIPROTO_FLAG_EXITING		0x4000
+#define WIIPROTO_FLAG_DRM_LOCKED	0x8000
 
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
-- 
1.8.2.1

