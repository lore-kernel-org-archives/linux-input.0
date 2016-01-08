From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Fri, 08 Jan 2016 20:53:08 +0530
Message-ID: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54816 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbcAHPXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 10:23:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

Add ioctl cmd EVIOCGBUFSIZE to get kernel buffer size of device so that
clients can accordingly set the size of userspace buffer and can know
maximum number of events that they are required to read in worst case.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c      |    3 +++
 include/uapi/linux/input.h |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..8b16f08 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1103,6 +1103,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 		return 0;
 
+	case EVIOCGBUFSIZE:
+		return put_user(client->bufsize, (unsigned int __user *)p);
+
 	case EVIOCRMFF:
 		return input_ff_erase(dev, (int)(unsigned long) p, file);
 
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2758687..51d66aa 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -114,6 +114,8 @@ struct input_mask {
 #define EVIOCSKEYCODE		_IOW('E', 0x04, unsigned int[2])        /* set keycode */
 #define EVIOCSKEYCODE_V2	_IOW('E', 0x04, struct input_keymap_entry)
 
+#define EVIOCGBUFSIZE		_IOR('E', 0x05, unsigned int)		/* get device buffer size */
+
 #define EVIOCGNAME(len)		_IOC(_IOC_READ, 'E', 0x06, len)		/* get device name */
 #define EVIOCGPHYS(len)		_IOC(_IOC_READ, 'E', 0x07, len)		/* get physical location */
 #define EVIOCGUNIQ(len)		_IOC(_IOC_READ, 'E', 0x08, len)		/* get unique identifier */
-- 
1.7.9.5

