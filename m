From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Properly free inputs if 'wacom_allocate_inputs' fails
Date: Mon, 13 Jul 2015 18:03:44 -0700
Message-ID: <1436835825-15380-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35259 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbbGNBDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 21:03:53 -0400
Received: by pdrg1 with SMTP id g1so101009235pdr.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 18:03:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The 'wacom_allocate_inputs' function tries to allocate three input
devices: one each for the pen, touch, and pad. The pointers that are
returned by the 'wacom_allocate_input' calls are temporarily stored
to local variables where they are checked to ensure they're non-null
before storing them in the 'wacom_wac' structure. If an allocation
fails,  the 'wacom_free_inputs' function is called to reclaim the
memory. Unfortunately, 'wacom_free_inputs' is called prior to the
pointers being copied, so it is not actually able to free anything.

This patch has the calls to 'wacom_allocate_input' store the pointer
directly in the 'wacom_wac' structure where they can be freed. Also,
it replaces the call to 'wacom_free_inputs' with the (more general)
'wacom_clean_inputs' and removes the no-longer-used function.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri,

This patch should cleanly apply to either your 'for-4.3/wacom' or
'for-4.2/upstream-fixes' branch. It conflicts with 'for-4.3/upstream'
where Markus' "Delete unnecessary checks" patch (67e123f) resides.
I can provide a patch which applies cleanly to that branch instead
if you would like. The conflict is due to his patch modifying the
'wacom_free_inputs' function; this patch removes the function
entirely though so the conflict shouldn't be too difficult to resolve.

Jason

 drivers/hid/wacom_sys.c | 55 ++++++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4c0ffca..3512d83 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1145,43 +1145,6 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	return input_dev;
 }
 
-static void wacom_free_inputs(struct wacom *wacom)
-{
-	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
-
-	if (wacom_wac->pen_input)
-		input_free_device(wacom_wac->pen_input);
-	if (wacom_wac->touch_input)
-		input_free_device(wacom_wac->touch_input);
-	if (wacom_wac->pad_input)
-		input_free_device(wacom_wac->pad_input);
-	wacom_wac->pen_input = NULL;
-	wacom_wac->touch_input = NULL;
-	wacom_wac->pad_input = NULL;
-}
-
-static int wacom_allocate_inputs(struct wacom *wacom)
-{
-	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
-	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
-
-	pen_input_dev = wacom_allocate_input(wacom);
-	touch_input_dev = wacom_allocate_input(wacom);
-	pad_input_dev = wacom_allocate_input(wacom);
-	if (!pen_input_dev || !touch_input_dev || !pad_input_dev) {
-		wacom_free_inputs(wacom);
-		return -ENOMEM;
-	}
-
-	wacom_wac->pen_input = pen_input_dev;
-	wacom_wac->touch_input = touch_input_dev;
-	wacom_wac->touch_input->name = wacom_wac->touch_name;
-	wacom_wac->pad_input = pad_input_dev;
-	wacom_wac->pad_input->name = wacom_wac->pad_name;
-
-	return 0;
-}
-
 static void wacom_clean_inputs(struct wacom *wacom)
 {
 	if (wacom->wacom_wac.pen_input) {
@@ -1208,6 +1171,24 @@ static void wacom_clean_inputs(struct wacom *wacom)
 	wacom_destroy_leds(wacom);
 }
 
+static int wacom_allocate_inputs(struct wacom *wacom)
+{
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+
+	wacom_wac->pen_input = wacom_allocate_input(wacom);
+	wacom_wac->touch_input = wacom_allocate_input(wacom);
+	wacom_wac->pad_input = wacom_allocate_input(wacom);
+	if (!wacom_wac->pen_input || !wacom_wac->touch_input || !wacom_wac->pad_input) {
+		wacom_clean_inputs(wacom);
+		return -ENOMEM;
+	}
+
+	wacom_wac->touch_input->name = wacom_wac->touch_name;
+	wacom_wac->pad_input->name = wacom_wac->pad_name;
+
+	return 0;
+}
+
 static int wacom_register_inputs(struct wacom *wacom)
 {
 	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
-- 
2.4.5

