From: Guilhem Lettron <guilhem@lettron.fr>
Subject: [PATCH] sensor-hub: Add in quirk for Lenovo Yogas with ITE
Date: Thu,  2 Jul 2015 12:12:13 +0200
Message-ID: <1435831933-2998-1-git-send-email-guilhem@lettron.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36178 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbGBKMc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jul 2015 06:12:32 -0400
Received: by widjy10 with SMTP id jy10so80453748wid.1
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2015 03:12:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Guilhem Lettron <guilhem@lettron.fr>

Like yogas with TEXAS INSTRUMENTS chips, yogas with ITE need
to be initialized with enumeration quirks.

Signed-off-by: Guilhem Lettron <guilhem@lettron.fr>
---
 drivers/hid/hid-ids.h        | 3 +++
 drivers/hid/hid-sensor-hub.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b04b082..9a59810 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -497,6 +497,9 @@
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
+#define USB_VENDOR_ID_ITE               0x048d
+#define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
+
 #define USB_VENDOR_ID_JABRA		0x0b0e
 #define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
 #define USB_DEVICE_ID_JABRA_SPEAK_510	0x0420
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 090a1ba..a76eb2a 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -774,6 +774,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_TEXAS_INSTRUMENTS,
 			USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_ITE,
+			USB_DEVICE_ID_ITE_LENOVO_YOGA),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
 		     HID_ANY_ID) },
 	{ }
-- 
2.1.4

