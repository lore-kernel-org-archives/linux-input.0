From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/atari: Remove obsolete keyboard_tasklet scheduling
Date: Fri, 29 Aug 2014 18:14:56 +0200
Message-ID: <1409328896-8457-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:49539 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaH2QO5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Aug 2014 12:14:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_VT=n:

arch/m68k/atari/built-in.o: In function `atari_keyboard_interrupt':
atakeyb.c:(.text+0x1846): undefined reference to `keyboard_tasklet'
atakeyb.c:(.text+0x1852): undefined reference to `keyboard_tasklet'

I think the keyboard_tasklet scheduling is no longer needed, as I
believe it's handled by drivers/tty/vt/keyboard.c based on events
received from the input subsystem. So just remove it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Not tested on real hardware. ARAnyM doesn't have keyboard LEDs.

 arch/m68k/atari/atakeyb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/atari/atakeyb.c b/arch/m68k/atari/atakeyb.c
index 95022b04b62d..1e2be1d34635 100644
--- a/arch/m68k/atari/atakeyb.c
+++ b/arch/m68k/atari/atakeyb.c
@@ -170,7 +170,6 @@ repeat:
 	if (acia_stat & ACIA_RDRF) {
 		/* received a character */
 		scancode = acia.key_data;	/* get it or reset the ACIA, I'll get it! */
-		tasklet_schedule(&keyboard_tasklet);
 	interpret_scancode:
 		switch (kb_state.state) {
 		case KEYBOARD:
-- 
1.9.1

