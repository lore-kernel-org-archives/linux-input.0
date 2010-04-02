From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4/6] usbhid: enable remote wakeup for keyboards
Date: Fri, 2 Apr 2010 13:21:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004021310110.1324-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44164 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755689Ab0DBRV7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Apr 2010 13:21:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Input list <linux-input@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

This patch (as1365) enables remote wakeup by default for USB keyboard
devices.  Keyboards in general are supposed to be wakeup devices, but
the correct place to enable it depends on the device's bus; no single
approach will work for all keyboard devices.  In particular, this
covers only USB keyboards (and then only those supporting the boot
protocol).

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

This patch is necessary in view of the preceding patch (3/6) in this 
series, which disables remote wakeup by default for all USB devices.



Index: usb-2.6/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-2.6.orig/drivers/hid/usbhid/hid-core.c
+++ usb-2.6/drivers/hid/usbhid/hid-core.c
@@ -1024,12 +1024,15 @@ static int usbhid_start(struct hid_devic
 	/* Some keyboards don't work until their LEDs have been set.
 	 * Since BIOSes do set the LEDs, it must be safe for any device
 	 * that supports the keyboard boot protocol.
+	 * In addition, enable remote wakeup by default for all keyboard
+	 * devices supporting the boot protocol.
 	 */
 	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
 			interface->desc.bInterfaceProtocol ==
-				USB_INTERFACE_PROTOCOL_KEYBOARD)
+				USB_INTERFACE_PROTOCOL_KEYBOARD) {
 		usbhid_set_leds(hid);
-
+		device_set_wakeup_enable(&dev->dev, 1);
+	}
 	return 0;
 
 fail:
Index: usb-2.6/drivers/hid/usbhid/usbkbd.c
===================================================================
--- usb-2.6.orig/drivers/hid/usbhid/usbkbd.c
+++ usb-2.6/drivers/hid/usbhid/usbkbd.c
@@ -311,6 +311,7 @@ static int usb_kbd_probe(struct usb_inte
 		goto fail2;
 
 	usb_set_intfdata(iface, kbd);
+	device_set_wakeup_enable(&dev->dev, 1);
 	return 0;
 
 fail2:	

