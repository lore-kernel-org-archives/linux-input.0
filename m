From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: serio_raw - signal EFAULT even if read/write
 partially succeeds
Date: Sun, 29 Apr 2012 23:44:51 -0700
Message-ID: <20120430064450.GA29212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33646 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2D3Go4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 02:44:56 -0400
Received: by dadz8 with SMTP id z8so3683232dad.10
        for <linux-input@vger.kernel.org>; Sun, 29 Apr 2012 23:44:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, David Herrmann <dh.herrmann@googlemail.com>

When copy_to/from_user fails in the middle of transfer we should not
report to the user that read/write partially succeeded but rather
report -EFAULT right away, so that application will know that it got
its buffers all wrong.

If application messed up its buffers we can't trust the data fetched
from userspace and successfully written to the device or if data read
from the device and transferred to userspace ended up where application
expected it to end.

If serio_write() fails we still going to report partial writes if failure
happens in the middle of the transfer.

This is basically a revert of 7a0a27d2ce38aee19a31fee8c12095f586eed393
and 4fa0771138d0b56fe59ab8ab3b1ce9e594484362.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/serio_raw.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 3e24362..59df2e7 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -165,9 +165,9 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 	struct serio_raw *serio_raw = client->serio_raw;
 	char uninitialized_var(c);
 	ssize_t read = 0;
-	int error = 0;
+	int error;
 
-	do {
+	for (;;) {
 		if (serio_raw->dead)
 			return -ENODEV;
 
@@ -179,24 +179,24 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 			break;
 
 		while (read < count && serio_raw_fetch_byte(serio_raw, &c)) {
-			if (put_user(c, buffer++)) {
-				error = -EFAULT;
-				goto out;
-			}
+			if (put_user(c, buffer++))
+				return -EFAULT;
 			read++;
 		}
 
 		if (read)
 			break;
 
-		if (!(file->f_flags & O_NONBLOCK))
+		if (!(file->f_flags & O_NONBLOCK)) {
 			error = wait_event_interruptible(serio_raw->wait,
 					serio_raw->head != serio_raw->tail ||
 					serio_raw->dead);
-	} while (!error);
+			if (error)
+				return error;
+		}
+	}
 
-out:
-	return read ?: error;
+	return read;
 }
 
 static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
@@ -204,8 +204,7 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
-	ssize_t written = 0;
-	int retval;
+	int retval = 0;
 	unsigned char c;
 
 	retval = mutex_lock_interruptible(&serio_raw_mutex);
@@ -225,16 +224,20 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 			retval = -EFAULT;
 			goto out;
 		}
+
 		if (serio_write(serio_raw->serio, c)) {
-			retval = -EIO;
+			/* Either signal error or partial write */
+			if (retval == 0)
+				retval = -EIO;
 			goto out;
 		}
-		written++;
+
+		retval++;
 	}
 
 out:
 	mutex_unlock(&serio_raw_mutex);
-	return written ?: retval;
+	return retval;
 }
 
 static unsigned int serio_raw_poll(struct file *file, poll_table *wait)
-- 
1.7.7.6


-- 
Dmitry
