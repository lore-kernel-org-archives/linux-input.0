From: Eric.Brunet@lps.ens.fr
Subject: Bug with keyboard input
Date: Thu, 15 May 2008 14:02:25 +0200
Message-ID: <20080515120225.GA20070@platane.lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nef2.ens.fr ([129.199.96.40]:1441 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbYEOMl3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 08:41:29 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi list,

The following bug is on uptodate Fedora 7 on a Dell D430 laptop. It
happens both with the Fedora kernel-2.6.23.15-80.fc7 and with a vanilla
2.6.25.

In short, if I do
	echo -n "i8042" > /sys/bus/platform/drivers/i8042/unbind
followed by
	echo -n "i8042" > /sys/bus/platform/drivers/i8042/bind
everything works fine, EXCEPT if I hit a key on the keyboard between th=
e
unbind and the bind (tested with leftcontrol and spacebar). If I did hi=
t a
key, it looks like the keyboard isn't taking release events anymore and
the next key I hit is forever repeated. When my keyboard is in its work=
ing
state, I read
	N: Name=3D"AT Translated Set 2 keyboard"
in /proc/bus/input/devices. When it is in its non-working state (I hit =
a
key between unbind and bind), I read
	N: Name=3D"AT Raw Set 2 keyboard"
in the same file, and each time I hit a key, I have messages such as
    atkbd.c: Unknown key pressed (raw set 2, code 0x11f on isa0060/seri=
o0).
    atkbd.c: Use 'setkeycodes 1f <keycode>' to make it known.
    atkbd.c: Unknown key pressed (raw set 2, code 0x11e on isa0060/seri=
o0).
    atkbd.c: Use 'setkeycodes 1e <keycode>' to make it known.
in my logs.

Note that the key doesn't have to be pressed while the bind happens, it
is sufficient that the key have been pressed and released before the
bind.

So, is there a way to make it work and have the input layer automatical=
ly
recognize the correct keyboard type or keyboard mode ? If not, is there=
 a
way to keep it from guessing and to force it to treat the keyboard as a=
n
"AT Translated Set 2 keyboard" ?

As a final note, I get hit by this bug quite often during suspend/resum=
e
cycles. I had found that the keyboard wasn't all the time properly waki=
ng up,
(it was getting stuck) so I've added a file in /etc/pm/sleep.d to do th=
e
unbind at suspend time and the bind at resume time. This fixed my
problem, except that at times I stupidly press a key in the hope that t=
he
resume is done and that the screen is black only because of the
screensaver, and that hitting a key will make appear the unlocking
window...

Thanks,

	=C9ric Brunet
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
