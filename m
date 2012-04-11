From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: evdev - return proper result for partial writes
Date: Wed, 11 Apr 2012 00:28:00 -0700
Message-ID: <1334129282-15892-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52812 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab2DKH2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 03:28:07 -0400
Received: by dake40 with SMTP id e40so809689dak.11
        for <linux-input@vger.kernel.org>; Wed, 11 Apr 2012 00:28:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dima Zavin <dima@android.com>, Heiko Stuebner <heiko@sntech.de>, Jeff Brown <jeffbrown@android.com>, Daniel Kurtz <djkurtz@google.com>

If we encounter an error in middle of transferring several events from
userspace we should return number of bytes successfully transferred
instead of error code. If transfer fails on the very first event then
we can return error code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/evdev.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 9226b4d..0e32b6a 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -343,34 +343,35 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
 	struct input_event event;
-	int retval = 0;
+	int written = 0;
+	int error;
 
 	if (count < input_event_size())
 		return -EINVAL;
 
-	retval = mutex_lock_interruptible(&evdev->mutex);
-	if (retval)
-		return retval;
+	error = mutex_lock_interruptible(&evdev->mutex);
+	if (error)
+		return error;
 
 	if (!evdev->exist) {
-		retval = -ENODEV;
+		error = -ENODEV;
 		goto out;
 	}
 
 	do {
-		if (input_event_from_user(buffer + retval, &event)) {
-			retval = -EFAULT;
+		if (input_event_from_user(buffer + written, &event)) {
+			error = -EFAULT;
 			goto out;
 		}
-		retval += input_event_size();
+		written += input_event_size();
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
-	} while (retval + input_event_size() <= count);
+	} while (written + input_event_size() <= count);
 
  out:
 	mutex_unlock(&evdev->mutex);
-	return retval;
+	return written ?: error;
 }
 
 static int evdev_fetch_next_event(struct evdev_client *client,
-- 
1.7.7.6

