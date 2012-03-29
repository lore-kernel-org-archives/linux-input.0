From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH RESEND 2/2] Input: uinput: Avoid returning 0 on read()
Date: Thu, 29 Mar 2012 14:14:04 +0200
Message-ID: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51093 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab2C2MOZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 08:14:25 -0400
Received: by wgbdr13 with SMTP id dr13so1503996wgb.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 05:14:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: aris@ruivo.org, dmitry.torokhov@gmail.com, David Herrmann <dh.herrmann@googlemail.com>

Consider the output-queue to be almost full. A thread inside read() will
pass the wait_event_*() call and reach the while() loop. Now assume a new
message was added to the output-queue and the queue overruns, i.e.,
we now have udev->head == udev->tail.
The thread now passes the while() loop without fetching any message and
returns 0. However, at least for blocking FDs there is really no reason to
wake up user-space and for non-blocking FDs we should return -EAGAIN now.
Therefore, simply retry the read() if we didn't fetch any message.

We also check whether the user-supplied buffer is actually big enough and
return -EINVAL if it is not. This differs from current behavior which
caused 0 to be returned which actually does not make any sense. This may
break ABI since user-space programs might be used to get 0 if the buffer
is to small. However, 0 means the FD was closed so returning -EINVAL
*must* be handled similar in user-space, otherwise the programs are
broken.
Anyway, we need this check, otherwise we would have a never-returning
loop here because retval would always be 0.

Also note that an queue-overrun is not the only situation where this bug
occurs. We might also have a race between multiple threads here so we
definitely need to handle it this way.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Acked-by: Aristeu Rozanski <aris@ruivo.org>
---
Hi Dmitry

Please note that this is based on my previous fix so you might get some
(trivial) conflicts if you didn't apply the previous one. They should be easy to
solve, though.
Also, the issue with returning -EINVAL if the buffer is too small and hence
breaking API can be resolved by moving the check down directly before running
"goto try_again;". However, I think returning -EINVAL is the better fix. Feel
free to change this, though.
To be honest, I also don't know whether read() actually returns 0 to user-space
if our handler returns 0 or if it changes this to anything else.

Regards
David

 drivers/input/misc/uinput.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 1526814..bf5cd7b 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -457,6 +457,10 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	struct uinput_device *udev = file->private_data;
 	int retval = 0;
 
+	if (count < input_event_size())
+		return -EINVAL;
+
+try_again:
 	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 
@@ -490,6 +494,8 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 
  out:
 	mutex_unlock(&udev->mutex);
+	if (!retval)
+		goto try_again;
 
 	return retval;
 }
-- 
1.7.9.4

