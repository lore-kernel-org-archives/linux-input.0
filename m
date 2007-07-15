From: federico ferri <xaero@inwind.it>
Subject: [PATCH] input: change SysRq keycode for systems without SysRq key
Date: Sun, 15 Jul 2007 19:04:05 +0200
Message-ID: <469A5385.6030402@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: torvalds@linux-foundation.org
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

this patch adds an entry in Kconfig after 'config MAGIC_SYSRQ' which
asks for a different keycode (replacing also KEY_SYSRQ with
CONFIG_MAGIC_SYSRQ_KEYCODE in char/keyboard.c)

it was tested on some USB keyboards (Microsoft and Apple USB keyboards,
and it works)

I sumbitted this patch two years ago, but it was ignored.

I think this patch is very important, even to a non-developer (SysRq-k
is very helpful when testing unstable software/drivers)

[for 2.6]

Signed-off-by: Federico Ferri <xaero@inwind.it>

---

diff -uprN linux.orig/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- linux.orig/drivers/char/keyboard.c	2005-07-09 21:47:50.000000000 +0200
+++ linux/drivers/char/keyboard.c	2005-07-10 14:42:34.000000000 +0200
@@ -1081,7 +1087,7 @@ static void kbd_keycode(unsigned int key
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode
%d\n", keycode);

 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+	if (keycode == CONFIG_MAGIC_SYSRQ_KEYCODE && (sysrq_down || (down == 1
&& sysrq_alt))) {
 		sysrq_down = down;
 		return;
 	}
diff -uprN linux.orig/lib/Kconfig.debug linux/lib/Kconfig.debug
--- linux.orig/lib/Kconfig.debug	2005-07-09 21:47:22.000000000 +0200
+++ linux/lib/Kconfig.debug	2005-07-09 21:50:44.000000000 +0200
@@ -28,6 +28,16 @@ config MAGIC_SYSRQ
 	  send a BREAK and then within 5 seconds a command keypress. The
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
+	
+config MAGIC_SYSRQ_KEYCODE
+	int
+	prompt "Change SysRq key-code" if MAGIC_SYSRQ
+	default 99
+	depends on MAGIC_SYSRQ
+	help
+	  If your keyboard doesn't have a SysRq key (also labeled PrintScr),
+	  you can specify another keycode which should act as SysRq.
+	  Default is 99 (KEY_SYSRQ).
+	  You can find this number using programs like evtest, or (maybe)
+	  showkey.

 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
