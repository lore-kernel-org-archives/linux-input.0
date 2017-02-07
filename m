From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 18/18] HID-picoLCD: Use seq_puts() in
 picolcd_debug_reset_show()
Date: Tue, 7 Feb 2017 21:01:18 +0100
Message-ID: <7f443463-bbdd-8f7b-581e-d0c7da352ae8@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:64003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755340AbdBGUBb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 15:01:31 -0500
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:14:16 +0100

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-picolcd_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 3c13af684410..ddad570b4d9e 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -32,10 +32,8 @@
 
 static int picolcd_debug_reset_show(struct seq_file *f, void *p)
 {
-	if (picolcd_fbinfo((struct picolcd_data *)f->private))
-		seq_printf(f, "all fb\n");
-	else
-		seq_printf(f, "all\n");
+	seq_puts(f, picolcd_fbinfo((struct picolcd_data *)f->private)
+		    ? "all fb\n" : "all\n");
 	return 0;
 }
 
-- 
2.11.1

