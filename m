From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Sun, 17 Nov 2013 20:38:21 +0100
Message-ID: <1384717101-7027-1-git-send-email-sven@narfation.org>
References: <1384682880-5960-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42096 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab3KQTi5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 14:38:57 -0500
In-Reply-To: <1384682880-5960-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Sven Eckelmann <sven@narfation.org>

The ff_memless has a timer running which gets run in an atomic context and
calls the play_effect callback. The callback function for sony uses the
hid_output_raw_report (overwritten by sixaxis_usb_output_raw_report) function
to handle differences in the control message format. It is not safe for an
atomic context because it may sleep later in usb_start_wait_urb.

This "scheduling while atomic" can cause the system to lock up. A workaround is
to make the force feedback state update using work_queues and use the
play_effect function only to enqueue the work item.

Reported-by: Simon Wood <simon@mungewell.org>
Reported-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch can replace
 'Revert "HID: sony: Add force feedback support for Dualshock3 USB"'

It doesn't contain the command changes from <2014555.nmU692BQMt@sven-desktop>.
It would be nice when Simon Wood could test it again with his Intec Wired
controller. When it doesn't work:

 * Try to change to usb_interrupt_msg instead of sc->hdev->hid_output_raw_report
 * Send a interrupt message using buf[10] = 0x02
   (only when buf[3] != 0 || buf[5] != 0) followed by a message with
   buf[10] = 0x1e (always)

 drivers/hid/hid-sony.c | 53 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index da551d1..098af2f8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -225,6 +225,13 @@ static const unsigned int buzz_keymap[] = {
 struct sony_sc {
 	unsigned long quirks;
 
+#ifdef CONFIG_SONY_FF
+	struct work_struct rumble_worker;
+	struct hid_device *hdev;
+	__u8 left;
+	__u8 right;
+#endif
+
 	void *extra;
 };
 
@@ -615,9 +622,9 @@ static void buzz_remove(struct hid_device *hdev)
 }
 
 #ifdef CONFIG_SONY_FF
-static int sony_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
+static void sony_rumble_worker(struct work_struct *work)
 {
+	struct sony_sc *sc = container_of(work, struct sony_sc, rumble_worker);
 	unsigned char buf[] = {
 		0x01,
 		0x00, 0xff, 0x00, 0xff, 0x00,
@@ -628,21 +635,28 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0x00, 0x00, 0x00, 0x00, 0x00
 	};
-	__u8 left;
-	__u8 right;
+
+	buf[3] = sc->right;
+	buf[5] = sc->left;
+
+	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
+					HID_OUTPUT_REPORT);
+}
+
+static int sony_play_effect(struct input_dev *dev, void *data,
+			    struct ff_effect *effect)
+{
 	struct hid_device *hid = input_get_drvdata(dev);
+	struct sony_sc *sc = hid_get_drvdata(hid);
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
 
-	left = effect->u.rumble.strong_magnitude / 256;
-	right = effect->u.rumble.weak_magnitude ? 1 : 0;
+	sc->left = effect->u.rumble.strong_magnitude / 256;
+	sc->right = effect->u.rumble.weak_magnitude ? 1 : 0;
 
-	buf[3] = right;
-	buf[5] = left;
-
-	return hid->hid_output_raw_report(hid, buf, sizeof(buf),
-					  HID_OUTPUT_REPORT);
+	schedule_work(&sc->rumble_worker);
+	return 0;
 }
 
 static int sony_init_ff(struct hid_device *hdev)
@@ -650,16 +664,31 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct hid_input *hidinput = list_entry(hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	sc->hdev = hdev;
+	INIT_WORK(&sc->rumble_worker, sony_rumble_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
 }
 
+static void sony_destroy_ff(struct hid_device *hdev)
+{
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	cancel_work_sync(&sc->rumble_worker);
+}
+
 #else
 static int sony_init_ff(struct hid_device *hdev)
 {
 	return 0;
 }
+
+static void sony_destroy_ff(struct hid_device *hdev)
+{
+}
 #endif
 
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
@@ -728,6 +757,8 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & BUZZ_CONTROLLER)
 		buzz_remove(hdev);
 
+	sony_destroy_ff(hdev);
+
 	hid_hw_stop(hdev);
 }
 
-- 
1.8.4.3

