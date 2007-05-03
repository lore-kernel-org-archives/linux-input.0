From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] HID: usb_buffer_free() cleanup
Date: Thu, 3 May 2007 01:04:52 -0400
Message-ID: <200705030104.53140.dtor@insightbb.com>
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

Subject: HID: usb_buffer_free() cleanup
From: Dmitry Torokhov <dtor@insightbb.com>

HID: usb_buffer_free() cleanup

usb_buffer_free() now handles NULLs so remove unneeded chaecks
form callers.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hid/usbhid/hid-core.c |   12 ++++--------
 drivers/hid/usbhid/usbkbd.c   |    9 +++------
 2 files changed, 7 insertions(+), 14 deletions(-)

Index: work/drivers/hid/usbhid/hid-core.c
===================================================================
--- work.orig/drivers/hid/usbhid/hid-core.c
+++ work/drivers/hid/usbhid/hid-core.c
@@ -626,14 +626,10 @@ static void hid_free_buffers(struct usb_
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	if (usbhid->inbuf)
-		usb_buffer_free(dev, usbhid->bufsize, usbhid->inbuf, usbhid->inbuf_dma);
-	if (usbhid->outbuf)
-		usb_buffer_free(dev, usbhid->bufsize, usbhid->outbuf, usbhid->outbuf_dma);
-	if (usbhid->cr)
-		usb_buffer_free(dev, sizeof(*(usbhid->cr)), usbhid->cr, usbhid->cr_dma);
-	if (usbhid->ctrlbuf)
-		usb_buffer_free(dev, usbhid->bufsize, usbhid->ctrlbuf, usbhid->ctrlbuf_dma);
+	usb_buffer_free(dev, usbhid->bufsize, usbhid->inbuf, usbhid->inbuf_dma);
+	usb_buffer_free(dev, usbhid->bufsize, usbhid->outbuf, usbhid->outbuf_dma);
+	usb_buffer_free(dev, sizeof(*(usbhid->cr)), usbhid->cr, usbhid->cr_dma);
+	usb_buffer_free(dev, usbhid->bufsize, usbhid->ctrlbuf, usbhid->ctrlbuf_dma);
 }
 
 /*
Index: work/drivers/hid/usbhid/usbkbd.c
===================================================================
--- work.orig/drivers/hid/usbhid/usbkbd.c
+++ work/drivers/hid/usbhid/usbkbd.c
@@ -211,12 +211,9 @@ static void usb_kbd_free_mem(struct usb_
 {
 	usb_free_urb(kbd->irq);
 	usb_free_urb(kbd->led);
-	if (kbd->new)
-		usb_buffer_free(dev, 8, kbd->new, kbd->new_dma);
-	if (kbd->cr)
-		usb_buffer_free(dev, sizeof(struct usb_ctrlrequest), kbd->cr, kbd->cr_dma);
-	if (kbd->leds)
-		usb_buffer_free(dev, 1, kbd->leds, kbd->leds_dma);
+	usb_buffer_free(dev, 8, kbd->new, kbd->new_dma);
+	usb_buffer_free(dev, sizeof(struct usb_ctrlrequest), kbd->cr, kbd->cr_dma);
+	usb_buffer_free(dev, 1, kbd->leds, kbd->leds_dma);
 }
 
 static int usb_kbd_probe(struct usb_interface *iface,
