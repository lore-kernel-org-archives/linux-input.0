From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Make keyboard.c match braille-only keyboards
Date: Fri, 30 Jul 2010 22:41:18 +0200
Message-ID: <20100730204117.GI4824@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:60981 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab0G3UlX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 16:41:23 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

drivers/char/keyboard.c also handles braille keys, so it should also match
braille-only keyboards.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 54109dc..25be210 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1315,10 +1315,14 @@ static bool kbd_match(struct input_handler *handler, struct input_dev *dev)
 	if (test_bit(EV_SND, dev->evbit))
 		return true;
 
-	if (test_bit(EV_KEY, dev->evbit))
+	if (test_bit(EV_KEY, dev->evbit)) {
 		for (i = KEY_RESERVED; i < BTN_MISC; i++)
 			if (test_bit(i, dev->keybit))
 				return true;
+		for (i = KEY_BRL_DOT1; i <= KEY_BRL_DOT10; i++)
+			if (test_bit(i, dev->keybit))
+				return true;
+	}
 
 	return false;
 }
