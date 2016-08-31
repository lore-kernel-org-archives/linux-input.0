From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] HID: usbkbd: return proper error code
Date: Wed, 31 Aug 2016 21:58:21 +0530
Message-ID: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-input@vger.kernel.org

Use proper error code instead of using -1 on failure to allocate
memory. We may use the error code later in the caller.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/hid/usbhid/usbkbd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 9a332e6..ee53359 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -249,15 +249,15 @@ static void usb_kbd_close(struct input_dev *dev)
 static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
 {
 	if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
-		return -1;
+		return -ENOMEM;
 	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
-		return -1;
+		return -ENOMEM;
 	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
-		return -1;
+		return -ENOMEM;
 	if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
-		return -1;
+		return -ENOMEM;
 	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
-		return -1;
+		return -ENOMEM;
 
 	return 0;
 }
-- 
1.9.1
