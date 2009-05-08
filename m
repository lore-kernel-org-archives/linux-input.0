From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?=
	<sergey.belyashov@gmail.com>
Subject: [PATCH] autocentering support for Logitech Force 3D Pro
Date: Fri, 8 May 2009 23:44:59 +0400
Message-ID: <bb829a0b0905081244j36d069bfre73eba5d170494b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35809 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZEHTpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2009 15:45:00 -0400
Received: by ewy24 with SMTP id 24so2069858ewy.37
        for <linux-input@vger.kernel.org>; Fri, 08 May 2009 12:44:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hello
   Few days ago I sent email to the list with this text:

> Hello
> =C2=A0 I look code of ff-utils (fftest.c) and found that this program
> checks axis information for FF effects. For example, if kernel
> provides an ABS_X (also supported ABS_Y and ABS_WHEEL) via
> EVIOCGBIT(EV_FF, ...), then fftest shows "Axes query: Axis X". But I
> cannot found this feature in any existing driver. Moreover,
> documentation does not contain any information about it. So, is it
> really neccessary feature (I think yes)?
> =C2=A0 I am ready to create autocenter support patch for Logitech For=
ce 3D
> Pro (046d:c286). But all tested by me Logitech Joysticks with FF has
> support for autocentering in same way. May be it is good idea to add
> this feature for all joysticks in hid-lgff.c? If some joystick do not
> support it (users reported), then it is possible to exclude
> autocentering for this joystick later.

> Best regards,
> Sergey Belyashov

But no answer I recieve. So I write 3 incompatible patches:
1. adds autocentering support for Logitech force 3D Pro
2. adds autocentering support for all Logitech Joysticks and wheels
3. same as 2, but also adds information about applicable axes to the
EVIOCGBIT(EV_FF, ...) result and to FF documentation (discussion
required).

Only one patch may be applied.

Best regards,
Sergey Belyashov


PATCH N1 ---------------------------------------------------------

--- orig/drivers/hid/hid-lgff.c 2009-05-08 22:20:37.000000000 +0400
+++ new/drivers/hid/hid-lgff.c  2009-05-08 22:20:26.000000000 +0400
@@ -50,6 +50,12 @@
        -1
 };

+static const signed short ff_joystick_ac[] =3D {
+       FF_CONSTANT,
+       FF_AUTOCENTER,
+       -1
+};
+
 static const signed short ff_wheel[] =3D {
        FF_CONSTANT,
        FF_AUTOCENTER,
@@ -60,7 +66,7 @@
        { 0x046d, 0xc211, ff_rumble },
        { 0x046d, 0xc219, ff_rumble },
        { 0x046d, 0xc283, ff_joystick },
-       { 0x046d, 0xc286, ff_joystick },
+       { 0x046d, 0xc286, ff_joystick_ac },
        { 0x046d, 0xc294, ff_wheel },
        { 0x046d, 0xc295, ff_joystick },
        { 0x046d, 0xca03, ff_wheel },

PATCH N2 ---------------------------------------------------------

--- orig/drivers/hid/hid-lgff.c 2009-05-08 22:20:37.000000000 +0400
+++ new/drivers/hid/hid-lgff.c  2009-05-08 22:22:15.000000000 +0400
@@ -47,11 +47,6 @@

 static const signed short ff_joystick[] =3D {
        FF_CONSTANT,
-       -1
-};
-
-static const signed short ff_wheel[] =3D {
-       FF_CONSTANT,
        FF_AUTOCENTER,
        -1
 };
@@ -61,9 +56,9 @@
        { 0x046d, 0xc219, ff_rumble },
        { 0x046d, 0xc283, ff_joystick },
        { 0x046d, 0xc286, ff_joystick },
-       { 0x046d, 0xc294, ff_wheel },
+       { 0x046d, 0xc294, ff_joystick },
        { 0x046d, 0xc295, ff_joystick },
-       { 0x046d, 0xca03, ff_wheel },
+       { 0x046d, 0xca03, ff_joystick },
 };

 static int hid_lgff_play(struct input_dev *dev, void *data, struct
ff_effect *effect)

PATCH N3 ---------------------------------------------------------

--- orig/Documentation/input/ff.txt     2009-05-08 23:06:05.000000000 +=
0400
+++ new/Documentation/input/ff.txt      2009-05-08 23:09:29.000000000 +=
0400
@@ -72,6 +72,9 @@
 - FF_INERTIA    can simulate inertia
 - FF_GAIN      gain is adjustable
 - FF_AUTOCENTER        autocenter is adjustable
+- ABS_X        effects applicable for axis X
+- ABS_Y        effects applicable for axis Y
+- ABS_WHEEL    effects applicable for wheel

 Note: In most cases you should use FF_PERIODIC instead of FF_RUMBLE. A=
ll
       devices that support FF_RUMBLE support FF_PERIODIC (square, tria=
ngle,
--- orig/drivers/hid/hid-lgff.c 2009-05-08 22:20:37.000000000 +0400
+++ new/drivers/hid/hid-lgff.c  2009-05-08 22:55:56.000000000 +0400
@@ -47,12 +47,16 @@

 static const signed short ff_joystick[] =3D {
        FF_CONSTANT,
+       FF_AUTOCENTER,
+       ABS_X,
+       ABS_Y,
        -1
 };

 static const signed short ff_wheel[] =3D {
        FF_CONSTANT,
        FF_AUTOCENTER,
+       ABS_X,
        -1
 };

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Signed-off-by: Sergey Belyashov <Sergey.Belyashov@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
