From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/3] HID: multitouch: fix rare Win 8 cases when the touch up event gets missing
Date: Thu, 15 Jun 2017 15:32:04 +0200
Message-ID: <20170615133205.15441-3-benjamin.tissoires@redhat.com>
References: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Arek Burdach <arek.burdach@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Instead of blindly trusting the hardware to send us release, we should
consider some events can get lost and release them when we judge time has
come.

The Windows 8 spec allows to be confident in the fact that the device
will continuously report events when a finger touches the surface.
This has been tested on the HID recording database I have, and all of
those devices behave properly.
Also, Arek tested it on his Lenovo Yoga 910, which exports such bug in
some situations, when the movements are rather slow.

We use an atomic bit here to guard against concurrent accesses to the mt
slots because both mt_process_mt_event() and mt_expired_timeout() are
called in interrupt context.

Signed-off-by: Arek Burdach <arek.burdach@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 102 +++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 45be218..dd73907 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/input/mt.h>
 #include <linux/string.h>
+#include <linux/timer.h>
 
 
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
@@ -70,12 +71,15 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_FORCE_GET_FEATURE	BIT(13)
 #define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
 #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
+#define MT_QUIRK_STICKY_FINGERS		BIT(16)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
 
 #define MT_BUTTONTYPE_CLICKPAD		0
 
+#define MT_IO_FLAGS_RUNNING		0
+
 struct mt_slot {
 	__s32 x, y, cx, cy, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
@@ -104,8 +108,10 @@ struct mt_fields {
 struct mt_device {
 	struct mt_slot curdata;	/* placeholder of incoming data */
 	struct mt_class mtclass;	/* our mt device class */
+	struct timer_list release_timer;	/* to release sticky fingers */
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
 	int cc_index;	/* contact count field index in the report */
 	int cc_value_index;	/* contact count value index in the field */
 	unsigned last_slot_field;	/* the last field of a slot */
@@ -212,7 +218,8 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
-			MT_QUIRK_CONTACT_CNT_ACCURATE },
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
@@ -788,6 +795,10 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	unsigned count;
 	int r, n;
 
+	/* sticky fingers release in progress, abort */
+	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
+		return;
+
 	/*
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
@@ -813,6 +824,29 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 
 	if (td->num_received >= td->num_expected)
 		mt_sync_frame(td, report->field[0]->hidinput->input);
+
+	/*
+	 * Windows 8 specs says 2 things:
+	 * - once a contact has been reported, it has to be reported in each
+	 *   subsequent report
+	 * - the report rate when fingers are present has to be at least
+	 *   the refresh rate of the screen, 60 or 120 Hz
+	 *
+	 * I interprete this that the specification forces a report rate of
+	 * at least 60 Hz for a touchscreen to be certified.
+	 * Which means that if we do not get a report whithin 16 ms, either
+	 * something wrong happens, either the touchscreen forgets to send
+	 * a release. Taking a reasonable margin allows to remove issues
+	 * with USB communication or the load of the machine.
+	 *
+	 * Given that Win 8 devices are forced to send a release, this will
+	 * only affect laggish machines and the ones that have a firmware
+	 * defect.
+	 */
+	if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS)
+		mod_timer(&td->release_timer, jiffies + msecs_to_jiffies(100));
+
+	clear_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
 
 static int mt_touch_input_configured(struct hid_device *hdev,
@@ -1124,6 +1158,46 @@ static void mt_fix_const_fields(struct hid_device *hdev, unsigned int usage)
 	}
 }
 
+static void mt_release_contacts(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+	struct mt_device *td = hid_get_drvdata(hid);
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		struct input_dev *input_dev = hidinput->input;
+		struct input_mt *mt = input_dev->mt;
+		int i;
+
+		if (mt) {
+			for (i = 0; i < mt->num_slots; i++) {
+				input_mt_slot(input_dev, i);
+				input_mt_report_slot_state(input_dev,
+							   MT_TOOL_FINGER,
+							   false);
+			}
+			input_mt_sync_frame(input_dev);
+			input_sync(input_dev);
+		}
+	}
+
+	td->num_received = 0;
+}
+
+static void mt_expired_timeout(unsigned long arg)
+{
+	struct hid_device *hdev = (void *)arg;
+	struct mt_device *td = hid_get_drvdata(hdev);
+
+	/*
+	 * An input report came in just before we release the sticky fingers,
+	 * it will take care of the sticky fingers.
+	 */
+	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
+		return;
+	mt_release_contacts(hdev);
+	clear_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
+}
+
 static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
@@ -1193,6 +1267,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
+	setup_timer(&td->release_timer, mt_expired_timeout, (long)hdev);
+
 	ret = hid_parse(hdev);
 	if (ret != 0)
 		return ret;
@@ -1220,28 +1296,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 
 #ifdef CONFIG_PM
-static void mt_release_contacts(struct hid_device *hid)
-{
-	struct hid_input *hidinput;
-
-	list_for_each_entry(hidinput, &hid->inputs, list) {
-		struct input_dev *input_dev = hidinput->input;
-		struct input_mt *mt = input_dev->mt;
-		int i;
-
-		if (mt) {
-			for (i = 0; i < mt->num_slots; i++) {
-				input_mt_slot(input_dev, i);
-				input_mt_report_slot_state(input_dev,
-							   MT_TOOL_FINGER,
-							   false);
-			}
-			input_mt_sync_frame(input_dev);
-			input_sync(input_dev);
-		}
-	}
-}
-
 static int mt_reset_resume(struct hid_device *hdev)
 {
 	mt_release_contacts(hdev);
@@ -1266,6 +1320,8 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
+	del_timer_sync(&td->release_timer);
+
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
 	hdev->quirks = td->initial_quirks;
-- 
2.9.4
