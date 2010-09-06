From: Roland Baum <rba@tr33.de>
Subject: [Patch 1/1] HID: Provide support for a new Asus Multitouch Controller
Date: Mon, 6 Sep 2010 11:21:18 +0200
Message-ID: <201009061121.18816.rba@tr33.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from europa.nexplosion.de ([78.47.196.58]:56850 "EHLO
	europa.nexplosion.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0IFKH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Sep 2010 06:07:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, =?iso-8859-1?q?St=E9phane_Chatty?= <chatty@enac.fr>

Hello,

the following patch instructs usbhid/hid-mosart to handle a new Mutlito=
uch=20
controller, built-in by some Asus EeePC T101MT models.



Signed-off-by: Roland Baum <rba@tr33.de>
Tested-by: Roland Baum <rba@tr33.de>
Acked-by: St=E9phane Chatty <chatty@enac.fr>
CC: St=E9phane Chatty <chatty@enac.fr>
CC: Jiri Kosina <jkosina@suse.cz>


Build against 2.6.32
-----
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-core.c linux-source=
-2.6.32-
modified/drivers/hid/hid-core.c
--- linux-source-2.6.32-orig/drivers/hid/hid-core.c     2010-08-19=20
03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-core.c 2010-09-04=20
20:01:14.539265355 +0200
@@ -1294,6 +1294,7 @@ static const struct hid_device_id hid_bl
        { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
        { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
        { HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) =
},
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUS,=20
USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO)},
        { HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYM=
OTION)=20
},
        { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY,=20
USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
        { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,=20
USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-ids.h linux-source-=
2.6.32-
modified/drivers/hid/hid-ids.h
--- linux-source-2.6.32-orig/drivers/hid/hid-ids.h      2010-08-19=20
03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-ids.h  2010-09-04=20
20:00:14.050826601 +0200
@@ -101,6 +101,7 @@
=20
 #define USB_VENDOR_ID_ASUS             0x0486
 #define USB_DEVICE_ID_ASUS_T91MT       0x0185
+#define USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO   0x0186
=20
 #define USB_VENDOR_ID_ASUSTEK          0x0b05
 #define USB_DEVICE_ID_ASUSTEK_LCM      0x1726
diff -rupN linux-source-2.6.32-orig/drivers/hid/hid-mosart.c linux-
source-2.6.32-modified/drivers/hid/hid-mosart.c
--- linux-source-2.6.32-orig/drivers/hid/hid-mosart.c   2010-08-19=20
03:12:22.000000000 +0200
+++ linux-source-2.6.32-modified/drivers/hid/hid-mosart.c       2010-09=
-04=20
20:01:54.523282460 +0200
@@ -238,6 +238,7 @@ static void mosart_remove(struct hid_dev
=20
 static const struct hid_device_id mosart_devices[] =3D {
        { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) =
},
+       { HID_USB_DEVICE(USB_VENDOR_ID_ASUS,=20
USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO)},
        { }
 };
 MODULE_DEVICE_TABLE(hid, mosart_devices);

-----

--=20

Greetings from Frankfurt/Main, Germany.
Roland Baum
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
