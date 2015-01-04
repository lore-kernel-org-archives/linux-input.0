From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input: Added check for grabbed device
Date: Sun,  4 Jan 2015 00:25:55 -0800
Message-ID: <1420359955-21553-1-git-send-email-aksgarg1989@gmail.com>
References: <anshul.g@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59155 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbADI0Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2015 03:26:24 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so25941050wgh.32
        for <linux-input@vger.kernel.org>; Sun, 04 Jan 2015 00:26:23 -0800 (PST)
In-Reply-To: <anshul.g@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

If input device is grabbed then client which has grabbed the device can
flush or write to the device so for other clients -EINVAL should be returned.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/evdev.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b1a52ab..105e489 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -277,6 +277,8 @@ static int evdev_flush(struct file *file, fl_owner_t id)
 
 	if (!evdev->exist || client->revoked)
 		retval = -ENODEV;
+	else if (evdev->grab && evdev->grab != client)
+		retval = -EINVAL;
 	else
 		retval = input_flush_device(&evdev->handle, file);
 
@@ -475,6 +477,11 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
+
+	if (evdev->grab && evdev->grab != client) {
+		retval = -EINVAL;
+		goto out;
+	}
 	while (retval + input_event_size() <= count) {
 
 		if (input_event_from_user(buffer + retval, &event)) {
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

