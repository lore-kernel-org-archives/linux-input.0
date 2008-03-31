From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]race between open and disconnect in usbhid
Date: Mon, 31 Mar 2008 15:35:09 +0200
Message-ID: <200803311535.10067.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
oops. Fix by introducing a reliable flag an checking it in hid_start_in().

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

----

--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/usbhid.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/usbhid.h	2008-03-31 13:45:25.000000000 +0200
@@ -77,6 +77,7 @@
 	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /* Delay length in ms */
 	struct work_struct reset_work;                                  /* Task context for resets */
+	char disconnected:1;						/* indicates undead device - no use */
 
 };
 
--- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hid-core.c	2008-03-31 15:20:58.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hid-core.c	2008-03-31 13:45:10.000000000 +0200
@@ -82,6 +82,7 @@
 
 	spin_lock_irqsave(&usbhid->inlock, flags);
 	if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
+			!usbhid->disconnected &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0)
@@ -155,7 +156,7 @@
 	spin_lock_irqsave(&usbhid->inlock, flags);
 
 	/* Stop when disconnected */
-	if (usb_get_intfdata(usbhid->intf) == NULL)
+	if (usbhid->disconnected)
 		goto done;
 
 	/* If it has been a while since the last error, we'll assume
@@ -932,6 +933,7 @@
 
 	spin_lock_irq(&usbhid->inlock);	/* Sync with error handler */
 	usb_set_intfdata(intf, NULL);
+	usbhid->disconnected = 1;
 	spin_unlock_irq(&usbhid->inlock);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbout);
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
