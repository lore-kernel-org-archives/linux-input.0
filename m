From: Karl Dahlke <dmitry.torokhov@gmail.com>
Subject: [PATCH 21/37] Input: put ledstate in the keyboard notifier
Date: Tue, 15 Apr 2008 01:30:32 -0400
Message-ID: <0beb4f6f294b0f2dde07fa9da9c00abd4f9c8b50.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688AbYDUNTf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:35 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:35 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Led state should be part of the key event, like shiftstate, and not
grabbed asynchronously after the fact.

[samuel.thibault@ens-lyon.org: various fixes]

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/char/keyboard.c  |    2 ++
 include/linux/keyboard.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 4dbd342..59608e3 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1237,6 +1237,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	}
 
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
+	param.ledstate = kbd->ledflagstate;
 	key_map = key_maps[shift_final];
 
 	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYCODE, &param) == NOTIFY_STOP || !key_map) {
@@ -1285,6 +1286,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	(*k_handler[type])(vc, keysym & 0xff, !down);
 
+	param.ledstate = kbd->ledflagstate;
 	atomic_notifier_call_chain(&keyboard_notifier_list, KBD_POST_KEYSYM, &param);
 
 	if (type != KT_SLOCK)
diff --git a/include/linux/keyboard.h b/include/linux/keyboard.h
index 65c2d70..a3c984d 100644
--- a/include/linux/keyboard.h
+++ b/include/linux/keyboard.h
@@ -33,6 +33,7 @@ struct keyboard_notifier_param {
 	struct vc_data *vc;	/* VC on which the keyboard press was done */
 	int down;		/* Pressure of the key? */
 	int shift;		/* Current shift mask */
+	int ledstate;		/* Current led state */
 	unsigned int value;	/* keycode, unicode value or keysym */
 };
 
-- 
1.5.5.rc2.6.gf58d


