From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] HID: asus: Add touchpad max x/y and resolution info for the T200TA
Date: Fri,  5 Jan 2018 12:09:18 +0100
Message-ID: <20180105110919.30399-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeAELJY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jan 2018 06:09:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The Asus T200TA uses the same USB device-id for its keyboard dock as the
T100TA, but the touchpad has a different size and corresponding different
max x/y values.

Add a separate asus_touchpad_info struct for the T200TA and select this
based on the DMI product-name (as we are already doing for the T100HA),
so that we report the correct info to userspace.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6d2894b7d8e7..07525bc99b6a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -129,6 +129,15 @@ static const struct asus_touchpad_info asus_t100ha_tp = {
 	.max_contacts = 5,
 };
 
+static const struct asus_touchpad_info asus_t200ta_tp = {
+	.max_x = 3120,
+	.max_y = 1716,
+	.res_x = 30, /* units/mm */
+	.res_y = 28, /* units/mm */
+	.contact_size = 5,
+	.max_contacts = 5,
+};
+
 static const struct asus_touchpad_info asus_t100chi_tp = {
 	.max_x = 2640,
 	.max_y = 1320,
@@ -617,11 +626,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (intf->altsetting->desc.bInterfaceNumber == T100_TPAD_INTF) {
 			drvdata->quirks = QUIRK_SKIP_INPUT_MAPPING;
 			/*
-			 * The T100HA uses the same USB-ids as the T100TAF,
-			 * but has different max_x / max_y values.
+			 * The T100HA uses the same USB-ids as the T100TAF and
+			 * the T200TA uses the same USB-ids as the T100TA, while
+			 * both have different max x/y values as the T100TA[F].
 			 */
 			if (dmi_match(DMI_PRODUCT_NAME, "T100HAN"))
 				drvdata->tp = &asus_t100ha_tp;
+			else if (dmi_match(DMI_PRODUCT_NAME, "T200TA"))
+				drvdata->tp = &asus_t200ta_tp;
 			else
 				drvdata->tp = &asus_t100ta_tp;
 		}
-- 
2.14.3

