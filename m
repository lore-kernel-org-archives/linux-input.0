From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: uinput - fix race that can block nonblocking read
Date: Fri, 30 Mar 2012 23:06:19 -0700
Message-ID: <1333173983-19949-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab2CaGG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:28 -0400
Received: by pbcun15 with SMTP id un15so2610029pbc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:27 -0700 (PDT)
In-Reply-To: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

From: David Herrmann <dh.herrmann@googlemail.com>

Consider two threads calling read() on the same uinput-fd, both
non-blocking. Assume there is data-available so both will simultaneously
pass:
	udev->head == udev->tail

Then the first thread goes to sleep and the second one pops the message
from the queue. Now assume udev->head == udev->tail. If the first thread
wakes up it will call wait_event_*() and sleep in the waitq. This
effectively turns the non-blocking FD into a blocking one.

We fix this by never calling wait_event_*() for non-blocking FDs hence we
will never sleep in the waitq here.

Also, if we fail to retrieve an event because it was "stolen" by another
thread, we will return -EAGAIN instead of 0 in case of nonblocking read.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index eb9723a..5339c1d 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -460,16 +460,13 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	if (count < input_event_size())
 		return -EINVAL;
 
-	if (udev->state != UIST_CREATED)
-		return -ENODEV;
-
-	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
-
-	retval = wait_event_interruptible(udev->waitq,
-			udev->head != udev->tail || udev->state != UIST_CREATED);
-	if (retval)
-		return retval;
+	if (!(file->f_flags & O_NONBLOCK)) {
+		retval = wait_event_interruptible(udev->waitq,
+						  udev->head != udev->tail ||
+						  udev->state != UIST_CREATED);
+		if (retval)
+			return retval;
+	}
 
 	retval = mutex_lock_interruptible(&udev->mutex);
 	if (retval)
@@ -480,8 +477,10 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 		goto out;
 	}
 
-	while (udev->head != udev->tail && retval + input_event_size() <= count) {
-		if (input_event_to_user(buffer + retval, &udev->buff[udev->tail])) {
+	while (udev->head != udev->tail &&
+               retval + input_event_size() <= count) {
+		if (input_event_to_user(buffer + retval,
+					&udev->buff[udev->tail])) {
 			retval = -EFAULT;
 			goto out;
 		}
@@ -489,6 +488,9 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 		retval += input_event_size();
 	}
 
+	if (retval == 0 && (file->f_flags & O_NONBLOCK))
+		retval = -EAGAIN;
+
  out:
 	mutex_unlock(&udev->mutex);
 
-- 
1.7.7.6

