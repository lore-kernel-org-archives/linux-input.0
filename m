From: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Subject: [PATCH 1/1] input: ff-memless: Allow negative attack / fade ramps
Date: Thu, 27 Aug 2015 14:03:42 +0300
Message-ID: <1440673422-12279-2-git-send-email-kalle.jokiniemi@jolla.com>
References: <1440673422-12279-1-git-send-email-kalle.jokiniemi@jolla.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp80.ord1c.emailsrvr.com ([108.166.43.80]:36310 "EHLO
	smtp80.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752783AbbH0LLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 07:11:42 -0400
In-Reply-To: <1440673422-12279-1-git-send-email-kalle.jokiniemi@jolla.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jolla.com>

Currently the ff-memless force feedback periodic effects can only
have rising attack periods and declining fade periods. E.g. setting
a attack ramp that starts high to lower to normal magnitude, will
just cause the effect to rumble at high static speed for duration
of the attack period and then abruptly lower back to normal
magnitude instead of linearly declining the effect during attack
phase.

To fix this, a check has been added to see if the envelope_level
of the attack or fade period is higher than default magnitude or
vise versa, and then adjusting the difference value calculation
accordingly.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
---
 drivers/input/ff-memless.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 0723e0d..487df7e 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -190,7 +190,10 @@ static int apply_envelope(struct ml_effect_state *state, int value,
 	} else
 		return value;
 
-	difference = abs(value) - envelope_level;
+	if (abs(value) >= envelope_level)
+		difference = abs(value) - envelope_level;
+	else
+		difference = -(envelope_level - abs(value));
 
 	pr_debug("difference = %d\n", difference);
 	pr_debug("time_from_level = 0x%x\n", time_from_level);
-- 
1.9.1

