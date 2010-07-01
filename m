From: Pieter Hoekstra <pieter.hoekstra@5137.org>
Subject: Re: [PATCH] HID: expand hid-topseed driver to support TopSeed RF
 Combo Device
Date: Thu, 01 Jul 2010 23:46:25 +0200
Message-ID: <4C2D0CB1.4070404@5137.org>
References: <4C2646B8.5050204@5137.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010608060106090905060305"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.online.nl ([194.134.42.52]:43189 "EHLO smtp07.online.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759061Ab0GAVq2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Jul 2010 17:46:28 -0400
In-Reply-To: <4C2646B8.5050204@5137.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, kees.bakker@xs4all.nl

This is a multi-part message in MIME format.
--------------010608060106090905060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Op 26-06-10 20:28, Pieter Hoekstra schreef:
> I have created a small patch for the hid-topseed driver, to support 
> the TopSeed Technology Corp. USB RF Combo Device.
> The remote it is supporting for me, is branded as a "Conceptronic 
> Lounge 'n Look MCE" (CLLRCMCE) remote. I think this is a Topseed GP-type.
>
> I initially created a new driver, but the added keys for the "BTC 
> Emprex" remote, added almost all missing keys.
>
> Greetings,
> Pieter Hoekstra
>

Apparently, I missed a few lines in the patch, thanks for Kees Bakker 
for pointing it out.

I've attached a new patch!

Greetings,
Pieter Hoekstra

--------------010608060106090905060305
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
 
--- linux-2.6-518adaa/hid-core.c	2010-06-26 19:36:08.000000000 +0200
+++ hid/hid-core.c	2010-07-01 23:40:18.588363154 +0200
@@ -1357,6 +1357,7 @@ static const struct hid_device_id hid_bl
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEEDTECH, USB_DEVICE_ID_TOPSEEDTECH_RFCOMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },

--------------010608060106090905060305--
