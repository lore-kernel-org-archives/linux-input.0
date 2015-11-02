From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 2/3] evdev: add new ioctl EVIOCSEVENT / EVIOCGEVENT
Date: Mon,  2 Nov 2015 21:35:38 +0800
Message-ID: <1446471339-25464-3-git-send-email-pingbo.wen@linaro.org>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34690 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbKBNgm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 08:36:42 -0500
Received: by padec8 with SMTP id ec8so40337902pad.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 05:36:42 -0800 (PST)
In-Reply-To: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: y2038@lists.linaro.org, arnd@arndb.de, dmitry.torokhov@gmail.com, WEN Pingbo <pingbo.wen@linaro.org>

The two ioctl command is used to set is_input_event64 flag.

All userspace programs must set this flag to true, before using the
new input_event64 structure.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/evdev.c      | 9 +++++++++
 include/uapi/linux/input.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 815487f..990a083 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -863,6 +863,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	int __user *ip = (int __user *)p;
 	unsigned int i, t, u, v;
 	unsigned int size;
+	int event_flag;
 	int error;
 
 	/* First we check for fixed-length commands */
@@ -937,6 +938,14 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 	case EVIOCSKEYCODE_V2:
 		return evdev_handle_set_keycode_v2(dev, p);
+	case EVIOCSEVENT:
+		if (get_user(event_flag, ip))
+			return -EFAULT;
+		client->is_input_event64 = !!event_flag;
+
+		return 0;
+	case EVIOCGEVENT:
+		return put_user(client->is_input_event64, ip);
 	}
 
 	size = _IOC_SIZE(cmd);
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 1e252ff..966ce8f 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -171,6 +171,9 @@ struct input_keymap_entry {
 
 #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
 
+#define EVIOCSEVENT		_IOW('E', 0xa1, int)			/* Set input_event64 flag*/
+#define EVIOCGEVENT		_IOR('E', 0xa2, int)			/* Get input_event64 flag*/
+
 /*
  * Device properties and quirks
  */
-- 
1.9.1

