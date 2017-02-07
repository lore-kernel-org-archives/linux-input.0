From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 15/18] HID-debug: Return an error code only as a constant in
 hid_debug_events_open()
Date: Tue, 7 Feb 2017 20:58:26 +0100
Message-ID: <9935147f-3387-a583-b878-cbd90f1bfac0@users.sourceforge.net>
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
Date: Tue, 7 Feb 2017 20:08:04 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the local variable "err" and the jump label "out" which became
  unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-debug.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 444c63f0e4be..60984e2906a7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1079,22 +1079,18 @@ static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
 
 static int hid_debug_events_open(struct inode *inode, struct file *file)
 {
-	int err = 0;
 	struct hid_debug_list *list;
 	unsigned long flags;
 
 	list = kzalloc(sizeof(*list), GFP_KERNEL);
-	if (!list) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!list)
+		return -ENOMEM;
 
 	list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE,
 				      GFP_KERNEL);
 	if (!list->hid_debug_buf) {
-		err = -ENOMEM;
 		kfree(list);
-		goto out;
+		return -ENOMEM;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
 	file->private_data = list;
@@ -1103,9 +1099,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_add_tail(&list->node, &list->hdev->debug_list);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
-
-out:
-	return err;
+	return 0;
 }
 
 static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
-- 
2.11.1
