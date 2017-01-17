From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Fix sibling detection broken by 345857b
Date: Tue, 17 Jan 2017 15:38:58 -0800
Message-ID: <20170117233858.21546-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36322 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdAQXk5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Jan 2017 18:40:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so9115565pgf.3
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2017 15:39:18 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit 345857b included a change to the operation and location of the call
to 'wacom_add_shared_data' in 'wacom_parse_and_register'. The modifications
included moving it higher up so that it would occur before the call to
'wacom_retrieve_hid_descriptor'. This was done to prevent a crash that would
have occured when the report containing tablet offsets was fed into the
driver with 'wacom_hid_report_raw_event' (specifically: the various
'wacom_wac_*_report' functions were written with the assumption that they
would only be called once tablet setup had completed; 'wacom_wac_pen_report'
in particular dereferences 'shared' which wasn't yet allocated).

Moving the call to 'wacom_add_shared_data' effectively prevented the crash
but also broke the sibiling detection code which assumes that the HID
descriptor has been read and the various device_type flags set.

To fix this situation, we restore the original 'wacom_add_shared_data'
operation and location and instead implement an alternative change that
can also prevent the crash. Specifically, we notice that the report
functions mentioned above expect to be called only for input reports.
By adding a check, we can prevent feature reports (such as the offset
report) from causing trouble.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Tested-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c | 16 ++++++++--------
 drivers/hid/wacom_wac.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b9779bcbd140..8aeca038cc73 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -740,6 +740,11 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		return retval;
 	}
 
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
+		wacom_wac->shared->touch = hdev;
+	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
+		wacom_wac->shared->pen = hdev;
+
 out:
 	mutex_unlock(&wacom_udev_list_lock);
 	return retval;
@@ -2036,10 +2041,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail;
 
-	error = wacom_add_shared_data(hdev);
-	if (error)
-		goto fail;
-
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
 	 * into debug mode for the touch part.
@@ -2080,10 +2081,9 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	wacom_update_name(wacom, wireless ? " (WL)" : "");
 
-	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
-		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
-		wacom_wac->shared->pen = hdev;
+	error = wacom_add_shared_data(hdev);
+	if (error)
+		goto fail;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b1a9a3ca6d56..0884dc9554fd 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2187,6 +2187,16 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 
 	wacom_report_events(hdev, report);
 
+	/*
+	 * Non-input reports may be sent prior to the device being
+	 * completely initialized. Since only their events need
+	 * to be processed, exit after 'wacom_report_events' has
+	 * been called to prevent potential crashes in the report-
+	 * processing functions.
+	 */
+	if (report->type != HID_INPUT_REPORT)
+		return;
+
 	if (WACOM_PAD_FIELD(field)) {
 		wacom_wac_pad_battery_report(hdev, report);
 		if (wacom->wacom_wac.pad_input)
-- 
2.11.0

