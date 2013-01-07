From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Input: new EVIOCGKEYF to get keystate and flush queues
Date: Mon,  7 Jan 2013 12:58:23 +0100
Message-ID: <1357559903-1881-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47005 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab3AGMDm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 07:03:42 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so8491263bkc.36
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 04:03:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ran Benita <ran234@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>

EVIOCGKEYF returns the current keystate similar to EVIOCGKEY but also
flushes the outgoing evdev event queue. This allows user-space devices to
reliably retrieve the current state without having old events still in the
read()-queue.

Userspace libraries like XKB/xkbcommon use stacking key trackers, so they
allow the kernel to map multiple keys to the same keycode. For instance if
left-shift and right-shift map to the same keycode, xkbcommon allows the
kernel to send key-down twice but also requires it to send key-up twice. A
single input device doesn't support that, but this is very useful if you want
multiple connected keyboards to have one shared modifier state: Pressing Shift
on the one keyboard affects keys on the other keyboard. This is not the usual
setup but it is supported and known to be used (for instance if you have
external num-pads etc.).

When a program opens input devices, it can read the keystate via EVIOCGKEY
to update its internal keyboard state. This allows to keep CTRL pressed
while switching VTs and having both applications remember that CTRL is
still pressed.
However, if there are still outgoing events in the evdev queue, the
application will update its internal keyboard state and then read the
event again, even though it already processed it via EVIOCGKEY.

EVIOCGKEYF solves this race condition by flushing the evdev queue while
returning the keystate. We cannot change EVIOCGKEY because we don't know
whether userspace depends on a clean read() history and flushing the queue
effectively drops events.

This race could be fixed in user-space by keeping an exact copy of the keystate
array for each input device that we opened and ignoring double-events for a
single keycode. However, if we, as mentioned, want a shared keyboard-state, it
seems to be a waste of computing power and memory to keep another copy for each
input device if we could just use something like EVIOCGKEYF.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
Hi

I am actually not sure whether I did the locking in the right order. However, I
need to take event_lock _and_ buffer_lock to be sure neither the kernel-internal
keystate nor the output queue is changed as this ioctl needs to be atomic.

Regards
David

 drivers/input/evdev.c      | 10 ++++++++++
 include/uapi/linux/input.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f0f8928..f178ae0 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -782,6 +782,16 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 	case EVIOCGSW(0):
 		return bits_to_user(dev->sw, SW_MAX, size, p, compat_mode);
 
+	case EVIOCGKEYF(0):
+		spin_lock_irq(&dev->event_lock);
+		spin_lock(&client->buffer_lock);
+		error = bits_to_user(dev->key, KEY_MAX, size, p, compat_mode);
+		if (error >= 0)
+			client->tail = client->packet_head = client->head;
+		spin_unlock(&client->buffer_lock);
+		spin_unlock_irq(&dev->event_lock);
+		return error;
+
 	case EVIOCGNAME(0):
 		return str_to_user(dev->name, size, p);
 
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 5588285..ade47d1 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -142,6 +142,7 @@ struct input_keymap_entry {
 #define EVIOCGLED(len)		_IOC(_IOC_READ, 'E', 0x19, len)		/* get all LEDs */
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
 #define EVIOCGSW(len)		_IOC(_IOC_READ, 'E', 0x1b, len)		/* get all switch states */
+#define EVIOCGKEYF(len)		_IOC(_IOC_READ, 'E', 0x1c, len)		/* get global key state and flush queue */
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + (ev), len)	/* get event bits */
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + (abs), struct input_absinfo)	/* get abs value/limits */
-- 
1.8.1

