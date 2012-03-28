From: Oliver Neukum <oneukum@suse.de>
Subject: [RFC] usbhid: fix error handling of not enough bandwidth
Date: Wed, 28 Mar 2012 13:16:19 +0200
Message-ID: <201203281316.20038.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238Ab2C1LUp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 07:20:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Libor Pechacek <lpechacek@suse.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

>From 22569602350f8992f2d2b321cf195e633e74574a Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Wed, 28 Mar 2012 10:37:05 +0200
Subject: [PATCH] usbhid: fix error handling of not enough bandwidth

In case IO cannot be started because there is a lack of bandwidth
on the bus, it makes no sense to reset the device. If IO is requested
because the device is opened, user space should be notified with
an error right away. If the lack of bandwidth arises later, for
example after resume, there's no other choice but to retry in the
hope that bandwidth will be freed.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---

Unfortunately only XHCI implements check_bandwidth()
I've seen this trigger on UHCI due to an error, but still, it can happen.

	Regards
		Oliver

 drivers/hid/usbhid/hid-core.c |   37 +++++++++++++++++++++++++++----------
 drivers/hid/usbhid/usbhid.h   |    1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 5bf91db..c1a1dd5 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -86,8 +86,13 @@ static int hid_start_in(struct hid_device *hid)
 			!test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
-		if (rc != 0)
+		if (rc != 0) {
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
+			if (rc == -ENOSPC)
+				set_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
+		} else {
+			clear_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
+		}
 	}
 	spin_unlock_irqrestore(&usbhid->lock, flags);
 	return rc;
@@ -173,8 +178,10 @@ static void hid_io_error(struct hid_device *hid)
 
 	if (time_after(jiffies, usbhid->stop_retry)) {
 
-		/* Retries failed, so do a port reset */
-		if (!test_and_set_bit(HID_RESET_PENDING, &usbhid->iofl)) {
+		/* Retries failed, so do a port reset unless we lack bandwidth*/
+		if (test_bit(HID_NO_BANDWIDTH, &usbhid->iofl)
+		     && !test_and_set_bit(HID_RESET_PENDING, &usbhid->iofl)) {
+
 			schedule_work(&usbhid->reset_work);
 			goto done;
 		}
@@ -700,7 +707,7 @@ static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
 int usbhid_open(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
-	int res;
+	int res = 0;
 
 	mutex_lock(&hid_open_mut);
 	if (!hid->open++) {
@@ -708,17 +715,27 @@ int usbhid_open(struct hid_device *hid)
 		/* the device must be awake to reliably request remote wakeup */
 		if (res < 0) {
 			hid->open--;
-			mutex_unlock(&hid_open_mut);
-			return -EIO;
+			res = -EIO;
+			goto done;
 		}
 		usbhid->intf->needs_remote_wakeup = 1;
-		if (hid_start_in(hid))
-			hid_io_error(hid);
- 
+		res = hid_start_in(hid);
+		if (res) {
+			if (res != -ENOSPC) {
+				hid_io_error(hid);
+				res = 0;
+			} else {
+				/* no use opening if resources are insufficient */
+				hid->open--;
+				res = -EBUSY;
+				usbhid->intf->needs_remote_wakeup = 0;
+			}
+		}
 		usb_autopm_put_interface(usbhid->intf);
 	}
+done:
 	mutex_unlock(&hid_open_mut);
-	return 0;
+	return res;
 }
 
 void usbhid_close(struct hid_device *hid)
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index cb8f703..1883d7b 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -55,6 +55,7 @@ struct usb_interface *usbhid_find_interface(int minor);
 #define HID_STARTED		8
 #define HID_REPORTED_IDLE	9
 #define HID_KEYS_PRESSED	10
+#define HID_NO_BANDWIDTH	11
 
 /*
  * USB-specific HID struct, to be pointed to
-- 
1.7.1

