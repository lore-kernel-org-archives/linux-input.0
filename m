From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC PATCH] Only process ABS_MT_SLOT where there are slots available
Date: Thu, 18 Aug 2011 12:28:53 +0200
Message-ID: <1313663333-19810-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:46300 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462Ab1HRK3M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 06:29:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Simon Wood <simon@mungewell.org>, Henrik Rydberg <rydberg@euromail.se>, virtuousfox@gmail.com

This fixes the case when a non-multitouch device happens to have a HID
code equal to ABS_MT_SLOT, like the Sony Sixaxis has for the left dpad
analog control.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
Cc: Simon Wood <simon@mungewell.org>
Cc: Henrik Rydberg <rydberg@euromail.se>
Cc: virtuousfox@gmail.com
---

Hi,

following up from the discussion at 
http://thread.gmane.org/gmane.linux.kernel.input/19632 I've come up with this 
workaround to make the dpad left analog axis of the Sony Sixaxis controller 
working. What happens is that this button has a code of 0x2f (ABS_MT_SLOT) 
which gets some special handling regardless of the device being a multitouch one 
or not.

I do not know anything about multitouch devices, so I am not sure if this 
hack may break something else, I'd like some advice here.

Another possibility could be to remap the code at the HID level for the 
Sixaxis only, Simon you suggested this, are you willing to do that if this 
will be the preferred way? My HID-fu is way worse than yours and It'll take a 
lot more time for me.

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/input/input.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index da38d97..f878ae9 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -169,7 +169,7 @@ static int input_handle_abs_event(struct input_dev *dev,
 	bool is_mt_event;
 	int *pold;
 
-	if (code == ABS_MT_SLOT) {
+	if (code == ABS_MT_SLOT && dev->mtsize > 0) {
 		/*
 		 * "Stage" the event; we'll flush it later, when we
 		 * get actual touch data.
@@ -205,7 +205,8 @@ static int input_handle_abs_event(struct input_dev *dev,
 	}
 
 	/* Flush pending "slot" event */
-	if (is_mt_event && dev->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
+	if (is_mt_event && dev->slot != input_abs_get_val(dev, ABS_MT_SLOT) &&
+	    dev->mtsize > 0 ) {
 		input_abs_set_val(dev, ABS_MT_SLOT, dev->slot);
 		input_pass_event(dev, EV_ABS, ABS_MT_SLOT, dev->slot);
 	}
-- 
1.7.5.4

