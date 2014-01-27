From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] USB: input: gtco.c: fix usb_dev leak
Date: Tue, 28 Jan 2014 00:10:54 +0400
Message-ID: <1390853454-31749-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:43126 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763AbaA0ULQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 15:11:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is usb_get_dev() in gtco_probe(), but there is no usb_put_dev()
anywhere in the driver.

As pointed out by Dmitry Torokhov:
The lifetime of gtco structure is already directly tied to lifetime of
usb_dev: when destroying usb_dev driver core will call remove() function
of currently bound driver (in our case gtco) which will destroy gtco
memory. Taking additional reference is not needed here.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/input/tablet/gtco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index caecffe8caff..858045694e9d 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -848,7 +848,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	gtco->inputdevice = input_dev;
 
 	/* Save interface information */
-	gtco->usbdev = usb_get_dev(interface_to_usbdev(usbinterface));
+	gtco->usbdev = interface_to_usbdev(usbinterface);
 	gtco->intf = usbinterface;
 
 	/* Allocate some data for incoming reports */
-- 
1.8.3.2

