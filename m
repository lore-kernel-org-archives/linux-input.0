From: Clifton Barnes <clifton.a.barnes@gmail.com>
Subject: [PATCH] Input: tc3589x-keypad - remove stray ')'
Date: Sun, 22 May 2016 10:20:10 -0400
Message-ID: <1463926811-2921-1-git-send-email-clifton.a.barnes@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Clifton Barnes <clifton.a.barnes@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Himangi Saraogi <himangi774@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The end ')' needs to be removed if the macro is ever used or there
would be a compiler error as it does not have a matching '('.

Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>
---
 drivers/input/keyboard/tc3589x-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index e92dfd8..ec0070e 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -32,7 +32,7 @@
 #define TC3589x_PULL_DOWN_MASK		0x1
 #define TC3589x_PULL_UP_MASK		0x2
 #define TC3589x_PULLUP_ALL_MASK		0xAA
-#define TC3589x_IO_PULL_VAL(index, mask)	((mask)<<((index)%4)*2))
+#define TC3589x_IO_PULL_VAL(index, mask)	((mask)<<((index)%4)*2)
 
 /* Bit masks for IOCFG register */
 #define IOCFG_BALLCFG		0x01
-- 
1.9.1
