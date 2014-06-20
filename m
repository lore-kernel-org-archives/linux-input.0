From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 1/2] Input: uinput - add UI_GET_VERSION ioctl
Date: Fri, 20 Jun 2014 13:26:39 +0200
Message-ID: <1403263600-24736-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33878 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966744AbaFTL07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jun 2014 07:26:59 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so3642387wgh.16
        for <linux-input@vger.kernel.org>; Fri, 20 Jun 2014 04:26:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

This ioctl is the counterpart to EVIOCGVERSION and returns the
uinput-version the kernel was compiled with.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/misc/uinput.c | 6 ++++++
 include/uapi/linux/uinput.h | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 615324c..a2a3895 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -722,6 +722,12 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 	}
 
 	switch (cmd) {
+		case UI_GET_VERSION:
+			if (put_user(UINPUT_VERSION,
+				     (unsigned int __user*)p))
+				retval = -EFAULT;
+			goto out;
+
 		case UI_DEV_CREATE:
 			retval = uinput_create_device(udev);
 			goto out;
diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
index 0389b48..19339cf 100644
--- a/include/uapi/linux/uinput.h
+++ b/include/uapi/linux/uinput.h
@@ -84,6 +84,15 @@ struct uinput_ff_erase {
  */
 #define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 300, len)
 
+/**
+ * UI_GET_VERSION - Return uinput version of the kernel
+ *
+ * This writes the kernel's uinput version into the integer pointed to by the
+ * ioctl argument. The uinput-version is hard-coded in the kernel and
+ * independent of the uinput device.
+ */
+#define UI_GET_VERSION _IOR(UINPUT_IOCTL_BASE, 301, unsigned int)
+
 /*
  * To write a force-feedback-capable driver, the upload_effect
  * and erase_effect callbacks in input_dev must be implemented.
-- 
2.0.0

