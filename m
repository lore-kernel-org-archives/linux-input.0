From: Dan Carpenter <error27@gmail.com>
Subject: [patch] input/tc3589x: fix compile error
Date: Tue, 4 Jan 2011 14:08:20 +0300
Message-ID: <20110104110820.GC1886@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46696 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1ADLId (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jan 2011 06:08:33 -0500
Received: by fxm20 with SMTP id 20so13957188fxm.19
        for <linux-input@vger.kernel.org>; Tue, 04 Jan 2011 03:08:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-input@vger.kernel.org

There was a semi-colon missing and it broke the compile.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 69dc0cb..217a74f 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -469,4 +469,5 @@ module_exit(tc3589x_keypad_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jayeeta Banerjee/Sundar Iyer");
 MODULE_DESCRIPTION("TC35893 Keypad Driver");
-MODULE_ALIAS("platform:tc3589x-keypad")
+MODULE_ALIAS("platform:tc3589x-keypad");
+
