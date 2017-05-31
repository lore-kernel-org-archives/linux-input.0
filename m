From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/7] HID: usbhid: do not rely on hid->open when deciding to do IO
Date: Wed, 31 May 2017 13:59:47 -0700
Message-ID: <20170531205951.30852-4-dmitry.torokhov@gmail.com>
References: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of checking hid->open (that we plan on having HID core manage) in
hid_start_in(), let's allocate a couple of new flags: HID_IN_POLLING and
HID_OPENED, and use them to decide whether we should be submitting URBs or
not.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 25 ++++++++++++++++++-------
 drivers/hid/usbhid/usbhid.h   | 11 +++++++++++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 62b660622265..d927fe4ba592 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -85,10 +85,10 @@ static int hid_start_in(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->lock, flags);
-	if ((hid->open > 0 || hid->quirks & HID_QUIRK_ALWAYS_POLL) &&
-			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
-			!test_bit(HID_SUSPENDED, &usbhid->iofl) &&
-			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
+	if (test_bit(HID_IN_POLLING, &usbhid->iofl) &&
+	    !test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
+	    !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+	    !test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0) {
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
@@ -272,13 +272,13 @@ static int usbhid_restart_ctrl_queue(struct usbhid_device *usbhid)
 static void hid_irq_in(struct urb *urb)
 {
 	struct hid_device	*hid = urb->context;
-	struct usbhid_device 	*usbhid = hid->driver_data;
+	struct usbhid_device	*usbhid = hid->driver_data;
 	int			status;
 
 	switch (urb->status) {
 	case 0:			/* success */
 		usbhid->retry_delay = 0;
-		if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) && !hid->open)
+		if (!test_bit(HID_OPENED, &usbhid->iofl))
 			break;
 		usbhid_mark_busy(usbhid);
 		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
@@ -692,6 +692,8 @@ static int usbhid_open(struct hid_device *hid)
 			goto done;
 		}
 		usbhid->intf->needs_remote_wakeup = 1;
+		set_bit(HID_OPENED, &usbhid->iofl);
+		set_bit(HID_IN_POLLING, &usbhid->iofl);
 		set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
 		res = hid_start_in(hid);
 		if (res) {
@@ -701,6 +703,9 @@ static int usbhid_open(struct hid_device *hid)
 			} else {
 				/* no use opening if resources are insufficient */
 				hid->open--;
+				clear_bit(HID_OPENED, &usbhid->iofl);
+				if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
+					clear_bit(HID_IN_POLLING, &usbhid->iofl);
 				res = -EBUSY;
 				usbhid->intf->needs_remote_wakeup = 0;
 			}
@@ -734,6 +739,9 @@ static void usbhid_close(struct hid_device *hid)
 	 */
 	spin_lock_irq(&usbhid->lock);
 	if (!--hid->open) {
+		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
+			clear_bit(HID_IN_POLLING, &usbhid->iofl);
+		clear_bit(HID_OPENED, &usbhid->iofl);
 		spin_unlock_irq(&usbhid->lock);
 		hid_cancel_delayed_stuff(usbhid);
 		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
@@ -1135,6 +1143,7 @@ static int usbhid_start(struct hid_device *hid)
 		ret = usb_autopm_get_interface(usbhid->intf);
 		if (ret)
 			goto fail;
+		set_bit(HID_IN_POLLING, &usbhid->iofl);
 		usbhid->intf->needs_remote_wakeup = 1;
 		ret = hid_start_in(hid);
 		if (ret) {
@@ -1176,8 +1185,10 @@ static void usbhid_stop(struct hid_device *hid)
 	if (WARN_ON(!usbhid))
 		return;
 
-	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
+	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
+		clear_bit(HID_IN_POLLING, &usbhid->iofl);
 		usbhid->intf->needs_remote_wakeup = 0;
+	}
 
 	clear_bit(HID_STARTED, &usbhid->iofl);
 	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index ffcd329b3c3b..da9c61d54be6 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -49,6 +49,17 @@ struct usb_interface *usbhid_find_interface(int minor);
 #define HID_KEYS_PRESSED	10
 #define HID_NO_BANDWIDTH	11
 #define HID_RESUME_RUNNING	12
+/*
+ * The device is opened, meaning there is a client that is interested
+ * in data coming from the device.
+ */
+#define HID_OPENED		13
+/*
+ * We are polling input endpoint by [re]submitting IN URB, because
+ * either HID device is opened or ALWAYS POLL quirk is set for the
+ * device.
+ */
+#define HID_IN_POLLING		14
 
 /*
  * USB-specific HID struct, to be pointed to
-- 
2.13.0.506.g27d5fe0cd-goog
