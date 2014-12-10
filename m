From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: logitech-hidpp: do not return the name length
Date: Wed, 10 Dec 2014 17:21:09 -0500
Message-ID: <1418250070-28604-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We do not make any use of the actual name length get through
hidpp_get_device_name().

We can drop the extra code and simplify the API a bit.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1a6395d..3846305 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -461,7 +461,7 @@ static int hidpp_devicenametype_get_device_name(struct hidpp_device *hidpp,
 	return count;
 }
 
-static char *hidpp_get_device_name(struct hidpp_device *hidpp, u8 *name_length)
+static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 {
 	u8 feature_type;
 	u8 feature_index;
@@ -484,7 +484,6 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp, u8 *name_length)
 	if (!name)
 		goto out_err;
 
-	*name_length = __name_length + 1;
 	while (index < __name_length)
 		index += hidpp_devicenametype_get_device_name(hidpp,
 			feature_index, index, name + index,
@@ -493,7 +492,6 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp, u8 *name_length)
 	return name;
 
 out_err:
-	*name_length = 0;
 	return NULL;
 }
 
@@ -989,7 +987,6 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	char *name;
-	u8 name_length;
 
 	if (use_unifying)
 		/*
@@ -999,7 +996,7 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 		 */
 		name = hidpp_get_unifying_name(hidpp);
 	else
-		name = hidpp_get_device_name(hidpp, &name_length);
+		name = hidpp_get_device_name(hidpp);
 
 	if (!name)
 		hid_err(hdev, "unable to retrieve the name of the device");
@@ -1053,7 +1050,6 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	bool connected = atomic_read(&hidpp->connected);
 	struct input_dev *input;
 	char *name, *devm_name;
-	u8 name_length;
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		wtp_connect(hdev, connected);
@@ -1080,7 +1076,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		return;
 	}
 
-	name = hidpp_get_device_name(hidpp, &name_length);
+	name = hidpp_get_device_name(hidpp);
 	if (!name) {
 		hid_err(hdev, "unable to retrieve the name of the device");
 	} else {
-- 
2.1.0
