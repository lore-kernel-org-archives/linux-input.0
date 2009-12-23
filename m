From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [RFC] ff-memless instant starting
Date: Wed, 23 Dec 2009 15:31:14 +0200
Message-ID: <1261575074.24604.31.camel@tema>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2mrcevQF6B+U0cn0KIGU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39634 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbZLWNcS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 08:32:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>


--=-2mrcevQF6B+U0cn0KIGU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

Looks like starting effect with low HZ machine takes considerably time
due need to wait for system timer. Simplest way to make things faster is
to do calculation for effect always instantly, like in stopping, but
this makes starting multiple effects more costly.

Other solution would be making it a module parameter, so behavior could
be controlled per machine. Optimize possible cost or speed. I attached
small patch which will do that.

If starting priority of individual effect is needed to controlled, you
probably need to add flag for that to effect itself... I don't know
which way FF-api is developing, so this could be either good or bad
thing.

Any opinions or suggestions? Other than rising HZ. =)

	++Jam


--=-2mrcevQF6B+U0cn0KIGU
Content-Disposition: attachment; filename="0001-Input-Add-instant-option-to-ff-memless.patch"
Content-Type: text/x-patch; name="0001-Input-Add-instant-option-to-ff-memless.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From d3b6fa1eaac42f878f7c9b89b22ddfa85d900f38 Mon Sep 17 00:00:00 2001
From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Date: Tue, 22 Dec 2009 16:49:29 +0200
Subject: [PATCH] Input: Add instant option to ff-memless

Allows Force Feedback effect to be started immediately
and not to wait for timer. Useful in low HZ systems.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/ff-memless.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index b483b29..dfd5830 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -67,6 +67,10 @@ struct ml_device {
 			   struct ff_effect *effect);
 };
 
+static int instant;
+module_param(instant, int, 0);
+MODULE_PARM_DESC(instant, "Start new effect instantly");
+
 static const struct ff_envelope *get_envelope(const struct ff_effect *effect)
 {
 	static const struct ff_envelope empty_envelope;
@@ -411,7 +415,10 @@ static int ml_ff_playback(struct input_dev *dev, int effect_id, int value)
 				 msecs_to_jiffies(state->effect->replay.length);
 		state->adj_at = state->play_at;
 
-		ml_schedule_timer(ml);
+		if (instant && !state->effect->replay.delay)
+			ml_play_effects(ml);
+		else
+			ml_schedule_timer(ml);
 
 	} else {
 		debug("initiated stop");
-- 
1.6.3.3


--=-2mrcevQF6B+U0cn0KIGU--

