From: Yufeng Shen <miletus@chromium.org>
Subject: [PATCH] HID: magicmouse: Correct report range of major / minor axes
Date: Fri, 22 Jun 2012 12:31:53 -0400
Message-ID: <1340382713-2957-1-git-send-email-miletus@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:49013 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab2FVQi0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jun 2012 12:38:26 -0400
Received: by vbnl22 with SMTP id l22so208040vbn.1
        for <linux-input@vger.kernel.org>; Fri, 22 Jun 2012 09:38:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, Yufeng Shen <miletus@chromium.org>, Andrew de los Reyes <adlr@chromium.org>

In patch "HID: magicmouse: Adjust major / minor axes to scale",
touch_major and touch_minor axes are scaled by a factor of
four when reported but the max touch_major/minor is not scaled
accordingly. This patch scales the max touch_major/minor to
be consistent with the reported value.

Signed-off-by: Yufeng Shen <miletus@chromium.org>
---
 drivers/hid/hid-magicmouse.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7cf3ffe..40ac665 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -426,8 +426,10 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 		__set_bit(EV_ABS, input->evbit);
 
 		input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 4, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255 << 2,
+				     4, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2,
+				     4, 0);
 		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
 
 		/* Note: Touch Y position from the device is inverted relative
-- 
1.7.7.3

