From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 4/6] HID: magicmouse: remove axis data filtering
Date: Mon, 30 Aug 2010 13:20:56 -0400
Message-ID: <1283188858-4839-4-git-send-email-chase.douglas@canonical.com>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57819 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab0H3RVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 13:21:08 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Oq82b-00078F-W2
	for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 18:21:06 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1Oq82b-0006Dr-NX
	for linux-input@vger.kernel.org; Mon, 30 Aug 2010 18:21:05 +0100
In-Reply-To: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The Magic Mouse device is very precise. No driver filtering of input
data needs to be performed.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f3ee6ab..65ec2f8 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -357,11 +357,11 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 		__set_bit(EV_ABS, input->evbit);
 
 		input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 1, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_X, -1100, 1358,
-				4, 0);
+				0, 0);
 		/* Note: Touch Y position from the device is inverted relative
 		 * to how pointer motion is reported (and relative to how USB
 		 * HID recommends the coordinates work).  This driver keeps
@@ -369,7 +369,7 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 		 * inverse of the reported Y.
 		 */
 		input_set_abs_params(input, ABS_MT_POSITION_Y, -1589, 2047,
-				4, 0);
+				0, 0);
 	}
 
 	if (report_undeciphered) {
-- 
1.7.1

