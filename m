From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC 2/7] Input: joystick - avoid fragile snprintf use
Date: Tue,  8 Mar 2016 21:40:49 +0100
Message-ID: <1457469654-17059-3-git-send-email-linux@rasmusvillemoes.dk>
References: <CAGXu5jJ-NApCpANjfz+bAEfwZJ8xizkM-jDHVhOPCzhxV-aqdA@mail.gmail.com>
 <1457469654-17059-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32768 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbcCHUlF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 15:41:05 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so166162222wml.0
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2016 12:41:04 -0800 (PST)
In-Reply-To: <1457469654-17059-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Passing overlapping src and dst buffers to snprintf is fragile, and
while it currently works for the special case of passing dst as the
argument corresponding to an initial "%s" in the format string, any
other use would very likely lead to chaos. It's easy enough to avoid,
so let's do that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/input/joystick/analog.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 6f8b084e13d0..d0a9b90e8f94 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -435,14 +435,16 @@ static void analog_calibrate_timer(struct analog_port *port)
 
 static void analog_name(struct analog *analog)
 {
-	snprintf(analog->name, sizeof(analog->name), "Analog %d-axis %d-button",
+	int ret = 0;
+
+	ret = scnprintf(analog->name, sizeof(analog->name), "Analog %d-axis %d-button",
 		 hweight8(analog->mask & ANALOG_AXES_STD),
 		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
 		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		snprintf(analog->name, sizeof(analog->name), "%s %d-hat",
-			 analog->name, hweight16(analog->mask & ANALOG_HATS_ALL));
+		scnprintf(analog->name + ret, sizeof(analog->name) - ret, " %d-hat",
+			  hweight16(analog->mask & ANALOG_HATS_ALL));
 
 	if (analog->mask & ANALOG_HAT_FCS)
 		strlcat(analog->name, " FCS", sizeof(analog->name));
-- 
2.1.4

