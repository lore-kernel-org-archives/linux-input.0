From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH RESEND 3/5] Input: uinput - add UI_GET_VERSION ioctl
Date: Sat, 19 Jul 2014 15:10:43 +0200
Message-ID: <1405775445-4454-4-git-send-email-dh.herrmann@gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:56056 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbaGSNLD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 09:11:03 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so4530873wev.40
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2014 06:11:02 -0700 (PDT)
In-Reply-To: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@google.com>, David Herrmann <dh.herrmann@gmail.com>

This ioctl is the counterpart to EVIOCGVERSION and returns the
uinput-version the kernel was compiled with.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
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
2.0.2

