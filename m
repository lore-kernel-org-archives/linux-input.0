From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: [PATCH] HID: magicmouse: Fix race in input mapping.
Date: Fri, 16 Sep 2011 15:12:34 -0700
Message-ID: <1316211154-9436-1-git-send-email-jaikumarg@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9753 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab1IPWMn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 18:12:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumarg@android.com>

magicmouse_select_input was being called after device
registration. Hence, any thread scanning "/dev" for new
devices will see the input bits change on an open file
descriptor. Fix this by calling select_input inside
input_mapping.

Based on discussions with Michael Poole <mdpoole@troilus.org>

Change-Id: I289a37a850977c2cbbc9eb76fbf6c9a28d1833c5
Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
---
 drivers/hid/hid-magicmouse.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 56d0539..1175452 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -98,6 +98,7 @@ struct magicmouse_sc {
 	int ntouches;
 	int scroll_accel;
 	unsigned long scroll_jiffies;
+	bool setup_input;
 
 	struct {
 		short x;
@@ -437,6 +438,11 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
 	if (!msc->input)
 		msc->input = hi->input;
 
+	if (!msc->setup_input) {
+		magicmouse_setup_input(msc->input, hdev);
+		msc->setup_input = true;
+	}
+
 	/* Magic Trackpad does not give relative data after switching to MT */
 	if (hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
 	    field->flags & HID_MAIN_ITEM_RELATIVE)
@@ -465,6 +471,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 	hid_set_drvdata(hdev, msc);
 
 	msc->single_touch_id = NO_TOUCHES;
+	msc->setup_input = false;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -478,12 +485,6 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	/* We do this after hid-input is done parsing reports so that
-	 * hid-input uses the most natural button and axis IDs.
-	 */
-	if (msc->input)
-		magicmouse_setup_input(msc->input, hdev);
-
 	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
 			MOUSE_REPORT_ID);
-- 
1.7.3.1

