From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] hid: blacklist Velleman data acquisition boards
Date: Wed, 13 Feb 2013 13:22:45 +0000
Message-ID: <1360761765-20142-1-git-send-email-abbotti@mev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:43474 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274Ab3BMNXC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2013 08:23:02 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ian Abbott <abbotti@mev.co.uk>

These are simple data acquistion boards, not HID devices and are handled
by the vmk80xx comedi driver.  At least one of them (10cf:5500)
misidentifies itself as a HID in its USB interface descriptor.  Ignore
all these devices.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/hid/hid-core.c | 8 ++++++++
 drivers/hid/hid-ids.h  | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index eb2ee11..8e055ea 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2228,6 +2228,14 @@ bool hid_ignore(struct hid_device *hdev)
 		    hdev->type != HID_TYPE_USBMOUSE)
 			return true;
 		break;
+	case USB_VENDOR_ID_VELLEMAN:
+		/* These are not HID devices.  They are handled by comedi. */
+		if ((hdev->product >= USB_DEVICE_ID_VELLEMAN_K8055_FIRST &&
+		     hdev->product <= USB_DEVICE_ID_VELLEMAN_K8055_LAST) ||
+		    (hdev->product >= USB_DEVICE_ID_VELLEMAN_K8061_FIRST &&
+		     hdev->product <= USB_DEVICE_ID_VELLEMAN_K8061_LAST))
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4dfa605..187de47 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -791,6 +791,12 @@
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19	0x0a19
 
+#define USB_VENDOR_ID_VELLEMAN		0x10cf
+#define USB_DEVICE_ID_VELLEMAN_K8055_FIRST	0x5500
+#define USB_DEVICE_ID_VELLEMAN_K8055_LAST	0x5503
+#define USB_DEVICE_ID_VELLEMAN_K8061_FIRST	0x8061
+#define USB_DEVICE_ID_VELLEMAN_K8061_LAST	0x8068
+
 #define USB_VENDOR_ID_VERNIER		0x08f7
 #define USB_DEVICE_ID_VERNIER_LABPRO	0x0001
 #define USB_DEVICE_ID_VERNIER_GOTEMP	0x0002
-- 
1.8.1.2

