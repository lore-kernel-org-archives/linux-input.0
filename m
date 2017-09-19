From: Meng Xu <mengxu.gatech@gmail.com>
Subject: [PATCH] hid/uhid: fix a double-fetch bug when copying event from user
Date: Tue, 19 Sep 2017 01:21:37 -0400
Message-ID: <1505798497-22436-1-git-send-email-mengxu.gatech@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dh.herrmann@googlemail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: meng.xu@gatech.edu, sanidhya@gatech.edu, taesoo@gatech.edu, Meng Xu <mengxu.gatech@gmail.com>
List-Id: linux-input@vger.kernel.org

When in_compat_syscall(), a user could make type != UHID_CREATE when
get_user(type, buffer) [first fetch] and later make event->type ==
UHID_CREATE in copy_from_user(event, buffer, ...) [second fetch].

By doing so, an attacker might circumvent the specific logic to handle
the type == UHID_CREATE case and later cause undefined behaviors.

This patch enforces that event->type is overriden to the type value
copied in the first fetch and thus, mitigate this race condition attack.

Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
---
 drivers/hid/uhid.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 7f8ff39..4bbfd8a 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -448,11 +448,20 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
 			kfree(compat);
 			return 0;
 		}
+
 		/* All others can be copied directly */
-	}
+		if (copy_from_user(event, buffer, min(len, sizeof(*event))))
+			return -EFAULT;
 
-	if (copy_from_user(event, buffer, min(len, sizeof(*event))))
-		return -EFAULT;
+		/* 
+		 * Override type in case the user process rushes to change it 
+		 * between two fetches 
+		 * */
+		event->type = type;
+	} else {
+		if (copy_from_user(event, buffer, min(len, sizeof(*event))))
+			return -EFAULT;
+	}
 
 	return 0;
 }
-- 
2.7.4
