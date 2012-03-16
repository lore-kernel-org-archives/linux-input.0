From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Input: uinput: Fix race condition on read()
Date: Fri, 16 Mar 2012 21:04:29 +0100
Message-ID: <1331928269-22532-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36843 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931Ab2CPUEs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 16:04:48 -0400
Received: by wejx9 with SMTP id x9so4271463wej.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 13:04:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: aris@cathedrallabs.org, dmitry.torokhov@gmail.com, David Herrmann <dh.herrmann@googlemail.com>

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

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/input/misc/uinput.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 7360568..1526814 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -460,13 +460,15 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 	if (udev->state != UIST_CREATED)
 		return -ENODEV;
 
-	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
-
-	retval = wait_event_interruptible(udev->waitq,
+	if (file->f_flags & O_NONBLOCK) {
+		if (udev->head == udev->tail)
+			return -EAGAIN;
+	} else {
+		retval = wait_event_interruptible(udev->waitq,
 			udev->head != udev->tail || udev->state != UIST_CREATED);
-	if (retval)
-		return retval;
+		if (retval)
+			return retval;
+	}
 
 	retval = mutex_lock_interruptible(&udev->mutex);
 	if (retval)
-- 
1.7.9.4

