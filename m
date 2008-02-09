From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] keyboard notifier documentation
Date: Sat, 9 Feb 2008 01:33:22 +0000
Message-ID: <20080209013322.GC4463@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759154AbYBIBd6@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@osdl.org, linux-input@vger.kernel.org, dtor@mail.ru
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Document the keyboard notifier.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- /dev/null	2008-02-09 01:22:34.790011677 +0000
+++ linux/Documentation/input/notifier.txt	2008-02-09 01:28:12.00000000=
0 +0000
@@ -0,0 +1,52 @@
+Keyboard notifier
+
+One can use register_keyboard_notifier to get called back on keyboard
+events (see kbd_keycode() function for details).  The passed structure=
 is
+keyboard_notifier_param:
+
+- 'vc' always provide the VC for which the keyboard event applies=A0;
+- 'down' is 1 for a key press event, 0 for a key release=A0;
+- 'shift' is the current modifier state, mask bit indexes are KG_*=A0;
+- 'value' depends on the type of event.
+
+- KBD_KEYCODE events are always sent before other events, value is the=
 keycode.
+- KBD_UNBOUND_KEYCODE events are sent if the keycode is not bound to a=
 keysym.
+  value is the keycode.
+- KBD_UNICODE events are sent if the keycode -> keysym translation pro=
duced a
+  unicode character. value is the unicode value.
+- KBD_KEYSYM events are sent if the keycode -> keysym translation prod=
uced a
+  non-unicode character. value is the keysym.
+- KBD_POST_KEYSYM events are sent after the treatment of non-unicode k=
eysyms.
+  That permits to inspect the resulting LEDs for instance.
+
+For each kind of event but the last, the callback may return NOTIFY_ST=
OP in
+order to "eat" the event: the notify loop is stopped and the keyboard =
event is
+dropped.
+
+I a rough C snippet, we have:
+
+kbd_keycode(keycode) {
+	...
+	params.value =3D keycode;
+	if (notifier_call_chain(KBD_KEYCODE,&params) =3D=3D NOTIFY_STOP)
+	    || !bound) {
+		notifier_call_chain(KBD_UNBOUND_KEYCODE,&params);
+		return;
+	}
+
+	if (unicode) {
+		param.value =3D unicode;
+		if (notifier_call_chain(KBD_UNICODE,&params) =3D=3D NOTIFY_STOP)
+			return;
+		emit unicode;
+		return;
+	}
+
+	params.value =3D keysym;
+	if (notifier_call_chain(KBD_KEYSYM,&params) =3D=3D NOTIFY_STOP)
+		return;
+	apply keysym;
+	notifier_call_chain(KBD_POST_KEYSYM,&params);
+}
+
+NOTE: This notifier is usually called from interrupt context.
