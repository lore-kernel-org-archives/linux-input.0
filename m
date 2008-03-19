From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch to add NOGET for DMI/Acomdata
Date: Wed, 19 Mar 2008 15:43:31 -0700
Message-ID: <20080319154331.c670489d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764848AbYCSWr5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 18:47:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2JMluSq020704
	for <linux-input@vger.kernel.org>; Wed, 19 Mar 2008 18:47:56 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2JMltWl000607
	for <linux-input@vger.kernel.org>; Wed, 19 Mar 2008 18:47:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: zaitcev@redhat.com

This must be the weirdest failure yet. My external disk stops processing
the storage commands the moment it receives a GET_REPORT. The firmware
does not crash; if I do rmmod hid, then SET-INTERFACE restores normal
operations. Still, I cannot live without the keyboard when I want backup
my files. Adding the NOGET quirk fixes this problem for me.

Signed-Off-By: Pete Zaitcev <zaitcev@redhat.com>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e29a057..d1ac267 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -124,6 +124,9 @@
 #define USB_DEVICE_ID_DELORME_EARTHMATE 0x0100
 #define USB_DEVICE_ID_DELORME_EM_LT20	0x0200
 
+#define USB_VENDOR_ID_DMI		0x0c0b	/* Found in Acomdata */
+#define USB_DEVICE_ID_DMI_ENC		0x5fab
+
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020
 
@@ -601,6 +604,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC,    HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_EXTREME_3D, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL, HID_QUIRK_NOGET },
