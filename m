From: Jan Kandziora <jjj@gmx.de>
Subject: USB PCT multitouch 0eef:7200 (eGalaxTouch EXC7200-766Dv1.000)  PATCH
 INCLUDED
Date: Tue, 04 Mar 2014 22:58:33 +0100
Message-ID: <53164C89.1010803@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60536 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189AbaCDV6f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2014 16:58:35 -0500
Received: from janskasten.localdomain ([62.227.225.116]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MS5QA-1Wmxpz321y-00TBH5 for
 <linux-input@vger.kernel.org>; Tue, 04 Mar 2014 22:58:33 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I found this touchscreen chip built into the board of the Posiflex
XT3015 cash register hardware.


Sadly, it doesn't work with the current usbhid OOTB. As the device ID
isn't in the hid-ids.h, I tried adding it:

--------------------------------------------------------------------------
diff -urN linux-3.10.27.orig/drivers/hid/hid-ids.h
linux-3.10.27/drivers/hid/hid-ids.h
--- linux-3.10.27.orig/drivers/hid/hid-ids.h    2014-01-16
00:29:14.000000000 +0100
+++ linux-3.10.27/drivers/hid/hid-ids.h 2014-03-04 20:51:09.889687222 +0100
@@ -268,6 +268,7 @@
 #define USB_DEVICE_ID_DWAV_TOUCHCONTROLLER     0x0002
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480D      0x480d
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480E      0x480e
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7200      0x7200
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207      0x7207
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C      0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224      0x7224
diff -urN linux-3.10.27.orig/drivers/hid/hid-multitouch.c
linux-3.10.27/drivers/hid/hid-multitouch.c
--- linux-3.10.27.orig/drivers/hid/hid-multitouch.c     2014-01-16
00:29:14.000000000 +0100
+++ linux-3.10.27/drivers/hid/hid-multitouch.c  2014-03-04
20:48:35.351350357 +0100
@@ -1166,6 +1166,9 @@
                        USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
        { .driver_data = MT_CLS_EGALAX,
                HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+                       USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7200) },
+       { .driver_data = MT_CLS_EGALAX,
+               HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
                        USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
        { .driver_data = MT_CLS_EGALAX,
                HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
--------------------------------------------------------------------------

That works. Haven't checked the multitouch functions, though.


Kind regards

	Jan
