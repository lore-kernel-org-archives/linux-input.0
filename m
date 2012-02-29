From: Diego Carrera Gallego <diegocarrera2000@gmail.com>
Subject: include patch to solve bug 916319
Date: Wed, 29 Feb 2012 11:56:17 +0100
Message-ID: <4F4E0451.5050106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020408060008090002050207"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55322 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab2B2K4Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 05:56:24 -0500
Received: by bkcik5 with SMTP id ik5so2136832bkc.19
        for <linux-input@vger.kernel.org>; Wed, 29 Feb 2012 02:56:23 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------020408060008090002050207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

According instructions of Joseph Salisbury at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916319

I send this patch, in order to include into ubuntu kernel,

Credits to: eran, http://thread.gmane.org/gmane.linux.bluez.kernel/18801


Changelog: Bluetooth: Adding USB device 13d3:3375 as an Atheros AR3012.
Description:

The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012
and requires a firmware to be uploaded before it's usable.

output of usb-devices for this module:
T:  Bus=01 Lev=02 Prnt=02 Port=07 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3375 Rev=00.02
S:  Manufacturer=Atheros Communications
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=Alaska Day 2006
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb


Signed-off-by: Diego Carrera diegocarrera2000@gmail.com


------------

Please, tell me if everything is ok

Thanks so much

Diego


--------------020408060008090002050207
Content-Type: text/x-patch;
 name="fix-load-new-devices-ux31e-bluetooth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix-load-new-devices-ux31e-bluetooth.patch"

diff -ur linux-3.2.5.orig/drivers/bluetooth/ath3k.c linux-3.2.5/drivers/bluetooth/ath3k.c
--- linux-3.2.5.orig/drivers/bluetooth/ath3k.c	2012-02-06 18:47:00.000000000 +0100
+++ linux-3.2.5/drivers/bluetooth/ath3k.c	2012-02-07 15:09:33.918295301 +0100
@@ -70,6 +70,7 @@
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3004) },
+	{ USB_DEVICE(0x13d3, 0x3375) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -86,6 +87,7 @@
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff -ur linux-3.2.5.orig/drivers/bluetooth/btusb.c linux-3.2.5/drivers/bluetooth/btusb.c
--- linux-3.2.5.orig/drivers/bluetooth/btusb.c	2012-02-06 18:47:00.000000000 +0100
+++ linux-3.2.5/drivers/bluetooth/btusb.c	2012-02-07 15:09:33.918295301 +0100
@@ -125,6 +125,7 @@
 
 	/* Atheros 3012 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },

--------------020408060008090002050207--
