From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 3/3] uinput: convert input_event to input_event64
Date: Mon,  2 Nov 2015 21:35:39 +0800
Message-ID: <1446471339-25464-4-git-send-email-pingbo.wen@linaro.org>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33459 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbKBNgq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 08:36:46 -0500
Received: by pabfh17 with SMTP id fh17so25431850pab.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 05:36:46 -0800 (PST)
In-Reply-To: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: y2038@lists.linaro.org, arnd@arndb.de, dmitry.torokhov@gmail.com, WEN Pingbo <pingbo.wen@linaro.org>

evdev has converted to input_event64, so is uinput.

Since uinput uses input_event to talk with driver, we hardcode
is_input_event64 flag here directly.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/misc/uinput.c | 17 +++++++++++------
 include/linux/uinput.h      |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 5adbced..d60dc6f 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -50,7 +50,7 @@ static int uinput_dev_event(struct input_dev *dev,
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
-	do_gettimeofday(&udev->buff[udev->head].time);
+	getnstimeofday64(&udev->buff[udev->head].time);
 	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
@@ -436,7 +436,7 @@ static int uinput_setup_device(struct uinput_device *udev,
 static ssize_t uinput_inject_events(struct uinput_device *udev,
 				    const char __user *buffer, size_t count)
 {
-	struct input_event ev;
+	struct input_event64 ev;
 	size_t bytes = 0;
 
 	if (count != 0 && count < input_event_size())
@@ -448,8 +448,10 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 		 * we are still going to return EFAULT instead of partial
 		 * count to let userspace know that it got it's buffers
 		 * all wrong.
+		 *
+		 * Force set is_input_event64 to false
 		 */
-		if (input_event_from_user(buffer + bytes, &ev))
+		if (input_event_from_user(buffer + bytes, &ev, 0))
 			return -EFAULT;
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
@@ -482,7 +484,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
 }
 
 static bool uinput_fetch_next_event(struct uinput_device *udev,
-				    struct input_event *event)
+				    struct input_event64 *event)
 {
 	bool have_event;
 
@@ -502,13 +504,16 @@ static bool uinput_fetch_next_event(struct uinput_device *udev,
 static ssize_t uinput_events_to_user(struct uinput_device *udev,
 				     char __user *buffer, size_t count)
 {
-	struct input_event event;
+	struct input_event64 event;
 	size_t read = 0;
 
 	while (read + input_event_size() <= count &&
 	       uinput_fetch_next_event(udev, &event)) {
 
-		if (input_event_to_user(buffer + read, &event))
+		/*
+		 * Force set is_input_event64 to false
+		 */
+		if (input_event_to_user(buffer + read, &event, 0))
 			return -EFAULT;
 
 		read += input_event_size();
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index 0994c0d..17859c0 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -66,7 +66,7 @@ struct uinput_device {
 	unsigned char		ready;
 	unsigned char		head;
 	unsigned char		tail;
-	struct input_event	buff[UINPUT_BUFFER_SIZE];
+	struct input_event64	buff[UINPUT_BUFFER_SIZE];
 	unsigned int		ff_effects_max;
 
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
-- 
1.9.1

