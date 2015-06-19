From: Brent Adam <brentadamdev@gmail.com>
Subject: [PATCH v2] USB: HID: Fix fields from pen report ID being interpreted for multitouch.
Date: Fri, 19 Jun 2015 10:53:35 -0600
Message-ID: <1434732815-5172-1-git-send-email-brentadam@smarttech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34105 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbFSQyJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2015 12:54:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brent Adam <brentadam@smarttech.com>

Fields like HID_DG_CONTACTCOUNT are outside of the physical collection,
but within the application collection and report ID.  Make sure to catch
those fields that are not part of the mt_report_id and return 0 so they
can be processed with the pen.  Otherwise, the wrong HID_DG_CONTACTCOUNT
will be applied to cc_index and result in dereferencing a null pointer in
mt_touch_report.

Signed-off-by: Brent Adam <brentadam@smarttech.com>
---
 drivers/hid/hid-multitouch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6a9b05b..7c81125 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -778,9 +778,16 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	/*
 	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
 	 * for the stylus.
+	 * The check for mt_report_id ensures we don't process
+	 * HID_DG_CONTACTCOUNT from the pen report as it is outside the physical
+	 * collection, but within the report ID.
 	 */
 	if (field->physical == HID_DG_STYLUS)
 		return 0;
+	else if ((field->physical == 0) &&
+		 (field->report->id != td->mt_report_id) &&
+		 (td->mt_report_id != -1))
+		return 0;
 
 	if (field->application == HID_DG_TOUCHSCREEN ||
 	    field->application == HID_DG_TOUCHPAD)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
