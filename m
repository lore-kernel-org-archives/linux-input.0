From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Sun, 15 Jul 2007 11:57:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>
References: <469A5385.6030402@inwind.it> <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
 <469A68CC.5040902@inwind.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469A68CC.5040902@inwind.it>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: federico ferri <xaero@inwind.it>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org



On Sun, 15 Jul 2007, federico ferri wrote:
>> 
> (I can imagine it could be done via a /proc/sysrq-keycode virtual file,
> but that's just one possibility)
> 
> So, this should turn into a feature request...
> would you accept feature requests?  ( :

Well, this is totally untested, and I won't guarantee that this works at 
all, but this is how to generally do these kinds of things..

		Linus

---
 drivers/char/keyboard.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 90965b4..e21f52b 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -157,6 +157,10 @@ static int sysrq_alt_use;
 #endif
 static int sysrq_alt;
 
+static int sysrq_key = KEY_SYSRQ;
+module_param_named(sysrq_key, sysrq_key, uint, 0644);
+MODULE_PARM_DESC(sysrq_key, "The keycode to be used for sysrq");
+
 /*
  * Translation of scancodes to keycodes. We set them on only the first
  * keyboard in the list that accepts the scancode and keycode.
@@ -1139,7 +1143,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+	if (keycode == sysrq_key && (sysrq_down || (down == 1 && sysrq_alt))) {
 		if (!sysrq_down) {
 			sysrq_down = down;
 			sysrq_alt_use = sysrq_alt;
