From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/2] Input: amikbd - Allocate temporary keymap buffer on the stack
Date: Sun, 30 Nov 2014 10:30:20 +0100
Message-ID: <1417339820-5285-2-git-send-email-geert@linux-m68k.org>
References: <1417339820-5285-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:40620 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbaK3Ja1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Nov 2014 04:30:27 -0500
In-Reply-To: <1417339820-5285-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Allocate the temporary buffer needed for initialization of the console
keyboard maps (512 bytes, as NR_KEYS = 256) on the stack instead of
statically, to reduce kernel size.

add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-512 (-512)
function                                     old     new   delta
temp_map                                     512       -    -512

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Allocate temp_map[] on the stack instead of using kmalloc().
---
 drivers/input/keyboard/amikbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index 4f81e65d9e35cb7d..60580d8104b9f970 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -147,10 +147,10 @@ static unsigned char amikbd_keycode[0x78] __initdata = {
 
 static void __init amikbd_init_console_keymaps(void)
 {
+	unsigned short temp_map[NR_KEYS];
 	int i, j;
 
 	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
-		static u_short temp_map[NR_KEYS] __initdata;
 		if (!key_maps[i])
 			continue;
 		memset(temp_map, 0, sizeof(temp_map));
-- 
1.9.1

