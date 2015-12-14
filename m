From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] hid-input: ignore the battery in OKLICK Laser BTmouse
Date: Mon, 14 Dec 2015 17:42:26 +0500
Message-ID: <1450096946-1376-1-git-send-email-patrakov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33747 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbLNMmw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 07:42:52 -0500
Received: by mail-wm0-f51.google.com with SMTP id n186so43810666wmn.0
        for <linux-input@vger.kernel.org>; Mon, 14 Dec 2015 04:42:52 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, "Alexander E. Patrakov" <patrakov@gmail.com>

This mouse, when asked about the battery, ceases to report movements and
clicks. So just don't ask.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 drivers/hid/hid-input.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2ba6bf6..0869fae 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -303,6 +303,7 @@ static enum power_supply_property hidinput_battery_props[] = {
 
 #define HID_BATTERY_QUIRK_PERCENT	(1 << 0) /* always reports percent */
 #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
+#define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the battery */
 
 static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
@@ -320,6 +321,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
 	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
+		USB_DEVICE_ID_ELECOM_BM084),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
@@ -408,6 +412,14 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (dev->battery != NULL)
 		goto out;	/* already initialized? */
 
+	quirks = find_battery_quirk(dev);
+
+	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
+		dev->bus, dev->vendor, dev->product, dev->version, quirks);
+
+	if (quirks & HID_BATTERY_QUIRK_IGNORE)
+		goto out;
+
 	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
 	if (psy_desc == NULL)
 		goto out;
@@ -424,11 +436,6 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	psy_desc->use_for_apm = 0;
 	psy_desc->get_property = hidinput_get_battery_property;
 
-	quirks = find_battery_quirk(dev);
-
-	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
-		dev->bus, dev->vendor, dev->product, dev->version, quirks);
-
 	min = field->logical_minimum;
 	max = field->logical_maximum;
 
-- 
2.6.4

