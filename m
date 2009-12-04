From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [PATCH] Input: Add direction to ff-memless
Date: Fri,  4 Dec 2009 15:05:13 +0200
Message-ID: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53923 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297AbZLDNFP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 08:05:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, ext-jari.vanhala@nokia.com

This adds simple direction calculation to effect
combine. It's useful to decide motor direction for
rumble (vibrator).

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/ff-memless.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 2d1415e..9af009a 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -221,6 +221,14 @@ static int get_compatible_type(struct ff_device *ff, int effect_type)
 	return 0;
 }
 
+static unsigned int ml_calculate_direction(
+	unsigned int direction, unsigned int force,
+	unsigned int new_direction, unsigned int new_force)
+{
+	return ((u32)direction * force + new_direction * new_force) /
+		(force + new_force);
+}
+
 /*
  * Combine two effects and apply gain.
  */
@@ -255,6 +263,19 @@ static void ml_combine_effects(struct ff_effect *effect,
 	case FF_RUMBLE:
 		strong = new->u.rumble.strong_magnitude * gain / 0xffff;
 		weak = new->u.rumble.weak_magnitude * gain / 0xffff;
+
+		if (effect->u.rumble.strong_magnitude + strong)
+			effect->direction = ml_calculate_direction(
+				effect->direction,
+				effect->u.rumble.strong_magnitude,
+				new->direction, strong);
+		else if (effect->u.rumble.weak_magnitude + weak)
+			effect->direction = ml_calculate_direction(
+				effect->direction,
+				effect->u.rumble.weak_magnitude,
+				new->direction, weak);
+		else
+			effect->direction = 0;
 		effect->u.rumble.strong_magnitude =
 			min(strong + effect->u.rumble.strong_magnitude,
 			    0xffffU);
@@ -269,6 +290,13 @@ static void ml_combine_effects(struct ff_effect *effect,
 		/* here we also scale it 0x7fff => 0xffff */
 		i = i * gain / 0x7fff;
 
+		if (effect->u.rumble.strong_magnitude + i)
+			effect->direction = ml_calculate_direction(
+				effect->direction,
+				effect->u.rumble.strong_magnitude,
+				new->direction, i);
+		else
+			effect->direction = 0;
 		effect->u.rumble.strong_magnitude =
 			min(i + effect->u.rumble.strong_magnitude, 0xffffU);
 		effect->u.rumble.weak_magnitude =
-- 
1.6.3.3

