From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Autocentering support for Logitech G25 Racing Wheel and others
 with  ID 046d:c294
Date: Mon, 4 May 2009 11:21:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905041120470.22532@wotan.suse.de>
References: <bb829a0b0905040201r7623ddcam2601ce9f92939c20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40427 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbZEDJV7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 May 2009 05:21:59 -0400
In-Reply-To: <bb829a0b0905040201r7623ddcam2601ce9f92939c20@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?KOI8-R?B?88XSx8XKIOLFzNHbz9c=?= <sergey.belyashov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 4 May 2009, ?????? ??????? wrote:

>      Some months ago I send patch which adds autocentering for Logitech 
> MOMO Wheel. Now I have access to Logitech G25 Racing Wheel and test 
> autocentering for it. I write patch for current kernel to support 
> autocentering for G25 in legacy mode (this device supports other modes, 
> but after switching device reconnects with ID 0xc299 and FF support 
> comes out) and others Logitech (Driving Force, Formula Force Ex etc) 
> wheels with ID 046d:c294.

Hi,

have you seen this patch from Christophe?


commit 243b706d8a71364ad6080328d45b73516c8af5f3
Author: Christophe Borivant <christophe.borivant@wanadoo.fr>
Date:   Fri Apr 17 11:39:39 2009 +0200

    HID: Add support for the G25 force feedback wheel in native mode
    
    Add Product Id 0xc299 for the Logitech G25 force feedback wheel
    The Logitech G25 force feedback wheel, is first recognize by the kernel
    with the product id "0xc294". In this mode, we can't use all the axes
    and buttons of the wheel.
    
    Using a userland utility, it is possible to make the wheel switch to native
    mode -- http://svn.vdrift.net/viewvc.cgi/trunk/tools/G25manage/?root=VDrift
    In native mode, the wheel change its id number to "0xc299".
    
    The packet that needs to be sent to the wheel to swtich to native mode and
    change its PID is
    
    	{ 0xf8, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00 }
    
    Signed-off-by: Christophe Borivant <christophe.borivant@wanadoo.fr>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5746a59..c7075d2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1293,6 +1293,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index bdeda4c..aa1b995 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -292,6 +292,7 @@
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_WHEEL	0xc294
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
+#define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
 #define USB_DEVICE_ID_S510_RECEIVER	0xc50c
 #define USB_DEVICE_ID_S510_RECEIVER_2	0xc517
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 7b80cb6..7afbaa0 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -297,6 +297,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2),
 		.driver_data = LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
+		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
 		.driver_data = LG_FF2 },
 	{ }

-- 
Jiri Kosina
SUSE Labs
