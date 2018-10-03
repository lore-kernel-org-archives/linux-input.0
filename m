From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 3/3] HID: debug: fix the ring buffer writer implementation
Date: Wed,  3 Oct 2018 19:19:36 +0200
Message-ID: <20181003171936.11271-4-vdronov@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>
List-Id: linux-input@vger.kernel.org

ring buffer implementation hid_debug_event() is strange allowing a lost
of data. it does not move head pointer on append and uses per-byte for()
loop. fix this by introducing a new ring buffer implementation, which
overwrites the oldest data in case of the ring buffer overflow. it uses
some calculations for the buffer pointers but only 2 or less memcpy()
calls.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/hid/hid-debug.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index de640e4132c7..63247ac4a9ce 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -661,20 +661,70 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	unsigned i;
 	struct hid_debug_list *list;
-	unsigned long flags, flags2;
+	unsigned long flags1, flags2;
+	unsigned int part1, part2;
+	size_t len;
 
-	spin_lock_irqsave(&hdev->debug_list_lock, flags);
+	if (!buf || !buf[0])
+		return;
+
+	len = strlen(buf);
+
+	spin_lock_irqsave(&hdev->debug_list_lock, flags1);
 	list_for_each_entry(list, &hdev->debug_list, node) {
 		spin_lock_irqsave(&list->list_lock, flags2);
-		for (i = 0; buf[i]; i++)
-			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
-				buf[i];
-		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
+
+		/* len >= BUFSIZE, copy the last HID_DEBUG_BUFSIZE-1 bytes */
+		if (len > HID_DEBUG_BUFSIZE - 1) {
+			memcpy(list->hid_debug_buf,
+				buf + len - (HID_DEBUG_BUFSIZE - 1),
+				HID_DEBUG_BUFSIZE - 1);
+
+			list->head = 0;
+			list->tail = HID_DEBUG_BUFSIZE - 1;
+		} else {
+			/* append data to the ring buffer */
+			part1 = min_t(size_t, HID_DEBUG_BUFSIZE - list->tail,
+					len);
+			part2 = len - part1;
+
+			memcpy(list->hid_debug_buf + list->tail, buf, part1);
+
+			/* check if head must be moved as the ring is full */
+			if ((list->tail < list->head) &&
+			    (list->tail + part1 >= list->head)) {
+				list->head = list->tail + part1 + 1;
+
+				if (list->head >= HID_DEBUG_BUFSIZE)
+					list->head -= HID_DEBUG_BUFSIZE;
+			}
+
+			/* set tail after the end of appended data */
+			list->tail = list->tail + part1;
+			if (list->tail == HID_DEBUG_BUFSIZE) {
+				list->tail = 0;
+				if (list->head == 0)
+					list->head = 1;
+			}
+
+			/* append the 2nd part of data to the ring */
+			if (part2 > 0) {
+				memcpy(list->hid_debug_buf, buf + part1, part2);
+
+				/* check if head must be moved again as
+				 * the ring is full
+				 */
+				if (list->tail + part2 >= list->head)
+					list->head = list->tail + part2 + 1;
+
+				list->tail = list->tail + part2;
+			}
+		}
+
 		spin_unlock_irqrestore(&list->list_lock, flags2);
 	}
-	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
+	spin_unlock_irqrestore(&hdev->debug_list_lock, flags1);
 
 	wake_up_interruptible(&hdev->debug_wait);
 }
-- 
2.19.0
