From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re (hello?): [PATCH] Let keyboard notifiers modify key codes
Date: Fri, 9 Jan 2009 22:23:58 +0100
Message-ID: <20090109212358.GG5073@const.famille.thibault.fr>
References: <20090107005813.GA4987@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:57305 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695AbZAIVYG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 16:24:06 -0500
Content-Disposition: inline
In-Reply-To: <20090107005813.GA4987@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hello,

Came somebody have a look at this?  The need is real, the only question
that comes to my mind is whether notifiers are allowed to modify the
param they are given.  Since they are not marked const, I'd guess it'd
be ok?

Samuel

Samuel Thibault, le Wed 07 Jan 2009 01:58:13 +0100, a =E9crit :


Make kbd_keycode() read param.value after calling the keyboard notifica=
tion
chain, to let the callee change the translation on the fly. This for in=
stance
permits to remap the physical positions of the keys independently of th=
e
configured keymap, for e.g. single-handed people.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- linux/drivers/char/keyboard.c.orig	2009-01-07 00:48:46.000000000 +0=
100
+++ linux/drivers/char/keyboard.c	2009-01-07 01:02:05.000000000 +0100
@@ -1248,6 +1248,7 @@ kbd_keycode
 		kbd->slockstate =3D 0;
 		return;
 	}
+	keycode =3D param.value;
=20
 	if (keycode >=3D NR_KEYS)
 		if (keycode >=3D KEY_BRL_DOT1 && keycode <=3D KEY_BRL_DOT8)
@@ -1263,6 +1264,7 @@ kbd_keycode
 		param.value =3D keysym;
 		if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_UNICODE,=
 &param) =3D=3D NOTIFY_STOP)
 			return;
+		keysym =3D param.value;
 		if (down && !raw_mode)
 			to_utf8(vc, keysym);
 		return;
@@ -1282,6 +1284,7 @@ kbd_keycode
=20
 	if (atomic_notifier_call_chain(&keyboard_notifier_list, KBD_KEYSYM, &=
param) =3D=3D NOTIFY_STOP)
 		return;
+	keysym =3D param.value;
=20
 	if (raw_mode && type !=3D KT_SPEC && type !=3D KT_SHIFT)
 		return;
--- linux/Documentation/input/notifier.txt.orig	2008-04-17 12:14:30.000=
000000 +0200
+++ linux/Documentation/input/notifier.txt	2009-01-07 01:04:16.00000000=
0 +0100
@@ -21,7 +21,8 @@
=20
 For each kind of event but the last, the callback may return NOTIFY_ST=
OP in
 order to "eat" the event: the notify loop is stopped and the keyboard =
event is
-dropped.
+dropped.  The callee can also modify param.value so as to change the k=
ey
+translation.
=20
 In a rough C snippet, we have:
=20
@@ -33,18 +34,26 @@
 		notifier_call_chain(KBD_UNBOUND_KEYCODE,&params);
 		return;
 	}
+	keycode =3D param.value;
+
+	...
=20
 	if (unicode) {
 		param.value =3D unicode;
 		if (notifier_call_chain(KBD_UNICODE,&params) =3D=3D NOTIFY_STOP)
 			return;
+		keysym =3D param.value;
 		emit unicode;
 		return;
 	}
=20
+	...
+
 	params.value =3D keysym;
 	if (notifier_call_chain(KBD_KEYSYM,&params) =3D=3D NOTIFY_STOP)
 		return;
+	keysym =3D params.value;
+
 	apply keysym;
 	notifier_call_chain(KBD_POST_KEYSYM,&params);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
