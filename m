From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 17/18] HID-debug: Delete an unnecessary variable
 initialisation in hid_resolv_usage()
Date: Tue, 7 Feb 2017 21:00:08 +0100
Message-ID: <87289011-09d8-d544-f4f7-46ca739ccbf5@users.sourceforge.net>
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
Date: Tue, 7 Feb 2017 20:12:09 +0100

The local variable "buf" will be set to an appropriate pointer
by the following statement. Thus omit the explicit initialisation
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 044b12e32240..0d33bf0d47d1 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -481,7 +481,7 @@ static char *resolv_usage_page(unsigned page, struct seq_file *f) {
 
 char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 	const struct hid_usage_entry *p;
-	char *buf = NULL;
+	char *buf;
 	int len = 0;
 
 	buf = resolv_usage_page(usage >> 16, f);
-- 
2.11.1
