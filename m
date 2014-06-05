From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] HID: usbhid: remove unneeded initialization of quirks_param[]
Date: Thu,  5 Jun 2014 21:20:51 +0200
Message-ID: <1401996051-7951-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:59564 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbaFETVB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jun 2014 15:21:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The quirks_param array is located in the BSS, no need to explicitly
initialize it with NULL.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/hid/usbhid/hid-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 7b88f4cb99..37d2a95c5a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -58,7 +58,7 @@ module_param_named(ignoreled, ignoreled, uint, 0644);
 MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
 
 /* Quirks specified at module load time */
-static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = { [ 0 ... (MAX_USBHID_BOOT_QUIRKS - 1) ] = NULL };
+static char *quirks_param[MAX_USBHID_BOOT_QUIRKS];
 module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
 MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
 		" quirks=vendorID:productID:quirks"
-- 
1.7.10.4

