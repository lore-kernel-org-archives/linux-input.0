From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] input/serio/hp_sdc.c section fix
Date: Wed, 24 Oct 2007 18:26:40 +0200
Message-ID: <20071024162640.GO30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hp_sdc_exit() mustn't be __exit since it's called from the
__init hp_sdc_register().

This patch fixes the following section mismatch:

<--  snip  -->

...
  MODPOST vmlinux.o
...
WARNING: vmlinux.o(.init.text+0x1af68): Section mismatch: reference to .exit.text:hp_sdc_exit (between 'hp_sdc_register' and 'hp_sdc_mlc_init')
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
4022ed345d1b61dc5b6ac0fc35877656e444a11d 
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 6af1998..02b3ad8 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -944,11 +944,7 @@ static int __init hp_sdc_init_hppa(struct parisc_device *d)
 
 #endif /* __hppa__ */
 
-#if !defined(__mc68000__) /* Link error on m68k! */
-static void __exit hp_sdc_exit(void)
-#else
 static void hp_sdc_exit(void)
-#endif
 {
 	write_lock_irq(&hp_sdc.lock);
 
