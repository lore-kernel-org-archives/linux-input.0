From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: uinput - avoid FF flush when destroying device
Date: Wed,  6 Sep 2017 17:21:07 -0700
Message-ID: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Normally, when input device supporting force feedback effects is being
destroyed, we try to "flush" currently playing effects, so that the
physical device does not continue vibrating (or executing other effects).
Unfortunately this does not work well for uinput as flushing of the effects
deadlocks with the destroy action:

- if device is being destroyed because the file descriptor is being closed,
  then there is noone to even service FF requests;

- if device is being destroyed because userspace sent UI_DEV_DESTROY,
  while theoretically it could be possible to service FF requests,
  userspace is unlikely to do so (they'd need to make sure FF handling
  happens on a separate thread) even if kernel solves the issue with FF
  ioctls deadlocking with UI_DEV_DESTROY ioctl on udev->mutex.

To avoid lockups like the one below, let's install a custom input device
flush handler, and avoid trying to flush force feedback effects when we
destroying the device, and instead rely on uinput to shut off the device
properly.

NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
...
 <<EOE>>  [<ffffffff817a0307>] _raw_spin_lock_irqsave+0x37/0x40
 [<ffffffff810e633d>] complete+0x1d/0x50
 [<ffffffffa00ba08c>] uinput_request_done+0x3c/0x40 [uinput]
 [<ffffffffa00ba587>] uinput_request_submit.part.7+0x47/0xb0 [uinput]
 [<ffffffffa00bb62b>] uinput_dev_erase_effect+0x5b/0x76 [uinput]
 [<ffffffff815d91ad>] erase_effect+0xad/0xf0
 [<ffffffff815d929d>] flush_effects+0x4d/0x90
 [<ffffffff815d4cc0>] input_flush_device+0x40/0x60
 [<ffffffff815daf1c>] evdev_cleanup+0xac/0xc0
 [<ffffffff815daf5b>] evdev_disconnect+0x2b/0x60
 [<ffffffff815d74ac>] __input_unregister_device+0xac/0x150
 [<ffffffff815d75f7>] input_unregister_device+0x47/0x70
 [<ffffffffa00bac45>] uinput_destroy_device+0xb5/0xc0 [uinput]
 [<ffffffffa00bb2de>] uinput_ioctl_handler.isra.9+0x65e/0x740 [uinput]
 [<ffffffff811231ab>] ? do_futex+0x12b/0xad0
 [<ffffffffa00bb3f8>] uinput_ioctl+0x18/0x20 [uinput]
 [<ffffffff81241248>] do_vfs_ioctl+0x298/0x480
 [<ffffffff81337553>] ? security_file_ioctl+0x43/0x60
 [<ffffffff812414a9>] SyS_ioctl+0x79/0x90
 [<ffffffff817a04ee>] entry_SYSCALL_64_fastpath+0x12/0x71

Reported-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Reported-by: Clément VUCHENER <clement.vuchener@gmail.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=193741
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/ff-core.c     | 13 ++++++++++---
 drivers/input/misc/uinput.c | 18 ++++++++++++++++++
 include/linux/input.h       |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 8f2042432c85..66a46c84e28f 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -237,9 +237,15 @@ int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file)
 EXPORT_SYMBOL_GPL(input_ff_erase);
 
 /*
- * flush_effects - erase all effects owned by a file handle
+ * input_ff_flush - erase all effects owned by a file handle
+ * @dev: input device to erase effect from
+ * @file: purported owner of the effects
+ *
+ * This function erases all force-feedback effects associated with
+ * the given owner from specified device. Note that @file may be %NULL,
+ * in which case all effects will be erased.
  */
-static int flush_effects(struct input_dev *dev, struct file *file)
+int input_ff_flush(struct input_dev *dev, struct file *file)
 {
 	struct ff_device *ff = dev->ff;
 	int i;
@@ -255,6 +261,7 @@ static int flush_effects(struct input_dev *dev, struct file *file)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(input_ff_flush);
 
 /**
  * input_ff_event() - generic handler for force-feedback events
@@ -343,7 +350,7 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 	mutex_init(&ff->mutex);
 
 	dev->ff = ff;
-	dev->flush = flush_effects;
+	dev->flush = input_ff_flush;
 	dev->event = input_ff_event;
 	__set_bit(EV_FF, dev->evbit);
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 022be0e22eba..2cff40be8860 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -230,6 +230,18 @@ static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
 	return uinput_request_submit(udev, &request);
 }
 
+static int uinput_dev_flush(struct input_dev *dev, struct file *file)
+{
+	/*
+	 * If we are called with file == NULL that means we are tearing
+	 * down the device, and therefore we can not handle FF erase
+	 * requests: either we are handling UI_DEV_DESTROY (and holding
+	 * the udev->mutex), or the file descriptor is closed and there is
+	 * nobody on the other side anymore.
+	 */
+	return file ? input_ff_flush(dev, file) : 0;
+}
+
 static void uinput_destroy_device(struct uinput_device *udev)
 {
 	const char *name, *phys;
@@ -297,6 +309,12 @@ static int uinput_create_device(struct uinput_device *udev)
 		dev->ff->playback = uinput_dev_playback;
 		dev->ff->set_gain = uinput_dev_set_gain;
 		dev->ff->set_autocenter = uinput_dev_set_autocenter;
+		/*
+		 * The standard input_ff_flush() implementation does
+		 * not quite work for uinput as we can't reasonably
+		 * handle FF requests during device teardown.
+		 */
+		dev->flush = uinput_dev_flush;
 	}
 
 	error = input_register_device(udev->dev);
diff --git a/include/linux/input.h b/include/linux/input.h
index 5645a0f39b9a..9b03f34807a7 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -537,6 +537,7 @@ int input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code,
 
 int input_ff_upload(struct input_dev *dev, struct ff_effect *effect, struct file *file);
 int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file);
+int input_ff_flush(struct input_dev *dev, struct file *file);
 
 int input_ff_create_memless(struct input_dev *dev, void *data,
 		int (*play_effect)(struct input_dev *, void *, struct ff_effect *));
-- 
2.14.1.581.gf28d330327-goog
