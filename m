From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: uinput - take event lock when fetching events from buffer
Date: Wed,  9 May 2012 01:08:23 -0700
Message-ID: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49191 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab2EIIId (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 04:08:33 -0400
Received: by dady13 with SMTP id y13so3728315dad.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 01:08:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Aristeu Rozanski <aris@ruivo.org>
Cc: linux-input@vger.kernel.org

When fetching events form device's buffer in uinput_read() we need to
take input device's event_lock to avoid racing with new event delivery.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 7360568..1b4ee4a 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -452,9 +452,28 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t
 	return retval;
 }
 
+static bool uinput_fetch_next_event(struct uinput_device *udev,
+				    struct input_event *event)
+{
+	bool have_event;
+
+	spin_lock_irq(&udev->dev->event_lock);
+
+	have_event = udev->head != udev->tail;
+	if (have_event) {
+		*event = udev->buff[udev->tail];
+		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
+	}
+
+	spin_unlock_irq(&udev->dev->event_lock);
+
+	return have_event;
+}
+
 static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
+	struct input_event event;
 	int retval = 0;
 
 	if (udev->state != UIST_CREATED)
@@ -477,12 +496,14 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
 		goto out;
 	}
 
-	while (udev->head != udev->tail && retval + input_event_size() <= count) {
-		if (input_event_to_user(buffer + retval, &udev->buff[udev->tail])) {
+	while (retval + input_event_size() <= count &&
+	       uinput_fetch_next_event(udev, &event)) {
+
+		if (input_event_to_user(buffer + retval, &event)) {
 			retval = -EFAULT;
 			goto out;
 		}
-		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
+
 		retval += input_event_size();
 	}
 
-- 
1.7.7.6

