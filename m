From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 03/10] m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
Date: Wed, 15 Aug 2007 11:45:42 +0200
Message-ID: <20070815094849.163898629@mail.of.borg>
References: <20070815094539.181979221@mail.of.borg>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline; filename=mac-mac_hid_mouse_emulate_buttons-prototype.diff
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: linux-input@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible

drivers/char/keyboard.c: In function 'kbd_keycode':
drivers/char/keyboard.c:1142: error: implicit declaration of function 'mac_hid_mouse_emulate_buttons'

The forward declaration of mac_hid_mouse_emulate_buttons() is not visible on
m68k because it's hidden in the middle of a big #ifdef block.

Move it to <linux/kbd_kern.h>, correct the type of the second parameter, and
include <linux/kbd_kern.h> where needed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/char/keyboard.c     |    4 ----
 drivers/macintosh/mac_hid.c |    1 +
 include/linux/kbd_kern.h    |    3 +++
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1022,10 +1022,6 @@ static const unsigned short x86_keycodes
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-extern int mac_hid_mouse_emulate_buttons(int, int, int);
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 #ifdef CONFIG_SPARC
 static int sparc_l1_a_state = 0;
 extern void sun_do_break(void);
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -13,6 +13,7 @@
 #include <linux/sysctl.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/kbd_kern.h>
 
 
 static struct input_dev *emumousebtn;
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -161,4 +161,7 @@ static inline void con_schedule_flip(str
 	schedule_delayed_work(&t->buf.work, 0);
 }
 
+/* mac_hid.c */
+extern int mac_hid_mouse_emulate_buttons(int, unsigned int, int);
+
 #endif

-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
