From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] input: atari - Enable the 102nd key for German keyboards
Date: Sat, 17 Jan 2015 19:02:05 +0100
Message-ID: <1421517725-31970-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Schmitz <schmitz@debian.org>, linux-input@vger.kernel.org, linux-m68k@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Acked-by: Thorsten Glaser <tg@mirbsd.org>
Tested-by: Stefan Niestegge <beetle@atari.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/keyboard/atakbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index 10bcd4ae5402..f1235831283d 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -170,7 +170,7 @@ static unsigned char atakbd_keycode[0x72] = {	/* American layout */
 	[93]	 = KEY_KPASTERISK,
 	[94]	 = KEY_KPPLUS,
 	[95]	 = KEY_HELP,
-	[96]	 = KEY_BACKSLASH,	/* FIXME: '<' */
+	[96]	 = KEY_102ND,
 	[97]	 = KEY_KPASTERISK,	/* FIXME */
 	[98]	 = KEY_KPSLASH,
 	[99]	 = KEY_KPLEFTPAREN,
-- 
1.9.1
