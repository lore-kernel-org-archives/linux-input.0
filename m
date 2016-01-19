From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: core: prevent out-of-bound readings
Date: Tue, 19 Jan 2016 12:34:58 +0100
Message-ID: <1453203298-24993-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Plugging a Logitech DJ receiver with KASAN activated raises a bunch of
out-of-bound readings.

The fields are allocated up to MAX_USAGE, meaning that potentially, we do
not have enough fields to fit the incoming values.
Add checks and silence KASAN.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1532ae6..4f329d4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1294,6 +1294,7 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 		/* Ignore report if ErrorRollOver */
 		if (!(field->flags & HID_MAIN_ITEM_VARIABLE) &&
 		    value[n] >= min && value[n] <= max &&
+		    value[n] - min < field->maxusage &&
 		    field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1)
 			goto exit;
 	}
@@ -1306,11 +1307,13 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 		}
 
 		if (field->value[n] >= min && field->value[n] <= max
+			&& field->value[n] - min < field->maxusage
 			&& field->usage[field->value[n] - min].hid
 			&& search(value, field->value[n], count))
 				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, interrupt);
 
 		if (value[n] >= min && value[n] <= max
+			&& value[n] - min < field->maxusage
 			&& field->usage[value[n] - min].hid
 			&& search(field->value, value[n], count))
 				hid_process_event(hid, field, &field->usage[value[n] - min], 1, interrupt);
-- 
2.5.0
