From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 1/3] HID: magicmouse: properly account for scroll movement in state
Date: Sun, 20 Jun 2010 21:32:29 -0400
Message-ID: <1277083951-29137-2-git-send-email-chase.douglas@canonical.com>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53164 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0FUBcg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 21:32:36 -0400
In-Reply-To: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org

Before this change, sequential scroll events would take a variable
amount of movement due to incorrect accounting. This change ensures all
scroll movements require a deterministic touch movement for an action to
occur.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Acked-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 4c4a79c..f44aaf2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -189,7 +189,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
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

