From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 25/26] HID: wiimote: fix DRM debug-attr to correctly parse input
Date: Sun,  5 May 2013 23:13:09 +0200
Message-ID: <1367788390-29835-26-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35007 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3EEVOZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:25 -0400
Received: by mail-bk0-f49.google.com with SMTP id e19so1352757bku.36
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:23 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

We need to correctly zero-terminate the input to parse it. Otherwise, we
always end up interpreting it as numbers.
Furthermore, we actually want hexadecimal numbers instead of decimal. As
it is a debugfs interface, we can change the API at any time.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 6e76a2c..c13fb5b 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -141,7 +141,7 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 	if (copy_from_user(buf, u, len))
 		return -EFAULT;
 
-	buf[15] = 0;
+	buf[len] = 0;
 
 	for (i = 0; i < WIIPROTO_REQ_MAX; ++i) {
 		if (!wiidebug_drmmap[i])
@@ -151,7 +151,7 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 	}
 
 	if (i == WIIPROTO_REQ_MAX)
-		i = simple_strtoul(buf, NULL, 10);
+		i = simple_strtoul(buf, NULL, 16);
 
 	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
 	dbg->wdata->state.flags &= ~WIIPROTO_FLAG_DRM_LOCKED;
-- 
1.8.2.2

