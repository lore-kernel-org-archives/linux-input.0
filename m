From: Jeff Brown <jeffbrown@android.com>
Subject: [PATCH v2 2/4] hid: hid-input: Remove obsolete default events per packet setting.
Date: Fri,  1 Apr 2011 23:54:17 -0700
Message-ID: <1301727259-5185-2-git-send-email-jeffbrown@android.com>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40464 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1DBGyw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Apr 2011 02:54:52 -0400
In-Reply-To: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, djkurtz@google.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Brown <jeffbrown@google.com>, jeffbrown@android.com

From: Jeff Brown <jeffbrown@google.com>

The hardcoded default is no longer needed because the input core now
calculates an appropriate value when the input device is registered.

Signed-off-by: jeffbrown@android.com
---
 drivers/hid/hid-input.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 33dde87..4b348e0 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -665,10 +665,6 @@ mapped:
 
 		input_abs_set_res(input, usage->code,
 				  hidinput_calc_abs_res(field, usage->code));
-
-		/* use a larger default input buffer for MT devices */
-		if (usage->code == ABS_MT_POSITION_X && input->hint_events_per_packet == 0)
-			input_set_events_per_packet(input, 60);
 	}
 
 	if (usage->type == EV_ABS &&
-- 
1.7.0.4

