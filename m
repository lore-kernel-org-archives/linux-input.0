From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] drivers/input/ff-core.c needs <linux/sched.h>
Date: Tue, 1 Jul 2008 13:55:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807011300110.21227@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755515AbYGALzn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

commit 656acd2bbc4ce7f224de499ee255698701396c48
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu Jun 26 11:30:02 2008 -0400

    Input: fix locking in force-feedback core

    The newly added event_lock spinlock in the input core disallows sleeping
    and therefore using mutexes in event handlers. Convert force-feedback 
    core to rely on event_lock instead of mutex to protect slots allocated  
    for fore-feedback effects. The original mutex is still used to serialize
    uploading and erasing of effects.

causes the following regression on m68k:

| linux/drivers/input/ff-core.c: In function 'input_ff_upload':
| linux/drivers/input/ff-core.c:172: error: dereferencing pointer to incomplete type
| linux/drivers/input/ff-core.c: In function 'erase_effect':
| linux/drivers/input/ff-core.c:197: error: dereferencing pointer to incomplete type
| linux/drivers/input/ff-core.c:204: error: dereferencing pointer to incomplete type
| make[4]: *** [drivers/input/ff-core.o] Error 1

As the incomplete type is `struct task_struct', including <linux/sched.h> fixes
it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/ff-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -28,6 +28,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
 
 /*
  * Check that the effect_id is a valid effect and whether the user

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
