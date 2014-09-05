From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] HID: usbhid: add always-poll quirk
Date: Fri,  5 Sep 2014 18:08:47 +0200
Message-ID: <1409933328-7190-2-git-send-email-johan@kernel.org>
References: <alpine.LNX.2.00.1408211337050.23162@pobox.suse.cz>
 <1409933328-7190-1-git-send-email-johan@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409933328-7190-1-git-send-email-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Drew Von Spreecken <drewvs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add quirk to make sure that a device is always polled for input events
even if it hasn't been opened.

This is needed for devices that disconnects from the bus unless the
interrupt endpoint has been polled at least once or when not responding
to an input event (e.g. after having shut down X).

Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c | 26 +++++++++++++++++++++++---
 include/linux/hid.h           |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 7b88f4c..d8b6976 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -82,7 +82,7 @@ static int hid_start_in(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->lock, flags);
-	if (hid->open > 0 &&
+	if ((hid->open > 0 || hid->quirks & HID_QUIRK_ALWAYS_POLL) &&
 			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 			!test_bit(HID_SUSPENDED, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
@@ -292,6 +292,8 @@ static void hid_irq_in(struct urb *urb)
 	case 0:			/* success */
 		usbhid_mark_busy(usbhid);
 		usbhid->retry_delay = 0;
+		if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) && !hid->open)
+			break;
 		hid_input_report(urb->context, HID_INPUT_REPORT,
 				 urb->transfer_buffer,
 				 urb->actual_length, 1);
@@ -734,8 +736,10 @@ void usbhid_close(struct hid_device *hid)
 	if (!--hid->open) {
 		spin_unlock_irq(&usbhid->lock);
 		hid_cancel_delayed_stuff(usbhid);
-		usb_kill_urb(usbhid->urbin);
-		usbhid->intf->needs_remote_wakeup = 0;
+		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
+			usb_kill_urb(usbhid->urbin);
+			usbhid->intf->needs_remote_wakeup = 0;
+		}
 	} else {
 		spin_unlock_irq(&usbhid->lock);
 	}
@@ -1133,6 +1137,19 @@ static int usbhid_start(struct hid_device *hid)
 
 	set_bit(HID_STARTED, &usbhid->iofl);
 
+	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
+		ret = usb_autopm_get_interface(usbhid->intf);
+		if (ret)
+			goto fail;
+		usbhid->intf->needs_remote_wakeup = 1;
+		ret = hid_start_in(hid);
+		if (ret) {
+			dev_err(&hid->dev,
+				"failed to start in urb: %d\n", ret);
+		}
+		usb_autopm_put_interface(usbhid->intf);
+	}
+
 	/* Some keyboards don't work until their LEDs have been set.
 	 * Since BIOSes do set the LEDs, it must be safe for any device
 	 * that supports the keyboard boot protocol.
@@ -1165,6 +1182,9 @@ static void usbhid_stop(struct hid_device *hid)
 	if (WARN_ON(!usbhid))
 		return;
 
+	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
+		usbhid->intf->needs_remote_wakeup = 0;
+
 	clear_bit(HID_STARTED, &usbhid->iofl);
 	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
 	set_bit(HID_DISCONNECTED, &usbhid->iofl);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 77632cf..05eb710 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -286,6 +286,7 @@ struct hid_item {
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
 #define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
+#define HID_QUIRK_ALWAYS_POLL			0x00000400
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
