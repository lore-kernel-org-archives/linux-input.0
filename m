From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 1/5] HID: sony: Rename rumble_* functions/variables to state_*
Date: Tue, 19 Nov 2013 20:26:28 +0100
Message-ID: <1384889192-18488-2-git-send-email-sven@narfation.org>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42235 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3KST0k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 14:26:40 -0500
In-Reply-To: <1384889192-18488-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Sven Eckelmann <sven@narfation.org>

The commands used to modify the rumble motor state also modifies the LEDs at
the same time. The functionality used to modify this state in the driver has to
be shared between the rumble and LED part. It is therefore better to replace
the "rumble" part of the names with "state".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 098af2f8..28b847a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -226,7 +226,7 @@ struct sony_sc {
 	unsigned long quirks;
 
 #ifdef CONFIG_SONY_FF
-	struct work_struct rumble_worker;
+	struct work_struct state_worker;
 	struct hid_device *hdev;
 	__u8 left;
 	__u8 right;
@@ -622,9 +622,9 @@ static void buzz_remove(struct hid_device *hdev)
 }
 
 #ifdef CONFIG_SONY_FF
-static void sony_rumble_worker(struct work_struct *work)
+static void sony_state_worker(struct work_struct *work)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, rumble_worker);
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	unsigned char buf[] = {
 		0x01,
 		0x00, 0xff, 0x00, 0xff, 0x00,
@@ -655,7 +655,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	sc->left = effect->u.rumble.strong_magnitude / 256;
 	sc->right = effect->u.rumble.weak_magnitude ? 1 : 0;
 
-	schedule_work(&sc->rumble_worker);
+	schedule_work(&sc->state_worker);
 	return 0;
 }
 
@@ -667,7 +667,7 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	sc->hdev = hdev;
-	INIT_WORK(&sc->rumble_worker, sony_rumble_worker);
+	INIT_WORK(&sc->state_worker, sony_state_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
@@ -677,7 +677,7 @@ static void sony_destroy_ff(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	cancel_work_sync(&sc->rumble_worker);
+	cancel_work_sync(&sc->state_worker);
 }
 
 #else
-- 
1.8.4.3

