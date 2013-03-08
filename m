From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH] Input: tc3589x-keypad - fix keymap size
Date: Fri, 8 Mar 2013 15:26:43 +0100
Message-ID: <1362752803-21853-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from beta.dmz-us.st.com ([167.4.1.35]:33898 "EHLO beta.dmz-us.st.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758058Ab3CHPA3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Mar 2013 10:00:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, rabin@rab.in, Rabin Vincent <rabin.vincent@stericsson.com>

The keymap size used by tc3589x is too low, leading to the driver
overwriting other people's memory.  Fix this by making the driver use
the automatically allocated keymap provided by
matrix_keypad_build_keymap() instead of allocating one on its own.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/input/keyboard/tc3589x-keypad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 2fb0d76..208de7c 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -70,8 +70,6 @@
 #define TC3589x_EVT_INT_CLR	0x2
 #define TC3589x_KBD_INT_CLR	0x1
 
-#define TC3589x_KBD_KEYMAP_SIZE     64
-
 /**
  * struct tc_keypad - data structure used by keypad driver
  * @tc3589x:    pointer to tc35893
@@ -88,7 +86,7 @@ struct tc_keypad {
 	const struct tc3589x_keypad_platform_data *board;
 	unsigned int krow;
 	unsigned int kcol;
-	unsigned short keymap[TC3589x_KBD_KEYMAP_SIZE];
+	unsigned short *keymap;
 	bool keypad_stopped;
 };
 
@@ -338,12 +336,14 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 
 	error = matrix_keypad_build_keymap(plat->keymap_data, NULL,
 					   TC3589x_MAX_KPROW, TC3589x_MAX_KPCOL,
-					   keypad->keymap, input);
+					   NULL, input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to build keymap\n");
 		goto err_free_mem;
 	}
 
+	keypad->keymap = input->keycode;
+
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	if (!plat->no_autorepeat)
 		__set_bit(EV_REP, input->evbit);
-- 
1.8.1.5

