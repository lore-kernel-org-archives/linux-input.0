From: akpm@linux-foundation.org
Subject: [patch 8/8] usbtouchscreen: fix leaks and check return value of usb_submit_urb()
Date: Mon, 21 Dec 2009 16:23:06 -0800
Message-ID: <200912220023.nBM0N69n005064@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35060 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446AbZLVAXm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 19:23:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux@rainbow-software.org, daniel.ritz@gmx.ch, ddstreet@ieee.org, dmitry.torokhov@gmail.com, floe@butterbrot.org, greg@kroah.com, jim-linux@nurd.se, oliver@neukum.org

From: Ondrej Zary <linux@rainbow-software.org>

Fix urb and priv leaks in error paths of initialization and NEXIO ack_buf
leak.

Also check usb_submit_urb() return value.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jim Persson <jim-linux@nurd.se>
Cc: Florian Echtler <floe@butterbrot.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/usbtouchscreen.c |   21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff -puN drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-fix-leaks-and-check-return-value-of-usb_submit_urb drivers/input/touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-fix-leaks-and-check-return-value-of-usb_submit_urb
+++ a/drivers/input/touchscreen/usbtouchscreen.c
@@ -834,6 +834,7 @@ static void nexio_exit(struct usbtouch_u
 
 	usb_kill_urb(priv->ack);
 	usb_free_urb(priv->ack);
+	kfree(priv->ack_buf);
 	kfree(priv);
 }
 
@@ -1395,23 +1396,35 @@ static int usbtouch_probe(struct usb_int
 		err = type->init(usbtouch);
 		if (err) {
 			dbg("%s - type->init() failed, err: %d", __func__, err);
-			goto out_free_buffers;
+			goto out_free_urb;
 		}
 	}
 
 	err = input_register_device(usbtouch->input);
 	if (err) {
 		dbg("%s - input_register_device failed, err: %d", __func__, err);
-		goto out_free_buffers;
+		goto out_exit;
 	}
 
 	usb_set_intfdata(intf, usbtouch);
 
-	if (usbtouch->type->irq_always)
-		usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+	if (usbtouch->type->irq_always) {
+		err = usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+		if (err) {
+			err("%s - usb_submit_urb failed with result: %d",
+			    __func__, err);
+			input_unregister_device(usbtouch->input);
+			goto out_exit;
+		}
+	}
 
 	return 0;
 
+out_exit:
+	if (type->exit)
+		type->exit(usbtouch);
+out_free_urb:
+	usb_free_urb(usbtouch->irq);
 out_free_buffers:
 	usbtouch_free_buffers(udev, usbtouch);
 out_free:
_
