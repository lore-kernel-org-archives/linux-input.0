From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v3 05/13] HID: hid-multitouch: support arrays for the split of the touches in a report
Date: Wed,  7 Nov 2012 17:37:28 +0100
Message-ID: <1352306256-12180-6-git-send-email-benjamin.tissoires@gmail.com>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Win8 certification introduced the ability to transmit two X and two Y per
touch. The specification precises that it must be used in an array.

This test guarantees that we split the touches on the last element
in this array.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 9f64e36..a6a4e0a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -577,12 +577,15 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 			return 0;
 		}
 
-		if (usage->hid == td->last_slot_field)
-			mt_complete_slot(td, field->hidinput->input);
-
-		if (field->index == td->last_field_index
-			&& td->num_received >= td->num_expected)
-			mt_sync_frame(td, field->hidinput->input);
+		if (usage->usage_index + 1 == field->report_count) {
+			/* we only take into account the last report. */
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
