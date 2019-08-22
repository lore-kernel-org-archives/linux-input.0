From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] HID: hidraw: replace printk() with corresponding pr_xx() variant
Date: Thu, 22 Aug 2019 22:13:52 +0530
Message-ID: <1566492232-13590-1-git-send-email-gupt21@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-input@vger.kernel.org

This commit replaces direct invocations of printk with
their appropriate pr_info/warn() variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/hid/hidraw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 006bd6f..67b652b 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,14 +197,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	if (count > HID_MAX_BUFFER_SIZE) {
-		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
+		pr_warn("hidraw: pid %d passed too large report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (count < 2) {
-		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
+		pr_warn("hidraw: pid %d passed too short report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
@@ -597,7 +597,7 @@ int __init hidraw_init(void)
 	if (result < 0)
 		goto error_class;
 
-	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
+	pr_info("hidraw: raw HID events driver (C) Jiri Kosina\n");
 out:
 	return result;
 
-- 
2.7.4
