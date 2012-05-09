From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] Input: uinput - fix formatting
Date: Wed,  9 May 2012 01:08:28 -0700
Message-ID: <1336550908-30644-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36822 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757757Ab2EIIIl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 04:08:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so190360pbb.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 01:08:41 -0700 (PDT)
In-Reply-To: <1336550908-30644-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Aristeu Rozanski <aris@ruivo.org>
Cc: linux-input@vger.kernel.org

Reformat the code to keep it within 80 columns.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index b247e1c..86328e9 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -40,7 +40,8 @@
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
-static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static int uinput_dev_event(struct input_dev *dev,
+			    unsigned int type, unsigned int code, int value)
 {
 	struct uinput_device	*udev = input_get_drvdata(dev);
 
@@ -95,7 +96,8 @@ static int uinput_request_reserve_slot(struct uinput_device *udev,
 					uinput_request_alloc_id(udev, request));
 }
 
-static void uinput_request_done(struct uinput_device *udev, struct uinput_request *request)
+static void uinput_request_done(struct uinput_device *udev,
+				struct uinput_request *request)
 {
 	/* Mark slot as available */
 	udev->requests[request->id] = NULL;
@@ -151,7 +153,7 @@ static int uinput_request_submit(struct uinput_device *udev,
 }
 
 /*
- * Fail all ouitstanding requests so handlers don't wait for the userspace
+ * Fail all outstanding requests so handlers don't wait for the userspace
  * to finish processing them.
  */
 static void uinput_flush_requests(struct uinput_device *udev)
@@ -187,7 +189,9 @@ static int uinput_dev_playback(struct input_dev *dev, int effect_id, int value)
 	return uinput_dev_event(dev, EV_FF, effect_id, value);
 }
 
-static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
+static int uinput_dev_upload_effect(struct input_dev *dev,
+				    struct ff_effect *effect,
+				    struct ff_effect *old)
 {
 	struct uinput_device *udev = input_get_drvdata(dev);
 	struct uinput_request request;
@@ -353,7 +357,8 @@ static int uinput_allocate_device(struct uinput_device *udev)
 	return 0;
 }
 
-static int uinput_setup_device(struct uinput_device *udev, const char __user *buffer, size_t count)
+static int uinput_setup_device(struct uinput_device *udev,
+			       const char __user *buffer, size_t count)
 {
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
@@ -425,7 +430,8 @@ static int uinput_setup_device(struct uinput_device *udev, const char __user *bu
 	return retval;
 }
 
-static inline ssize_t uinput_inject_event(struct uinput_device *udev, const char __user *buffer, size_t count)
+static ssize_t uinput_inject_event(struct uinput_device *udev,
+				   const char __user *buffer, size_t count)
 {
 	struct input_event ev;
 
@@ -440,7 +446,8 @@ static inline ssize_t uinput_inject_event(struct uinput_device *udev, const char
 	return input_event_size();
 }
 
-static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t uinput_write(struct file *file, const char __user *buffer,
+			    size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
 	int retval;
@@ -744,7 +751,8 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 				break;
 
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!req || req->code != UI_FF_UPLOAD || !req->u.upload.effect) {
+			if (!req || req->code != UI_FF_UPLOAD ||
+			    !req->u.upload.effect) {
 				retval = -EINVAL;
 				break;
 			}
@@ -827,7 +835,8 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
-static long uinput_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long uinput_compat_ioctl(struct file *file,
+				unsigned int cmd, unsigned long arg)
 {
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }
@@ -872,4 +881,3 @@ MODULE_VERSION("0.3");
 
 module_init(uinput_init);
 module_exit(uinput_exit);
-
-- 
1.7.7.6

