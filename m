From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/3] HID: wacom: Replace WACOM_QUIRK_MONITOR with WACOM_DEVICETYPE_WL_MONITOR
Date: Mon,  3 Aug 2015 10:17:04 -0700
Message-ID: <1438622225-6718-2-git-send-email-killertofu@gmail.com>
References: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34462 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbbHCRRU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 13:17:20 -0400
Received: by pawu10 with SMTP id u10so17182489paw.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 10:17:20 -0700 (PDT)
In-Reply-To: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The monitor interface on the wireless receiver is more logically expressed
as a type of device instead of a quirk.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 6 +++---
 drivers/hid/wacom_wac.c | 4 +---
 drivers/hid/wacom_wac.h | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a334332..13834ba 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -454,7 +454,7 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 	 */
 	if (features->type == WIRELESS) {
 		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
-			features->device_type = WACOM_DEVICETYPE_NONE;
+			features->device_type = WACOM_DEVICETYPE_WL_MONITOR;
 		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
 			features->device_type |= WACOM_DEVICETYPE_TOUCH;
 		}
@@ -1581,7 +1581,7 @@ static int wacom_probe(struct hid_device *hdev,
 	if (error)
 		goto fail_shared_data;
 
-	if (!(features->quirks & WACOM_QUIRK_MONITOR) &&
+	if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
 		error = wacom_initialize_battery(wacom);
 		if (error)
@@ -1615,7 +1615,7 @@ static int wacom_probe(struct hid_device *hdev,
 	/* Note that if query fails it is not a hard failure */
 	wacom_query_tablet_data(hdev, features);
 
-	if (features->quirks & WACOM_QUIRK_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
 	if (wacom_wac->features.type == INTUOSHT && 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 280deb2..82bb0d3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2330,9 +2330,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 		/* monitor never has input and pen/touch have delayed create */
 		features->quirks |= WACOM_QUIRK_NO_INPUT;
 
-		/* must be monitor interface if no device_type set */
-		if (features->device_type == WACOM_DEVICETYPE_NONE) {
-			features->quirks |= WACOM_QUIRK_MONITOR;
+		if (features->device_type == WACOM_DEVICETYPE_WL_MONITOR) {
 			features->quirks |= WACOM_QUIRK_BATTERY;
 		}
 	}
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index c245a66..87df674 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -69,7 +69,6 @@
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
 #define WACOM_QUIRK_NO_INPUT		0x0002
-#define WACOM_QUIRK_MONITOR		0x0004
 #define WACOM_QUIRK_BATTERY		0x0008
 
 /* device types */
@@ -77,6 +76,7 @@
 #define WACOM_DEVICETYPE_PEN            0x0001
 #define WACOM_DEVICETYPE_TOUCH          0x0002
 #define WACOM_DEVICETYPE_PAD            0x0004
+#define WACOM_DEVICETYPE_WL_MONITOR     0x0008
 
 #define WACOM_VENDORDEFINED_PEN		0xff0d0001
 
-- 
2.4.6

