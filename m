From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC] [PATCH] HID: Fix race condition between driver core and ll-driver
Date: Wed, 13 Jul 2011 16:24:21 +0200
Message-ID: <1310567061-2679-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52419 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab1GMOYj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 10:24:39 -0400
Received: by fxd18 with SMTP id 18so5997361fxd.11
        for <linux-input@vger.kernel.org>; Wed, 13 Jul 2011 07:24:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, dmitry.torokhov@gmail.com, David Herrmann <dh.herrmann@googlemail.com>

HID low level drivers register new devices with the HID core which then
adds the devices to the HID bus. The HID bus normally immediately probes
an appropriate driver which then handles HID input for this device.
The ll driver now uses the hid_input_report() function to report input
events for a specific device. However, if the HID bus unloads the driver
at the same time (for instance via a call to
 /sys/bus/hid/devices/<dev>/unbind) then the hdev->driver pointer may be
used by hid_input_report() and hid_device_remove() at the same time
which may cause hdev->driver to point to invalid memory.

This fix adds a semaphore to every hid device which protects
hdev->driver from asynchronous access. This semaphore is locked during
driver *_probe and *_remove and also inside hid_input_report(). The
*_probe and *_remove functions may sleep so the semaphore is good here,
however, hid_input_report() is in atomic context and hence only uses
down_trylock(). If it cannot acquire the lock it simply drops the input
package.

The low-level drivers report input events synchronously so
hid_input_report() should never be entered twice at the same time on the
same device. Hence, the lock should always be available. But if the
driver is currently probed/removed then the lock is not available and
dropping the package should be safe because this is what would have
happened if the package arrived some milliseconds earlier/later.

This also fixes another race condition while probing drivers:
First the *_probe function of the driver is called and only if that
succeeds, the related input device of hidinput is registered. If the low
level driver reports input events after the *_probe function returned
but before the input device is registered, then a NULL pointer
dereference will occur. (Equivalently on driver remove function).
This is not possible anymore, since the semaphore lock drops all
incoming packages until the driver/device is fully initialized.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-core.c |   41 ++++++++++++++++++++++++++++++++++-------
 include/linux/hid.h    |    2 ++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2a268fc..59b1a5b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -29,6 +29,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
 
 #include <linux/hid.h>
 #include <linux/hiddev.h>
@@ -1087,14 +1088,23 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 	unsigned int i;
 	int ret;
 
-	if (!hid || !hid->driver)
+	if (!hid)
 		return -ENODEV;
+
+	if (down_trylock(&hid->driver_lock))
+		return -EBUSY;
+
+	if (!hid->driver) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
 	if (!size) {
 		dbg_hid("empty report\n");
-		return -1;
+		ret = -1;
+		goto unlock;
 	}
 
 	buf = kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
@@ -1118,17 +1128,23 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 nomem:
 	report = hid_get_report(report_enum, data);
 
-	if (!report)
-		return -1;
+	if (!report) {
+		ret = -1;
+		goto unlock;
+	}
 
 	if (hdrv && hdrv->raw_event && hid_match_report(hid, report)) {
 		ret = hdrv->raw_event(hid, report, data, size);
-		if (ret != 0)
-			return ret < 0 ? ret : 0;
+		if (ret != 0) {
+			ret = ret < 0 ? ret : 0;
+			goto unlock;
+		}
 	}
 
 	hid_report_raw_event(hid, type, data, size, interrupt);
 
+unlock:
+	up(&hid->driver_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
@@ -1612,6 +1628,9 @@ static int hid_device_probe(struct device *dev)
 	const struct hid_device_id *id;
 	int ret = 0;
 
+	if (down_interruptible(&hdev->driver_lock))
+		return -EINTR;
+
 	if (!hdev->driver) {
 		id = hid_match_device(hdev, hdrv);
 		if (id == NULL)
@@ -1628,14 +1647,20 @@ static int hid_device_probe(struct device *dev)
 		if (ret)
 			hdev->driver = NULL;
 	}
+
+	up(&hdev->driver_lock);
 	return ret;
 }
 
 static int hid_device_remove(struct device *dev)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct hid_driver *hdrv = hdev->driver;
+	struct hid_driver *hdrv;
+
+	if (down_interruptible(&hdev->driver_lock))
+		return -EINTR;
 
+	hdrv = hdev->driver;
 	if (hdrv) {
 		if (hdrv->remove)
 			hdrv->remove(hdev);
@@ -1644,6 +1669,7 @@ static int hid_device_remove(struct device *dev)
 		hdev->driver = NULL;
 	}
 
+	up(&hdev->driver_lock);
 	return 0;
 }
 
@@ -1991,6 +2017,7 @@ struct hid_device *hid_allocate_device(void)
 
 	init_waitqueue_head(&hdev->debug_wait);
 	INIT_LIST_HEAD(&hdev->debug_list);
+	sema_init(&hdev->driver_lock, 1);
 
 	return hdev;
 err:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9cf8e7a..9c02d07 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -71,6 +71,7 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
+#include <linux/semaphore.h>
 
 /*
  * We parse each description item into this structure. Short items data
@@ -475,6 +476,7 @@ struct hid_device {							/* device report descriptor */
 	unsigned country;						/* HID country */
 	struct hid_report_enum report_enum[HID_REPORT_TYPES];
 
+	struct semaphore driver_lock;					/* protects the current driver */
 	struct device dev;						/* device */
 	struct hid_driver *driver;
 	struct hid_ll_driver *ll_driver;
-- 
1.7.6

I've tested this patch on my machine with USB keyboard and bluetooth wiimote
and both worked. The worst bug I could introduce with this locking would be a
dead-lock but this should never happen, because the _probe() and _remove()
functionts are never entered asynchronously. The other occurences of the lock
only use trylock() and hence cannot dead-lock.

I cannot use a mutex here, because a mutex must not be used in atomic contexts.
Also a spinlock cannot be used, because the probe() callbacks of registered
drivers need to be able to sleep. A semaphore was the only choice here.

I would also recommend to remove hid_report_raw_event() from public API. It
is not used anywhere outside hid-core.c and it does not provide the same
locking as hid_input_report(), anymore (otherwise it would dead-lock).
I haven't included this in this patch because I have no idea why it was
exported in the past at all.

I would be glad if some of you could test this on their machines and probably
look over the locking again. I've looked over all the code and haven't found
anything that could break with this semaphore.

Regards
David
