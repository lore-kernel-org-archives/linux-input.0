From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on keypad config
Date: Sun, 28 Oct 2012 18:46:03 +0300
Message-ID: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36364 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab2J1PqP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Oct 2012 11:46:15 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2548797lbo.19
        for <linux-input@vger.kernel.org>; Sun, 28 Oct 2012 08:46:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>

Bootloader can leave interrupt bit pending, and it confuses driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
Rebased against v3.7-rc2

 drivers/input/keyboard/pxa27x_keypad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 803ff6f..cad9d5d 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -368,6 +368,9 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	unsigned int mask = 0, direct_key_num = 0;
 	unsigned long kpc = 0;
 
+	/* clear pending interrupt bit */
+	keypad_readl(KPC);
+
 	/* enable matrix keys with automatic scan */
 	if (pdata->matrix_key_rows && pdata->matrix_key_cols) {
 		kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
-- 
1.7.12.4

