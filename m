From: Karl Relton <karllinuxtest.relton@ntlworld.com>
Subject: [PATCH] hid: Add battery quirk for
 USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO keyboard
Date: Wed, 10 Dec 2014 11:57:45 +0000
Message-ID: <1418212665.4327.7.camel@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from know-smtprelay-omc-8.server.virginmedia.net ([80.0.253.72]:38567
	"EHLO know-smtprelay-omc-8.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbaLJMGE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2014 07:06:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Apple bluetooth wireless keyboard (sold in UK) has always reported zero
for battery strength no matter what condition the batteries are actually
in. With this patch applied (applying same quirk as other Apple
keyboards), the battery strength is now correctly reported.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
---
--- linux-3.16.0.orig/drivers/hid/hid-input.c	2014-12-10 10:59:37.864211493 +0000
+++ linux-3.16.0/drivers/hid/hid-input.c	2014-12-04 17:37:47.145113489 +0000
@@ -312,6 +312,9 @@ static const struct hid_device_id hid_ba
 			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
 	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
+	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
 	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{}


