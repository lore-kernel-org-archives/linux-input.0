From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] HID: usbhid: Use GFP_KERNEL instead of GFP_ATOMIC when applicable
Date: Thu,  1 Aug 2019 09:47:59 +0200
Message-ID: <20190801074759.32738-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

There is no need to use GFP_ATOMIC when calling 'usb_alloc_coherent()'
here. These calls are done from probe functions and using GFP_KERNEL should
be safe.
The memory itself is used within some interrupts, but it is not a
problem, once it has been allocated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/usbhid/usbkbd.c   | 4 ++--
 drivers/hid/usbhid/usbmouse.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index d5b7a696a68c..63e8ef8beb45 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -239,11 +239,11 @@ static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
 		return -1;
 	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
 		return -1;
-	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
+	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, &kbd->new_dma)))
 		return -1;
 	if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
 		return -1;
-	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
+	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, &kbd->leds_dma)))
 		return -1;
 
 	return 0;
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index 073127e65ac1..c89332017d5d 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -130,7 +130,7 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 	if (!mouse || !input_dev)
 		goto fail1;
 
-	mouse->data = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &mouse->data_dma);
+	mouse->data = usb_alloc_coherent(dev, 8, GFP_KERNEL, &mouse->data_dma);
 	if (!mouse->data)
 		goto fail1;
 
-- 
2.20.1
