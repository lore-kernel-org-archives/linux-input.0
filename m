From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: [PATCH] keyboard.c: fix some problems found by checkpatch.pl
Date: Sat, 1 Dec 2007 22:40:24 +0100
Message-ID: <20071201213950.GA10179@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:6253 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXLAVjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2007 16:39:18 -0500
Received: by mu-out-0910.google.com with SMTP id i10so129664mue
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2007 13:39:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

keyboard.c: fix some problems found by checkpatch.pl

fix some problems found by checkpatch.pl:
- remove ctrl_alt_del prototype (linux/reboot.h: included 2 lines above=
)
- wrap lines longer than 80 characters
- change spaces to tabs
- add spaces after commas
- remove unneeded variable initializations
- remove assignement from if condition

Signed-off-by: Marcin =C5=9Alusarz <marcin.slusarz@gmail.com>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index fc54d23..e473b56 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -44,8 +44,6 @@
 #include <linux/reboot.h>
 #include <linux/notifier.h>

-extern void ctrl_alt_del(void);
-
 /*
  * Exported functions/variables
  */
@@ -55,11 +53,12 @@ extern void ctrl_alt_del(void);
 /*
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock =
is on.
  * This seems a good reason to start with NumLock off. On HIL keyboard=
s
- * of PARISC machines however there is no NumLock key and everyone exp=
ects the keypad
- * to be used for numbers.
+ * of PARISC machines however there is no NumLock key and everyone exp=
ects
+ * the keypad to be used for numbers.
  */

-#if defined(CONFIG_PARISC) && (defined(CONFIG_KEYBOARD_HIL) || defined=
(CONFIG_KEYBOARD_HIL_OLD))
+#if defined(CONFIG_PARISC) && \
+    (defined(CONFIG_KEYBOARD_HIL) || defined(CONFIG_KEYBOARD_HIL_OLD))
 #define KBD_DEFLEDS (1 << VC_NUMLOCK)
 #else
 #define KBD_DEFLEDS 0
@@ -122,21 +121,21 @@ struct vt_spawn_console vt_spawn_con =3D {
  * Variables exported for vt.c
  */

-int shift_state =3D 0;
+int shift_state;

 /*
  * Internal Data.
  */

 static struct input_handler kbd_handler;
-static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key=
 bitmap */
-static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. =
*/
+static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)]; /* keyboard key=
 bitmap */
+static unsigned char shift_down[NR_SHIFT];          /* shift state cou=
nters.. */
 static int dead_key_next;
-static int npadch =3D -1;					/* -1 or number assembled on pad */
+static int npadch =3D -1;                      /* -1 or number assembl=
ed on pad */
 static unsigned int diacr;
-static char rep;					/* flag telling character repeat */
+static char rep;                             /* flag telling character=
 repeat */

-static unsigned char ledstate =3D 0xff;			/* undefined */
+static unsigned char ledstate =3D 0xff;                            /* =
undefined */
 static unsigned char ledioctl;

 static struct ledptr {
@@ -149,13 +148,13 @@ static struct ledptr {

 #ifdef CONFIG_MAGIC_SYSRQ
 unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =3D
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
+	"\000\0331234567890-=3D\177\t"                    /* 0x00 - 0x0f */
+	"qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
+	"dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
+	"bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
+	"\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
+	"230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* =
0x50 - 0x5f */
+	"\r\000/";                                      /* 0x60 - 0x6f */
 static int sysrq_down;
 static int sysrq_alt_use;
 #endif
@@ -340,8 +339,8 @@ static void to_utf8(struct vc_data *vc, uint c)
 		/* 110***** 10****** */
 		put_queue(vc, 0xc0 | (c >> 6));
 		put_queue(vc, 0x80 | (c & 0x3f));
-    	} else if (c < 0x10000) {
-	       	if (c >=3D 0xD800 && c < 0xE000)
+	} else if (c < 0x10000) {
+		if (c >=3D 0xD800 && c < 0xE000)
 			return;
 		if (c =3D=3D 0xFFFF)
 			return;
@@ -349,7 +348,7 @@ static void to_utf8(struct vc_data *vc, uint c)
 		put_queue(vc, 0xe0 | (c >> 12));
 		put_queue(vc, 0x80 | ((c >> 6) & 0x3f));
 		put_queue(vc, 0x80 | (c & 0x3f));
-    	} else if (c < 0x110000) {
+	} else if (c < 0x110000) {
 		/* 11110*** 10****** 10****** 10****** */
 		put_queue(vc, 0xf0 | (c >> 18));
 		put_queue(vc, 0x80 | ((c >> 12) & 0x3f));
@@ -415,7 +414,8 @@ static unsigned int handle_diacr(struct vc_data *vc=
, unsigned int ch)
 			return d | ch;
 	} else {
 		for (i =3D 0; i < accent_table_size; i++)
-			if (accent_table[i].diacr =3D=3D d && accent_table[i].base =3D=3D c=
h)
+			if (accent_table[i].diacr =3D=3D d &&
+			    accent_table[i].base =3D=3D ch)
 				return accent_table[i].result;
 	}

@@ -494,7 +494,7 @@ static void fn_hold(struct vc_data *vc)

 static void fn_num(struct vc_data *vc)
 {
-	if (vc_kbd_mode(kbd,VC_APPLIC))
+	if (vc_kbd_mode(kbd, VC_APPLIC))
 		applkey(vc, 'P', 1);
 	else
 		fn_bare_num(vc);
@@ -693,7 +693,8 @@ static void k_dead2(struct vc_data *vc, unsigned ch=
ar value, char up_flag)
  */
 static void k_dead(struct vc_data *vc, unsigned char value, char up_fl=
ag)
 {
-	static const unsigned char ret_diacr[NR_DEAD] =3D {'`', '\'', '^', '~=
', '"', ',' };
+	static const unsigned char ret_diacr[NR_DEAD] =3D
+		{'`', '\'', '^', '~', '"', ','};
 	value =3D ret_diacr[value];
 	k_deadunicode(vc, value, up_flag);
 }
@@ -882,11 +883,13 @@ static void k_slock(struct vc_data *vc, unsigned =
char value, char up_flag)

 /* by default, 300ms interval for combination release */
 static unsigned brl_timeout =3D 300;
-MODULE_PARM_DESC(brl_timeout, "Braille keys release delay in ms (0 for=
 commit on first key release)");
+MODULE_PARM_DESC(brl_timeout,
+	"Braille keys release delay in ms (0 for commit on first key release)=
");
 module_param(brl_timeout, uint, 0644);

 static unsigned brl_nbchords =3D 1;
-MODULE_PARM_DESC(brl_nbchords, "Number of chords that produce a braill=
e pattern (0 for dead chords)");
+MODULE_PARM_DESC(brl_nbchords,
+	"Number of chords that produce a braille pattern (0 for dead chords)"=
);
 module_param(brl_nbchords, uint, 0644);

 static void k_brlcommit(struct vc_data *vc, unsigned int pattern, char=
 up_flag)
@@ -909,7 +912,7 @@ static void k_brlcommit(struct vc_data *vc, unsigne=
d int pattern, char up_flag)

 static void k_brl(struct vc_data *vc, unsigned char value, char up_fla=
g)
 {
-	static unsigned pressed,committing;
+	static unsigned pressed, committing;
 	static unsigned long releasestart;

 	if (kbd->kbdmode !=3D VC_UNICODE) {
@@ -1036,8 +1039,11 @@ DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_b=
h, 0);
     defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
     (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined=
(CONFIG_ARCH_RPC))

-#define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && test_bit(MSC_RAW,=
 dev->mscbit) &&\
-			((dev)->id.bustype =3D=3D BUS_I8042) && ((dev)->id.vendor =3D=3D 0x=
0001) && ((dev)->id.product =3D=3D 0x0001))
+#define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && \
+		     test_bit(MSC_RAW, dev->mscbit) && \
+		     ((dev)->id.bustype =3D=3D BUS_I8042) && \
+		     ((dev)->id.vendor =3D=3D 0x0001) && \
+		     ((dev)->id.product =3D=3D 0x0001))

 static const unsigned short x86_keycodes[256] =3D
 	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
@@ -1057,7 +1063,7 @@ static const unsigned short x86_keycodes[256] =3D
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };

 #ifdef CONFIG_SPARC
-static int sparc_l1_a_state =3D 0;
+static int sparc_l1_a_state;
 extern void sun_do_break(void);
 #endif

@@ -1124,7 +1130,8 @@ static int emulate_raw(struct vc_data *vc, unsign=
ed int keycode,

 #warning "Cannot generate rawmode keyboard for your architecture yet."

-static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsig=
ned char up_flag)
+static int emulate_raw(struct vc_data *vc, unsigned int keycode,
+			unsigned char up_flag)
 {
 	if (keycode > 127)
 		return -1;
@@ -1174,7 +1181,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)
 		return;
 #endif /* CONFIG_MAC_EMUMOUSEBTN */

-	if ((raw_mode =3D (kbd->kbdmode =3D=3D VC_RAW)) && !hw_raw)
+	raw_mode =3D (kbd->kbdmode =3D=3D VC_RAW);
+	if (raw_mode && !hw_raw)
 		if (emulate_raw(vc, keycode, !down << 7))
 			if (keycode < BTN_MISC && printk_ratelimit())
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode=
 %d\n", keycode);
@@ -1376,14 +1384,14 @@ static void kbd_start(struct input_handle *hand=
le)

 static const struct input_device_id kbd_ids[] =3D {
 	{
-                .flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
-                .evbit =3D { BIT_MASK(EV_KEY) },
-        },
+		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit =3D { BIT_MASK(EV_KEY) },
+	},

 	{
-                .flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
-                .evbit =3D { BIT_MASK(EV_SND) },
-        },
+		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit =3D { BIT_MASK(EV_SND) },
+	},

 	{ },    /* Terminating entry */
 };
@@ -1404,7 +1412,7 @@ int __init kbd_init(void)
 	int i;
 	int error;

-        for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
+	for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
 		kbd_table[i].ledflagstate =3D KBD_DEFLEDS;
 		kbd_table[i].default_ledflagstate =3D KBD_DEFLEDS;
 		kbd_table[i].ledmode =3D LED_SHOW_FLAGS;
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
