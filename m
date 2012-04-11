From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: evdev - properly handle read/write with count 0
Date: Wed, 11 Apr 2012 00:28:02 -0700
Message-ID: <1334129282-15892-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1334129282-15892-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35280 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2DKH2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 03:28:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so892064pbc.19
        for <linux-input@vger.kernel.org>; Wed, 11 Apr 2012 00:28:10 -0700 (PDT)
In-Reply-To: <1334129282-15892-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dima Zavin <dima@android.com>, Heiko Stuebner <heiko@sntech.de>, Jeff Brown <jeffbrown@android.com>, Daniel Kurtz <djkurtz@google.com>

According to the standard count 0 is special - no IO should happen but we
can check error conditions (device gone away, etc), and return 0 if there
are no errors. We used to return -EINVAL instead and we also could return 0
if an event was "stolen: by another thread.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/evdev.c |   54 +++++++++++++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 8f59fc1..ff49ba3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -346,7 +346,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	int written = 0;
 	int error;
 
-	if (count < input_event_size())
+	if (count != 0 && count < input_event_size())
 		return -EINVAL;
 
 	error = mutex_lock_interruptible(&evdev->mutex);
@@ -358,7 +358,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
-	do {
+	while (written + input_event_size() <= count) {
 		if (input_event_from_user(buffer + written, &event)) {
 			error = -EFAULT;
 			goto out;
@@ -367,7 +367,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
-	} while (written + input_event_size() <= count);
+	}
 
  out:
 	mutex_unlock(&evdev->mutex);
@@ -401,33 +401,43 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 	int read = 0;
 	int error = 0;
 
-	if (count < input_event_size())
+	if (count != 0 && count < input_event_size())
 		return -EINVAL;
 
-	if (!(file->f_flags & O_NONBLOCK)) {
-		error = wait_event_interruptible(evdev->wait,
-				client->packet_head != client->tail ||
-				!evdev->exist);
-		if (error)
-			return error;
-	}
+	do {
+		if (!evdev->exist)
+			return -ENODEV;
 
-	if (!evdev->exist)
-		return -ENODEV;
+		if (client->packet_head == client->tail &&
+		    (file->f_flags & O_NONBLOCK))
+			return -EAGAIN;
 
-	while (read + input_event_size() <= count &&
-	       evdev_fetch_next_event(client, &event)) {
+		/*
+		 * count == 0 is special - no IO is done but we check
+		 * for error conditions.
+		 */
+		if (count == 0)
+			break;
 
-		if (input_event_to_user(buffer + read, &event)) {
-			error = -EFAULT;
-			goto out;
+		while (read + input_event_size() <= count &&
+		       evdev_fetch_next_event(client, &event)) {
+
+			if (input_event_to_user(buffer + read, &event)) {
+				error = -EFAULT;
+				goto out;
+			}
+
+			read += input_event_size();
 		}
 
-		read += input_event_size();
-	}
+		if (read)
+			break;
 
-	if (read == 0 && (file->f_flags & O_NONBLOCK))
-		error = -EAGAIN;
+		if (!(file->f_flags & O_NONBLOCK))
+			error = wait_event_interruptible(evdev->wait,
+					client->packet_head != client->tail ||
+					!evdev->exist);
+	} while (!error);
 
 out:
 	return read ?: error;
-- 
1.7.7.6

