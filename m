From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Report ABS_MISC event for Cintiq Companion Hybrid
Date: Thu, 22 Jan 2015 15:53:28 -0800
Message-ID: <1421970808-4098-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39843 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbbAVXxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 18:53:34 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so367509pad.4
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2015 15:53:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>

It appears that the Cintiq Companion Hybrid does not send an ABS_MISC
event to userspace when any of its ExpressKeys are pressed. This is not
strictly necessary now that the pad exists on its own device, but
should be fixed for consistency's sake.

Traditionally both the stylus and pad shared the same device node, and
xf86-input-wacom would use ABS_MISC for disambiguation. Not sending this 
causes the Hybrid to behave incorrectly with xf86-input-wacom beginning with 
its 8f44f3 commit.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Question: I'd like to write a version of this patch which targets stable 
releases where the stylus and pad share the device node. How would I go 
about submitting one, since CCing this patch to stable won't quite do the 
trick (the patches would have to be against our old home under 
drivers/input/tablet...)

 drivers/hid/wacom_wac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a4ba8ca..f886149 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -783,6 +783,12 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_7, (data[4] & 0x40));  /* Left   */
 			input_report_key(input, BTN_8, (data[4] & 0x80));  /* Down   */
 			input_report_key(input, BTN_0, (data[3] & 0x01));  /* Center */
+
+			if (data[4] | (data[3] & 0x01)) {
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
 			int i;
 
-- 
2.2.1

