From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 2/3] HID: multitouch: do not retrieve all reports for all devices
Date: Fri, 25 Nov 2016 14:27:22 +0100
Message-ID: <1480080443-7636-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753631AbcKYN1d (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 08:27:33 -0500
In-Reply-To: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dennis Chen <barracks510@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We already have in place a quirk for Windows 8 devices, but it looks
like the Surface Cover are not conforming to it.
Given that we are only interested in 3 feature reports (the ones that
the Windows driver retrieves), we should be safe to unconditionally apply
the quirk to everybody.

In case there is an issue with a controller, we can always mark it as such
in the transport driver, and hid-multitouch won't try to retrieve the
feature report.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/hid/hid-multitouch.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a65a4c5..8979359 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -108,6 +108,7 @@ struct mt_device {
 	int cc_value_index;	/* contact count value index in the field */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
+	unsigned long initial_quirks;	/* initial quirks state */
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
 	__s16 maxcontact_report_id;	/* Maximum Contact Number HID feature,
@@ -318,13 +319,10 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 	u8 *buf;
 
 	/*
-	 * Only fetch the feature report if initial reports are not already
-	 * been retrieved. Currently this is only done for Windows 8 touch
-	 * devices.
+	 * Do not fetch the feature report if the device has been explicitly
+	 * marked as non-capable.
 	 */
-	if (!(hdev->quirks & HID_QUIRK_NO_INIT_REPORTS))
-		return;
-	if (td->mtclass.name != MT_CLS_WIN_8)
+	if (td->initial_quirks & HID_QUIRK_NO_INIT_REPORTS)
 		return;
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
@@ -1091,36 +1089,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	/* This allows the driver to correctly support devices
-	 * that emit events over several HID messages.
-	 */
-	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
-
-	/*
-	 * This allows the driver to handle different input sensors
-	 * that emits events through different reports on the same HID
-	 * device.
-	 */
-	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
-	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
-
-	/*
-	 * Handle special quirks for Windows 8 certified devices.
-	 */
-	if (id->group == HID_GROUP_MULTITOUCH_WIN_8)
-		/*
-		 * Some multitouch screens do not like to be polled for input
-		 * reports. Fortunately, the Win8 spec says that all touches
-		 * should be sent during each report, making the initialization
-		 * of input reports unnecessary.
-		 *
-		 * In addition some touchpads do not behave well if we read
-		 * all feature reports from them. Instead we prevent
-		 * initial report fetching and then selectively fetch each
-		 * report we are interested in.
-		 */
-		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	td = devm_kzalloc(&hdev->dev, sizeof(struct mt_device), GFP_KERNEL);
 	if (!td) {
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
@@ -1144,6 +1112,39 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;
 
+	/*
+	 * Store the initial quirk state
+	 */
+	td->initial_quirks = hdev->quirks;
+
+	/* This allows the driver to correctly support devices
+	 * that emit events over several HID messages.
+	 */
+	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
+
+	/*
+	 * This allows the driver to handle different input sensors
+	 * that emits events through different reports on the same HID
+	 * device.
+	 */
+	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
+
+	/*
+	 * Some multitouch screens do not like to be polled for input
+	 * reports. Fortunately, the Win8 spec says that all touches
+	 * should be sent during each report, making the initialization
+	 * of input reports unnecessary. For Win7 devices, well, let's hope
+	 * they will still be happy (this is only be a problem if a touch
+	 * was already there while probing the device).
+	 *
+	 * In addition some touchpads do not behave well if we read
+	 * all feature reports from them. Instead we prevent
+	 * initial report fetching and then selectively fetch each
+	 * report we are interested in.
+	 */
+	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
 	ret = hid_parse(hdev);
 	if (ret != 0)
 		return ret;
@@ -1212,8 +1213,11 @@ static int mt_resume(struct hid_device *hdev)
 
 static void mt_remove(struct hid_device *hdev)
 {
+	struct mt_device *td = hid_get_drvdata(hdev);
+
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
+	hdev->quirks = td->initial_quirks;
 }
 
 /*
-- 
2.7.4

