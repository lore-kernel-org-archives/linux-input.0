From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: uinput - fix race that can block nonblocking read
Date: Wed,  9 May 2012 01:08:25 -0700
Message-ID: <1336550908-30644-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49191 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757757Ab2EIIIg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 04:08:36 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3728315dad.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 01:08:36 -0700 (PDT)
In-Reply-To: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Aristeu Rozanski <aris@ruivo.org>
Cc: linux-input@vger.kernel.org

Consider two threads calling read() on the same uinput-fd, both
non-blocking. Assume there is data-available so both will simultaneously
pass:
	udev->head == udev->tail

Then the first thread goes to sleep and the second one pops the message
from the queue. Now assume udev->head == udev->tail. If the first thread
wakes up it will call wait_event_*() and sleep in the waitq. This
effectively turns the non-blocking FD into a blocking one.

We fix this by attempting to fetch events from the queue first and only
if we fail to retrieve any events we either return -EAGAIN (in case of
non-blocing read) or wait until there are more events.

This also fixes incorrect return code (we were returning 0 instead of
 -EAGAIN for non-blocking reads) when an event is "stolen" by another
thread. Blocking reads will now continue to wait instead of returning 0
in this scenario.

Count of 0 continues to be a special case, as per spec: we will check for
device existence and whether there are events in the queue, but no events
will be actually retrieved.

Reported-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   74 +++++++++++++++++++++++++-----------------
 1 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e74ed9c..1719554 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -439,6 +439,9 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t
 	struct uinput_device *udev = file->private_data;
 	int retval;
 
+	if (count == 0)
+		return 0;
+
 	retval = mutex_lock_interruptible(&udev->mutex);
 	if (retval)
 		return retval;
@@ -470,48 +473,59 @@ static bool uinput_fetch_next_event(struct uinput_device *udev,
 	return have_event;
 }
 
-static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t uinput_events_to_user(struct uinput_device *udev,
+				     char __user *buffer, size_t count)
 {
-	struct uinput_device *udev = file->private_data;
 	struct input_event event;
-	int retval = 0;
+	size_t read = 0;
+	int error = 0;
 
-	if (count != 0 && count < input_event_size())
-		return -EINVAL;
+	while (read + input_event_size() <= count &&
+	       uinput_fetch_next_event(udev, &event)) {
 
-	if (udev->state != UIST_CREATED)
-		return -ENODEV;
+		if (input_event_to_user(buffer + read, &event)) {
+			error = -EFAULT;
+			break;
+		}
 
-	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
+		read += input_event_size();
+	}
 
-	retval = wait_event_interruptible(udev->waitq,
-			udev->head != udev->tail || udev->state != UIST_CREATED);
-	if (retval)
-		return retval;
+	return read ?: error;
+}
 
-	retval = mutex_lock_interruptible(&udev->mutex);
-	if (retval)
-		return retval;
+static ssize_t uinput_read(struct file *file, char __user *buffer,
+			   size_t count, loff_t *ppos)
+{
+	struct uinput_device *udev = file->private_data;
+	ssize_t retval;
 
-	if (udev->state != UIST_CREATED) {
-		retval = -ENODEV;
-		goto out;
-	}
+	if (count != 0 && count < input_event_size())
+		return -EINVAL;
 
-	while (retval + input_event_size() <= count &&
-	       uinput_fetch_next_event(udev, &event)) {
+	do {
+		retval = mutex_lock_interruptible(&udev->mutex);
+		if (retval)
+			return retval;
 
-		if (input_event_to_user(buffer + retval, &event)) {
-			retval = -EFAULT;
-			goto out;
-		}
+		if (udev->state != UIST_CREATED)
+			retval = -ENODEV;
+		else if (udev->head == udev->tail &&
+			 (file->f_flags & O_NONBLOCK))
+			retval = -EAGAIN;
+		else
+			retval = uinput_events_to_user(udev, buffer, count);
 
-		retval += input_event_size();
-	}
+		mutex_unlock(&udev->mutex);
 
- out:
-	mutex_unlock(&udev->mutex);
+		if (retval || count == 0)
+			break;
+
+		if (!(file->f_flags & O_NONBLOCK))
+			retval = wait_event_interruptible(udev->waitq,
+						  udev->head != udev->tail ||
+						  udev->state != UIST_CREATED);
+	} while (retval == 0);
 
 	return retval;
 }
-- 
1.7.7.6

