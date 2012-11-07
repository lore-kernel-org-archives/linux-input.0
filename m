From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v3 04/13] HID: hid-input: add usage_index in struct hid_usage.
Date: Wed,  7 Nov 2012 17:37:27 +0100
Message-ID: <1352306256-12180-5-git-send-email-benjamin.tissoires@gmail.com>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Currently, there is no way to know the index of the current field
in the .input_mapping and .event callbacks  when this field is inside
an array of HID fields.
This patch adds this index to the struct hid_usage so that this
information is available to input_mapping and event callbacks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-core.c | 4 ++++
 include/linux/hid.h    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9da3007..8f82c4c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -92,6 +92,7 @@ EXPORT_SYMBOL_GPL(hid_register_report);
 static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
 {
 	struct hid_field *field;
+	int i;
 
 	if (report->maxfield == HID_MAX_FIELDS) {
 		hid_err(report->device, "too many fields in report\n");
@@ -110,6 +111,9 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 	field->value = (s32 *)(field->usage + usages);
 	field->report = report;
 
+	for (i = 0; i < usages; i++)
+		field->usage[i].usage_index = i;
+
 	return field;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a110a3e..6b4f322 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -380,6 +380,7 @@ struct hid_usage {
 	unsigned  hid;			/* hid usage code */
 	unsigned  collection_index;	/* index into collection array */
 	/* hidinput data */
+	unsigned  usage_index;		/* index into usage array */
 	__u16     code;			/* input driver code */
 	__u8      type;			/* input driver type */
 	__s8	  hat_min;		/* hat switch fun */
-- 
1.7.11.7
