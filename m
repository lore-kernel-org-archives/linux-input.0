From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 2/2] Input: uinput: Avoid returning 0 on read()
Date: Mon, 2 Apr 2012 00:48:15 -0700
Message-ID: <20120402074815.GA24313@core.coreip.homeip.net>
References: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
 <20120331060033.GA12307@core.coreip.homeip.net>
 <CANq1E4TJ3DPKjx7WBFFJUzLL-pZESYtKL6UadvdYBjE+vm_2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50320 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2DBHsS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 03:48:18 -0400
Received: by dake40 with SMTP id e40so2097590dak.11
        for <linux-input@vger.kernel.org>; Mon, 02 Apr 2012 00:48:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4TJ3DPKjx7WBFFJUzLL-pZESYtKL6UadvdYBjE+vm_2uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

On Sat, Mar 31, 2012 at 10:39:49AM +0200, David Herrmann wrote:
> Hi Dmitry
> 
> On Sat, Mar 31, 2012 at 8:00 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi David,
> >
> <snip>
> > I agree that we should return -EINVAL when buffer is too small. I
> > however do not like the whole "try_again" business; I think it is
> > perfectly fine to return 0 for blocking reads, we just want to return
> > -EAGAIN for nonblocking.
> 
> The read() manpage says that return-code 0 means the fd got closed.
> Does the VFS layer forward the return-code untouched to user-space or
> why do you think returning 0 is fine? At least my uinput user-space
> apps handle read()==0 as failure.

Hmm, according to the spec:

http://pubs.opengroup.org/onlinepubs/009695399/functions/read.html

it returns 0 to signal end of file, which does not make sense for
character devices, only regular files. I think I could also claim
that returning 0 when an event is "stolen" because "The behavior of
multiple concurrent reads on the same pipe, FIFO, or terminal device is
unspecified."

However I do not think that fixing it should be too hard, even taking
into account the special case of count == 0 outlined in the spec.
Below is the updated versions of the first 2 patches.

Thanks.

-- 
Dmitry


Input: uinput - return -EINVAL when read buffer size is too small

From: David Herrmann <dh.herrmann@googlemail.com>

Let's check whether the user-supplied buffer is actually big enough and
return -EINVAL if it is not. This differs from current behavior, which
caused 0 to be returned and actually does not make any sense, as
broken application will simply repeat the read getting into endless
loop.

Note that we treat 0 as a special case, according to the standard:

"Before any action described below is taken, and if nbyte is zero,
the read() function may detect and return errors as described below.
In the absence of errors, or if error detection is not performed,
the read() function shall return zero and have no other results."

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 7360568..0386064 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -457,6 +457,9 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
 
+	if (count != 0 && count < input_event_size())
+		return -EINVAL;
+
 	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 

Input: uinput - fix race that can block nonblocking read

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

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

 drivers/input/misc/uinput.c |   70 +++++++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 29 deletions(-)


diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 0386064..75e5502 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -452,45 +452,57 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t
 	return retval;
 }
 
-static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t uinput_events_to_user(struct uinput_device *udev,
+				     char __user *buffer, size_t count)
+{
+	size_t read = 0;
+	int error = 0;
+
+	while (udev->head != udev->tail &&
+               read + input_event_size() <= count) {
+		if (input_event_to_user(buffer + read,
+					&udev->buff[udev->tail])) {
+			error = -EFAULT;
+			break;
+		}
+		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
+		read += input_event_size();
+	}
+
+	return read ?: error;
+}
+
+static ssize_t uinput_read(struct file *file, char __user *buffer,
+			   size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
-	int retval = 0;
+	ssize_t retval;
 
 	if (count != 0 && count < input_event_size())
 		return -EINVAL;
 
-	if (udev->state != UIST_CREATED)
-		return -ENODEV;
+	do {
+		retval = mutex_lock_interruptible(&udev->mutex);
+		if (retval)
+			return retval;
 
-	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
+		if (udev->state != UIST_CREATED)
+			retval = -ENODEV;
+		else if (udev->head == udev->tail &&
+			 (file->f_flags & O_NONBLOCK))
+			retval = -EAGAIN;
+		else
+			retval = uinput_events_to_user(udev, buffer, count);
 
-	retval = wait_event_interruptible(udev->waitq,
-			udev->head != udev->tail || udev->state != UIST_CREATED);
-	if (retval)
-		return retval;
+		mutex_unlock(&udev->mutex);
 
-	retval = mutex_lock_interruptible(&udev->mutex);
-	if (retval)
-		return retval;
-
-	if (udev->state != UIST_CREATED) {
-		retval = -ENODEV;
-		goto out;
-	}
-
-	while (udev->head != udev->tail && retval + input_event_size() <= count) {
-		if (input_event_to_user(buffer + retval, &udev->buff[udev->tail])) {
-			retval = -EFAULT;
-			goto out;
-		}
-		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
-		retval += input_event_size();
-	}
+		if (retval)
+			return retval;
 
- out:
-	mutex_unlock(&udev->mutex);
+		retval = wait_event_interruptible(udev->waitq,
+						  udev->head != udev->tail ||
+						  udev->state != UIST_CREATED);
+	} while (retval == 0);
 
 	return retval;
 }
