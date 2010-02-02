From: akpm@linux-foundation.org
Subject: [patch 5/7] usbtouchscreen: fix NEXIO ACK and USB disconnect
Date: Tue, 02 Feb 2010 14:42:55 -0800
Message-ID: <201002022242.o12MgtKo019144@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37419 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756822Ab0BBWn1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2010 17:43:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux@rainbow-software.org, daniel.ritz@gmx.ch, ddstreet@ieee.org, dmitry.torokhov@gmail.com, floe@butterbrot.org, greg@kroah.com, jim-linux@nurd.se, oliver@neukum.org

From: Ondrej Zary <linux@rainbow-software.org>

Fix sending ACK urbs and oops on USB disconnecting NEXIO touchscreen.

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

 drivers/input/touchscreen/usbtouchscreen.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-fix-nexio-ack-and-usb-disconnect drivers/input/touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-fix-nexio-ack-and-usb-disconnect
+++ a/drivers/input/touchscreen/usbtouchscreen.c
@@ -728,6 +728,10 @@ struct nexio_touch_packet {
 static unsigned char nexio_ack_pkt[2] = { 0xaa, 0x02 };
 static unsigned char nexio_init_pkt[4] = { 0x82, 0x04, 0x0a, 0x0f };
 
+static void nexio_ack_complete(struct urb *urb)
+{
+}
+
 static int nexio_init(struct usbtouch_usb *usbtouch)
 {
 	struct usb_device *dev = interface_to_usbdev(usbtouch->interface);
@@ -811,8 +815,8 @@ static int nexio_init(struct usbtouch_us
 		goto err_ack_buf;
 	}
 	usb_fill_bulk_urb(priv->ack, dev, usb_sndbulkpipe(dev, output_ep),
-			  priv->ack_buf, sizeof(priv->ack_buf), NULL,
-			  usbtouch);
+			  priv->ack_buf, sizeof(nexio_ack_pkt),
+			  nexio_ack_complete, usbtouch);
 	ret = 0;
 	goto out_buf;
 err_ack_buf:
@@ -1227,6 +1231,7 @@ static void usbtouch_irq(struct urb *urb
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
+	case -EPIPE:
 		/* this urb is terminated, clean up */
 		dbg("%s - urb shutting down with status: %d",
 		    __func__, urb->status);
_
