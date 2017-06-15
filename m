From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/3] HID: multitouch: optimize the sticky fingers timer
Date: Thu, 15 Jun 2017 15:32:05 +0200
Message-ID: <20170615133205.15441-4-benjamin.tissoires@redhat.com>
References: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Arek Burdach <arek.burdach@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Instead of unconditionally expiring the timer and calling a long
mt_release_contacts(), we can check if some slots are used when the
timer expires.

We can also remove the timer if we happen to receive all the releases.

The logic behind the MT_IO_FLAGS_PENDING_SLOTS could be implemented by
counting how many slots are active, but using bits feels slightly more
efficient.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dd73907..9481935 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -79,6 +79,8 @@ MODULE_LICENSE("GPL");
 #define MT_BUTTONTYPE_CLICKPAD		0
 
 #define MT_IO_FLAGS_RUNNING		0
+#define MT_IO_FLAGS_ACTIVE_SLOTS	1
+#define MT_IO_FLAGS_PENDING_SLOTS	2
 
 struct mt_slot {
 	__s32 x, y, cx, cy, p, w, h;
@@ -689,6 +691,8 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+
+			set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 		}
 	}
 
@@ -704,6 +708,11 @@ static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 	input_mt_sync_frame(input);
 	input_sync(input);
 	td->num_received = 0;
+	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
+		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
+	else
+		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
+	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
@@ -843,8 +852,13 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	 * only affect laggish machines and the ones that have a firmware
 	 * defect.
 	 */
-	if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS)
-		mod_timer(&td->release_timer, jiffies + msecs_to_jiffies(100));
+	if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS) {
+		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+			mod_timer(&td->release_timer,
+				  jiffies + msecs_to_jiffies(100));
+		else
+			del_timer(&td->release_timer);
+	}
 
 	clear_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
@@ -1194,7 +1208,8 @@ static void mt_expired_timeout(unsigned long arg)
 	 */
 	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	mt_release_contacts(hdev);
+	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		mt_release_contacts(hdev);
 	clear_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
 
-- 
2.9.4
