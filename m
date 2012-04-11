From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: evdev - return proper value for partial reads
Date: Wed, 11 Apr 2012 00:28:01 -0700
Message-ID: <1334129282-15892-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1334129282-15892-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35280 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2DKH2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 03:28:07 -0400
Received: by pbcun15 with SMTP id un15so892064pbc.19
        for <linux-input@vger.kernel.org>; Wed, 11 Apr 2012 00:28:07 -0700 (PDT)
In-Reply-To: <1334129282-15892-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dima Zavin <dima@android.com>, Heiko Stuebner <heiko@sntech.de>, Jeff Brown <jeffbrown@android.com>, Daniel Kurtz <djkurtz@google.com>

If we encounter an error in middle of transferring several events to
userspace we should return number of bytes successfully transferred
instead of error code. If transfer fails on the very first event then
we can return error code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/evdev.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 0e32b6a..8f59fc1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -398,35 +398,39 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
 	struct input_event event;
-	int retval = 0;
+	int read = 0;
+	int error = 0;
 
 	if (count < input_event_size())
 		return -EINVAL;
 
 	if (!(file->f_flags & O_NONBLOCK)) {
-		retval = wait_event_interruptible(evdev->wait,
+		error = wait_event_interruptible(evdev->wait,
 				client->packet_head != client->tail ||
 				!evdev->exist);
-		if (retval)
-			return retval;
+		if (error)
+			return error;
 	}
 
 	if (!evdev->exist)
 		return -ENODEV;
 
-	while (retval + input_event_size() <= count &&
+	while (read + input_event_size() <= count &&
 	       evdev_fetch_next_event(client, &event)) {
 
-		if (input_event_to_user(buffer + retval, &event))
-			return -EFAULT;
+		if (input_event_to_user(buffer + read, &event)) {
+			error = -EFAULT;
+			goto out;
+		}
 
-		retval += input_event_size();
+		read += input_event_size();
 	}
 
-	if (retval == 0 && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
+	if (read == 0 && (file->f_flags & O_NONBLOCK))
+		error = -EAGAIN;
 
-	return retval;
+out:
+	return read ?: error;
 }
 
 /* No kernel lock - fine */
-- 
1.7.7.6

