From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] HID: usbhid: Convert timers to use timer_setup()
Date: Wed, 4 Oct 2017 17:53:24 -0700
Message-ID: <20171005005324.GA23752@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-input@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds pointer back to hid_device for
multitouch.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/hid/hid-multitouch.c  | 10 ++++++----
 drivers/hid/usbhid/hid-core.c |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 440b999304a5..b0e3e2614b18 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -112,6 +112,7 @@ struct mt_device {
 	struct mt_slot curdata;	/* placeholder of incoming data */
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
+	struct hid_device *hdev;	/* hid_device we're attached to */
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
@@ -1245,10 +1246,10 @@ static void mt_release_contacts(struct hid_device *hid)
 	td->num_received = 0;
 }
 
-static void mt_expired_timeout(unsigned long arg)
+static void mt_expired_timeout(struct timer_list *t)
 {
-	struct hid_device *hdev = (void *)arg;
-	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_device *td = from_timer(td, t, release_timer);
+	struct hid_device *hdev = td->hdev;
 
 	/*
 	 * An input report came in just before we release the sticky fingers,
@@ -1279,6 +1280,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
+	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->maxcontact_report_id = -1;
@@ -1330,7 +1332,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
-	setup_timer(&td->release_timer, mt_expired_timeout, (long)hdev);
+	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 089bad8a9a21..9f9fe0e58f5b 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -101,10 +101,10 @@ static int hid_start_in(struct hid_device *hid)
 }
 
 /* I/O retry timer routine */
-static void hid_retry_timeout(unsigned long _hid)
+static void hid_retry_timeout(struct timer_list *t)
 {
-	struct hid_device *hid = (struct hid_device *) _hid;
-	struct usbhid_device *usbhid = hid->driver_data;
+	struct usbhid_device *usbhid = from_timer(usbhid, t, io_retry);
+	struct hid_device *hid = usbhid->hid;
 
 	dev_dbg(&usbhid->intf->dev, "retrying intr urb\n");
 	if (hid_start_in(hid))
@@ -1363,7 +1363,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 
 	init_waitqueue_head(&usbhid->wait);
 	INIT_WORK(&usbhid->reset_work, hid_reset);
-	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
+	timer_setup(&usbhid->io_retry, hid_retry_timeout, 0);
 	spin_lock_init(&usbhid->lock);
 
 	ret = hid_add_device(hid);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
