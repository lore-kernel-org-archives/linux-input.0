From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: holtek: Holtek devices depends on USB_HID
Date: Thu,  7 Mar 2013 10:48:29 +0100
Message-ID: <1362649709-9608-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab3CGJtS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Mar 2013 04:49:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

In the HID drivers tranport cleanup series, I removed the dependency
between hid-holtek and usbhid. This was wrong as hid-holtek.c relies
extensively on usb calls.

This fixes compilation error when CONFIG_USB_SUPPORT is not enabled.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 3abb11f..613083a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -215,7 +215,7 @@ config HID_EZKEY
 
 config HID_HOLTEK
 	tristate "Holtek HID devices"
-	depends on HID
+	depends on USB_HID
 	---help---
 	Support for Holtek based devices:
 	  - Holtek On Line Grip based game controller
-- 
1.8.1.4

