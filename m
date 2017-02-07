From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 13/18] HID-debug: Combine 11 seq_printf() calls into one call
 in hid_dump_field()
Date: Tue, 7 Feb 2017 20:56:24 +0100
Message-ID: <99abe158-ba41-99eb-95e1-e9aed7bafb53@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754690AbdBGUDh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 15:03:37 -0500
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:04:28 +0100

Some data were printed into a sequence by eleven separate function calls.
Print the same data by a single function call instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 2ce809eb4c97..aafa963e8a04 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -614,19 +614,18 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 	tab(n, f); seq_printf(f, "Report Size(%u)\n", field->report_size);
 	tab(n, f); seq_printf(f, "Report Count(%u)\n", field->report_count);
 	tab(n, f); seq_printf(f, "Report Offset(%u)\n", field->report_offset);
-
-	tab(n, f); seq_printf(f, "Flags( ");
+	tab(n, f);
 	j = field->flags;
-	seq_printf(f, "%s", HID_MAIN_ITEM_CONSTANT & j ? "Constant " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_VARIABLE & j ? "Variable " : "Array ");
-	seq_printf(f, "%s", HID_MAIN_ITEM_RELATIVE & j ? "Relative " : "Absolute ");
-	seq_printf(f, "%s", HID_MAIN_ITEM_WRAP & j ? "Wrap " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_NONLINEAR & j ? "NonLinear " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_NO_PREFERRED & j ? "NoPreferredState " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_NULL_STATE & j ? "NullState " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_VOLATILE & j ? "Volatile " : "");
-	seq_printf(f, "%s", HID_MAIN_ITEM_BUFFERED_BYTE & j ? "BufferedByte " : "");
-	seq_printf(f, ")\n");
+	seq_printf(f, "Flags( %s%s%s%s%s%s%s%s%s)\n",
+		   HID_MAIN_ITEM_CONSTANT & j ? "Constant " : "",
+		   HID_MAIN_ITEM_VARIABLE & j ? "Variable " : "Array ",
+		   HID_MAIN_ITEM_RELATIVE & j ? "Relative " : "Absolute ",
+		   HID_MAIN_ITEM_WRAP & j ? "Wrap " : "",
+		   HID_MAIN_ITEM_NONLINEAR & j ? "NonLinear " : "",
+		   HID_MAIN_ITEM_NO_PREFERRED & j ? "NoPreferredState " : "",
+		   HID_MAIN_ITEM_NULL_STATE & j ? "NullState " : "",
+		   HID_MAIN_ITEM_VOLATILE & j ? "Volatile " : "",
+		   HID_MAIN_ITEM_BUFFERED_BYTE & j ? "BufferedByte " : "");
 }
 EXPORT_SYMBOL_GPL(hid_dump_field);
 
-- 
2.11.1

