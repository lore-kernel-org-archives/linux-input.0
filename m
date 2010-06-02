From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 2/4] HID: magicmouse: properly account for scroll movement in state
Date: Wed,  2 Jun 2010 10:28:26 -0400
Message-ID: <1275488908-23624-3-git-send-email-chase.douglas@canonical.com>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51423 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab0FBO2f (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 10:28:35 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OJovq-0003Jb-Cu
	for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 15:28:34 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1OJovq-0005FQ-4Z
	for linux-input@vger.kernel.org; Wed, 02 Jun 2010 15:28:34 +0100
In-Reply-To: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Before this change, sequential scroll events would take a variable
amount of movement due to incorrect accounting. This change ensures all
scroll movements require a deterministic touch movement for an action to
occur.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index cd70635..171ed0c 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -183,7 +183,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		case TOUCH_STATE_DRAG:
 			step = step / accel_profile[msc->scroll_accel];
 			if (step != 0) {
-				msc->touches[id].scroll_y = y;
+				msc->touches[id].scroll_y -=
+					step * accel_profile[msc->scroll_accel];
 				msc->scroll_jiffies = now;
 				input_report_rel(input, REL_WHEEL, step);
 			}
-- 
1.7.0.4

