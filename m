From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] input: fix input_open_file() accessing out-of-bound buffers
Date: Thu, 13 Sep 2012 18:17:30 +0200
Message-ID: <1347553050-25480-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35496 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab2IMQQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 12:16:11 -0400
Received: by weyx8 with SMTP id x8so1792808wey.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 09:16:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, stable@kernel.org

The "input_table" array is very small and we cannot be sure that the file
the user opens has a minor-ID below 256 (8 << 5). Hence, simply check that
the minor isn't out-of-bounds. If it is, return -ENODEV.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Cc: <stable@kernel.org>
---
 drivers/input/input.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8921c61..eb65ad7 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2095,13 +2095,19 @@ static int input_open_file(struct inode *inode, struct file *file)
 	struct input_handler *handler;
 	const struct file_operations *old_fops, *new_fops = NULL;
 	int err;
+	unsigned int minor_group;
 
 	err = mutex_lock_interruptible(&input_mutex);
 	if (err)
 		return err;
 
 	/* No load-on-demand here? */
-	handler = input_table[iminor(inode) >> 5];
+
+	minor_group = iminor(inode) >> 5;
+	if (minor_group >= sizeof(input_table) / sizeof(*input_table))
+		return -ENODEV;
+
+	handler = input_table[minor_group];
 	if (handler)
 		new_fops = fops_get(handler->fops);
 
-- 
1.7.12

