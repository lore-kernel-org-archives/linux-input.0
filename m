From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] pxa: Fix some issues with pxa27x_keypad driver v2
Date: Wed, 28 May 2008 16:25:39 +0200
Message-ID: <20080528162539.6d7a2158.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vsmtp21.tin.it ([212.216.176.109]:54868 "EHLO vsmtp21.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbYE1ObS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 10:31:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: eric miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dtor@mail.ru>


Fix some issues with pxa27x_keypad driver:

1. set input bits for direct keys codes
2. set input bits for rotary encoder codes only if rotary
   encoder is enabled
3. enable EV_REL only if rel_codes are set for rotary encoders

Signed-off-by: Antonio Ospite <ao2@openezx.org>

Index: linux-2.6.26-rc3/drivers/input/keyboard/pxa27x_keypad.c
===================================================================
--- linux-2.6.26-rc3.orig/drivers/input/keyboard/pxa27x_keypad.c
+++ linux-2.6.26-rc3/drivers/input/keyboard/pxa27x_keypad.c
@@ -136,6 +136,9 @@
 		set_bit(code, input_dev->keybit);
 	}
 
+	for (i = 0; i < pdata->direct_key_num; i++)
+		set_bit(pdata->direct_key_map[i], input_dev->keybit);
+
 	keypad->rotary_up_key[0] = pdata->rotary0_up_key;
 	keypad->rotary_up_key[1] = pdata->rotary1_up_key;
 	keypad->rotary_down_key[0] = pdata->rotary0_down_key;
@@ -143,17 +146,21 @@
 	keypad->rotary_rel_code[0] = pdata->rotary0_rel_code;
 	keypad->rotary_rel_code[1] = pdata->rotary1_rel_code;
 
-	if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
-		set_bit(pdata->rotary0_up_key, input_dev->keybit);
-		set_bit(pdata->rotary0_down_key, input_dev->keybit);
-	} else
-		set_bit(pdata->rotary0_rel_code, input_dev->relbit);
-
-	if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
-		set_bit(pdata->rotary1_up_key, input_dev->keybit);
-		set_bit(pdata->rotary1_down_key, input_dev->keybit);
-	} else
-		set_bit(pdata->rotary1_rel_code, input_dev->relbit);
+	if (pdata->enable_rotary0) {
+		if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
+			set_bit(pdata->rotary0_up_key, input_dev->keybit);
+			set_bit(pdata->rotary0_down_key, input_dev->keybit);
+		} else
+			set_bit(pdata->rotary0_rel_code, input_dev->relbit);
+	}
+
+	if (pdata->enable_rotary1) {
+		if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
+			set_bit(pdata->rotary1_up_key, input_dev->keybit);
+			set_bit(pdata->rotary1_down_key, input_dev->keybit);
+		} else
+			set_bit(pdata->rotary1_rel_code, input_dev->relbit);
+	}
 }
 
 static inline unsigned int lookup_matrix_keycode(
@@ -484,8 +491,9 @@
 	keypad->input_dev = input_dev;
 	input_set_drvdata(input_dev, keypad);
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
-		BIT_MASK(EV_REL);
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	if (keypad->pdata->rotary0_rel_code || keypad->pdata->rotary1_rel_code)
+		input_dev->evbit[0] |= BIT_MASK(EV_REL);
 
 	pxa27x_keypad_build_keycode(keypad);
 	platform_set_drvdata(pdev, keypad);

