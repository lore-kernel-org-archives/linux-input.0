From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] usbhid: correct PM failure with closed devices
Date: Wed, 15 Apr 2015 15:18:45 +0200
Message-ID: <1429103925-31304-1-git-send-email-oneukum@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-input@vger.kernel.org

When usbhid closes a device which was awake only because remote
wakeup was required but not provided, the interface must go through
a get/put cycle or the core will never reattempt to suspend the device.
This brakes runtime PM for all joysticks.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index bfbe1be..63d1f0f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -734,7 +734,15 @@ void usbhid_close(struct hid_device *hid)
 		hid_cancel_delayed_stuff(usbhid);
 		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
 			usb_kill_urb(usbhid->urbin);
+			/*
+			 * We need a put on the interface to force
+			 * a recheck needed in case only a lack
+			 * of capability to do remote wakeup
+			 * kept us awake
+			 */
+			usb_autopm_get_interface(usbhid->intf);
 			usbhid->intf->needs_remote_wakeup = 0;
+			usb_autopm_put_interface(usbhid->intf);
 		}
 	} else {
 		spin_unlock_irq(&usbhid->lock);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
