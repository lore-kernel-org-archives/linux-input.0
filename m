From: Forest Bond <forest@forestbond.com>
Subject: [PATCH 2/2] Input: usbtouchscreen: ignore eGalax/D-Wav/EETI HIDs
Date: Mon, 21 Oct 2013 12:38:18 -0400
Message-ID: <20131021163818.GB30240@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:55607 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3JUQyI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 12:54:08 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Christian Engelmayer <christian.engelmayer@frequentis.com>

From: Forest Bond <forest.bond@rapidrollout.com>

The HID driver now handles these devices, regardless of what protocol
the device claims it supports.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 drivers/input/touchscreen/usbtouchscreen.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 721fdb3..ae4b6b9 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -146,12 +146,10 @@ enum {
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
 	.match_flags = USB_DEVICE_ID_MATCH_INT_CLASS \
-		| USB_DEVICE_ID_MATCH_INT_PROTOCOL \
 		| USB_DEVICE_ID_MATCH_DEVICE, \
 	.idVendor = (vend), \
 	.idProduct = (prod), \
-	.bInterfaceClass = USB_INTERFACE_CLASS_HID, \
-	.bInterfaceProtocol = USB_INTERFACE_PROTOCOL_MOUSE
+	.bInterfaceClass = USB_INTERFACE_CLASS_HID
 
 static const struct usb_device_id usbtouch_devices[] = {
 #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
-- 
1.7.9.5
