From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH RESEND 1/2] Input: uinput: Fix race condition on read()
Date: Thu, 29 Mar 2012 14:14:05 +0200
Message-ID: <1333023245-13704-2-git-send-email-dh.herrmann@googlemail.com>
References: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51093 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab2C2MO0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 08:14:26 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1503996wgb.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 05:14:25 -0700 (PDT)
In-Reply-To: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: aris@ruivo.org, dmitry.torokhov@gmail.com, David Herrmann <dh.herrmann@googlemail.com>

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
Acked-by: Aristeu Rozanski <aris@ruivo.org>
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

