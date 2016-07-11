From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Replace 'oVid' and 'oPid' with heuristics
Date: Mon, 11 Jul 2016 11:07:11 -0700
Message-ID: <20160711180711.17537-2-killertofu@gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35552 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbcGKSHV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 14:07:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id t190so13774082pfb.2
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2016 11:07:21 -0700 (PDT)
In-Reply-To: <20160711180711.17537-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The 'oVid' and 'oPid' variables used by wacom_are_sibling are a hacky
solution to the problem of the driver having few good heuristics to use
to determine if two devices should be considered siblings or not. This
commit replaces them with heuristics that leverage the information we
have available to determine if two devices are likely siblings or not.

Written out, the new heuristics are basically:

  * If a device with the same VID/PID as that being probed already exists,
    it should be preferentially checked for siblingship.

  * Two HID devices which have the same VID/PID are not siblings if they
    are not part of the same logical hardware device.

  * Two HID devices which have different VID/PIDs are not siblings if
    they have different parent (e.g. USB hub) devices.

  * Devices without the WACOM_DEVICETYPE_DIRECT flag set may only be
    siblings of devies with the same VID/PID (Wacom often splits their
    direct input tablets into two devices to make it easier to meet
    Microsoft's touchscreen requirements).

  * Two devices which have different "directness" are not siblings.

  * Two devices which do not serve complementary roles (i.e. pen/touch)
    are not siblings.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 58 +++++++++++++++++++++++++++++++++++++++----------
 drivers/hid/wacom_wac.c | 41 ++++++++++++++--------------------
 drivers/hid/wacom_wac.h |  2 --
 3 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4a0bb6f..a5bc038 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -532,31 +532,65 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_features *features = &wacom->wacom_wac.features;
-	int vid = features->oVid;
-	int pid = features->oPid;
-	int n1,n2;
+	struct wacom *sibling_wacom = hid_get_drvdata(sibling);
+	struct wacom_features *sibling_features = &sibling_wacom->wacom_wac.features;
+	int n1, n2;
 
-	if (vid == 0 && pid == 0) {
-		vid = hdev->vendor;
-		pid = hdev->product;
+	/* Compare the physical path. Require devices with the same
+	 * PID to share the same device, and devices with different
+	 * PIDs to share parent devices.
+	 */
+	if (hdev->vendor == sibling->vendor && hdev->product == sibling->product) {
+		n1 = strrchr(hdev->phys, '/') - hdev->phys;
+		n2 = strrchr(sibling->phys, '/') - sibling->phys;
+	}
+	else {
+		n1 = strrchr(hdev->phys, '.') - hdev->phys;
+		n2 = strrchr(sibling->phys, '.') - sibling->phys;
 	}
 
-	if (vid != sibling->vendor || pid != sibling->product)
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
 		return false;
 
-	/* Compare the physical path. */
-	n1 = strrchr(hdev->phys, '.') - hdev->phys;
-	n2 = strrchr(sibling->phys, '.') - sibling->phys;
-	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+	if (strncmp(hdev->phys, sibling->phys, n1))
+		return false;
+
+	if (hdev->vendor != sibling->vendor || hdev->product != sibling->product) {
+		if(!(features->device_type & WACOM_DEVICETYPE_DIRECT))
+			return false;
+	}
+
+	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) !=
+	    (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
-	return !strncmp(hdev->phys, sibling->phys, n1);
+	if ((features->device_type & WACOM_DEVICETYPE_PEN) &&
+	    !(sibling_features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return false;
+
+	if ((features->device_type & WACOM_DEVICETYPE_TOUCH) &&
+	    !(sibling_features->device_type & WACOM_DEVICETYPE_PEN))
+		return false;
+
+	return true;
 }
 
 static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 {
 	struct wacom_hdev_data *data;
 
+	/* Try to find an already-probed interface from the same device */
+	list_for_each_entry(data, &wacom_udev_list, list) {
+		int n1, n2;
+		n1 = strrchr(hdev->phys, '/') - hdev->phys;
+		n2 = strrchr(data->dev->phys, '/') - data->dev->phys;
+		if (n1 != n2 || n1 <= 0 || n2 <= 0)
+			continue;
+		if (!strncmp(hdev->phys, data->dev->phys, n1))
+			return data;
+	}
+
+	/* Fallback to finding devices that appear to be "siblings" */
 	list_for_each_entry(data, &wacom_udev_list, list) {
 		if (wacom_are_sibling(hdev, data->dev)) {
 			kref_get(&data->kref);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2523a29..cb6fc63 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3229,11 +3229,10 @@ static const struct wacom_features wacom_features_0xF4 =
 static const struct wacom_features wacom_features_0xF8 =
 	{ "Wacom Cintiq 24HD touch", 104080, 65200, 2047, 63, /* Pen */
 	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xF6 =
 	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x32A =
 	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047, 63,
@@ -3242,11 +3241,10 @@ static const struct wacom_features wacom_features_0x32A =
 static const struct wacom_features wacom_features_0x32B =
 	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
 	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32C };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x32C =
 	{ "Wacom Cintiq 27QHD touch", .type = WACOM_27QHDT,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32B, .touch_max = 10 };
+	  .touch_max = 10 };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX", 87200, 65600, 1023, 63,
 	  CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
@@ -3263,11 +3261,10 @@ static const struct wacom_features wacom_features_0x304 =
 static const struct wacom_features wacom_features_0x333 =
 	{ "Wacom Cintiq 13HD touch", 59152, 33448, 2047, 63,
 	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x335 };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x335 =
 	{ "Wacom Cintiq 13HD touch", .type = WACOM_24HDT, /* Touch */
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x333, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xC7 =
 	{ "Wacom DTU1931", 37832, 30305, 511, 0,
@@ -3298,11 +3295,10 @@ static const struct wacom_features wacom_features_0x57 =
 static const struct wacom_features wacom_features_0x59 = /* Pen */
 	{ "Wacom DTH2242", 95640, 54060, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5D = /* Touch */
 	{ "Wacom DTH2242",       .type = WACOM_24HDT,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xCC =
 	{ "Wacom Cintiq 21UX2", 86800, 65200, 2047, 63,
@@ -3315,11 +3311,10 @@ static const struct wacom_features wacom_features_0xFA =
 static const struct wacom_features wacom_features_0x5B =
 	{ "Wacom Cintiq 22HDT", 95440, 53860, 2047, 63,
 	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5E =
 	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5b, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x90 =
 	{ "Wacom ISDv4 90", 26202, 16325, 255, 0,
@@ -3461,20 +3456,18 @@ static const struct wacom_features wacom_features_0x6004 =
 static const struct wacom_features wacom_features_0x307 =
 	{ "Wacom ISDv5 307", 59152, 33448, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x309 =
 	{ "Wacom ISDv5 309", .type = WACOM_24HDT, /* Touch */
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x0307, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x30A =
 	{ "Wacom ISDv5 30A", 59152, 33448, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30C };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x30C =
 	{ "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30A, .touch_max = 10,
+	  .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x318 =
 	{ "Wacom USB Bamboo PAD", 4095, 4095, /* Touch */
@@ -3485,11 +3478,9 @@ static const struct wacom_features wacom_features_0x319 =
 static const struct wacom_features wacom_features_0x325 =
 	{ "Wacom ISDv5 325", 59552, 33848, 2047, 63,
 	  CINTIQ_COMPANION_2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 11,
-	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
-	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x326 };
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x326 = /* Touch */
-	{ "Wacom ISDv5 326", .type = HID_GENERIC, .oVid = USB_VENDOR_ID_WACOM,
-	  .oPid = 0x325 };
+	{ "Wacom ISDv5 326", .type = HID_GENERIC };
 static const struct wacom_features wacom_features_0x323 =
 	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
 	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 7ad6273..a5bd05a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -181,8 +181,6 @@ struct wacom_features {
 	int tilt_fuzz;
 	unsigned quirks;
 	unsigned touch_max;
-	int oVid;
-	int oPid;
 	int pktlen;
 	bool check_for_hid_type;
 	int hid_type;
-- 
2.9.0

