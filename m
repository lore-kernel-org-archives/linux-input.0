From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Console keyboard events and accessibility
Date: Tue, 14 Aug 2007 01:56:42 +0200
Message-ID: <20070813235642.GI3694@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: dtor@mail.ru
List-Id: linux-input@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Some blind people use a kernel engine called Speakup which uses hardware
synthesis to speak what gets displayed on the screen.  They use the
PC keyboard to control this engine (start/stop, accelerate, ...) and
also need to get keyboard feedback (to make sure to know what they are
typing, the caps lock status, etc.).

To tell the truth, the way it's currently done in Speakup is just ugly:
it patches the kernel to have it call its own function, and modifies the
fn_handler array on the fly to get called when these should have been
:o)

As patching the kernel is never an easy thing for end users, and since
there might be other interesting uses, I wondered whether we could add a
notifier list for keyboard events.  Attached is a (not-even-compiled!)
patch that does this: call the list with a KBD_KEYCODE event, and
if anyone returns NOTIFY_STOP, don't go further (key was eaten).
Then according to the situation, call the list with a KBD_UNICODE or
KBD_KEYSYM event, and if anyone returns NOTIFY_STOP, don't go further.
That way, kernel modules may grab some shortcuts for their own uses or
monitor key presses.

You may wonder why this can't be done at the input layer.  The problem
is that what people want to monitor is the console keyboard, i.e. all
input keyboards that got attached to the console, and with the currently
active keymap (i.e. keysyms, not only keycodes).

What do people think about this?

Samuel

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-kbd-notifier

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 2ce0af1..2480980 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -159,6 +159,23 @@ static int sysrq_alt_use;
 static int sysrq_alt;
 
 /*
+ * Notifier list for console keyboard events
+ */
+static ATOMIC_NOTIFIER_HEAD(keyboard_notifier_list); 
+
+int register_keyboard_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&keyboard_notifier_list, nb);
+}
+EXPORT_SYMBOL(register_keyboard_notifier);
+
+int unregister_keyboard_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&keyboard_notifier_list, nb);
+}
+EXPORT_SYMBOL(unregister_keyboard_notifier);
+
+/*
  * Translation of scancodes to keycodes. We set them on only the first
  * keyboard in the list that accepts the scancode and keycode.
  * Explanation for not choosing the first attached keyboard anymore:
@@ -1119,6 +1136,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	unsigned char type, raw_mode;
 	struct tty_struct *tty;
 	int shift_final;
+	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 
 	tty = vc->vc_tty;
 
@@ -1206,10 +1224,10 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 		return;
 	}
 
-	shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
+	param.shift_final = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
 	key_map = key_maps[shift_final];
 
-	if (!key_map) {
+	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYCODE, &param) == NOTIFY_STOP || !key_map) {
 		compute_shiftstate();
 		kbd->slockstate = 0;
 		return;
@@ -1226,6 +1244,9 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	type = KTYP(keysym);
 
 	if (type < 0xf0) {
+		param.value = keysym;
+		if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_UNICODE, &param) == NOTIFY_STOP)
+			return;
 		if (down && !raw_mode)
 			to_utf8(vc, keysym);
 		return;
@@ -1233,9 +1254,6 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	type -= 0xf0;
 
-	if (raw_mode && type != KT_SPEC && type != KT_SHIFT)
-		return;
-
 	if (type == KT_LETTER) {
 		type = KT_LATIN;
 		if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
@@ -1244,6 +1262,13 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 				keysym = key_map[keycode];
 		}
 	}
+	param.value = keysym;
+
+	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYSYM, &param) == NOTIFY_STOP)
+		return;
+
+	if (raw_mode && type != KT_SPEC && type != KT_SHIFT)
+		return;
 
 	(*k_handler[type])(vc, keysym & 0xff, !down);
 
diff --git a/include/linux/keyboard.h b/include/linux/keyboard.h
index 7ddbc30..d97066f 100644
--- a/include/linux/keyboard.h
+++ b/include/linux/keyboard.h
@@ -27,6 +27,16 @@ extern const int NR_TYPES;
 extern const int max_vals[];
 extern unsigned short *key_maps[MAX_NR_KEYMAPS];
 extern unsigned short plain_map[NR_KEYS];
+
+struct keyboard_notifier_param {
+	struct vc_data *vc;	/* VC on which the keyboard press was done */
+	int down;		/* Pressure of the key? */
+	int shift_final;	/* Current shift mask */
+	unsigned int value;	/* keycode, unicode value or keysym */
+};
+
+extern int register_keyboard_notifier(struct notifier_block *nb);
+extern int unregister_keyboard_notifier(struct notifier_block *nb);
 #endif
 
 #define MAX_NR_FUNC	256	/* max nr of strings assigned to keys */
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index fad7ff1..b657361 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -231,5 +231,11 @@ static inline int notifier_to_errno(int ret)
 #define PM_SUSPEND_PREPARE	0x0003 /* Going to suspend the system */
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
 
+/* Console keyboard events.
+ * Note: KBD_KEYCODE is usually sent before KBD_UNICODE and KBD_KEYSYM. */
+#define KBD_KEYCODE		0x0001 /* Keyboard keycode */
+#define KBD_UNICODE		0x0002 /* Keyboard unicode */
+#define KBD_KEYSYM		0x0003 /* Keyboard keysym */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff --git a/kernel/sys.c b/kernel/sys.c

--FL5UXtIhxfXey3p5--
