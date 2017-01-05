From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: ignore Petzl USB headlamp
Date: Thu, 5 Jan 2017 14:31:54 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701051431270.28985@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42259 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935113AbdAENb4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 08:31:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

This headlamp contains a dummy HID descriptor which pretends to be a 
mouse-like device, but can't be used as a mouse at all.

Reported-by: Lukas Ocilka <lukas.ocilka@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cff060b56da9..ea36b557d5ee 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2496,6 +2496,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0002) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0003) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0004) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PETZL, USB_DEVICE_ID_PETZL_HEADLAMP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PHILIPS, USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
 #if IS_ENABLED(CONFIG_MOUSE_SYNAPTICS_USB)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 54bd22dc1411..f46f2c5117fa 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -816,6 +816,9 @@
 #define USB_VENDOR_ID_PETALYNX		0x18b1
 #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
 
+#define USB_VENDOR_ID_PETZL		0x2122
+#define USB_DEVICE_ID_PETZL_HEADLAMP	0x1234
+
 #define USB_VENDOR_ID_PHILIPS		0x0471
 #define USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE 0x0617
 
-- 
2.11.0
