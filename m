From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 16/18] HID-debug: Add some spaces for better code readability
Date: Tue, 7 Feb 2017 20:59:21 +0100
Message-ID: <68441f8a-c654-8fe2-a302-fc67e5485464@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63856 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdBGUA3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 15:00:29 -0500
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:10:40 +0100

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 60984e2906a7..044b12e32240 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -493,7 +493,7 @@ char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 
 	if (!f) {
 		len = strlen(buf);
-		snprintf(buf+len, max(0, HID_DEBUG_BUFSIZE - len), ".");
+		snprintf(buf + len, max(0, HID_DEBUG_BUFSIZE - len), ".");
 		len++;
 	}
 	else {
@@ -501,12 +501,14 @@ char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 	}
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == (usage >> 16)) {
-			for(++p; p->description && p->usage != 0; p++)
+			for (++p; p->description && p->usage != 0; p++)
 				if (p->usage == (usage & 0xffff)) {
 					if (!f)
 						snprintf(buf + len,
-							max(0,HID_DEBUG_BUFSIZE - len - 1),
-							"%s", p->description);
+							 max(0,
+							     HID_DEBUG_BUFSIZE
+							     - len - 1),
+							 "%s", p->description);
 					else
 						seq_puts(f, p->description);
 					return buf;
@@ -582,7 +584,7 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 		sys = data & 0xf;
 		data >>= 4;
 
-		if(sys > 4) {
+		if (sys > 4) {
 			tab(n, f);
 			seq_puts(f, "Unit(Invalid)\n");
 		}
@@ -591,19 +593,19 @@ void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 
 			tab(n, f); seq_printf(f, "Unit(%s : ", systems[sys]);
 
-			for (i=1 ; i<sizeof(__u32)*2 ; i++) {
+			for (i = 1; i < sizeof(__u32) * 2; i++) {
 				char nibble = data & 0xf;
 				data >>= 4;
 				if (nibble != 0) {
-					if(earlier_unit++ > 0)
+					if (earlier_unit++ > 0)
 						seq_putc(f, '*');
 					seq_puts(f, units[sys][i]);
-					if(nibble != 1) {
+					if (nibble != 1) {
 						/* This is a _signed_ nibble(!) */
-
 						int val = nibble & 0x7;
-						if(nibble & 0x08)
-							val = -((0x7 & ~val) +1);
+
+						if (nibble & 0x08)
+							val = -((0x7 & ~val) + 1);
 						seq_printf(f, "^%d", val);
 					}
 				}
@@ -634,7 +636,7 @@ void hid_dump_device(struct hid_device *device, struct seq_file *f)
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 	struct list_head *list;
-	unsigned i,k;
+	unsigned int i, k;
 	static const char *table[] = {"INPUT", "OUTPUT", "FEATURE"};
 
 	for (i = 0; i < HID_REPORT_TYPES; i++) {
-- 
2.11.1

