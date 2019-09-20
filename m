From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3] HID: hidraw: replace printk() with corresponding pr_xx() variant
Date: Fri, 20 Sep 2019 08:05:01 +0530
Message-ID: <1568946901-29752-1-git-send-email-gupt21@gmail.com>
References: <20190919161613.GR237523@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919161613.GR237523@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-input@vger.kernel.org

This commit replaces direct invocations of printk with
their appropriate pr_info/warn() variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
* Use hid_warn() subsystem specific variant instead of pr_warn()

 drivers/hid/hidraw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 006bd6f..a42f4b5 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,15 +197,15 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	if (count > HID_MAX_BUFFER_SIZE) {
-		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
-				task_pid_nr(current));
+		hid_warn(dev, "pid %d passed too large report\n",
+			task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (count < 2) {
-		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
-				task_pid_nr(current));
+		hid_warn(dev, "pid %d passed too short report\n",
+			task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -597,7 +597,7 @@ int __init hidraw_init(void)
 	if (result < 0)
 		goto error_class;
 
-	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
+	pr_info("raw HID events driver (C) Jiri Kosina\n");
 out:
 	return result;
 
-- 
2.7.4
