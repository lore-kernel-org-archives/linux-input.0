From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/2] HID: Add Oculus Rift CV1 id
Date: Wed,  7 Jun 2017 07:54:34 +0200
Message-ID: <20170607055435.25988-1-philipp.zabel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34781 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdFGFyx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 01:54:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>

Add VID/PID for Oculus Rift CV1.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/hid/hid-ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8ca1e8ce0af2..2953d53a8cc9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1133,6 +1133,9 @@
 #define USB_VENDOR_ID_MULTIPLE_1781	0x1781
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD	0x0a9d
 
+#define USB_VENDOR_ID_OCULUSVR		0x2833
+#define USB_DEVICE_ID_RIFT_CV1		0x0031
+
 #define USB_VENDOR_ID_DRACAL_RAPHNET	0x289b
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
-- 
2.11.0

