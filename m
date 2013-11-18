From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv3 1/5] HID: sony: Send ff commands in non-atomic context
Date: Mon, 18 Nov 2013 21:42:32 +0100
Message-ID: <1384807356-15561-2-git-send-email-sven@narfation.org>
References: <1384807356-15561-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42168 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab3KRUnP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 15:43:15 -0500
In-Reply-To: <1384807356-15561-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>, Sven Eckelmann <sven@narfation.org>

The ff_memless has a timer running which gets run in an atomic context and
calls the play_effect callback. The callback function for sony uses the
hid_output_raw_report (overwritten by sixaxis_usb_output_raw_report) function
to handle differences in the control message format. It is not safe for an
atomic context because it may sleep later in usb_start_wait_urb.

This "scheduling while atomic" can cause the system to lock up. A workaround is
to make the force feedback state update using work_queues and use the
play_effect function only to enqueue the work item.

This problem was introduced in a08c22c0df0ad23d0df10ae1a9df26643589b3cc
("HID: sony: Add force feedback support for Dualshock3 USB").

Reported-by: Simon Wood <simon@mungewell.org>
Reported-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 53 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index da551d1..28b847a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -225,6 +225,13 @@ static const unsigned int buzz_keymap[] = {
 struct sony_sc {
 	unsigned long quirks;
 
+#ifdef CONFIG_SONY_FF
+	struct work_struct state_worker;
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
+static void sony_state_worker(struct work_struct *work)
 {
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
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
+	schedule_work(&sc->state_worker);
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
+	INIT_WORK(&sc->state_worker, sony_state_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
 }
 
+static void sony_destroy_ff(struct hid_device *hdev)
+{
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	cancel_work_sync(&sc->state_worker);
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

