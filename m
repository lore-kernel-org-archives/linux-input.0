From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 14/18] HID-debug: Adjust two function calls together with a
 variable assignment
Date: Tue, 7 Feb 2017 20:57:31 +0100
Message-ID: <79f4cfa3-b21b-946c-e108-654400f3f62c@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:62549 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753909AbdBGUES (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 15:04:18 -0500
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 20:06:31 +0100

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix the affected source code places.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index aafa963e8a04..444c63f0e4be 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1083,12 +1083,15 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	struct hid_debug_list *list;
 	unsigned long flags;
 
-	if (!(list = kzalloc(sizeof(struct hid_debug_list), GFP_KERNEL))) {
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	if (!(list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
+	list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE,
+				      GFP_KERNEL);
+	if (!list->hid_debug_buf) {
 		err = -ENOMEM;
 		kfree(list);
 		goto out;
-- 
2.11.1

