From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v2 04/11] HID: hid-multitouch: support arrays for the split of the touches in a report
Date: Fri, 26 Oct 2012 10:44:20 +0200
Message-ID: <1351241067-9521-5-git-send-email-benjamin.tissoires@gmail.com>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Win8 certification introduced the ability to transmit two X and two Y per
touch. The specification precises that it must be in an array, with a
report count == 2.

This test guarantees that we split the touches on the last element
in this array.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-multitouch.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 725d155..95562d8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -577,12 +577,16 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 			return 0;
 		}
 
-		if (usage->hid == td->last_slot_field)
-			mt_complete_slot(td, field->hidinput->input);
-
-		if (field->index == td->last_field_index
-			&& td->num_received >= td->num_expected)
-			mt_sync_frame(td, field->hidinput->input);
+		if (usage_index + 1 == field->report_count) {
+			/* we only take into account the last report
+			 * of a field if report_count > 1 */
+			if (usage->hid == td->last_slot_field)
+				mt_complete_slot(td, field->hidinput->input);
+
+			if (field->index == td->last_field_index
+				&& td->num_received >= td->num_expected)
+				mt_sync_frame(td, field->hidinput->input);
+		}
 
 	}
 
-- 
1.7.11.7
