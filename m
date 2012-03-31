From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: uinput - return number of bytes copied on partial reads
Date: Fri, 30 Mar 2012 23:06:20 -0700
Message-ID: <1333173983-19949-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39403 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab2CaGGb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:31 -0400
Received: by dake40 with SMTP id e40so341177dak.11
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:30 -0700 (PDT)
In-Reply-To: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

If uinput_read() fails after copying several events to userspace
we need to return number of bytes successfully copied, not -EFAULT.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 5339c1d..a33a7b3 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -455,7 +455,8 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t
 static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
-	int retval = 0;
+	size_t read = 0;
+	int retval;
 
 	if (count < input_event_size())
 		return -EINVAL;
@@ -478,23 +479,23 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	}
 
 	while (udev->head != udev->tail &&
-               retval + input_event_size() <= count) {
-		if (input_event_to_user(buffer + retval,
+               read + input_event_size() <= count) {
+		if (input_event_to_user(buffer + read,
 					&udev->buff[udev->tail])) {
 			retval = -EFAULT;
 			goto out;
 		}
 		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
-		retval += input_event_size();
+		read += input_event_size();
 	}
 
-	if (retval == 0 && (file->f_flags & O_NONBLOCK))
+	if (read == 0 && (file->f_flags & O_NONBLOCK))
 		retval = -EAGAIN;
 
  out:
 	mutex_unlock(&udev->mutex);
 
-	return retval;
+	return read ?: retval;
 }
 
 static unsigned int uinput_poll(struct file *file, poll_table *wait)
-- 
1.7.7.6

