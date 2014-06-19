From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Thu, 19 Jun 2014 15:11:55 +0200
Message-ID: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32902 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbaFSNML (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 09:12:11 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so10076297wib.4
        for <linux-input@vger.kernel.org>; Thu, 19 Jun 2014 06:12:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

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

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi

I replaced my old approach with a new ioctl(). In my opinion the write() method
for setup is error-prone and hard to replace correctly with a dynamic structure
like I did for this ioctl. The ioctl-way is also much more flexible and allows
read _and_ write in the same call.

This is untested so far, just wanted to get it out as Peter asked for it.

Btw., this should even perform better than the old method as it avoids copying
the whole object from the user into a temporary buffer.

Comments?
Thanks
David

 drivers/input/misc/uinput.c | 83 +++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/uinput.h | 79 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 156 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 615324c..e3952f4 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -371,8 +371,81 @@ static int uinput_allocate_device(struct uinput_device *udev)
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
+	u16 ver;
+
+	/*
+	 * Currently, we require:
+	 *   setup.size >= sizeof(struct uinput_setup)
+	 *   setup.absinfo_size >= sizeof(struct input_absinfo)
+	 * because we only support the initial version of uinput_setup. In case
+	 * we extend this type, we need to adjust those checks and fall-back to
+	 * older types if we run old user-space.
+	 */
+
+	if (get_user(setup.size, (__u64 __user*)arg))
+		return -EFAULT;
+	if (setup.size < sizeof(struct uinput_setup))
+		return -EINVAL;
+	if (copy_from_user(&setup, arg, sizeof(setup)))
+		return -EFAULT;
+
+	ver = setup.version;
+	if (put_user((__u16)UINPUT_VERSION, &arg->version))
+		return -EFAULT;
+	if (ver > UINPUT_VERSION)
+		return -EOPNOTSUPP;
+
+	if (!setup.name[0])
+		return -EINVAL;
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
+		input_alloc_absinfo(dev);
+		if (!dev->absinfo)
+			return -ENOMEM;
+
+		for (i = 0; i < setup.abs_cnt; ++i) {
+			struct input_absinfo absinfo;
+			u8 __user *p = (u8 __user*)arg->abs;
+
+			if (copy_from_user(&absinfo, p, sizeof(absinfo)))
+				return -EFAULT;
+
+			dev->absinfo[i] = absinfo;
+			p += setup.absinfo_size;
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
+static int __uinput_setup_device(struct uinput_device *udev,
+				 const char __user *buffer, size_t count)
 {
 	struct uinput_user_dev	*user_dev;
 	struct input_dev	*dev;
@@ -475,7 +548,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
 
 	retval = udev->state == UIST_CREATED ?
 			uinput_inject_events(udev, buffer, count) :
-			uinput_setup_device(udev, buffer, count);
+			__uinput_setup_device(udev, buffer, count);
 
 	mutex_unlock(&udev->mutex);
 
@@ -730,6 +803,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
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
index 0389b48..bafc0dd 100644
--- a/include/uapi/linux/uinput.h
+++ b/include/uapi/linux/uinput.h
@@ -20,6 +20,8 @@
  * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
  *
  * Changes/Revisions:
+ *	0.5	06/19/2014 (David Herrmann <dh.herrmann@gmail.com>
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
@@ -84,6 +86,78 @@ struct uinput_ff_erase {
  */
 #define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 300, len)
 
+struct uinput_setup {
+	__u32 size;
+	__u32 absinfo_size;
+	struct input_id id;
+	char name[UINPUT_MAX_NAME_SIZE];
+	__u32 ff_effects_max;
+	__u16 version;
+	__u16 abs_cnt;
+	struct input_absinfo abs[];
+};
+
+/**
+ * UI_DEV_SETUP - Set device parameters for setup
+ *
+ * This ioctl sets parameters for the input-device to be created. It must be
+ * issued _before_ calling UI_DEV_CREATE or it will fail. This ioctl supersedes
+ * the old "struct uinput_user_dev" method, which wrote this data via write().
+ *
+ * This ioctl takes a "struct uinput_setup" object as argument. The fields of
+ * this object are as follows:
+ *            size: This field _must_ be initialized to
+ *                  "sizeof(struct uinput_setup)". It *may not* include the
+ *                  size of the "abs" array at its end. The kernel uses this
+ *                  field to detect the revision of this ioctl. "uinput_setup"
+ *                  might be increased in the future, but will always be
+ *                  backwards compatible. If you pass a new object to an old
+ *                  kernel, the kernel will ignore unknown new fields.
+ *    absinfo_size: This field _must_ be initialized to
+ *                  "sizeof(struct input_absinfo)". It allows to extend the API
+ *                  to support more absinfo fields. Older kernels ignore unknown
+ *                  extensions to "struct input_absinfo".
+ *              id: See the description of "struct input_id". This field is
+ *                  copied unchanged into the new device.
+ *            name: This is used unchanged as name for the new device.
+ *  ff_effects_max: This limits the maximum numbers of force-feedback effects.
+ *                  See below for a description of FF with uinput.
+ *         version: This field must be set to the least required UINPUT version.
+ *                  If you do not require a specific version, set this to 0.
+ *                  Note that this ioctl was introduced with UINPUT_VERSION==5,
+ *                  so any version below will be treated as 0.
+ *                  Upon ioctl return, the kernel will overwrite this field
+ *                  with the actual UINPUT version of the kernel. You can
+ *                  obviously only rely on this, if the ioctl was successful.
+ *                  Otherwise, writing "version" might have caused the failure.
+ *                  However, the kernel tries to write this field as early as
+ *                  possible. So if it changed, you know that it was written
+ *                  properly.
+ *                  The kernel always writes a version greater than, or equal
+ *                  to, UINPUT_VERSION==5.
+ *         abs_cnt: This field defines the amount of elements in the following
+ *                  "abs" array. If this field is bigger than the kernel's view
+ *                  of ABS_CNT, the kernel will ignore any values beyond
+ *                  ABS_CNT.
+ *             abs: This is an appended array that contains parameters for ABS
+ *                  axes. See "struct input_absinfo" for a description of these
+ *                  fields. This array is copied unchanged into the kernel for
+ *                  all specified axes. However, to have effect, you must also
+ *                  enable the wanted axes via UI_SET_ABSBIT.
+ *
+ * This ioctl can be called multiple times and will overwrite previous values.
+ * If this ioctl fails, you're recommended to use the old "uinput_user_dev"
+ * method via write() as fallback, in case you run on an old kernel that does
+ * not support this ioctl.
+ *
+ * This ioctl may fail with -EINVAL if it is not supported or if you passed
+ * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
+ * passed uinput_setup object cannot be read/written.
+ * If this call fails, partial data may have already been applied to the
+ * internal device.
+ */
+#define UI_DEV_SETUP _IOWR(UINPUT_IOCTL_BASE, 301, struct uinput_setup)
+
 /*
  * To write a force-feedback-capable driver, the upload_effect
  * and erase_effect callbacks in input_dev must be implemented.
@@ -135,7 +209,6 @@ struct uinput_ff_erase {
 #define UI_FF_UPLOAD		1
 #define UI_FF_ERASE		2
 
-#define UINPUT_MAX_NAME_SIZE	80
 struct uinput_user_dev {
 	char name[UINPUT_MAX_NAME_SIZE];
 	struct input_id id;
-- 
2.0.0

