From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] usbkbd/usbmouse - handle errors when registering devices
Date: Wed, 4 Apr 2007 01:52:36 -0400
Message-ID: <200704040152.37315.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Jiri,

I have been sitting on this patch for some time, now you can have it ;)

-- 
Dmitry

Input: usbkbd/usbmouse - handle errors when registering input devices

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/usbkbd.c   |   11 +++++++----
 drivers/usb/input/usbmouse.c |   12 ++++++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

Index: work/drivers/usb/input/usbkbd.c
===================================================================
--- work.orig/drivers/usb/input/usbkbd.c
+++ work/drivers/usb/input/usbkbd.c
@@ -228,6 +228,7 @@ static int usb_kbd_probe(struct usb_inte
 	struct usb_kbd *kbd;
 	struct input_dev *input_dev;
 	int i, pipe, maxp;
+	int error = -ENOMEM;
 
 	interface = iface->cur_altsetting;
 
@@ -306,15 +307,17 @@ static int usb_kbd_probe(struct usb_inte
 	kbd->led->transfer_dma = kbd->leds_dma;
 	kbd->led->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP | URB_NO_SETUP_DMA_MAP);
 
-	input_register_device(kbd->dev);
+	error = input_register_device(kbd->dev);
+	if (error)
+		goto fail2;
 
 	usb_set_intfdata(iface, kbd);
 	return 0;
 
-fail2:	usb_kbd_free_mem(dev, kbd);
-fail1:	input_free_device(input_dev);
+ fail2:	usb_kbd_free_mem(dev, kbd);
+ fail1:	input_free_device(input_dev);
 	kfree(kbd);
-	return -ENOMEM;
+	return error;
 }
 
 static void usb_kbd_disconnect(struct usb_interface *intf)
Index: work/drivers/usb/input/usbmouse.c
===================================================================
--- work.orig/drivers/usb/input/usbmouse.c
+++ work/drivers/usb/input/usbmouse.c
@@ -120,6 +120,7 @@ static int usb_mouse_probe(struct usb_in
 	struct usb_mouse *mouse;
 	struct input_dev *input_dev;
 	int pipe, maxp;
+	int error = -ENOMEM;
 
 	interface = intf->cur_altsetting;
 
@@ -188,15 +189,18 @@ static int usb_mouse_probe(struct usb_in
 	mouse->irq->transfer_dma = mouse->data_dma;
 	mouse->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	input_register_device(mouse->dev);
+	error = input_register_device(mouse->dev);
+	if (error)
+		goto fail3;
 
 	usb_set_intfdata(intf, mouse);
 	return 0;
 
-fail2:	usb_buffer_free(dev, 8, mouse->data, mouse->data_dma);
-fail1:	input_free_device(input_dev);
+ fail3:	usb_free_urb(mouse->irq);
+ fail2:	usb_buffer_free(dev, 8, mouse->data, mouse->data_dma);
+ fail1:	input_free_device(input_dev);
 	kfree(mouse);
-	return -ENOMEM;
+	return error;
 }
 
 static void usb_mouse_disconnect(struct usb_interface *intf)
