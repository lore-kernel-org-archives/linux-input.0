From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH RESEND 4/5] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Sat, 19 Jul 2014 15:10:44 +0200
Message-ID: <1405775445-4454-5-git-send-email-dh.herrmann@gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:52339 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbaGSNLF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 09:11:05 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so5785760wes.32
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2014 06:11:04 -0700 (PDT)
In-Reply-To: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@google.com>, David Herrmann <dh.herrmann@gmail.com>

This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
method (by write()'ing "struct uinput_user_dev" to the node). The old
method is not easily extendable and requires huge payloads. Furthermore,
overloading write() without properly versioned objects is error-prone.

Therefore, we introduce a new ioctl to replace the old method. The ioctl
supports all features of the old method, plus a "resolution" field for
absinfo. Furthermore, it's properly forward-compatible to new ABS codes
and a growing "struct input_absinfo" structure.

The ioctl also allows user-space to skip unknown axes if not set. The
payload-size can now be specified by the caller. There is no need to copy
the whole array temporarily into the kernel, but instead we can iterate
over it and copy each value manually.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/misc/uinput.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/uinput.h | 55 ++++++++++++++++++++++++++++++++++--
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index a2a3895..0f45595 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -371,8 +371,67 @@ static int uinput_allocate_device(struct uinput_device *udev)
 	return 0;
 }
 
-static int uinput_setup_device(struct uinput_device *udev,
-			       const char __user *buffer, size_t count)
+static int uinput_dev_setup(struct uinput_device *udev,
+			    struct uinput_setup __user *arg)
+{
+	struct uinput_setup setup;
+	struct input_dev *dev;
+	int i, retval;
+
+	if (udev->state == UIST_CREATED)
+		return -EINVAL;
+	if (copy_from_user(&setup, arg, sizeof(setup)))
+		return -EFAULT;
+	if (!setup.name[0])
+		return -EINVAL;
+	/* So far we only support the original "struct input_absinfo", but be
+	 * forward compatible and allow larger payloads. */
+	if (setup.absinfo_size < sizeof(struct input_absinfo))
+		return -EINVAL;
+
+	dev = udev->dev;
+	dev->id = setup.id;
+	udev->ff_effects_max = setup.ff_effects_max;
+
+	kfree(dev->name);
+	dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
+	if (!dev->name)
+		return -ENOMEM;
+
+	if (setup.abs_cnt > ABS_CNT)
+		setup.abs_cnt = ABS_CNT;
+
+	if (setup.abs_cnt > 0) {
+		u8 __user *p = (u8 __user*)arg->abs;
+
+		input_alloc_absinfo(dev);
+		if (!dev->absinfo)
+			return -ENOMEM;
+
+		for (i = 0; i < setup.abs_cnt; ++i, p += setup.absinfo_size) {
+			struct input_absinfo absinfo;
+
+			if (!test_bit(i, dev->absbit))
+				continue;
+
+			if (copy_from_user(&absinfo, p, sizeof(absinfo)))
+				return -EFAULT;
+
+			dev->absinfo[i] = absinfo;
+		}
+	}
+
+	retval = uinput_validate_absbits(dev);
+	if (retval < 0)
+		return retval;
+
+	udev->state = UIST_SETUP_COMPLETE;
+	return 0;
+}
+
+/* legacy setup via write() */
+static int uinput_setup_device_legacy(struct uinput_device *udev,
+				      const char __user *buffer, size_t count)
 {
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
@@ -475,7 +534,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
 
 	retval = udev->state == UIST_CREATED ?
 			uinput_inject_events(udev, buffer, count) :
-			uinput_setup_device(udev, buffer, count);
+			uinput_setup_device_legacy(udev, buffer, count);
 
 	mutex_unlock(&udev->mutex);
 
@@ -736,6 +795,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			uinput_destroy_device(udev);
 			goto out;
 
+		case UI_DEV_SETUP:
+			retval = uinput_dev_setup(udev, p);
+			goto out;
+
 		case UI_SET_EVBIT:
 			retval = uinput_set_bit(arg, evbit, EV_MAX);
 			goto out;
diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
index 19339cf..04a3876 100644
--- a/include/uapi/linux/uinput.h
+++ b/include/uapi/linux/uinput.h
@@ -20,6 +20,8 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  *
  * Changes/Revisions:
+ *	0.5	06/20/2014 (David Herrmann <dh.herrmann@gmail.com>
+ *		- add UI_DEV_SETUP ioctl
  *	0.4	01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
  *		- add UI_GET_SYSNAME ioctl
  *	0.3	24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
@@ -37,8 +39,8 @@
 #include <linux/types.h>
 #include <linux/input.h>
 
-#define UINPUT_VERSION		4
-
+#define UINPUT_VERSION		5
+#define UINPUT_MAX_NAME_SIZE	80
 
 struct uinput_ff_upload {
 	__u32			request_id;
@@ -93,6 +95,54 @@ struct uinput_ff_erase {
  */
 #define UI_GET_VERSION _IOR(UINPUT_IOCTL_BASE, 301, unsigned int)
 
+struct uinput_setup {
+	__u64 absinfo_size;
+	struct input_id id;
+	char name[UINPUT_MAX_NAME_SIZE];
+	__u32 ff_effects_max;
+	__u32 abs_cnt;
+	struct input_absinfo abs[];
+};
+
+/**
+ * UI_DEV_SETUP - Set device parameters for setup
+ *
+ * This ioctl sets parameters for the input-device to be created. It must be
+ * issued *before* calling UI_DEV_CREATE or it will fail. This ioctl supersedes
+ * the old "struct uinput_user_dev" method, which wrote this data via write().
+ *
+ * This ioctl takes a "struct uinput_setup" object as argument. The fields of
+ * this object are as follows:
+ *    absinfo_size: This field *must* be initialized to
+ *                  "sizeof(struct input_absinfo)". It allows to extend the API
+ *                  to support more absinfo fields. Older kernels ignore unknown
+ *                  extensions to "struct input_absinfo".
+ *              id: See the description of "struct input_id". This field is
+ *                  copied unchanged into the new device.
+ *            name: This is used unchanged as name for the new device.
+ *  ff_effects_max: This limits the maximum numbers of force-feedback effects.
+ *                  See below for a description of FF with uinput.
+ *         abs_cnt: This field defines the amount of elements in the following
+ *                  "abs" array. Axes beyond the kernel's ABS_CNT are ignored.
+ *             abs: This is an appended array that contains parameters for ABS
+ *                  axes. See "struct input_absinfo" for a description of these
+ *                  fields. This array is copied unchanged into the kernel for
+ *                  all specified axes. Axes not enabled via UI_SET_ABSBIT are
+ *                  ignored.
+ *
+ * This ioctl can be called multiple times and will overwrite previous values.
+ * If this ioctl fails with -EINVAL, you're recommended to use the old
+ * "uinput_user_dev" method via write() as fallback, in case you run on an old
+ * kernel that does not support this ioctl.
+ *
+ * This ioctl may fail with -EINVAL if it is not supported or if you passed
+ * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
+ * passed uinput_setup object cannot be read/written.
+ * If this call fails, partial data may have already been applied to the
+ * internal device.
+ */
+#define UI_DEV_SETUP _IOWR(UINPUT_IOCTL_BASE, 302, struct uinput_setup)
+
 /*
  * To write a force-feedback-capable driver, the upload_effect
  * and erase_effect callbacks in input_dev must be implemented.
@@ -144,7 +194,6 @@ struct uinput_ff_erase {
 #define UI_FF_UPLOAD		1
 #define UI_FF_ERASE		2
 
-#define UINPUT_MAX_NAME_SIZE	80
 struct uinput_user_dev {
 	char name[UINPUT_MAX_NAME_SIZE];
 	struct input_id id;
-- 
2.0.2

