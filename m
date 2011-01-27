From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 11:03:27 +0100
Message-ID: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62919 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1A0KDu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 05:03:50 -0500
Received: by wwa36 with SMTP id 36so1969798wwa.1
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 02:03:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, baruch@tkos.co.il
Cc: Peter Korsgaard <jacmet@sunsite.dk>

As was recently brought up on the busybox list
(http://lists.busybox.net/pipermail/busybox/2011-January/074565.html),
evdev_write doesn't properly check the count argument, which will
lead to a return value > count on partial writes if the remaining bytes
are accessible - Causing userspace confusion.

Fix it by only handling each full input_event structure and return -EINVAL
if less than 1 struct was written, similar to how it is done in evdev_read.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Changes since v1:
 - Return -EINVAL on writes of length < sizeof(struct input_event), similar
   to how it's done in evdev_read.

 drivers/input/evdev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c8471a2..1ee7d0f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	struct input_event event;
 	int retval;
 
+	if (count < input_event_size())
+		return -EINVAL;
+
 	retval = mutex_lock_interruptible(&evdev->mutex);
 	if (retval)
 		return retval;
@@ -330,7 +333,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
-	while (retval < count) {
+	while ((retval + input_event_size()) <= count) {
 
 		if (input_event_from_user(buffer + retval, &event)) {
 			retval = -EFAULT;
-- 
1.7.2.3

