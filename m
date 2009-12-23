From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [PATCH v2] Input: Add direction to ff-memless
Date: Wed, 23 Dec 2009 14:58:14 +0200
Message-ID: <1261573094-26837-1-git-send-email-ext-jari.vanhala@nokia.com>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25854 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbZLWNBV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 08:01:21 -0500
In-Reply-To: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@iki.fi>, ext-jari.vanhala@nokia.com

This adds simple direction calculation to effect
combine. It's useful to decide motor direction for
rumble (vibrator).

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/ff-memless.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index b483b29..5914a7d 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -221,6 +221,22 @@ static int get_compatible_type(struct ff_device *ff, int effect_type)
 }
 
 /*
+ * Only left/right direction should be used (under/over 0x8000) for
+ * forward/reverse motor direction (to keep calculation fast & simple).
+ */
+static u16 ml_calculate_direction(u16 direction, u16 force,
+				  u16 new_direction, u16 new_force)
+{
+	if (!force)
+		return new_direction;
+	if (!new_force)
+		return direction;
+	return (((u32)(direction >> 1) * force +
+		 (new_direction >> 1) * new_force) /
+		(force + new_force)) << 1;
+}
+
+/*
  * Combine two effects and apply gain.
  */
 static void ml_combine_effects(struct ff_effect *effect,
@@ -254,6 +270,19 @@ static void ml_combine_effects(struct ff_effect *effect,
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
@@ -268,6 +297,13 @@ static void ml_combine_effects(struct ff_effect *effect,
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

