From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 18/26] HID: wiimote: fix ctx pointer in debugfs DRM-write
Date: Sun,  5 May 2013 23:13:02 +0200
Message-ID: <1367788390-29835-19-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:49334 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab3EEVON (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:13 -0400
Received: by mail-bk0-f53.google.com with SMTP id i18so1359438bkv.12
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:12 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

single_open() stores the seq_file pointer in file->private_data. It stores
our ctx pointer in seq_file->private.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index fdd30dd..0c0deaa 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -127,7 +127,8 @@ static int wiidebug_drm_open(struct inode *i, struct file *f)
 static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 							size_t s, loff_t *off)
 {
-	struct wiimote_debug *dbg = f->private_data;
+	struct seq_file *sf = f->private_data;
+	struct wiimote_debug *dbg = sf->private;
 	unsigned long flags;
 	char buf[16];
 	ssize_t len;
-- 
1.8.2.2

