From: Avraham Shukron <avraham.shukron@gmail.com>
Subject: [PATCH] usbhid: usbmouse: Fix checkpatch.pl issues
Date: Tue, 21 Feb 2017 19:11:06 +0200
Message-ID: <47ddad07-231a-b832-0db5-501272988dd3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdBURL1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 12:11:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Removed trailing and unneeded white-spaces, broke long lines where appropriate.

Signed-off-by: Avraham Shukron <avraham.shukron@gmail.com>
---
 drivers/hid/usbhid/usbmouse.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index dd911c5..914a5a9 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -89,7 +89,7 @@ static void usb_mouse_irq(struct urb *urb)

 	input_sync(dev);
 resubmit:
-	status = usb_submit_urb (urb, GFP_ATOMIC);
+	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status)
 		dev_err(&mouse->usbdev->dev,
 			"can't resubmit intr, %s-%s/input0, status %d\n",
@@ -115,7 +115,8 @@ static void usb_mouse_close(struct input_dev *dev)
 	usb_kill_urb(mouse->irq);
 }

-static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static int usb_mouse_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_host_interface *interface;
@@ -202,11 +203,11 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 	usb_set_intfdata(intf, mouse);
 	return 0;

-fail3:	
+fail3:
 	usb_free_urb(mouse->irq);
-fail2:	
+fail2:
 	usb_free_coherent(dev, 8, mouse->data, mouse->data_dma);
-fail1:	
+fail1:
 	input_free_device(input_dev);
 	kfree(mouse);
 	return error;
@@ -214,25 +215,27 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i

 static void usb_mouse_disconnect(struct usb_interface *intf)
 {
-	struct usb_mouse *mouse = usb_get_intfdata (intf);
+	struct usb_mouse *mouse = usb_get_intfdata(intf);

 	usb_set_intfdata(intf, NULL);
 	if (mouse) {
 		usb_kill_urb(mouse->irq);
 		input_unregister_device(mouse->dev);
 		usb_free_urb(mouse->irq);
-		usb_free_coherent(interface_to_usbdev(intf), 8, mouse->data, mouse->data_dma);
+		usb_free_coherent(interface_to_usbdev(intf), 8,
+				mouse->data, mouse->data_dma);
 		kfree(mouse);
 	}
 }

-static struct usb_device_id usb_mouse_id_table [] = {
-	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID, USB_INTERFACE_SUBCLASS_BOOT,
+static struct usb_device_id usb_mouse_id_table[] = {
+	{ USB_INTERFACE_INFO(USB_INTERFACE_CLASS_HID,
+		USB_INTERFACE_SUBCLASS_BOOT,
 		USB_INTERFACE_PROTOCOL_MOUSE) },
 	{ }	/* Terminating entry */
 };

-MODULE_DEVICE_TABLE (usb, usb_mouse_id_table);
+MODULE_DEVICE_TABLE(usb, usb_mouse_id_table);

 static struct usb_driver usb_mouse_driver = {
 	.name		= "usbmouse",
-- 
2.7.4
