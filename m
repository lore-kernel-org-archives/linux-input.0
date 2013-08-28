From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Wed, 28 Aug 2013 22:31:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57991 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab3H1Ubk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:31:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

From: Kees Cook <keescook@chromium.org>

When working on report indexes, always validate that they are in bounds.
Without this, a HID device could report a malicious feature report that
could trick the driver into a heap overflow:

[  634.885003] usb 1-1: New USB device found, idVendor=0596, idProduct=0500
...
[  676.469629] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten

CVE-2013-2897

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-multitouch.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index cb0e361..2aa275e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -330,9 +330,18 @@ static void mt_feature_mapping(struct hid_device *hdev,
 				break;
 			}
 		}
+		/* Ignore if value index is out of bounds. */
+		if (td->inputmode_index < 0 ||
+		    td->inputmode_index >= field->report_count) {
+			dev_err(&hdev->dev, "HID_DG_INPUTMODE out of range\n");
+			td->inputmode = -1;
+		}
 
 		break;
 	case HID_DG_CONTACTMAX:
+		/* Ignore if value count is out of bounds. */
+		if (field->report_count < 1)
+			break;
 		td->maxcontact_report_id = field->report->id;
 		td->maxcontacts = field->value[0];
 		if (!td->maxcontacts &&
@@ -743,15 +752,21 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	unsigned count;
 	int r, n;
 
+	if (report->maxfield == 0)
+		return;
+
 	/*
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
 	 */
-	if (td->cc_index >= 0) {
-		struct hid_field *field = report->field[td->cc_index];
-		int value = field->value[td->cc_value_index];
-		if (value)
-			td->num_expected = value;
+	if (td->cc_index >= 0 && td->cc_index < report->maxfield) {
+		field = report->field[td->cc_index];
+		if (td->cc_value_index >= 0 &&
+		    td->cc_value_index < field->report_count) {
+			int value = field->value[td->cc_value_index];
+			if (value)
+				td->num_expected = value;
+		}
 	}
 
 	for (r = 0; r < report->maxfield; r++) {

-- 
Jiri Kosina
SUSE Labs
