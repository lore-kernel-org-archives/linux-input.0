From: Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 1/2] hid: fix kworld fm700 radio hidquirks
Date: Thu, 13 Nov 2008 05:44:31 +0300
Message-ID: <1226544271.7246.12.camel@tux.localhost>
References: <491B3E90.5020307@gmail.com>
	 <alpine.LNX.1.10.0811130131190.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:22058 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYKMCoX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 21:44:23 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1233623ugf.37
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2008 18:44:21 -0800 (PST)
In-Reply-To: <alpine.LNX.1.10.0811130131190.32143@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jirislaby@gmail.com>
Cc: Tobias Lorenz <tobias.lorenz@gmx.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This patch fixes kworld fm700 usb-radio hidqurks that handled by
radio-si470x. Removes it from blacklist entry and places it in ignore
entry in hid/hid-core.c

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>

---

diff -r 43cd5fe03c6b linux/drivers/hid/hid-core.c
--- a/linux/drivers/hid/hid-core.c	Thu Nov 13 05:08:59 2008 +0300
+++ b/linux/drivers/hid/hid-core.c	Thu Nov 13 05:12:13 2008 +0300
@@ -1265,7 +1265,6 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERIC_13BA, USB_DEVICE_ID_GENERIC_13BA_KBD_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
@@ -1486,6 +1485,7 @@
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD, USB_DEVICE_ID_KWORLD_RADIO_FM700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_GPEN_560) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CASSY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POCKETCASSY) },


-- 
Best regards, Klimov Alexey

