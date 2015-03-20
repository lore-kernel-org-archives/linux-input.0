From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] HID: wacom: remove hardcoded WACOM_QUIRK_MULTI_INPUT
Date: Fri, 20 Mar 2015 14:57:00 -0700
Message-ID: <1426888620-8643-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35937 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbCTV5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 17:57:05 -0400
Received: by pdbcz9 with SMTP id cz9so120157239pdb.3
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2015 14:57:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

The quirk was added for devices that support both pen and touch.
It decides if a device supports multiple inputs by hardcoded
feature type. However, for some devices, we do not know if they
support both before accessing their HID descriptors.

This patch relies on dynamically assigned device_type to make
the decision. Also, we make it certain that wacom_wac->shared
is always created. That is, the driver will not be loaded if
it fails to create wacom_wac->shared.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c | 24 +++++++++++-------------
 drivers/hid/wacom_wac.c | 18 ++++--------------
 drivers/hid/wacom_wac.h |  9 ++++-----
 3 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0568a7..a99e66f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1462,19 +1462,17 @@ static int wacom_probe(struct hid_device *hdev,
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
 		"%s Pad", features->name);
 
-	if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
-		/* Append the device type to the name */
-		if (features->device_type != BTN_TOOL_FINGER)
-			strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
-		else if (features->touch_max)
-			strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
-		else
-			strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
-
-		error = wacom_add_shared_data(hdev);
-		if (error)
-			goto fail_shared_data;
-	}
+	/* Append the device type to the name */
+	if (features->device_type != BTN_TOOL_FINGER)
+		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
+	else if (features->touch_max)
+		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
+	else
+		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+
+	error = wacom_add_shared_data(hdev);
+	if (error)
+		goto fail_shared_data;
 
 	if (!(features->quirks & WACOM_QUIRK_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bbe32d6..3b01dc9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -551,12 +551,9 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	   (features->type == CINTIQ && !(data[1] & 0x40)))
 		return 1;
 
-	if (wacom->shared) {
-		wacom->shared->stylus_in_proximity = true;
-
-		if (wacom->shared->touch_down)
-			return 1;
-	}
+	wacom->shared->stylus_in_proximity = true;
+	if (wacom->shared->touch_down)
+		return 1;
 
 	/* in Range while exiting */
 	if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
@@ -568,8 +565,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
-		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
-			wacom->shared->stylus_in_proximity = false;
+		wacom->shared->stylus_in_proximity = false;
 		wacom->reporting_data = false;
 
 		/* don't report exit if we don't know the ID */
@@ -2054,12 +2050,6 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 		features->y_max = 1023;
 	}
 
-	/* these device have multiple inputs */
-	if (features->type >= WIRELESS ||
-	    (features->type >= INTUOS5S && features->type <= INTUOSHT) ||
-	    (features->oVid && features->oPid))
-		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
-
 	/* quirk for bamboo touch with 2 low res touches */
 	if (features->type == BAMBOO_PT &&
 	    features->pktlen == WACOM_PKGLEN_BBTOUCH) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 021ee1c..309f219 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -69,11 +69,10 @@
 #define WACOM_REPORT_USB		192
 
 /* device quirks */
-#define WACOM_QUIRK_MULTI_INPUT		0x0001
-#define WACOM_QUIRK_BBTOUCH_LOWRES	0x0002
-#define WACOM_QUIRK_NO_INPUT		0x0004
-#define WACOM_QUIRK_MONITOR		0x0008
-#define WACOM_QUIRK_BATTERY		0x0010
+#define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
+#define WACOM_QUIRK_NO_INPUT		0x0002
+#define WACOM_QUIRK_MONITOR		0x0004
+#define WACOM_QUIRK_BATTERY		0x0008
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
-- 
1.9.1

