From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Fri, 30 Nov 2018 21:49:51 -0500
Message-ID: <20181201024951.5508-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-input@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/hid/hid-debug.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index b48100236df8..c530476edba6 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1072,11 +1072,6 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	return 0;
 }
 
-static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hid_debug_rdesc_show, inode->i_private);
-}
-
 static int hid_debug_events_open(struct inode *inode, struct file *file)
 {
 	int err = 0;
@@ -1211,12 +1206,7 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static const struct file_operations hid_debug_rdesc_fops = {
-	.open           = hid_debug_rdesc_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hid_debug_rdesc);
 
 static const struct file_operations hid_debug_events_fops = {
 	.owner =        THIS_MODULE,
-- 
2.17.0
