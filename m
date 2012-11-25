From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Sun, 25 Nov 2012 10:48:28 -0800
Message-ID: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51258 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2KYSss (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Nov 2012 13:48:48 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so7516265iay.19
        for <linux-input@vger.kernel.org>; Sun, 25 Nov 2012 10:48:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Linux-Input, Jiri,

Benjamin Tissoires and Nestor Lopez Casado have been helping me to add
Linux support for new Logitech Touch Mice (T620, T400). After running
into a road-block in hid-core, and solving it with this patch, we
thought it was good to show the community and see if this is okay, or
if there's a better solution that we've missed.

Thanks for your comments,
-andrew

This patch separates struct hid_device's driver_lock into two. The
goal is to allow hid device drivers to receive input during their
probe() function call. This is necessary because some drivers need to
communicate with the device to determine parameters needed during
probe (e.g., size of a multi-touch surface).

Historically, three functions used driver_lock:

- hid_device_probe: blocks to acquire lock
- hid_device_remove: blocks to acquire lock
- hid_input_report: if locked returns -EBUSY, else acquires lock

This patch adds another lock (driver_input_lock) which is used to
block input from occurring. The lock behavior is now:

- hid_device_probe: blocks to acq. driver_lock, then driver_input_lock
- hid_device_remove: blocks to acq. driver_lock, then driver_input_lock
- hid_input_report: if driver_input_lock locked returns -EBUSY, else
  acquires driver_input_lock

This results in no behavior change for existing devices and
drivers. However, during a probe() function call in a driver, that
driver may now selectively unlock driver_input_lock to let input
events come through, then re-lock.

---
 drivers/hid/hid-core.c |   15 +++++++++++++--
 include/linux/hid.h    |    3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4da66b4..3eb4398 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1097,7 +1097,7 @@ int hid_input_report(struct hid_device *hid, int
type, u8 *data, int size, int i
 	if (!hid)
 		return -ENODEV;

-	if (down_trylock(&hid->driver_lock))
+	if (down_trylock(&hid->driver_input_lock))
 		return -EBUSY;

 	if (!hid->driver) {
@@ -1150,7 +1150,7 @@ nomem:
 	hid_report_raw_event(hid, type, data, size, interrupt);

 unlock:
-	up(&hid->driver_lock);
+	up(&hid->driver_input_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
@@ -1703,6 +1703,10 @@ static int hid_device_probe(struct device *dev)

 	if (down_interruptible(&hdev->driver_lock))
 		return -EINTR;
+	if (down_interruptible(&hdev->driver_input_lock)) {
+		up(&hdev->driver_lock);
+		return -EINTR;
+	}

 	if (!hdev->driver) {
 		id = hid_match_device(hdev, hdrv);
@@ -1726,6 +1730,7 @@ static int hid_device_probe(struct device *dev)
 			hdev->driver = NULL;
 	}
 unlock:
+	up(&hdev->driver_input_lock);
 	up(&hdev->driver_lock);
 	return ret;
 }
@@ -1737,6 +1742,10 @@ static int hid_device_remove(struct device *dev)

 	if (down_interruptible(&hdev->driver_lock))
 		return -EINTR;
+	if (down_interruptible(&hdev->driver_input_lock)) {
+		up(&hdev->driver_lock);
+		return -EINTR;
+	}

 	hdrv = hdev->driver;
 	if (hdrv) {
@@ -1747,6 +1756,7 @@ static int hid_device_remove(struct device *dev)
 		hdev->driver = NULL;
 	}

+	up(&hdev->driver_input_lock);
 	up(&hdev->driver_lock);
 	return 0;
 }
@@ -2126,6 +2136,7 @@ struct hid_device *hid_allocate_device(void)
 	init_waitqueue_head(&hdev->debug_wait);
 	INIT_LIST_HEAD(&hdev->debug_list);
 	sema_init(&hdev->driver_lock, 1);
+	sema_init(&hdev->driver_input_lock, 1);

 	return hdev;
 err:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3a95da6..7e9d235 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -481,7 +481,8 @@ struct hid_device {							/* device report descriptor */
 	unsigned country;						/* HID country */
 	struct hid_report_enum report_enum[HID_REPORT_TYPES];

-	struct semaphore driver_lock;					/* protects the current driver */
+	struct semaphore driver_lock;					/* protects the current driver,
except during input */
+	struct semaphore driver_input_lock;				/* protects the current driver */
 	struct device dev;						/* device */
 	struct hid_driver *driver;
 	struct hid_ll_driver *ll_driver;
-- 
1.7.7.3
