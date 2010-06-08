From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Wed, 09 Jun 2010 00:55:08 +0200
Message-ID: <4C0ECA4C.9020806@tudelft.nl>
References: <4C0E0E51.8050709@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:46970 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0FHWzP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jun 2010 18:55:15 -0400
In-Reply-To: <4C0E0E51.8050709@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Op 08-06-10 11:33, =C3=89ric Piel schreef:
> Hello,
> I haven't investigated much yet, but I have the feeling that since
> 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I pres=
s
> it (normally assigned to take screenshot in gnome), nothing happens (=
no
> input event received in userspace) and no key on the keyboard works
> afterwards, until I press Alt. Actually the keys work, but behave as =
if
> the sysrq key was kept pressed (can be seen in dmesg, or by pressing =
"b").
>=20
> Looking at the log, a potential culprit is commit
> 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq as a
> separate input handler). Probably the logic of "have to press all the
> keys at the same time" changed to "have to press the keys one after e=
ach
> other". So pressing alt and later on pressing PrintScreen leads to a =
SysRq.
>=20
> Does anybody else see this behaviour? Any suggestion on how to solve
> this bug? I'll try reverting the commit and report if it fixes the
> problem (the git revert fails so I've got to fix the conflict manuall=
y).
I can confirm this regression is due to
97f5f0cd8cd0a05449cbb77d1e6f02e026875802: the reverting patch below
fixes it. And, as long as you don't press alt since boot, PrintScreen
works fine. So it is likely due to not taking into account key releases=
=2E

Dmitry, do you have a better fix? I'll be happy to test it if needed.

Cheers,
Eric
8<---------------------------------------------------------


This reverts commit 97f5f0cd8cd0a05449cbb77d1e6f02e026875802.
Trying to solve sysrq too easy

Conflicts:

	drivers/char/keyboard.c
---
 drivers/char/keyboard.c |   54 ++++++++++-
 drivers/char/sysrq.c    |  243 ++++++---------------------------------=
--------
 include/linux/sysrq.h   |   23 +++--
 kernel/sysctl.c         |   23 +----
 4 files changed, 99 insertions(+), 244 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 54109dc..9d89fcd 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -40,6 +40,7 @@
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
+#include <linux/sysrq.h>
 #include <linux/input.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
@@ -83,7 +84,8 @@ void compute_shiftstate(void);
 typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value,
 			    char up_flag);
 static k_handler_fn K_HANDLERS;
-static k_handler_fn *k_handler[16] =3D { K_HANDLERS };
+k_handler_fn *k_handler[16] =3D { K_HANDLERS };
+EXPORT_SYMBOL_GPL(k_handler);
=20
 #define FN_HANDLERS\
 	fn_null,	fn_enter,	fn_show_ptregs,	fn_show_mem,\
@@ -147,6 +149,22 @@ static struct ledptr {
 	unsigned char valid:1;
 } ledptrs[3];
=20
+/* Simple translation table for the SysRq keys */
+
+#ifdef CONFIG_MAGIC_SYSRQ
+unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =3D
+        "\000\0331234567890-=3D\177\t"                    /* 0x00 - 0x=
0f */
+        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f=
 */
+        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f=
 */
+        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f=
 */
+        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f=
 */
+        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\0=
00" /* 0x50 - 0x5f */
+        "\r\000/";                                      /* 0x60 - 0x6f=
 */
+static int sysrq_down;
+static int sysrq_alt_use;
+#endif
+static int sysrq_alt;
+
 /*
  * Notifier list for console keyboard events
  */
@@ -1092,6 +1110,23 @@ static int emulate_raw(struct vc_data *vc, unsig=
ned int keycode,
 			put_queue(vc, 0xf1);
 		break;
=20
+//	case KEY_SYSRQ:
+//		/*
+//		 * Real AT keyboards (that's what we're trying
+//		 * to emulate here emit 0xe0 0x2a 0xe0 0x37 when
+//		 * pressing PrtSc/SysRq alone, but simply 0x54
+//		 * when pressing Alt+PrtSc/SysRq.
+//		 */
+//		if (sysrq_alt) {
+//			put_queue(vc, 0x54 | up_flag);
+//		} else {
+//			put_queue(vc, 0xe0);
+//			put_queue(vc, 0x2a | up_flag);
+//			put_queue(vc, 0xe0);
+//			put_queue(vc, 0x37 | up_flag);
+//		}
+//		break;
+
 	case KEY_SYSRQ:
 		/*
 		 * Real AT keyboards (that's what we're trying
@@ -1171,6 +1206,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)
=20
 	kbd =3D kbd_table + vc->vc_num;
=20
+	if (keycode =3D=3D KEY_LEFTALT || keycode =3D=3D KEY_RIGHTALT)
+		sysrq_alt =3D down ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode =3D=3D KEY_STOP)
 		sparc_l1_a_state =3D down;
@@ -1185,6 +1222,21 @@ static void kbd_keycode(unsigned int keycode, in=
t down, int hw_raw)
 				pr_warning("can't emulate rawmode for keycode %d\n",
 					   keycode);
=20
+#ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
+	if (keycode =3D=3D KEY_SYSRQ && (sysrq_down || (down =3D=3D 1 && sysr=
q_alt))) {
+		if (!sysrq_down) {
+			sysrq_down =3D down;
+			sysrq_alt_use =3D sysrq_alt;
+		}
+		return;
+	}
+	if (sysrq_down && !down && keycode =3D=3D sysrq_alt_use)
+		sysrq_down =3D 0;
+	if (sysrq_down && down && !rep) {
+		handle_sysrq(kbd_sysrq_xlate[keycode], tty);
+		return;
+	}
+#endif
 #ifdef CONFIG_SPARC
 	if (keycode =3D=3D KEY_A && sparc_l1_a_state) {
 		sparc_l1_a_state =3D false;
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index 5d15630..d4e8b21 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -1,4 +1,7 @@
-/*
+/* -*- linux-c -*-
+ *
+ *	$Id: sysrq.c,v 1.15 1998/08/23 14:56:41 mj Exp $
+ *
  *	Linux Magic System Request Key Hacks
  *
  *	(c) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
@@ -7,13 +10,8 @@
  *	(c) 2000 Crutcher Dunnavant <crutcher+kernel@datastacks.com>
  *	overhauled to use key registration
  *	based upon discusions in irc://irc.openprojects.net/#kernelnewbies
- *
- *	Copyright (c) 2010 Dmitry Torokhov
- *	Input handler conversion
  */
=20
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
@@ -41,34 +39,33 @@
 #include <linux/hrtimer.h>
 #include <linux/oom.h>
 #include <linux/slab.h>
-#include <linux/input.h>
=20
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
=20
 /* Whether we react on sysrq keys or just ignore them */
-static int __read_mostly sysrq_enabled =3D 1;
-static bool __read_mostly sysrq_always_enabled;
+int __read_mostly __sysrq_enabled =3D 1;
+
+static int __read_mostly sysrq_always_enabled;
=20
-static bool sysrq_on(void)
+int sysrq_on(void)
 {
-	return sysrq_enabled || sysrq_always_enabled;
+	return __sysrq_enabled || sysrq_always_enabled;
 }
=20
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
  */
-static bool sysrq_on_mask(int mask)
+static inline int sysrq_on_mask(int mask)
 {
-	return sysrq_always_enabled ||
-	       sysrq_enabled =3D=3D 1 ||
-	       (sysrq_enabled & mask);
+	return sysrq_always_enabled || __sysrq_enabled =3D=3D 1 ||
+						(__sysrq_enabled & mask);
 }
=20
 static int __init sysrq_always_enabled_setup(char *str)
 {
-	sysrq_always_enabled =3D true;
-	pr_info("sysrq always enabled.\n");
+	sysrq_always_enabled =3D 1;
+	printk(KERN_INFO "debug: sysrq always enabled.\n");
=20
 	return 1;
 }
@@ -79,7 +76,6 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_=
setup);
 static void sysrq_handle_loglevel(int key, struct tty_struct *tty)
 {
 	int i;
-
 	i =3D key - '0';
 	console_loglevel =3D 7;
 	printk("Loglevel set to %d\n", i);
@@ -105,7 +101,7 @@ static struct sysrq_key_op sysrq_SAK_op =3D {
 	.enable_mask	=3D SYSRQ_ENABLE_KEYBOARD,
 };
 #else
-#define sysrq_SAK_op (*(struct sysrq_key_op *)NULL)
+#define sysrq_SAK_op (*(struct sysrq_key_op *)0)
 #endif
=20
 #ifdef CONFIG_VT
@@ -123,7 +119,7 @@ static struct sysrq_key_op sysrq_unraw_op =3D {
 	.enable_mask	=3D SYSRQ_ENABLE_KEYBOARD,
 };
 #else
-#define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
+#define sysrq_unraw_op (*(struct sysrq_key_op *)0)
 #endif /* CONFIG_VT */
=20
 static void sysrq_handle_crash(int key, struct tty_struct *tty)
@@ -199,7 +195,7 @@ static struct sysrq_key_op sysrq_showlocks_op =3D {
 	.action_msg	=3D "Show Locks Held",
 };
 #else
-#define sysrq_showlocks_op (*(struct sysrq_key_op *)NULL)
+#define sysrq_showlocks_op (*(struct sysrq_key_op *)0)
 #endif
=20
 #ifdef CONFIG_SMP
@@ -302,7 +298,7 @@ static struct sysrq_key_op sysrq_ftrace_dump_op =3D=
 {
 	.enable_mask	=3D SYSRQ_ENABLE_DUMP,
 };
 #else
-#define sysrq_ftrace_dump_op (*(struct sysrq_key_op *)NULL)
+#define sysrq_ftrace_dump_op (*(struct sysrq_key_op *)0)
 #endif
=20
 static void sysrq_handle_showmem(int key, struct tty_struct *tty)
@@ -481,7 +477,6 @@ struct sysrq_key_op *__sysrq_get_key_op(int key)
 	i =3D sysrq_key_table_key2index(key);
 	if (i !=3D -1)
 	        op_p =3D sysrq_key_table[i];
-
         return op_p;
 }
=20
@@ -493,7 +488,11 @@ static void __sysrq_put_key_op(int key, struct sys=
rq_key_op *op_p)
                 sysrq_key_table[i] =3D op_p;
 }
=20
-static void __handle_sysrq(int key, struct tty_struct *tty, int check_=
mask)
+/*
+ * This is the non-locking version of handle_sysrq.  It must/can only =
be called
+ * by sysrq key handlers, as they are inside of the lock
+ */
+void __handle_sysrq(int key, struct tty_struct *tty, int check_mask)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
@@ -545,6 +544,10 @@ static void __handle_sysrq(int key, struct tty_str=
uct *tty, int check_mask)
 	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
 }
=20
+/*
+ * This function is called by the keyboard handler when SysRq is press=
ed
+ * and any other keycode arrives.
+ */
 void handle_sysrq(int key, struct tty_struct *tty)
 {
 	if (sysrq_on())
@@ -552,177 +555,10 @@ void handle_sysrq(int key, struct tty_struct *tt=
y)
 }
 EXPORT_SYMBOL(handle_sysrq);
=20
-#ifdef CONFIG_INPUT
-
-/* Simple translation table for the SysRq keys */
-static const unsigned char sysrq_xlate[KEY_MAX + 1] =3D
-        "\000\0331234567890-=3D\177\t"                    /* 0x00 - 0x=
0f */
-        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f=
 */
-        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f=
 */
-        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f=
 */
-        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f=
 */
-        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\0=
00" /* 0x50 - 0x5f */
-        "\r\000/";                                      /* 0x60 - 0x6f=
 */
-
-static bool sysrq_down;
-static int sysrq_alt_use;
-static int sysrq_alt;
-
-static bool sysrq_filter(struct input_handle *handle, unsigned int typ=
e,
-		         unsigned int code, int value)
-{
-	if (type !=3D EV_KEY)
-		goto out;
-
-	switch (code) {
-
-	case KEY_LEFTALT:
-	case KEY_RIGHTALT:
-		if (value)
-			sysrq_alt =3D code;
-		else if (sysrq_down && code =3D=3D sysrq_alt_use)
-			sysrq_down =3D false;
-		break;
-
-	case KEY_SYSRQ:
-		if (value =3D=3D 1 && sysrq_alt) {
-			sysrq_down =3D true;
-			sysrq_alt_use =3D sysrq_alt;
-		}
-		break;
-
-	default:
-		if (sysrq_down && value && value !=3D 2)
-			__handle_sysrq(sysrq_xlate[code], NULL, 1);
-		break;
-	}
-
-out:
-	return sysrq_down;
-}
-
-static int sysrq_connect(struct input_handler *handler,
-			 struct input_dev *dev,
-			 const struct input_device_id *id)
-{
-	struct input_handle *handle;
-	int error;
-
-	sysrq_down =3D false;
-	sysrq_alt =3D 0;
-
-	handle =3D kzalloc(sizeof(struct input_handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->dev =3D dev;
-	handle->handler =3D handler;
-	handle->name =3D "sysrq";
-
-	error =3D input_register_handle(handle);
-	if (error) {
-		pr_err("Failed to register input sysrq handler, error %d\n",
-			error);
-		goto err_free;
-	}
-
-	error =3D input_open_device(handle);
-	if (error) {
-		pr_err("Failed to open input device, error %d\n", error);
-		goto err_unregister;
-	}
-
-	return 0;
-
- err_unregister:
-	input_unregister_handle(handle);
- err_free:
-	kfree(handle);
-	return error;
-}
-
-static void sysrq_disconnect(struct input_handle *handle)
-{
-	input_close_device(handle);
-	input_unregister_handle(handle);
-	kfree(handle);
-}
-
-/*
- * We are matching on KEY_LEFTALT insteard of KEY_SYSRQ because not al=
l
- * keyboards have SysRq ikey predefined and so user may add it to keym=
ap
- * later, but we expect all such keyboards to have left alt.
- */
-static const struct input_device_id sysrq_ids[] =3D {
-	{
-		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT |
-				INPUT_DEVICE_ID_MATCH_KEYBIT,
-		.evbit =3D { BIT_MASK(EV_KEY) },
-		.keybit =3D { BIT_MASK(KEY_LEFTALT) },
-	},
-	{ },
-};
-
-static struct input_handler sysrq_handler =3D {
-	.filter		=3D sysrq_filter,
-	.connect	=3D sysrq_connect,
-	.disconnect	=3D sysrq_disconnect,
-	.name		=3D "sysrq",
-	.id_table	=3D sysrq_ids,
-};
-
-static bool sysrq_handler_registered;
-
-static inline void sysrq_register_handler(void)
-{
-	int error;
-
-	error =3D input_register_handler(&sysrq_handler);
-	if (error)
-		pr_err("Failed to register input handler, error %d", error);
-	else
-		sysrq_handler_registered =3D true;
-}
-
-static inline void sysrq_unregister_handler(void)
-{
-	if (sysrq_handler_registered) {
-		input_unregister_handler(&sysrq_handler);
-		sysrq_handler_registered =3D false;
-	}
-}
-
-#else
-
-static inline void sysrq_register_handler(void)
-{
-}
-
-static inline void sysrq_unregister_handler(void)
-{
-}
-
-#endif /* CONFIG_INPUT */
-
-int sysrq_toggle_support(int enable_mask)
-{
-	bool was_enabled =3D sysrq_on();
-
-	sysrq_enabled =3D enable_mask;
-
-	if (was_enabled !=3D sysrq_on()) {
-		if (sysrq_on())
-			sysrq_register_handler();
-		else
-			sysrq_unregister_handler();
-	}
-
-	return 0;
-}
-
 static int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_o=
p_p,
                                 struct sysrq_key_op *remove_op_p)
 {
+
 	int retval;
 	unsigned long flags;
=20
@@ -763,7 +599,6 @@ static ssize_t write_sysrq_trigger(struct file *fil=
e, const char __user *buf,
 			return -EFAULT;
 		__handle_sysrq(c, NULL, 0);
 	}
-
 	return count;
 }
=20
@@ -771,28 +606,10 @@ static const struct file_operations proc_sysrq_tr=
igger_operations =3D {
 	.write		=3D write_sysrq_trigger,
 };
=20
-static void sysrq_init_procfs(void)
-{
-	if (!proc_create("sysrq-trigger", S_IWUSR, NULL,
-			 &proc_sysrq_trigger_operations))
-		pr_err("Failed to register proc interface\n");
-}
-
-#else
-
-static inline void sysrq_init_procfs(void)
-{
-}
-
-#endif /* CONFIG_PROC_FS */
-
 static int __init sysrq_init(void)
 {
-	sysrq_init_procfs();
-
-	if (sysrq_on())
-		sysrq_register_handler();
-
+	proc_create("sysrq-trigger", S_IWUSR, NULL, &proc_sysrq_trigger_opera=
tions);
 	return 0;
 }
 module_init(sysrq_init);
+#endif
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 4496322..99adcdc 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -39,34 +39,41 @@ struct sysrq_key_op {
=20
 #ifdef CONFIG_MAGIC_SYSRQ
=20
+extern int sysrq_on(void);
+
+/*
+ * Do not use this one directly:
+ */
+extern int __sysrq_enabled;
+
 /* Generic SysRq interface -- you may call it from any device driver, =
supplying
  * ASCII code of the key, pointer to registers and kbd/tty structs (if=
 they
  * are available -- else NULL's).
  */
=20
 void handle_sysrq(int key, struct tty_struct *tty);
+void __handle_sysrq(int key, struct tty_struct *tty, int check_mask);
 int register_sysrq_key(int key, struct sysrq_key_op *op);
 int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
=20
-int sysrq_toggle_support(int enable_mask);
-
 #else
=20
-static inline void handle_sysrq(int key, struct tty_struct *tty)
+static inline int sysrq_on(void)
 {
+	return 0;
 }
-
-static inline int register_sysrq_key(int key, struct sysrq_key_op *op)
+static inline int __reterr(void)
 {
 	return -EINVAL;
 }
-
-static inline int unregister_sysrq_key(int key, struct sysrq_key_op *o=
p)
+static inline void handle_sysrq(int key, struct tty_struct *tty)
 {
-	return -EINVAL;
 }
=20
+#define register_sysrq_key(ig,nore) __reterr()
+#define unregister_sysrq_key(ig,nore) __reterr()
+
 #endif
=20
 #endif /* _LINUX_SYSRQ_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 997080f..ab9e4d8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -165,27 +165,6 @@ static int proc_taint(struct ctl_table *table, int=
 write,
 			       void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
=20
-#ifdef CONFIG_MAGIC_SYSRQ
-static int __sysrq_enabled; /* Note: sysrq code ises it's own private =
copy */
-
-static int sysrq_sysctl_handler(ctl_table *table, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos)
-{
-	int error;
-
-	error =3D proc_dointvec(table, write, buffer, lenp, ppos);
-	if (error)
-		return error;
-
-	if (write)
-		sysrq_toggle_support(__sysrq_enabled);
-
-	return 0;
-}
-
-#endif
-
 static struct ctl_table root_table[];
 static struct ctl_table_root sysctl_table_root;
 static struct ctl_table_header root_table_header =3D {
@@ -595,7 +574,7 @@ static struct ctl_table kern_table[] =3D {
 		.data		=3D &__sysrq_enabled,
 		.maxlen		=3D sizeof (int),
 		.mode		=3D 0644,
-		.proc_handler	=3D sysrq_sysctl_handler,
+		.proc_handler	=3D proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_PROC_SYSCTL
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
