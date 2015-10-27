From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 1/3] input: keychord: Add keychord driver
Date: Tue, 27 Oct 2015 09:47:26 +0100
Message-ID: <1445935647-5799-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38512 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbbJ0Irl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 04:47:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Mike Lockwood <lockwood@android.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Mike Lockwood <lockwood@android.com>

This driver allows userspace to receive notification when client
specified key combinations are pressed.
The client opens /dev/keychord and writes a list of keychords
for the driver to monitor.
The client then reads or polls /dev/keychord for notifications.
A client specified ID for the keychord is returned from read()
when a keychord press is detected.

Signed-off-by: Mike Lockwood <lockwood@android.com>

keychord: fix to build without CONFIG_PREEMPT

Change-Id: I911f13aeda4224b6fa57863bc7e8972fec8837fb
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/input/misc/Kconfig    |   11 ++
 drivers/input/misc/Makefile   |    1 +
 drivers/input/misc/keychord.c |  387 +++++++++++++++++++++++++++++++++=
++++++++
 include/linux/keychord.h      |   52 ++++++
 4 files changed, 451 insertions(+)
 create mode 100644 drivers/input/misc/keychord.c
 create mode 100644 include/linux/keychord.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 906dd1b..caf4b04 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -341,6 +341,17 @@ config INPUT_ATI_REMOTE2
 	  To compile this driver as a module, choose M here: the module will =
be
 	  called ati_remote2.
=20
+config INPUT_KEYCHORD
+	tristate "Key chord input driver support"
+	help
+	  Say Y here if you want to enable the key chord driver
+	  accessible at /dev/keychord.  This driver can be used
+	  for receiving notifications when client specified key
+	  combinations are pressed.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called keychord.
+
 config INPUT_KEYSPAN_REMOTE
 	tristate "Keyspan DMR USB remote control"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 0357a08..c521e82 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+=3D gpio_tilt_p=
olled.o
 obj-$(CONFIG_HP_SDC_RTC)		+=3D hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+=3D ims-pcu.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+=3D ixp4xx-beeper.o
+obj-$(CONFIG_INPUT_KEYCHORD)		+=3D keychord.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+=3D kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
diff --git a/drivers/input/misc/keychord.c b/drivers/input/misc/keychor=
d.c
new file mode 100644
index 0000000..3ffab6d
--- /dev/null
+++ b/drivers/input/misc/keychord.c
@@ -0,0 +1,387 @@
+/*
+ *  drivers/input/misc/keychord.c
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Author: Mike Lockwood <lockwood@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+*/
+
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/keychord.h>
+#include <linux/sched.h>
+
+#define KEYCHORD_NAME		"keychord"
+#define BUFFER_SIZE			16
+
+MODULE_AUTHOR("Mike Lockwood <lockwood@android.com>");
+MODULE_DESCRIPTION("Key chord input driver");
+MODULE_SUPPORTED_DEVICE("keychord");
+MODULE_LICENSE("GPL");
+
+#define NEXT_KEYCHORD(kc) ((struct input_keychord *) \
+		((char *)kc + sizeof(struct input_keychord) + \
+		kc->count * sizeof(kc->keycodes[0])))
+
+struct keychord_device {
+	struct input_handler	input_handler;
+	int			registered;
+
+	/* list of keychords to monitor */
+	struct input_keychord	*keychords;
+	int			keychord_count;
+
+	/* bitmask of keys contained in our keychords */
+	unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
+	/* current state of the keys */
+	unsigned long keystate[BITS_TO_LONGS(KEY_CNT)];
+	/* number of keys that are currently pressed */
+	int key_down;
+
+	/* second input_device_id is needed for null termination */
+	struct input_device_id  device_ids[2];
+
+	spinlock_t		lock;
+	wait_queue_head_t	waitq;
+	unsigned char		head;
+	unsigned char		tail;
+	__u16			buff[BUFFER_SIZE];
+};
+
+static int check_keychord(struct keychord_device *kdev,
+		struct input_keychord *keychord)
+{
+	int i;
+
+	if (keychord->count !=3D kdev->key_down)
+		return 0;
+
+	for (i =3D 0; i < keychord->count; i++) {
+		if (!test_bit(keychord->keycodes[i], kdev->keystate))
+			return 0;
+	}
+
+	/* we have a match */
+	return 1;
+}
+
+static void keychord_event(struct input_handle *handle, unsigned int t=
ype,
+			   unsigned int code, int value)
+{
+	struct keychord_device *kdev =3D handle->private;
+	struct input_keychord *keychord;
+	unsigned long flags;
+	int i, got_chord =3D 0;
+
+	if (type !=3D EV_KEY || code >=3D KEY_MAX)
+		return;
+
+	spin_lock_irqsave(&kdev->lock, flags);
+	/* do nothing if key state did not change */
+	if (!test_bit(code, kdev->keystate) =3D=3D !value)
+		goto done;
+	__change_bit(code, kdev->keystate);
+	if (value)
+		kdev->key_down++;
+	else
+		kdev->key_down--;
+
+	/* don't notify on key up */
+	if (!value)
+		goto done;
+	/* ignore this event if it is not one of the keys we are monitoring *=
/
+	if (!test_bit(code, kdev->keybit))
+		goto done;
+
+	keychord =3D kdev->keychords;
+	if (!keychord)
+		goto done;
+
+	/* check to see if the keyboard state matches any keychords */
+	for (i =3D 0; i < kdev->keychord_count; i++) {
+		if (check_keychord(kdev, keychord)) {
+			kdev->buff[kdev->head] =3D keychord->id;
+			kdev->head =3D (kdev->head + 1) % BUFFER_SIZE;
+			got_chord =3D 1;
+			break;
+		}
+		/* skip to next keychord */
+		keychord =3D NEXT_KEYCHORD(keychord);
+	}
+
+done:
+	spin_unlock_irqrestore(&kdev->lock, flags);
+
+	if (got_chord)
+		wake_up_interruptible(&kdev->waitq);
+}
+
+static int keychord_connect(struct input_handler *handler,
+					  struct input_dev *dev,
+					  const struct input_device_id *id)
+{
+	int i, ret;
+	struct input_handle *handle;
+	struct keychord_device *kdev =3D
+		container_of(handler, struct keychord_device, input_handler);
+
+	/*
+	 * ignore this input device if it does not contain any keycodes
+	 * that we are monitoring
+	 */
+	for (i =3D 0; i < KEY_MAX; i++) {
+		if (test_bit(i, kdev->keybit) && test_bit(i, dev->keybit))
+			break;
+	}
+	if (i =3D=3D KEY_MAX)
+		return -ENODEV;
+
+	handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev =3D dev;
+	handle->handler =3D handler;
+	handle->name =3D KEYCHORD_NAME;
+	handle->private =3D kdev;
+
+	ret =3D input_register_handle(handle);
+	if (ret)
+		goto err_input_register_handle;
+
+	ret =3D input_open_device(handle);
+	if (ret)
+		goto err_input_open_device;
+
+	pr_info("keychord: using input dev %s for fevent\n", dev->name);
+
+	return 0;
+
+err_input_open_device:
+	input_unregister_handle(handle);
+err_input_register_handle:
+	kfree(handle);
+	return ret;
+}
+
+static void keychord_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+/*
+ * keychord_read is used to read keychord events from the driver
+ */
+static ssize_t keychord_read(struct file *file, char __user *buffer,
+		size_t count, loff_t *ppos)
+{
+	struct keychord_device *kdev =3D file->private_data;
+	__u16   id;
+	int retval;
+	unsigned long flags;
+
+	if (count < sizeof(id))
+		return -EINVAL;
+	count =3D sizeof(id);
+
+	if (kdev->head =3D=3D kdev->tail && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval =3D wait_event_interruptible(kdev->waitq,
+			kdev->head !=3D kdev->tail);
+	if (retval)
+		return retval;
+
+	spin_lock_irqsave(&kdev->lock, flags);
+	/* pop a keychord ID off the queue */
+	id =3D kdev->buff[kdev->tail];
+	kdev->tail =3D (kdev->tail + 1) % BUFFER_SIZE;
+	spin_unlock_irqrestore(&kdev->lock, flags);
+
+	if (copy_to_user(buffer, &id, count))
+		return -EFAULT;
+
+	return count;
+}
+
+/*
+ * keychord_write is used to configure the driver
+ */
+static ssize_t keychord_write(struct file *file, const char __user *bu=
ffer,
+		size_t count, loff_t *ppos)
+{
+	struct keychord_device *kdev =3D file->private_data;
+	struct input_keychord *keychords =3D 0;
+	struct input_keychord *keychord, *next, *end;
+	int ret, i, key;
+	unsigned long flags;
+
+	if (count < sizeof(struct input_keychord))
+		return -EINVAL;
+	keychords =3D kzalloc(count, GFP_KERNEL);
+	if (!keychords)
+		return -ENOMEM;
+
+	/* read list of keychords from userspace */
+	if (copy_from_user(keychords, buffer, count)) {
+		kfree(keychords);
+		return -EFAULT;
+	}
+
+	/* unregister handler before changing configuration */
+	if (kdev->registered) {
+		input_unregister_handler(&kdev->input_handler);
+		kdev->registered =3D 0;
+	}
+
+	spin_lock_irqsave(&kdev->lock, flags);
+	/* clear any existing configuration */
+	kfree(kdev->keychords);
+	kdev->keychords =3D 0;
+	kdev->keychord_count =3D 0;
+	kdev->key_down =3D 0;
+	memset(kdev->keybit, 0, sizeof(kdev->keybit));
+	memset(kdev->keystate, 0, sizeof(kdev->keystate));
+	kdev->head =3D kdev->tail =3D 0;
+
+	keychord =3D keychords;
+	end =3D (struct input_keychord *)((char *)keychord + count);
+
+	while (keychord < end) {
+		next =3D NEXT_KEYCHORD(keychord);
+		if (keychord->count <=3D 0 || next > end) {
+			pr_err("keychord: invalid keycode count %d\n",
+				keychord->count);
+			goto err_unlock_return;
+		}
+		if (keychord->version !=3D KEYCHORD_VERSION) {
+			pr_err("keychord: unsupported version %d\n",
+				keychord->version);
+			goto err_unlock_return;
+		}
+
+		/* keep track of the keys we are monitoring in keybit */
+		for (i =3D 0; i < keychord->count; i++) {
+			key =3D keychord->keycodes[i];
+			if (key < 0 || key >=3D KEY_CNT) {
+				pr_err("keychord: keycode %d out of range\n",
+					key);
+				goto err_unlock_return;
+			}
+			__set_bit(key, kdev->keybit);
+		}
+
+		kdev->keychord_count++;
+		keychord =3D next;
+	}
+
+	kdev->keychords =3D keychords;
+	spin_unlock_irqrestore(&kdev->lock, flags);
+
+	ret =3D input_register_handler(&kdev->input_handler);
+	if (ret) {
+		kfree(keychords);
+		kdev->keychords =3D 0;
+		return ret;
+	}
+	kdev->registered =3D 1;
+
+	return count;
+
+err_unlock_return:
+	spin_unlock_irqrestore(&kdev->lock, flags);
+	kfree(keychords);
+	return -EINVAL;
+}
+
+static unsigned int keychord_poll(struct file *file, poll_table *wait)
+{
+	struct keychord_device *kdev =3D file->private_data;
+
+	poll_wait(file, &kdev->waitq, wait);
+
+	if (kdev->head !=3D kdev->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static int keychord_open(struct inode *inode, struct file *file)
+{
+	struct keychord_device *kdev;
+
+	kdev =3D kzalloc(sizeof(struct keychord_device), GFP_KERNEL);
+	if (!kdev)
+		return -ENOMEM;
+
+	spin_lock_init(&kdev->lock);
+	init_waitqueue_head(&kdev->waitq);
+
+	kdev->input_handler.event =3D keychord_event;
+	kdev->input_handler.connect =3D keychord_connect;
+	kdev->input_handler.disconnect =3D keychord_disconnect;
+	kdev->input_handler.name =3D KEYCHORD_NAME;
+	kdev->input_handler.id_table =3D kdev->device_ids;
+
+	kdev->device_ids[0].flags =3D INPUT_DEVICE_ID_MATCH_EVBIT;
+	__set_bit(EV_KEY, kdev->device_ids[0].evbit);
+
+	file->private_data =3D kdev;
+
+	return 0;
+}
+
+static int keychord_release(struct inode *inode, struct file *file)
+{
+	struct keychord_device *kdev =3D file->private_data;
+
+	if (kdev->registered)
+		input_unregister_handler(&kdev->input_handler);
+	kfree(kdev);
+
+	return 0;
+}
+
+static const struct file_operations keychord_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D keychord_open,
+	.release	=3D keychord_release,
+	.read		=3D keychord_read,
+	.write		=3D keychord_write,
+	.poll		=3D keychord_poll,
+};
+
+static struct miscdevice keychord_misc =3D {
+	.fops		=3D &keychord_fops,
+	.name		=3D KEYCHORD_NAME,
+	.minor		=3D MISC_DYNAMIC_MINOR,
+};
+
+static int __init keychord_init(void)
+{
+	return misc_register(&keychord_misc);
+}
+
+static void __exit keychord_exit(void)
+{
+	misc_deregister(&keychord_misc);
+}
+
+module_init(keychord_init);
+module_exit(keychord_exit);
diff --git a/include/linux/keychord.h b/include/linux/keychord.h
new file mode 100644
index 0000000..856a585
--- /dev/null
+++ b/include/linux/keychord.h
@@ -0,0 +1,52 @@
+/*
+ *  Key chord input driver
+ *
+ * Copyright (C) 2008 Google, Inc.
+ * Author: Mike Lockwood <lockwood@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+*/
+
+#ifndef __LINUX_KEYCHORD_H_
+#define __LINUX_KEYCHORD_H_
+
+#include <linux/input.h>
+
+#define KEYCHORD_VERSION		1
+
+/*
+ * One or more input_keychord structs are written to /dev/keychord
+ * at once to specify the list of keychords to monitor.
+ * Reading /dev/keychord returns the id of a keychord when the
+ * keychord combination is pressed.  A keychord is signalled when
+ * all of the keys in the keycode list are in the pressed state.
+ * The order in which the keys are pressed does not matter.
+ * The keychord will not be signalled if keys not in the keycode
+ * list are pressed.
+ * Keychords will not be signalled on key release events.
+ */
+struct input_keychord {
+	/* should be KEYCHORD_VERSION */
+	__u16 version;
+	/*
+	 * client specified ID, returned from read()
+	 * when this keychord is pressed.
+	 */
+	__u16 id;
+
+	/* number of keycodes in this keychord */
+	__u16 count;
+
+	/* variable length array of keycodes */
+	__u16 keycodes[];
+};
+
+#endif	/* __LINUX_KEYCHORD_H_ */
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
