From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 13/25] HID: multitouch: optimize MosArt panels
Date: Fri, 25 Jan 2013 14:22:58 +0100
Message-ID: <1359120190-18281-14-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:36132 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab3AYNX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jan 2013 08:23:59 -0500
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Not very different in terms of processing time. However, this
uniformizes the handling of devices.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index d66c4d7..bc680b5 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1114,7 +1114,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_CRYSTALTOUCH_DUAL) },
 
 	/* MosArt panels */
-	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
 			USB_DEVICE_ID_ASUS_T91MT)},
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
-- 
1.8.1

