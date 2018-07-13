From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Input: pxrc - fix leak of usb_device
Date: Fri, 13 Jul 2018 23:07:57 +0300
Message-ID: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
anywhere in the driver.

The patch adds one to error handling code and to pxrc_disconnect().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/input/joystick/pxrc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..0a31de63ac8e 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -221,6 +221,7 @@ static int pxrc_probe(struct usb_interface *intf,
 	usb_free_urb(pxrc->urb);
 
 error:
+	usb_put_dev(pxrc->udev);
 	return retval;
 }
 
@@ -229,6 +230,7 @@ static void pxrc_disconnect(struct usb_interface *intf)
 	struct pxrc *pxrc = usb_get_intfdata(intf);
 
 	usb_free_urb(pxrc->urb);
+	usb_put_dev(pxrc->udev);
 	usb_set_intfdata(intf, NULL);
 }
 
-- 
2.7.4
