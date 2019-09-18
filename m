From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2] HID: hidraw: replace printk() with corresponding pr_xx() variant
Date: Wed, 18 Sep 2019 21:59:11 +0530
Message-ID: <1568824151-12668-1-git-send-email-gupt21@gmail.com>
References: <20190912203119.GC636@penguin>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912203119.GC636@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-input@vger.kernel.org

This commit replaces direct invocations of printk with
their appropriate pr_info/warn() variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Removed manually adding prefix "hidraw:".

 drivers/hid/hidraw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 006bd6f..2d082f3 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,14 +197,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	if (count > HID_MAX_BUFFER_SIZE) {
-		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
+		pr_warn("pid %d passed too large report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (count < 2) {
-		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
+		pr_warn("pid %d passed too short report\n",
 				task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
@@ -597,7 +597,7 @@ int __init hidraw_init(void)
 	if (result < 0)
 		goto error_class;
 
-	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
+	pr_info("raw HID events driver (C) Jiri Kosina\n");
 out:
 	return result;
 
-- 
2.7.4
