From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: bugfix for controller detection failure
Date: Fri, 6 Dec 2013 08:14:20 -0800
Message-ID: <20131206161419.GA4400@core.coreip.homeip.net>
References: <afgut4ql5ujewc30qasvonpu.1386341346081@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44069 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757774Ab3LFQOZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 11:14:25 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so1256831pde.28
        for <linux-input@vger.kernel.org>; Fri, 06 Dec 2013 08:14:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <afgut4ql5ujewc30qasvonpu.1386341346081@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo <puretaurus@163.com>
Cc: linux-input@vger.kernel.org

Hi Pablo,

On Fri, Dec 06, 2013 at 10:49:06PM +0800, Pablo wrote:
> Subject: [PATCH] i8042: bugfix for controller detection failure
> From: Zhong Jun <puretaurs@163.com>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dto=
r@mail.ru>, linux-input@vger.kernel.org
>=20
> =A0=A0=A0 if i8042 internal buffer is completely filled before i8042=20
> initialization starting, function i8042_controller_check will fail be=
cause
> i8042_flush returns I8042_BUFFER_SIZE although i8042 internal buffer =
is=20
> completely cleared and I8042_STR_OBF bit of i8042 status register is =
cleared.
> =A0=A0=A0 To reproduce this bug, holding any key down while the kerne=
l booting from=20
> scratch. After system is up, no i8042 entry in /sys/bus/platform/devi=
ces directory and
> key press is not responded.

I believe this problem shoudl be fixed by commit
2f0d2604134880f739642fd7c3ae55db33c838e7

Thanks.

>=20
> Signed-off-by: Zhong Jun <zhongjun@zte.com.cn>
> Tested-by: Zhong Jun <zhongjun@zte.com.cn>
> Reviewed-by: Wu Dongling <wudongling@zte.com.cn>
> Reviewed-by: Jiang Biao jiang.biao2@zte.com.cn
>=20
> diff -up linux-2.6.32.61/drivers/input/serio/i8042.c.orig linux-2.6.3=
2.61/drivers/input/serio/i8042.c
> --- linux-2.6.32.61/drivers/input/serio/i8042.c.orig=A0=A0=A0 2013-11=
-29 16:42:37.788834724 +0800
> +++ linux-2.6.32.61/drivers/input/serio/i8042.c 2013-11-29 16:46:42.3=
71877282 +0800
> @@ -194,7 +194,7 @@ static int i8042_flush(void)
>=20
> =A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&i8042_lock, flags);
>=20
> -=A0=A0=A0=A0=A0=A0 return i;
> +=A0=A0=A0=A0=A0=A0 return i + (str & I8042_STR_OBF);
> }
>=20
> /*
> @@ -781,7 +781,7 @@ static int __init i8042_check_aux(void)
>=20
> static int i8042_controller_check(void)
> {
> -=A0=A0=A0=A0=A0=A0 if (i8042_flush() =3D=3D I8042_BUFFER_SIZE) {
> +=A0=A0=A0=A0=A0=A0 if (i8042_flush() > I8042_BUFFER_SIZE) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR "i8042.=
c: No controller found.\n");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
> =A0=A0=A0=A0=A0=A0=A0 }

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
