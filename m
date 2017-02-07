From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 10/18] HID-debug: Replace five seq_printf() calls by
 seq_putc()
Date: Tue, 7 Feb 2017 20:52:54 +0100
Message-ID: <c52b3bc3-5103-3e79-73f7-d433460ffbf0@users.sourceforge.net>
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
Date: Tue, 7 Feb 2017 19:21:17 +0100

Single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index acfb522a432a..383a4a838351 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -497,7 +497,7 @@ char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 		len++;
 	}
 	else {
-		seq_printf(f, ".");
+		seq_putc(f, '.');
 	}
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == (usage >> 16)) {
@@ -548,7 +548,9 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 	}
 	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
-		tab(n+2, f); hid_resolv_usage(field->usage[j].hid, f); seq_printf(f, "\n");
+		tab(n + 2, f);
+		hid_resolv_usage(field->usage[j].hid, f);
+		seq_putc(f, '\n');
 	}
 	if (field->logical_minimum != field->logical_maximum) {
 		tab(n, f); seq_printf(f, "Logical Minimum(%d)\n", field->logical_minimum);
@@ -592,7 +594,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 				data >>= 4;
 				if (nibble != 0) {
 					if(earlier_unit++ > 0)
-						seq_printf(f, "*");
+						seq_putc(f, '*');
 					seq_printf(f, "%s", units[sys][i]);
 					if(nibble != 1) {
 						/* This is a _signed_ nibble(!) */
@@ -1037,7 +1039,7 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 					hid_resolv_usage(usage->hid, f);
 					seq_printf(f, " ---> ");
 					hid_resolv_event(usage->type, usage->code, f);
-					seq_printf(f, "\n");
+					seq_putc(f, '\n');
 				}
 			}
 		}
@@ -1064,7 +1066,7 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 
 	/* dump parsed data and input mappings */
 	hid_dump_device(hdev, f);
-	seq_printf(f, "\n");
+	seq_putc(f, '\n');
 	hid_dump_input_mapping(hdev, f);
 
 	return 0;
-- 
2.11.1
