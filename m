From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 1/4] HID: magicmouse: scroll on entire surface, not just middle of mouse
Date: Wed,  2 Jun 2010 10:28:25 -0400
Message-ID: <1275488908-23624-2-git-send-email-chase.douglas@canonical.com>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51396 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab0FBO2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 10:28:33 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OJovo-0003Hg-LN
	for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 15:28:32 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1OJovo-0005FK-Dk
	for linux-input@vger.kernel.org; Wed, 02 Jun 2010 15:28:32 +0100
In-Reply-To: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Previously, scroll events only occurred when the user moved a touch
along the middle of the touch surface. This is unintuitive for a normal
user who is not aware of this. The device has a uniform surface, so the
distinction is artificial. This change removes the touch area check for
a scroll event, which replicates the OS X behavior.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f10d56a..cd70635 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -160,10 +160,9 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	msc->touches[id].size = misc & 63;
 
 	/* If requested, emulate a scroll wheel by detecting small
-	 * vertical touch motions along the middle of the mouse.
+	 * vertical touch motions.
 	 */
-	if (emulate_scroll_wheel &&
-	    middle_button_start < x && x < middle_button_stop) {
+	if (emulate_scroll_wheel) {
 		static const int accel_profile[] = {
 			256, 228, 192, 160, 128, 96, 64, 32,
 		};
-- 
1.7.0.4

