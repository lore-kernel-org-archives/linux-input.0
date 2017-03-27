From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 05/19] HID: logitech-hidpp: create a capabilities bits field
Date: Mon, 27 Mar 2017 16:59:25 +0200
Message-ID: <20170327145939.29824-6-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Do not pollute the quirks bits field which is public API
with elements that are queried from the device.

Move the 2 battery capabilities into the new field.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v3
---
 drivers/hid/hid-logitech-hidpp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4031405..4ee466c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,11 +62,12 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
-#define HIDPP_QUIRK_HIDPP20_BATTERY		BIT(25)
-#define HIDPP_QUIRK_HIDPP10_BATTERY		BIT(26)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
+#define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
+#define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
+
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
  * as register access protocol or RAP, the second version hidpp20 is known as
@@ -138,6 +139,7 @@ struct hidpp_device {
 	struct input_dev *delayed_input;
 
 	unsigned long quirks;
+	unsigned long capabilities;
 
 	struct hidpp_battery battery;
 };
@@ -834,7 +836,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (hidpp->protocol_major >= 2) {
 		ret = hidpp20_initialize_battery(hidpp);
 		if (ret == 0)
-			hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
+			hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_BATTERY;
 	}
 
 	return ret;
@@ -2283,7 +2285,7 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (ret != 0)
 		return ret;
 
-	if (hidpp->quirks & HIDPP_QUIRK_HIDPP20_BATTERY) {
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
 		ret = hidpp20_battery_event(hidpp, data, size);
 		if (ret != 0)
 			return ret;
-- 
2.9.3
