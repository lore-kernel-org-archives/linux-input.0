From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: [PATCH] keyboard.c: fix more problems found by checkpatch.pl
Date: Sat, 1 Dec 2007 22:43:55 +0100
Message-ID: <20071201214349.GC10179@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:15187 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXLAVmg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2007 16:42:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2476033nfb
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2007 13:42:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

keyboard.c: fix more problems found by checkpatch.pl

fix some problems found by checkpatch.pl:
- wrap lines longer than 80 characters
- switch / case indentation
- add KERN_* to printk

Signed-off-by: Marcin =C5=9Alusarz <marcin.slusarz@gmail.com>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 97f790f..c5ce8d9 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -193,7 +193,8 @@ int getkeycode(unsigned int scancode)
 	int error =3D -ENODEV;

 	list_for_each_entry(handle, &kbd_handler.h_list, h_node) {
-		error =3D handle->dev->getkeycode(handle->dev, scancode, &keycode);
+		error =3D handle->dev->getkeycode(handle->dev, scancode,
+						&keycode);
 		if (!error)
 			return keycode;
 	}
@@ -245,11 +246,13 @@ void kd_mksound(unsigned int hz, unsigned int tic=
ks)
 			struct input_handle *handle =3D to_handle_h(node);
 			if (test_bit(EV_SND, handle->dev->evbit)) {
 				if (test_bit(SND_TONE, handle->dev->sndbit)) {
-					input_inject_event(handle, EV_SND, SND_TONE, hz);
+					input_inject_event(handle, EV_SND,
+							   SND_TONE, hz);
 					break;
 				}
 				if (test_bit(SND_BELL, handle->dev->sndbit)) {
-					input_inject_event(handle, EV_SND, SND_BELL, 1);
+					input_inject_event(handle, EV_SND,
+							   SND_BELL, 1);
 					break;
 				}
 			}
@@ -276,9 +279,11 @@ int kbd_rate(struct kbd_repeat *rep)

 		if (test_bit(EV_REP, dev->evbit)) {
 			if (rep->delay > 0)
-				input_inject_event(handle, EV_REP, REP_DELAY, rep->delay);
+				input_inject_event(handle, EV_REP, REP_DELAY,
+						   rep->delay);
 			if (rep->period > 0)
-				input_inject_event(handle, EV_REP, REP_PERIOD, rep->period);
+				input_inject_event(handle, EV_REP, REP_PERIOD,
+						   rep->period);
 			d =3D dev->rep[REP_DELAY];
 			p =3D dev->rep[REP_PERIOD];
 		}
@@ -745,40 +750,40 @@ static void k_pad(struct vc_data *vc, unsigned ch=
ar value, char up_flag)

 	if (!vc_kbd_led(kbd, VC_NUMLOCK))
 		switch (value) {
-			case KVAL(K_PCOMMA):
-			case KVAL(K_PDOT):
-				k_fn(vc, KVAL(K_REMOVE), 0);
-				return;
-			case KVAL(K_P0):
-				k_fn(vc, KVAL(K_INSERT), 0);
-				return;
-			case KVAL(K_P1):
-				k_fn(vc, KVAL(K_SELECT), 0);
-				return;
-			case KVAL(K_P2):
-				k_cur(vc, KVAL(K_DOWN), 0);
-				return;
-			case KVAL(K_P3):
-				k_fn(vc, KVAL(K_PGDN), 0);
-				return;
-			case KVAL(K_P4):
-				k_cur(vc, KVAL(K_LEFT), 0);
-				return;
-			case KVAL(K_P6):
-				k_cur(vc, KVAL(K_RIGHT), 0);
-				return;
-			case KVAL(K_P7):
-				k_fn(vc, KVAL(K_FIND), 0);
-				return;
-			case KVAL(K_P8):
-				k_cur(vc, KVAL(K_UP), 0);
-				return;
-			case KVAL(K_P9):
-				k_fn(vc, KVAL(K_PGUP), 0);
-				return;
-			case KVAL(K_P5):
-				applkey(vc, 'G', vc_kbd_mode(kbd, VC_APPLIC));
-				return;
+		case KVAL(K_PCOMMA):
+		case KVAL(K_PDOT):
+			k_fn(vc, KVAL(K_REMOVE), 0);
+			return;
+		case KVAL(K_P0):
+			k_fn(vc, KVAL(K_INSERT), 0);
+			return;
+		case KVAL(K_P1):
+			k_fn(vc, KVAL(K_SELECT), 0);
+			return;
+		case KVAL(K_P2):
+			k_cur(vc, KVAL(K_DOWN), 0);
+			return;
+		case KVAL(K_P3):
+			k_fn(vc, KVAL(K_PGDN), 0);
+			return;
+		case KVAL(K_P4):
+			k_cur(vc, KVAL(K_LEFT), 0);
+			return;
+		case KVAL(K_P6):
+			k_cur(vc, KVAL(K_RIGHT), 0);
+			return;
+		case KVAL(K_P7):
+			k_fn(vc, KVAL(K_FIND), 0);
+			return;
+		case KVAL(K_P8):
+			k_cur(vc, KVAL(K_UP), 0);
+			return;
+		case KVAL(K_P9):
+			k_fn(vc, KVAL(K_PGUP), 0);
+			return;
+		case KVAL(K_P5):
+			applkey(vc, 'G', vc_kbd_mode(kbd, VC_APPLIC));
+			return;
 		}

 	put_queue(vc, pad_chars[value]);
@@ -917,7 +922,8 @@ static void k_brl(struct vc_data *vc, unsigned char=
 value, char up_flag)

 	if (kbd->kbdmode !=3D VC_UNICODE) {
 		if (!up_flag)
-			printk("keyboard mode must be unicode for braille patterns\n");
+			printk(KERN_WARNING "keyboard mode must be unicode "
+			       "for braille patterns\n");
 		return;
 	}

@@ -1037,7 +1043,8 @@ DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh=
, 0);
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPH=
A) ||\
     defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPAR=
C) ||\
     defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
-    (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined=
(CONFIG_ARCH_RPC))
+    (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && \
+     !defined(CONFIG_ARCH_RPC))

 #define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && \
 		     test_bit(MSC_RAW, dev->mscbit) && \
@@ -1088,52 +1095,52 @@ static int emulate_raw(struct vc_data *vc, unsi=
gned int keycode,
 	int code;

 	switch (keycode) {
-		case KEY_PAUSE:
-			put_queue(vc, 0xe1);
-			put_queue(vc, 0x1d | up_flag);
-			put_queue(vc, 0x45 | up_flag);
-			break;
+	case KEY_PAUSE:
+		put_queue(vc, 0xe1);
+		put_queue(vc, 0x1d | up_flag);
+		put_queue(vc, 0x45 | up_flag);
+		break;

-		case KEY_HANGEUL:
-			if (!up_flag)
-				put_queue(vc, 0xf2);
-			break;
+	case KEY_HANGEUL:
+		if (!up_flag)
+			put_queue(vc, 0xf2);
+		break;

-		case KEY_HANJA:
-			if (!up_flag)
-				put_queue(vc, 0xf1);
-			break;
+	case KEY_HANJA:
+		if (!up_flag)
+			put_queue(vc, 0xf1);
+		break;

-		case KEY_SYSRQ:
-			/*
-			 * Real AT keyboards (that's what we're trying
-			 * to emulate here emit 0xe0 0x2a 0xe0 0x37 when
-			 * pressing PrtSc/SysRq alone, but simply 0x54
-			 * when pressing Alt+PrtSc/SysRq.
-			 */
-			if (sysrq_alt) {
-				put_queue(vc, 0x54 | up_flag);
-			} else {
-				put_queue(vc, 0xe0);
-				put_queue(vc, 0x2a | up_flag);
-				put_queue(vc, 0xe0);
-				put_queue(vc, 0x37 | up_flag);
-			}
-			break;
+	case KEY_SYSRQ:
+		/*
+		 * Real AT keyboards (that's what we're trying
+		 * to emulate here emit 0xe0 0x2a 0xe0 0x37 when
+		 * pressing PrtSc/SysRq alone, but simply 0x54
+		 * when pressing Alt+PrtSc/SysRq.
+		 */
+		if (sysrq_alt) {
+			put_queue(vc, 0x54 | up_flag);
+		} else {
+			put_queue(vc, 0xe0);
+			put_queue(vc, 0x2a | up_flag);
+			put_queue(vc, 0xe0);
+			put_queue(vc, 0x37 | up_flag);
+		}
+		break;

-		default:
-			if (keycode > 255)
-				return -1;
+	default:
+		if (keycode > 255)
+			return -1;

-			code =3D x86_keycodes[keycode];
-			if (!code)
-				return -1;
+		code =3D x86_keycodes[keycode];
+		if (!code)
+			return -1;

-			if (code & 0x100)
-				put_queue(vc, 0xe0);
-			put_queue(vc, (code & 0x7f) | up_flag);
+		if (code & 0x100)
+			put_queue(vc, 0xe0);
+		put_queue(vc, (code & 0x7f) | up_flag);

-			break;
+		break;
 	}

 	return 0;
@@ -1171,7 +1178,11 @@ static void kbd_keycode(unsigned int keycode, in=
t down, int hw_raw)
 	unsigned char type, raw_mode;
 	struct tty_struct *tty;
 	int shift_final;
-	struct keyboard_notifier_param param =3D { .vc =3D vc, .value =3D key=
code, .down =3D down };
+	struct keyboard_notifier_param param =3D {
+		.vc =3D vc,
+		.value =3D keycode,
+		.down =3D down
+	};

 	tty =3D vc->vc_tty;

@@ -1200,7 +1211,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)
 	if (raw_mode && !hw_raw)
 		if (emulate_raw(vc, keycode, !down << 7))
 			if (keycode < BTN_MISC && printk_ratelimit())
-				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode=
 %d\n", keycode);
+				printk(KERN_WARNING "keyboard.c: can't emulate "
+					"rawmode for keycode %d\n", keycode);

 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
 	if (keycode =3D=3D KEY_SYSRQ && (sysrq_down || (down =3D=3D 1 && sysr=
q_alt))) {
@@ -1263,8 +1275,10 @@ static void kbd_keycode(unsigned int keycode, in=
t down, int hw_raw)
 	param.shift =3D shift_final =3D (shift_state | kbd->slockstate) ^ kbd=
->lockstate;
 	key_map =3D key_maps[shift_final];

-	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYCODE, =
&param) =3D=3D NOTIFY_STOP || !key_map) {
-		atomic_notifier_call_chain(&keyboard_notifier_list, KBD_UNBOUND_KEYC=
ODE, &param);
+	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYCODE,
+					&param) =3D=3D NOTIFY_STOP || !key_map) {
+		atomic_notifier_call_chain(&keyboard_notifier_list,
+					   KBD_UNBOUND_KEYCODE, &param);
 		compute_shiftstate();
 		kbd->slockstate =3D 0;
 		return;
@@ -1282,7 +1296,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)

 	if (type < 0xf0) {
 		param.value =3D keysym;
-		if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_UNICODE,=
 &param) =3D=3D NOTIFY_STOP)
+		if (atomic_notifier_call_chain(&keyboard_notifier_list,
+					KBD_UNICODE, &param) =3D=3D NOTIFY_STOP)
 			return;
 		if (down && !raw_mode)
 			to_utf8(vc, keysym);
@@ -1301,7 +1316,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)
 	}
 	param.value =3D keysym;

-	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYSYM, &=
param) =3D=3D NOTIFY_STOP)
+	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYSYM,
+					&param) =3D=3D NOTIFY_STOP)
 		return;

 	if (raw_mode && type !=3D KT_SPEC && type !=3D KT_SHIFT)
@@ -1309,7 +1325,8 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)

 	(*k_handler[type])(vc, keysym & 0xff, !down);

-	atomic_notifier_call_chain(&keyboard_notifier_list, KBD_POST_KEYSYM, =
&param);
+	atomic_notifier_call_chain(&keyboard_notifier_list,
+				   KBD_POST_KEYSYM, &param);

 	if (type !=3D KT_SLOCK)
 		kbd->slockstate =3D 0;
@@ -1318,7 +1335,9 @@ static void kbd_keycode(unsigned int keycode, int=
 down, int hw_raw)
 static void kbd_event(struct input_handle *handle, unsigned int event_=
type,
 		      unsigned int event_code, int value)
 {
-	if (event_type =3D=3D EV_MSC && event_code =3D=3D MSC_RAW && HW_RAW(h=
andle->dev))
+	if (event_type =3D=3D EV_MSC &&
+	    event_code =3D=3D MSC_RAW &&
+	    HW_RAW(handle->dev))
 		kbd_rawcode(value);
 	if (event_type =3D=3D EV_KEY)
 		kbd_keycode(event_code, value, HW_RAW(handle->dev));
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
