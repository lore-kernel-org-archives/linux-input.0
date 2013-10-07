From: Daniel Stone <daniel@fooishbar.org>
Subject: [PATCH] Input: evdev: Fall back to vmalloc for client event buffer
Date: Mon,  7 Oct 2013 14:06:53 +0100
Message-ID: <1381151213-32690-1-git-send-email-daniels@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63972 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3JGNG6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2013 09:06:58 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so4787909wid.9
        for <linux-input@vger.kernel.org>; Mon, 07 Oct 2013 06:06:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@euromail.se>

evdev always tries to allocate the event buffer for clients using
kzalloc rather than vmalloc, presumably to avoid mapping overhead where
possible.  However, drivers like bcm5974, which claims support for
reporting 16 fingers simultaneously, can have an extraordinarily large
buffer.  The resultant contiguous order-4 allocation attempt fails due
to fragmentation, and the device is thus unusable until reboot.

Try kzalloc if we can to avoid the mapping overhead, but if that fails,
fall back to vzalloc.

Signed-off-by: Daniel Stone <daniels@collabora.com>
---
 drivers/input/evdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f0f8928..edfca4a 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -18,6 +18,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input/mt.h>
@@ -289,7 +290,11 @@ static int evdev_release(struct inode *inode, struct file *file)
 	mutex_unlock(&evdev->mutex);
 
 	evdev_detach_client(evdev, client);
-	kfree(client);
+
+	if (is_vmalloc_addr(client))
+		vfree(client);
+	else
+		kfree(client);
 
 	evdev_close_device(evdev);
 
@@ -311,10 +316,12 @@ static int evdev_open(struct inode *inode, struct file *file)
 	unsigned int bufsize = evdev_compute_buffer_size(evdev->handle.dev);
 	struct evdev_client *client;
 	int error;
+	int size =
+		sizeof(struct evdev_client) + bufsize * sizeof(struct input_event);
 
-	client = kzalloc(sizeof(struct evdev_client) +
-				bufsize * sizeof(struct input_event),
-			 GFP_KERNEL);
+	client = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+	if (!client)
+		client = vzalloc(size);
 	if (!client)
 		return -ENOMEM;
 
-- 
1.8.3.1

