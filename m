From: Pieter Hoekstra <pieter.hoekstra@5137.org>
Subject: [PATCH] HID: expand hid-topseed driver to support TopSeed RF Combo
 Device
Date: Sat, 26 Jun 2010 20:28:08 +0200
Message-ID: <4C2646B8.5050204@5137.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000009010400080409070501"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp09.online.nl ([194.134.42.54]:60424 "EHLO smtp09.online.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab0FZSiG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jun 2010 14:38:06 -0400
Received: from smtp09.online.nl (localhost [127.0.0.1])
	by smtp09.online.nl (Postfix) with ESMTP id B39E71E357
	for <linux-input@vger.kernel.org>; Sat, 26 Jun 2010 20:28:10 +0200 (CEST)
Received: from [192.168.1.10] (unknown [83.119.191.164])
	by smtp09.online.nl (Postfix) with ESMTP
	for <linux-input@vger.kernel.org>; Sat, 26 Jun 2010 20:28:09 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009010400080409070501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have created a small patch for the hid-topseed driver, to support the 
TopSeed Technology Corp. USB RF Combo Device.
The remote it is supporting for me, is branded as a "Conceptronic Lounge 
'n Look MCE" (CLLRCMCE) remote. I think this is a Topseed GP-type.

I initially created a new driver, but the added keys for the "BTC 
Emprex" remote, added almost all missing keys.

Greetings,
Pieter Hoekstra


--------------000009010400080409070501
Content-Type: text/x-patch;
 name="cllrcmce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cllrcmce.patch"

--- linux-2.6-518adaa/hid-topseed.c	2010-06-26 19:36:08.000000000 +0200
+++ hid/hid-topseed.c	2010-06-26 20:04:06.816617201 +0200
@@ -6,6 +6,8 @@
  *
  *  Modified to also support BTC "Emprex 3009URF III Vista MCE Remote" by
  *  Wayne Thomas 2010.
+ *  Added support for Topseed RF Combo (like Conceptronic CLLRCMCE remote)
+ *  by Pieter Hoekstra 2010.
  */
 
 /*
@@ -50,6 +52,7 @@ static int ts_input_mapping(struct hid_d
 	case 0x05c: ts_map_key_clear(KEY_GREEN);	break;
 	case 0x05d: ts_map_key_clear(KEY_YELLOW);	break;
 	case 0x05e: ts_map_key_clear(KEY_BLUE);		break;
+	case 0x027: ts_map_key_clear(KEY_SCREEN);	break;
 	default:
 		return 0;
 	}
@@ -59,6 +62,7 @@ static int ts_input_mapping(struct hid_d
 
 static const struct hid_device_id ts_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEEDTECH, USB_DEVICE_ID_TOPSEEDTECH_RFCOMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE) },
 	{ }
 };
--- linux-2.6-518adaa/hid-ids.h	2010-06-26 19:36:08.000000000 +0200
+++ hid/hid-ids.h	2010-06-26 19:53:54.957856940 +0200
@@ -460,6 +460,9 @@
 #define USB_VENDOR_ID_TOPSEED		0x0766
 #define USB_DEVICE_ID_TOPSEED_CYBERLINK	0x0204
 
+#define USB_VENDOR_ID_TOPSEEDTECH      0x1784
+#define USB_DEVICE_ID_TOPSEEDTECH_RFCOMBO      0x0004
+
 #define USB_VENDOR_ID_TURBOX		0x062a
 #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
 

--------------000009010400080409070501--
