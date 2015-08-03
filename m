From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Remove WACOM_QUIRK_NO_INPUT
Date: Mon,  3 Aug 2015 10:17:05 -0700
Message-ID: <1438622225-6718-3-git-send-email-killertofu@gmail.com>
References: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33308 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbbHCRRW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 13:17:22 -0400
Received: by padck2 with SMTP id ck2so94488345pad.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 10:17:21 -0700 (PDT)
In-Reply-To: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

WACOM_QUIRK_NO_INPUT is a signal to the driver that input devices
should not be created for a particular device. This quirk was used by
the wireless receiver to prevent any devices from being created during
the initial probe (defering it instead until we got a tablet connection
event in 'wacom_wireless_work').

This quirk is not necessary now that a device_type is associated with each
device. Any input device allocated by 'wacom_allocate_inputs' which is
not necessary for a particular device is freed in 'wacom_register_inputs'.
In particular, none of the wireless receivers devices have the pen, pad,
or touch device types set so the same effect is achieved without the need
to be explicit.

We now return early in wacom_retrieve_hid_descriptor for wireless devices
(to prevent the device_type from being overridden) but since we ignore the
HID descriptor for the wireless reciever anyway, this is not an issue.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 24 ++++++++++--------------
 drivers/hid/wacom_wac.c |  4 ----
 drivers/hid/wacom_wac.h |  1 -
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 13834ba..20d15c5 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -453,11 +453,11 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 	 * interface number.
 	 */
 	if (features->type == WIRELESS) {
-		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
+		if (intf->cur_altsetting->desc.bInterfaceNumber == 0)
 			features->device_type = WACOM_DEVICETYPE_WL_MONITOR;
-		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
-			features->device_type |= WACOM_DEVICETYPE_TOUCH;
-		}
+		else
+			features->device_type = WACOM_DEVICETYPE_NONE;
+		return;
 	}
 
 	wacom_parse_hid(hdev, features);
@@ -1531,11 +1531,9 @@ static int wacom_probe(struct hid_device *hdev,
 	mutex_init(&wacom->lock);
 	INIT_WORK(&wacom->work, wacom_wireless_work);
 
-	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
-		error = wacom_allocate_inputs(wacom);
-		if (error)
-			goto fail_allocate_inputs;
-	}
+	error = wacom_allocate_inputs(wacom);
+	if (error)
+		goto fail_allocate_inputs;
 
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
@@ -1588,11 +1586,9 @@ static int wacom_probe(struct hid_device *hdev,
 			goto fail_battery;
 	}
 
-	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
-		error = wacom_register_inputs(wacom);
-		if (error)
-			goto fail_register_inputs;
-	}
+	error = wacom_register_inputs(wacom);
+	if (error)
+		goto fail_register_inputs;
 
 	if (hdev->bus == BUS_BLUETOOTH) {
 		error = device_create_file(&hdev->dev, &dev_attr_speed);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 82bb0d3..4d11c78 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2326,10 +2326,6 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	}
 
 	if (features->type == WIRELESS) {
-
-		/* monitor never has input and pen/touch have delayed create */
-		features->quirks |= WACOM_QUIRK_NO_INPUT;
-
 		if (features->device_type == WACOM_DEVICETYPE_WL_MONITOR) {
 			features->quirks |= WACOM_QUIRK_BATTERY;
 		}
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 87df674..6233eea 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -68,7 +68,6 @@
 
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
-#define WACOM_QUIRK_NO_INPUT		0x0002
 #define WACOM_QUIRK_BATTERY		0x0008
 
 /* device types */
-- 
2.4.6

