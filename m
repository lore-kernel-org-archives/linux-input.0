From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch: Add NOGET for Acomdata
Date: Tue, 1 Jan 2008 21:40:18 -0800
Message-ID: <20080101214018.671413f4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbYABFjR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jan 2008 00:39:17 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m025dGEs032026
	for <linux-input@vger.kernel.org>; Wed, 2 Jan 2008 00:39:16 -0500
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m025dGTw021374
	for <linux-input@vger.kernel.org>; Wed, 2 Jan 2008 00:39:16 -0500
Received: from localhost.localdomain (vpn-14-21.rdu.redhat.com [10.11.14.21])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with SMTP id m025dFPX017444
	for <linux-input@vger.kernel.org>; Wed, 2 Jan 2008 00:39:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch is for an external enclosure I have, it has two USB interfaces.
When usbhid issues GET REPORT, the device stops acting on storage commands
(replies with a STALL to all of them). It works ok with this patch.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a255285..a5bb3e6 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -108,6 +108,9 @@
 #define USB_DEVICE_ID_DELORME_EARTHMATE 0x0100
 #define USB_DEVICE_ID_DELORME_EM_LT20	0x0200
 
+#define USB_VENDOR_ID_DMI		0x0c0b	/* Found in Acomdata */
+#define USB_DEVICE_ID_DMI_ENC		0x5fab
+
 #define USB_VENDOR_ID_ELO		0x04E7
 #define USB_DEVICE_ID_ELO_TS2700	0x0020
 
@@ -530,6 +533,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC,    HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE, HID_QUIRK_NOGET },
