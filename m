From: Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] HID: debug: check length before copy_to_user()
Date: Mon,  2 Jul 2018 16:59:37 -0700
Message-ID: <20180702235937.111619-1-drosen@google.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If our length is greater than the size of the buffer, we
overflow the buffer

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-debug.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8469b6964ff64..b48100236df89 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1154,6 +1154,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			goto out;
 		if (list->tail > list->head) {
 			len = list->tail - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1163,6 +1165,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			list->head += len;
 		} else {
 			len = HID_DEBUG_BUFSIZE - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1170,7 +1174,9 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			}
 			list->head = 0;
 			ret += len;
-			goto copy_rest;
+			count -= len;
+			if (count > 0)
+				goto copy_rest;
 		}
 
 	}
-- 
2.18.0.399.gad0ab374a1-goog
