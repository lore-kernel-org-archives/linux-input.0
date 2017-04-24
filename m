From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/7] HID: debug: Replace 12 seq_printf() calls by seq_puts()
Date: Mon, 24 Apr 2017 22:21:16 +0200
Message-ID: <a439cb42-4bd9-acb0-1078-8b696d0dafe9@users.sourceforge.net>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:62160 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1174307AbdDXUV0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 16:21:26 -0400
In-Reply-To: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Apr 2017 20:55:27 +0200

Strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index d47d5085bc99..ce850f80d9e3 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -535,18 +535,18 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 
 	if (field->physical) {
 		tab(n, f);
-		seq_printf(f, "Physical(");
-		hid_resolv_usage(field->physical, f); seq_printf(f, ")\n");
+		seq_puts(f, "Physical(");
+		hid_resolv_usage(field->physical, f); seq_puts(f, ")\n");
 	}
 	if (field->logical) {
 		tab(n, f);
-		seq_printf(f, "Logical(");
-		hid_resolv_usage(field->logical, f); seq_printf(f, ")\n");
+		seq_puts(f, "Logical(");
+		hid_resolv_usage(field->logical, f); seq_puts(f, ")\n");
 	}
 	if (field->application) {
 		tab(n, f);
-		seq_printf(f, "Application(");
-		hid_resolv_usage(field->application, f); seq_printf(f, ")\n");
+		seq_puts(f, "Application(");
+		hid_resolv_usage(field->application, f); seq_puts(f, ")\n");
 	}
 	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
@@ -583,7 +583,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 		data >>= 4;
 
 		if(sys > 4) {
-			tab(n, f); seq_printf(f, "Unit(Invalid)\n");
+			tab(n, f); seq_puts(f, "Unit(Invalid)\n");
 		}
 		else {
 			int earlier_unit = 0;
@@ -607,14 +607,14 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 					}
 				}
 			}
-			seq_printf(f, ")\n");
+			seq_puts(f, ")\n");
 		}
 	}
 	tab(n, f); seq_printf(f, "Report Size(%u)\n", field->report_size);
 	tab(n, f); seq_printf(f, "Report Count(%u)\n", field->report_count);
 	tab(n, f); seq_printf(f, "Report Offset(%u)\n", field->report_offset);
 
-	tab(n, f); seq_printf(f, "Flags( ");
+	tab(n, f); seq_puts(f, "Flags( ");
 	j = field->flags;
 	seq_printf(f, "%s", HID_MAIN_ITEM_CONSTANT & j ? "Constant " : "");
 	seq_printf(f, "%s", HID_MAIN_ITEM_VARIABLE & j ? "Variable " : "Array ");
@@ -625,7 +625,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 	seq_printf(f, "%s", HID_MAIN_ITEM_NULL_STATE & j ? "NullState " : "");
 	seq_printf(f, "%s", HID_MAIN_ITEM_VOLATILE & j ? "Volatile " : "");
 	seq_printf(f, "%s", HID_MAIN_ITEM_BUFFERED_BYTE & j ? "BufferedByte " : "");
-	seq_printf(f, ")\n");
+	seq_puts(f, ")\n");
 }
 EXPORT_SYMBOL_GPL(hid_dump_field);
 
@@ -1038,5 +1038,5 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 				for ( j = 0; j < report->field[i]->maxusage; j++) {
 					usage = report->field[i]->usage + j;
 					hid_resolv_usage(usage->hid, f);
-					seq_printf(f, " ---> ");
+					seq_puts(f, " ---> ");
 					hid_resolv_event(usage->type, usage->code, f);
@@ -1063,7 +1063,7 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	/* dump HID report descriptor */
 	for (i = 0; i < rsize; i++)
 		seq_printf(f, "%02x ", rdesc[i]);
-	seq_printf(f, "\n\n");
+	seq_puts(f, "\n\n");
 
 	/* dump parsed data and input mappings */
 	hid_dump_device(hdev, f);
-- 
2.12.2

