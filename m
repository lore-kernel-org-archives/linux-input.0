From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 3/4] HID: magicmouse: disable and add module param for scroll acceleration
Date: Wed,  2 Jun 2010 10:28:27 -0400
Message-ID: <1275488908-23624-4-git-send-email-chase.douglas@canonical.com>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51450 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab0FBO2g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 10:28:36 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OJovs-0003L9-5h
	for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 15:28:36 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1OJovr-0005FT-Su
	for linux-input@vger.kernel.org; Wed, 02 Jun 2010 15:28:36 +0100
In-Reply-To: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Scroll acceleration is unique to the magicmouse driver, and is
unintuitive to a user who is unaware of the functionality. Thus, disable
it by default, but add a module parameter to enable it for power users
who want it.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 171ed0c..f44aaf2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -30,6 +30,10 @@ static bool emulate_scroll_wheel = true;
 module_param(emulate_scroll_wheel, bool, 0644);
 MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
 
+static bool scroll_acceleration = false;
+module_param(scroll_acceleration, bool, 0644);
+MODULE_PARM_DESC(scroll_acceleration, "Accelerate sequential scroll events");
+
 static bool report_touches = true;
 module_param(report_touches, bool, 0644);
 MODULE_PARM_DESC(report_touches, "Emit touch records (otherwise, only use them for emulation)");
@@ -177,7 +181,9 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		switch (tdata[7] & TOUCH_STATE_MASK) {
 		case TOUCH_STATE_START:
 			msc->touches[id].scroll_y = y;
-			msc->scroll_accel = min_t(int, msc->scroll_accel + 1,
+			if (scroll_acceleration)
+				msc->scroll_accel = min_t(int,
+						msc->scroll_accel + 1,
 						ARRAY_SIZE(accel_profile) - 1);
 			break;
 		case TOUCH_STATE_DRAG:
-- 
1.7.0.4

