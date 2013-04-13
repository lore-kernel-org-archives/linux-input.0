From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 18/21] HID: wiimote: fix ctx pointer in debugfs DRM-write
Date: Sat, 13 Apr 2013 12:47:59 +0200
Message-ID: <1365850082-3585-19-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:61335 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKs7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:59 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so1591497ead.40
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:58 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
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
1.8.2.1

