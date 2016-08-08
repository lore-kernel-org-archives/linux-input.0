From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v4 2/2] HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC
Date: Mon,  8 Aug 2016 12:06:30 -0700
Message-ID: <20160808190630.7641-2-killertofu@gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
 <20160808190630.7641-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36403 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbcHHTGs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Aug 2016 15:06:48 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so24443761pab.3
        for <linux-input@vger.kernel.org>; Mon, 08 Aug 2016 12:06:48 -0700 (PDT)
In-Reply-To: <20160808190630.7641-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The 'oVid' and 'oPid' variables used by wacom_are_sibling are a hacky
solution to the problem of the driver historically having few good
heuristics to use in determining if two devices should be considered
siblings or not. While it works well enough for explicitly supported
devices, it offers no help for HID_GENERIC devices. Now that we have
a bit more information (e.g. direct/indirect) available to us though,
we should make use of it it to improve the pairing of such devices.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changes from v3:
 * No longer remove oVid/oPid checks and variables
 * Modified oVid/oPid checks to recognize HID_ANY_ID as a wildcard
 * Moved path check towards beginning of function as it is common
   between HID_GENERIC and explicitly-supported devices
 * Removed heuristic which required deviecs with different VID/PIDs
   to be direct input.

 drivers/hid/wacom_sys.c | 83 ++++++++++++++++++++++++++++++++++++++++++-------
 drivers/hid/wacom_wac.c |  2 +-
 2 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index edde881..5e7a564 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -527,36 +527,95 @@ struct wacom_hdev_data {
 static LIST_HEAD(wacom_udev_list);
 static DEFINE_MUTEX(wacom_udev_list_lock);
 
+static bool compare_device_paths(struct hid_device *hdev_a,
+		struct hid_device *hdev_b, char separator)
+{
+	int n1 = strrchr(hdev_a->phys, separator) - hdev_a->phys;
+	int n2 = strrchr(hdev_b->phys, separator) - hdev_b->phys;
+
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+		return false;
+
+	return !strncmp(hdev_a->phys, hdev_b->phys, n1);
+}
+
 static bool wacom_are_sibling(struct hid_device *hdev,
 		struct hid_device *sibling)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_features *features = &wacom->wacom_wac.features;
-	int vid = features->oVid;
-	int pid = features->oPid;
-	int n1,n2;
+	struct wacom *sibling_wacom = hid_get_drvdata(sibling);
+	struct wacom_features *sibling_features = &sibling_wacom->wacom_wac.features;
+	__u32 oVid = features->oVid ? features->oVid : hdev->vendor;
+	__u32 oPid = features->oPid ? features->oPid : hdev->product;
 
-	if (vid == 0 && pid == 0) {
-		vid = hdev->vendor;
-		pid = hdev->product;
+	/* The defined oVid/oPid must match that of the sibling */
+	if (features->oVid != HID_ANY_ID && sibling->vendor != oVid)
+		return false;
+	if (features->oPid != HID_ANY_ID && sibling->product != oPid)
+		return false;
+
+	/*
+	 * Devices with the same VID/PID must share the same physical
+	 * device path, while those with different VID/PID must share
+	 * the same physical parent device path.
+	 */
+	if (hdev->vendor == sibling->vendor && hdev->product == sibling->product) {
+		if (!compare_device_paths(hdev, sibling, '/'))
+			return false;
+	} else {
+		if (!compare_device_paths(hdev, sibling, '.'))
+			return false;
 	}
 
-	if (vid != sibling->vendor || pid != sibling->product)
+	/* Skip the remaining heuristics unless you are a HID_GENERIC device */
+	if (features->type != HID_GENERIC)
+		return true;
+
+	/*
+	 * Direct-input devices may not be siblings of indirect-input
+	 * devices.
+	 */
+	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) &&
+	    !(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
-	/* Compare the physical path. */
-	n1 = strrchr(hdev->phys, '.') - hdev->phys;
-	n2 = strrchr(sibling->phys, '.') - sibling->phys;
-	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+	/*
+	 * Indirect-input devices may not be siblings of direct-input
+	 * devices.
+	 */
+	if (!(features->device_type & WACOM_DEVICETYPE_DIRECT) &&
+	    (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+		return false;
+
+	/* Pen devices may only be siblings of touch devices */
+	if ((features->device_type & WACOM_DEVICETYPE_PEN) &&
+	    !(sibling_features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return false;
+
+	/* Touch devices may only be siblings of pen devices */
+	if ((features->device_type & WACOM_DEVICETYPE_TOUCH) &&
+	    !(sibling_features->device_type & WACOM_DEVICETYPE_PEN))
 		return false;
 
-	return !strncmp(hdev->phys, sibling->phys, n1);
+	/*
+	 * No reason could be found for these two devices to NOT be
+	 * siblings, so there's a good chance they ARE siblings
+	 */
+	return true;
 }
 
 static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 {
 	struct wacom_hdev_data *data;
 
+	/* Try to find an already-probed interface from the same device */
+	list_for_each_entry(data, &wacom_udev_list, list) {
+		if (compare_device_paths(hdev, data->dev, '/'))
+			return data;
+	}
+
+	/* Fallback to finding devices that appear to be "siblings" */
 	list_for_each_entry(data, &wacom_udev_list, list) {
 		if (wacom_are_sibling(hdev, data->dev)) {
 			kref_get(&data->kref);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cfefed0..1b754b4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3521,7 +3521,7 @@ static const struct wacom_features wacom_features_0x343 =
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
-	{ "Wacom HID", .type = HID_GENERIC };
+	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
 
 #define USB_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_USB, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-- 
2.9.2

