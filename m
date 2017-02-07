From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 12/18] HID-debug: Replace 12 seq_printf() calls by seq_puts()
Date: Tue, 7 Feb 2017 20:55:09 +0100
Message-ID: <5e7692e4-b857-f708-080c-013ddcdcfe0f@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:02:45 +0100

Strings which did not contain data format specifications should be put into
a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8d019d0db4f3..2ce809eb4c97 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -508,9 +508,7 @@ char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 							max(0,HID_DEBUG_BUFSIZE - len - 1),
 							"%s", p->description);
 					else
-						seq_printf(f,
-							"%s",
-							p->description);
+						seq_puts(f, p->description);
 					return buf;
 				}
 			break;
@@ -533,18 +531,21 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 
 	if (field->physical) {
 		tab(n, f);
-		seq_printf(f, "Physical(");
-		hid_resolv_usage(field->physical, f); seq_printf(f, ")\n");
+		seq_puts(f, "Physical(");
+		hid_resolv_usage(field->physical, f);
+		seq_puts(f, ")\n");
 	}
 	if (field->logical) {
 		tab(n, f);
-		seq_printf(f, "Logical(");
-		hid_resolv_usage(field->logical, f); seq_printf(f, ")\n");
+		seq_puts(f, "Logical(");
+		hid_resolv_usage(field->logical, f);
+		seq_puts(f, ")\n");
 	}
 	if (field->application) {
 		tab(n, f);
-		seq_printf(f, "Application(");
-		hid_resolv_usage(field->application, f); seq_printf(f, ")\n");
+		seq_puts(f, "Application(");
+		hid_resolv_usage(field->application, f);
+		seq_puts(f, ")\n");
 	}
 	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
@@ -582,7 +583,8 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 		data >>= 4;
 
 		if(sys > 4) {
-			tab(n, f); seq_printf(f, "Unit(Invalid)\n");
+			tab(n, f);
+			seq_puts(f, "Unit(Invalid)\n");
 		}
 		else {
 			int earlier_unit = 0;
@@ -595,7 +597,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 				if (nibble != 0) {
 					if(earlier_unit++ > 0)
 						seq_putc(f, '*');
-					seq_printf(f, "%s", units[sys][i]);
+					seq_puts(f, units[sys][i]);
 					if(nibble != 1) {
 						/* This is a _signed_ nibble(!) */
 
@@ -606,7 +608,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 					}
 				}
 			}
-			seq_printf(f, ")\n");
+			seq_puts(f, ")\n");
 		}
 	}
 	tab(n, f); seq_printf(f, "Report Size(%u)\n", field->report_size);
@@ -1036,7 +1038,7 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 				for ( j = 0; j < report->field[i]->maxusage; j++) {
 					usage = report->field[i]->usage + j;
 					hid_resolv_usage(usage->hid, f);
-					seq_printf(f, " ---> ");
+					seq_puts(f, " ---> ");
 					hid_resolv_event(usage->type, usage->code, f);
 					seq_putc(f, '\n');
 				}
@@ -1061,7 +1063,7 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	/* dump HID report descriptor */
 	for (i = 0; i < rsize; i++)
 		seq_printf(f, "%02x ", rdesc[i]);
-	seq_printf(f, "\n\n");
+	seq_puts(f, "\n\n");
 
 	/* dump parsed data and input mappings */
 	hid_dump_device(hdev, f);
-- 
2.11.1
