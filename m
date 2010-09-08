From: Roland Baum <rba@tr33.de>
Subject: Re: [Patch 1/1] HID: Provide support for a new Asus Multitouch Controller
Date: Wed, 8 Sep 2010 13:55:56 +0200
Message-ID: <201009081355.57254.rba@tr33.de>
References: <201009061121.18816.rba@tr33.de> <alpine.LNX.2.00.1009081205180.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from europa.nexplosion.de ([78.47.196.58]:55856 "EHLO
	europa.nexplosion.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552Ab0IHL4d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 07:56:33 -0400
In-Reply-To: <alpine.LNX.2.00.1009081205180.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, =?iso-8859-1?q?St=E9phane_Chatty?= <chatty@enac.fr>

Am Mittwoch, 8. September 2010, um 12:07:00 schrieb Jiri Kosina:
> your patch has been line-wrapped, so it can't be applied as-is. Could you 
> please fix your mail client so that it doesn't damage the formatting of 
> the patch, and resend?
> (alternatively, you can send it as an attachment).

Sorry.

Better now ?

> 
> Thanks,
> 
> 

You're welcome.

-------------------------------------------------------
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-core.c linux-source-2.6.32-modified/drivers/hid/hid-core.c
--- linux-source-2.6.32-orig/drivers/hid/hid-core.c     2010-08-19 03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-core.c 2010-09-04 20:01:14.539265355 +0200
@@ -1294,6 +1294,7 @@ static const struct hid_device_id hid_bl
        { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
        { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
        { HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO)},
        { HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION) },
        { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
        { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-ids.h linux-source-2.6.32-modified/drivers/hid/hid-ids.h
--- linux-source-2.6.32-orig/drivers/hid/hid-ids.h      2010-08-19 03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-ids.h  2010-09-04 20:00:14.050826601 +0200
@@ -101,6 +101,7 @@
 
 #define USB_VENDOR_ID_ASUS             0x0486
 #define USB_DEVICE_ID_ASUS_T91MT       0x0185
+#define USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO   0x0186
 
 #define USB_VENDOR_ID_ASUSTEK          0x0b05
 #define USB_DEVICE_ID_ASUSTEK_LCM      0x1726
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-mosart.c linux-source-2.6.32-modified/drivers/hid/hid-mosart.c
--- linux-source-2.6.32-orig/drivers/hid/hid-mosart.c   2010-08-19 03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-mosart.c       2010-09-04 20:01:54.523282460 +0200
@@ -238,6 +238,7 @@ static void mosart_remove(struct hid_dev
 
 static const struct hid_device_id mosart_devices[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO)},
        { }
 };
 MODULE_DEVICE_TABLE(hid, mosart_devices);
-------------------------------------------------------

-- 

Greetings from Frankfurt/Main

Roland Baum


