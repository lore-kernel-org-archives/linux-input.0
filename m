From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]race between open and disconnect in usbhid #2
Date: Mon, 31 Mar 2008 16:25:10 +0200
Message-ID: <200803311625.10782.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

There is a window:

task A					task B
spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
usb_set_intfdata(intf, NULL);
spin_unlock_irq(&usbhid->inlock);
usb_kill_urb(usbhid->urbin);
usb_kill_urb(usbhid->urbout);
usb_kill_urb(usbhid->urbctrl);

del_timer_sync(&usbhid->io_retry);
cancel_work_sync(&usbhid->reset_work);

						if (!hid->open++) {
							res = usb_autopm_get_interface(usbhid->intf);
							if (res < 0) {
								hid->open--;
								return -EIO;
							}
						}
						if (hid_start_in(hid))

if (hid->claimed & HID_CLAIMED_INPUT)
	hidinput_disconnect(hid);

in which an open() to an already disconnected device will submit an URB
to an undead device. In case disconnect() was called by an ioctl, this'll
oops. Fix by introducing a new flag and checking it in hid_start_in().

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

----

--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hid-core.c	2008-03-31 15:20:58.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hid-core.c	2008-03-31 16:02:49.000000000 +0200
@@ -82,6 +82,7 @@
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
 	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -155,7 +156,7 @@
 	spin_lock_irqsave(&usbhid->inlock, flags);
 
 	/* Stop when disconnected */
-	if (usb_get_intfdata(usbhid->intf) == NULL)
+	if (test_bit(HID_DISCONNECTED, &usbhid->iofl))
 		goto done;
 
 	/* If it has been a while since the last error, we'll assume
@@ -932,6 +933,7 @@
 
 	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
 	usb_set_intfdata(intf, NULL);
+	set_bit(HID_DISCONNECTED, &usbhid->iofl);
 	spin_unlock_irq(&usbhid->inlock);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbout);
--- linux-2.6.25-rc7-vanilla/include/linux/hid.h	2008-03-31 15:21:24.000000000 +0200
+++ linux-2.6.25-rc7-work/include/linux/hid.h	2008-03-31 15:58:43.000000000 +0200
@@ -421,6 +421,7 @@
 #define HID_RESET_PENDING	4
 #define HID_SUSPENDED		5
 #define HID_CLEAR_HALT		6
+#define HID_DISCONNECTED	7
 
 struct hid_input {
 	struct list_head list;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
