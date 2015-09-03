From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: logitech-hidpp: split HIDPP_QUIRK_DELAYED_INIT in two
Date: Thu,  3 Sep 2015 09:08:29 -0400
Message-ID: <1441285710-21276-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbbICNIe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Sep 2015 09:08:34 -0400
In-Reply-To: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: simon@mungewell.org, BALATON Zoltan <balaton@eik.bme.hu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

HIDPP_QUIRK_DELAYED_INIT means two things currently:
- we want to delay the initialization process
- we do not want hid to create an input device based on the report
  descriptor.

This should actually be 2 different quirks so we can have special connect
events while still having HID creating the input for us.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4841964..81d1bc0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -43,8 +43,12 @@ MODULE_PARM_DESC(disable_raw_mode,
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
 
 /* bits 2..20 are reserved for classes */
-#define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
+#define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21)
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
+#define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
+
+#define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
+						 HIDPP_QUIRK_CONNECT_EVENTS)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -1203,7 +1207,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	if (unlikely(hidpp_report_is_connect_event(report))) {
 		atomic_set(&hidpp->connected,
 				!(report->rap.params[0] & (1 << 6)));
-		if ((hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) &&
+		if ((hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) &&
 		    (schedule_work(&hidpp->work) == 0))
 			dbg_hid("%s: connect event already queued\n", __func__);
 		return 1;
@@ -1333,18 +1337,21 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (!connected || hidpp->delayed_input)
 		return;
 
+	/* the device is already connected, we can ask for its name and
+	 * protocol */
 	if (!hidpp->protocol_major) {
 		ret = !hidpp_is_connected(hidpp);
 		if (ret) {
 			hid_err(hdev, "Can not get the protocol version.\n");
 			return;
 		}
+		hid_info(hdev, "HID++ %u.%u device connected.\n",
+			 hidpp->protocol_major, hidpp->protocol_minor);
 	}
 
-	/* the device is already connected, we can ask for its name and
-	 * protocol */
-	hid_info(hdev, "HID++ %u.%u device connected.\n",
-		 hidpp->protocol_major, hidpp->protocol_minor);
+	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
+		/* if HID created the input nodes for us, we can stop now */
+		return;
 
 	if (!hidpp->name || hidpp->name == hdev->name) {
 		name = hidpp_get_device_name(hidpp);
@@ -1397,7 +1404,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
-		hidpp->quirks &= ~HIDPP_QUIRK_DELAYED_INIT;
+		hidpp->quirks &= ~HIDPP_QUIRK_CONNECT_EVENTS;
+		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
@@ -1448,7 +1456,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Block incoming packets */
 	hid_device_io_stop(hdev);
 
-	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
+	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
 	ret = hid_hw_start(hdev, connect_mask);
@@ -1457,7 +1465,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_hw_start_fail;
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) {
+	if (hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) {
 		/* Allow incoming packets */
 		hid_device_io_start(hdev);
 
-- 
2.4.3

