From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: ff-memless - fix a couple min_t() casts
Date: Mon, 26 Sep 2011 09:16:04 +0300
Message-ID: <20110926061604.GC11832@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:43657 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1IZGQ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 02:16:26 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

envelope->attack_level is a u16 type.  We're trying to clamp it here
so it's between 0 and 0x7fff.  Unfortunately, the cast to __s16 turns
all the values larger than 0x7fff into negative numbers and min_t()
thinks they are less than 0x7fff.  envelope_level is an int so now
we've got negative values stored there.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 117a59a..4d2aa41 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -177,7 +177,7 @@ static int apply_envelope(struct ml_effect_state *state, int value,
 			 value, envelope->attack_level);
 		time_from_level = jiffies_to_msecs(now - state->play_at);
 		time_of_envelope = envelope->attack_length;
-		envelope_level = min_t(__s16, envelope->attack_level, 0x7fff);
+		envelope_level = min_t(u16, envelope->attack_level, 0x7fff);
 
 	} else if (envelope->fade_length && effect->replay.length &&
 		   time_after(now,
@@ -185,7 +185,7 @@ static int apply_envelope(struct ml_effect_state *state, int value,
 		   time_before(now, state->stop_at)) {
 		time_from_level = jiffies_to_msecs(state->stop_at - now);
 		time_of_envelope = envelope->fade_length;
-		envelope_level = min_t(__s16, envelope->fade_level, 0x7fff);
+		envelope_level = min_t(u16, envelope->fade_level, 0x7fff);
 	} else
 		return value;
 
