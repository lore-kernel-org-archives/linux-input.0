From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] keyboard notifier documentation
Date: Fri, 8 Feb 2008 20:12:53 -0800
Message-ID: <20080208201253.46c068ed.randy.dunlap@oracle.com>
References: <20080209013322.GC4463@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:34752 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbYBIEPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Feb 2008 23:15:02 -0500
In-Reply-To: <20080209013322.GC4463@implementation>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: torvalds@osdl.org, linux-input@vger.kernel.org, dtor@mail.ru, linux-kernel@vger.kernel.org

On Sat, 9 Feb 2008 01:33:22 +0000 Samuel Thibault wrote:

> Document the keyboard notifier.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>=20
> --- /dev/null	2008-02-09 01:22:34.790011677 +0000
> +++ linux/Documentation/input/notifier.txt	2008-02-09 01:28:12.000000=
000 +0000
> @@ -0,0 +1,52 @@
> +Keyboard notifier
> +
> +One can use register_keyboard_notifier to get called back on keyboar=
d
> +events (see kbd_keycode() function for details).  The passed structu=
re is
> +keyboard_notifier_param:
> +
> +- 'vc' always provide the VC for which the keyboard event applies=A0=
;
> +- 'down' is 1 for a key press event, 0 for a key release=A0;
> +- 'shift' is the current modifier state, mask bit indexes are KG_*=A0=
;

No space before the ';' (3 times).

> +- 'value' depends on the type of event.
> +
> +- KBD_KEYCODE events are always sent before other events, value is t=
he keycode.
> +- KBD_UNBOUND_KEYCODE events are sent if the keycode is not bound to=
 a keysym.
> +  value is the keycode.
> +- KBD_UNICODE events are sent if the keycode -> keysym translation p=
roduced a
> +  unicode character. value is the unicode value.
> +- KBD_KEYSYM events are sent if the keycode -> keysym translation pr=
oduced a
> +  non-unicode character. value is the keysym.
> +- KBD_POST_KEYSYM events are sent after the treatment of non-unicode=
 keysyms.
> +  That permits to inspect the resulting LEDs for instance.

     That permits (some object word here, like: you, one, code, etc.) t=
o
     inspect ...

> +
> +For each kind of event but the last, the callback may return NOTIFY_=
STOP in
> +order to "eat" the event: the notify loop is stopped and the keyboar=
d event is
> +dropped.
> +
> +I a rough C snippet, we have:

   In a rough (?)

> +
> +kbd_keycode(keycode) {
> +	...
> +	params.value =3D keycode;
> +	if (notifier_call_chain(KBD_KEYCODE,&params) =3D=3D NOTIFY_STOP)
> +	    || !bound) {
> +		notifier_call_chain(KBD_UNBOUND_KEYCODE,&params);
> +		return;
> +	}
> +
> +	if (unicode) {
> +		param.value =3D unicode;
> +		if (notifier_call_chain(KBD_UNICODE,&params) =3D=3D NOTIFY_STOP)
> +			return;
> +		emit unicode;
> +		return;
> +	}
> +
> +	params.value =3D keysym;
> +	if (notifier_call_chain(KBD_KEYSYM,&params) =3D=3D NOTIFY_STOP)
> +		return;
> +	apply keysym;
> +	notifier_call_chain(KBD_POST_KEYSYM,&params);
> +}
> +
> +NOTE: This notifier is usually called from interrupt context.
> --

---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
