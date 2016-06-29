From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 2/2] HID: logitech-hidpp: remove HIDPP_QUIRK_CONNECT_EVENTS
Date: Wed, 29 Jun 2016 19:28:02 +1000
Message-ID: <1467192482-2723-2-git-send-email-peter.hutterer@who-t.net>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:29336 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbcF2JbM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 05:31:12 -0400
In-Reply-To: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Now that we can create battery power_supply sources, it's better to enable
the connect_event callback unconditionally.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1ead9f6..4eeb550 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -58,15 +58,14 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
 
 /* bits 2..20 are reserved for classes */
-#define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21)
+/* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_HIDPP20_BATTERY		BIT(25)
 #define HIDPP_QUIRK_HIDPP10_BATTERY		BIT(26)
 
-#define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
-						 HIDPP_QUIRK_CONNECT_EVENTS)
+#define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -2230,8 +2229,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	if (unlikely(hidpp_report_is_connect_event(report))) {
 		atomic_set(&hidpp->connected,
 				!(report->rap.params[0] & (1 << 6)));
-		if ((hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) &&
-		    (schedule_work(&hidpp->work) == 0))
+		if (schedule_work(&hidpp->work) == 0)
 			dbg_hid("%s: connect event already queued\n", __func__);
 		return 1;
 	}
@@ -2449,7 +2447,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
-		hidpp->quirks &= ~HIDPP_QUIRK_CONNECT_EVENTS;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
 	}
 
@@ -2535,12 +2532,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) {
-		/* Allow incoming packets */
-		hid_device_io_start(hdev);
+	/* Allow incoming packets */
+	hid_device_io_start(hdev);
 
-		hidpp_connect_event(hidpp);
-	}
+	hidpp_connect_event(hidpp);
 
 	return ret;
 
@@ -2593,7 +2588,7 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
-	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS | HIDPP_QUIRK_CLASS_K400 },
+	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.7.4

