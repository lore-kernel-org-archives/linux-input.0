From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 5/5] HID: Correct Logitech order in hid-ids.h
Date: Tue, 19 Feb 2013 20:25:14 -0700
Message-ID: <1361330714-5217-5-git-send-email-simon@mungewell.org>
References: <1361330714-5217-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-04.shaw.ca ([64.59.134.12]:34066 "EHLO
	smtp-out-04.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933993Ab3BTDew (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Feb 2013 22:34:52 -0500
In-Reply-To: <1361330714-5217-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org

Reorders a couple of device IDs (Logitech controllers) to ensure
that they are in hexidecimal order.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-ids.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 34e2547..865492c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -525,8 +525,8 @@
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
-#define USB_DEVICE_ID_LOGITECH_WHEEL	0xc294
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_FFG	0xc293
+#define USB_DEVICE_ID_LOGITECH_WHEEL	0xc294
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL	0xc295
 #define USB_DEVICE_ID_LOGITECH_DFP_WHEEL	0xc298
 #define USB_DEVICE_ID_LOGITECH_G25_WHEEL	0xc299
-- 
1.7.10.4

