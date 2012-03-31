From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] Input: uinput - fix formatting
Date: Fri, 30 Mar 2012 23:06:23 -0700
Message-ID: <1333173983-19949-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39403 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab2CaGGe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:34 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so341177dak.11
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:34 -0700 (PDT)
In-Reply-To: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

Reformat the code to keep it within 80 columns.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index bfdee05..d9feed6 100644
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
@@ -458,7 +465,8 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer, size_t
 	return retval;
 }
 
-static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t uinput_read(struct file *file, char __user *buffer,
+			   size_t count, loff_t *ppos)
 {
 	struct uinput_device *udev = file->private_data;
 	size_t read = 0;
@@ -715,7 +723,8 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 				break;
 
 			req = uinput_request_find(udev, ff_up.request_id);
-			if (!req || req->code != UI_FF_UPLOAD || !req->u.upload.effect) {
+			if (!req || req->code != UI_FF_UPLOAD ||
+			    !req->u.upload.effect) {
 				retval = -EINVAL;
 				break;
 			}
@@ -798,7 +807,8 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
-static long uinput_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long uinput_compat_ioctl(struct file *file,
+				unsigned int cmd, unsigned long arg)
 {
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }
@@ -843,4 +853,3 @@ MODULE_VERSION("0.3");
 
 module_init(uinput_init);
 module_exit(uinput_exit);
-
-- 
1.7.7.6

