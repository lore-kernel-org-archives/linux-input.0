From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ARM: pxa27x_keypad: clear pending interrupts on keypad config
Date: Sun, 26 Feb 2012 16:50:50 +0300
Message-ID: <1330264250-5883-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62556 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab2BZNvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Feb 2012 08:51:09 -0500
Received: by eaah12 with SMTP id h12so1813663eaa.19
        for <linux-input@vger.kernel.org>; Sun, 26 Feb 2012 05:51:08 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>

Bootloader can leave interrupt bit pending, and it confuses driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index eca6ae6..a5f198f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -360,6 +360,9 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	unsigned int mask = 0, direct_key_num = 0;
 	unsigned long kpc = 0;
 
+	/* clear pending interrupt bit */
+	keypad_readl(KPC);
+
 	/* enable matrix keys with automatic scan */
 	if (pdata->matrix_key_rows && pdata->matrix_key_cols) {
 		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
-- 
1.7.9.2

