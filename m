From: drAke <drake@oomkill.net>
Subject: [PATCH] Fix force feedback uploading for 32-bit apps on 64-bit kernel
Date: Thu, 27 Mar 2008 22:20:18 +0100
Message-ID: <47EC0F92.7070106@oomkill.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090907090800060003060204"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host-217-172-231-67.gdynia.mm.pl ([217.172.231.67]:42113 "EHLO
	traktor.homelinux.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbYC0V32 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2008 17:29:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Adam Dawidowski <drake@oomkill.net>

This is a multi-part message in MIME format.
--------------090907090800060003060204
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Hello,

Force feedback upload of effects through the event device (ioctl
EVIOCSFF) is not working in 32 bit apps like wine on a 64-bit kernel. 64
bit apps like fftest work.

This is due to the fact that struct ff_effect contains a pointer,
resulting in the structure having different sizes in 64 and 32 bit
programs. This means that the ioctl issued from 32 bit code isn't
handled, because it has a different number.

Attached patch (against 2.6.24.3) fixes this. Tested on x86_64.

Is this ok or are there some alignment issues, which forbid this simple
zero-copy solution?

PS. Please keep me in the CC list, as I'm not subscribing this list.


--------------090907090800060003060204
Content-Type: text/plain;
 name="ioctl_EVIOCSFF_32bit_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioctl_EVIOCSFF_32bit_fix.patch"

diff -ruNp 2.6.24.3/drivers/input/evdev.c 2.6.24.3-ioctl-fix/drivers/input/evdev.c
--- 2.6.24.3/drivers/input/evdev.c	2008-01-24 23:58:37.000000000 +0100
+++ 2.6.24.3-ioctl-fix/drivers/input/evdev.c	2008-03-26 22:12:02.000000000 +0100
@@ -577,6 +577,9 @@ static long evdev_do_ioctl(struct file *
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
 	struct ff_effect effect;
+#ifdef CONFIG_COMPAT
+	struct ff_effect32 *effect32;
+#endif
 	int __user *ip = (int __user *)p;
 	int i, t, u, v;
 	int error;
@@ -632,10 +635,28 @@ static long evdev_do_ioctl(struct file *
 
 		return dev->setkeycode(dev, t, v);
 
+#ifdef CONFIG_COMPAT
+	case EVIOCSFF32:
+#endif
 	case EVIOCSFF:
-		if (copy_from_user(&effect, p, sizeof(effect)))
+		if (copy_from_user(&effect, p, _IOC_SIZE(cmd)))
 			return -EFAULT;
 
+#ifdef CONFIG_COMPAT
+		/*
+		 * It so happens that the pointer which needs to be changed
+		 * is the last field in the structure, so we can copy the
+		 * whole thing and replace just the pointer.
+		 */
+		if (cmd == EVIOCSFF32) {
+			effect32 = (struct ff_effect32 *)&effect;
+			if (effect32->type == FF_PERIODIC &&
+			    effect32->u.periodic.waveform == FF_CUSTOM)
+				effect.u.periodic.custom_data = compat_ptr(
+					effect32->u.periodic.custom_data);
+		}
+#endif
+
 		error = input_ff_upload(dev, &effect, file);
 
 		if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
diff -ruNp 2.6.24.3/include/linux/input.h 2.6.24.3-ioctl-fix/include/linux/input.h
--- 2.6.24.3/include/linux/input.h	2008-01-24 23:58:37.000000000 +0100
+++ 2.6.24.3-ioctl-fix/include/linux/input.h	2008-03-25 22:17:59.000000000 +0100
@@ -12,6 +12,7 @@
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/compat.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
@@ -75,7 +76,10 @@ struct input_absinfo {
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get abs value/limits */
 #define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, struct input_absinfo)		/* set abs value/limits */
 
-#define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))	/* send a force effect to a force feedback device */
+#define EVIOCSFF		_IOW('E', 0x80, struct ff_effect)	/* send a force effect to a force feedback device */
+#ifdef CONFIG_COMPAT
+#define EVIOCSFF32		_IOW('E', 0x80, struct ff_effect32)
+#endif
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */
 #define EVIOCGEFFECTS		_IOR('E', 0x84, int)			/* Report number of effects playable at the same time */
 
@@ -846,6 +850,21 @@ struct ff_periodic_effect {
 	__s16 *custom_data;
 };
 
+#ifdef CONFIG_COMPAT
+struct ff_periodic_effect32 {
+	__u16 waveform;
+	__u16 period;
+	__s16 magnitude;
+	__s16 offset;
+	__u16 phase;
+
+	struct ff_envelope envelope;
+
+	__u32 custom_len;
+	compat_uptr_t custom_data;
+};
+#endif
+
 /**
  * struct ff_rumble_effect - defines parameters of a periodic force-feedback effect
  * @strong_magnitude: magnitude of the heavy motor
@@ -898,6 +917,24 @@ struct ff_effect {
 	} u;
 };
 
+#ifdef CONFIG_COMPAT
+struct ff_effect32 {
+	__u16 type;
+	__s16 id;
+	__u16 direction;
+	struct ff_trigger trigger;
+	struct ff_replay replay;
+
+	union {
+		struct ff_constant_effect constant;
+		struct ff_ramp_effect ramp;
+		struct ff_periodic_effect32 periodic;
+		struct ff_condition_effect condition[2]; /* One for each axis */
+		struct ff_rumble_effect rumble;
+	} u;
+};
+#endif
+
 /*
  * Force feedback effect types
  */

--------------090907090800060003060204--
