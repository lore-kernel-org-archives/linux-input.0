From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: hidraw: fix signaling SIGIO when hidraw reports an event
Date: Tue, 27 Nov 2012 19:02:27 -0800
Message-ID: <1354071747-14007-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:22253 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2K1DMj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 22:12:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, cheiny@synaptics.com

Hi Jiri and Linux-Input,

This patch fixes sending SIGIO from hidraw_report_event by creating a fasync
handler which adds the fasync entry.


Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hidraw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 7c47fc3..d4a5af4 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -295,6 +295,13 @@ out:
 
 }
 
+static int hidraw_fasync(int fd, struct file *file, int on)
+{
+	struct hidraw_list *list = file->private_data;
+
+	return fasync_helper(fd, file, on, &list->fasync);
+}
+
 static int hidraw_release(struct inode * inode, struct file * file)
 {
 	unsigned int minor = iminor(inode);
@@ -438,6 +445,7 @@ static const struct file_operations hidraw_ops = {
 	.open =         hidraw_open,
 	.release =      hidraw_release,
 	.unlocked_ioctl = hidraw_ioctl,
+	.fasync =	hidraw_fasync,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = hidraw_ioctl,
 #endif
-- 
1.7.10.4

