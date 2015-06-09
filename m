From: Brent Adam <brentadamdev@gmail.com>
Subject: [PATCH] USB: HID: Fix fields from pen report ID being interpreted for multitouch.
Date: Tue,  9 Jun 2015 14:31:57 -0600
Message-ID: <1433881917-3627-1-git-send-email-brentadam@smarttech.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34166 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbFIUcc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 16:32:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brent Adam <brentadam@smarttech.com>

Fields like HID_DG_CONTACTCOUNT are outside of the physical collection,
but within the application collection and report ID.  Make sure to catch
those fields that are not part of the mt_report_id and return 0 so they
can be processed with the pen.  Otherwise, the wrong HID_DG_CONTACTCOUNT
will be applied to cc_index and result in dereferencing a null pointer in
mt_touch_report.

Signed-off-by: Brent Adam <brentadam@smarttech.com>
---
 drivers/hid/hid-multitouch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6a9b05b..2ee8800 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -781,6 +781,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	 */
 	if (field->physical == HID_DG_STYLUS)
 		return 0;
+	else if ((field->physical == 0) &&
+		 (field->report->id != td->mt_report_id))
+		return 0;
 
 	if (field->application == HID_DG_TOUCHSCREEN ||
 	    field->application == HID_DG_TOUCHPAD)
-- 
2.1.4

