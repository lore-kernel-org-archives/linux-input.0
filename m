From: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Subject: [PATCH 1/1] input: ff-memless: Change FF_ENVELOPE_INTERVAL to a module parameter.
Date: Fri, 28 Aug 2015 14:56:33 +0300
Message-ID: <1440762993-31329-1-git-send-email-kalle.jokiniemi@jolla.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:47401 "EHLO
	smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794AbbH1L4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 07:56:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jolla.com>

Sometimes you need to have tighter control over the ff-memless
effects. E.g. when creating short button / VKB press effects,
the effect duration is typically <= 40ms, and you want to have
a short acceleration period in beginning and fade out the end
to avoid "electric tooth brush" effect. With 50ms envelope
interval this control is not possible.

To allow this control without patching over ff-memless, change the
FF_ENVELOPE_INTERVAL macro to a module parameter that can be modified
via kernel command line or during runtime from
/sys/module/ff_memless/parameters/ff_envelope_interval sysfs file.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
---
 drivers/input/ff-memless.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index fcc6c33..058e4cb 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -41,7 +41,8 @@ MODULE_DESCRIPTION("Force feedback support for memoryless devices");
 #define FF_MEMLESS_EFFECTS	16
 
 /* Envelope update interval in ms */
-#define FF_ENVELOPE_INTERVAL	50
+static int ff_envelope_interval = 50;
+module_param(ff_envelope_interval, int, S_IWUSR | S_IRUGO);
 
 #define FF_EFFECT_STARTED	0
 #define FF_EFFECT_PLAYING	1
@@ -96,7 +97,7 @@ static unsigned long calculate_next_time(struct ml_effect_state *state)
 			msecs_to_jiffies(envelope->attack_length);
 		if (time_before(state->adj_at, attack_stop))
 			return state->adj_at +
-					msecs_to_jiffies(FF_ENVELOPE_INTERVAL);
+					msecs_to_jiffies(ff_envelope_interval);
 	}
 
 	if (state->effect->replay.length) {
@@ -110,7 +111,7 @@ static unsigned long calculate_next_time(struct ml_effect_state *state)
 
 			/* already fading, advance to next checkpoint */
 			next_fade = state->adj_at +
-					msecs_to_jiffies(FF_ENVELOPE_INTERVAL);
+					msecs_to_jiffies(ff_envelope_interval);
 			if (time_before(next_fade, state->stop_at))
 				return next_fade;
 		}
-- 
1.9.1

