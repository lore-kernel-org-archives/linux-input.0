From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] keypad/nuc900: change keypad driver name from
	'nuc900-keypad' to 'nuc900-kpi'
Date: Thu, 22 Jul 2010 13:34:17 +0800
Message-ID: <AANLkTil5hsZYCWaMekzPkLfEC0_wxmBWfT3jj0IC5j6f@mail.gmail.com>
References: <4C431211.6030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39129 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0GVFeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jul 2010 01:34:18 -0400
In-Reply-To: <4C431211.6030706@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Dmitry,

Can it be applied?

Thanks!

> Hi Dmitry,
>
> I ever changed the keypad platform device name from 'nuc900-keypad' t=
o
> 'nuc900-kpi', but I forget to modify the related keypad driver name,s=
o
> the keypad driver does not work,I have to send the patch to fix this =
issue.
>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> ---
> =C2=A0drivers/input/keyboard/w90p910_keypad.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/=
keyboard/w90p910_keypad.c
> index 4ef764c..ee2bf6b 100644
> --- a/drivers/input/keyboard/w90p910_keypad.c
> +++ b/drivers/input/keyboard/w90p910_keypad.c
> @@ -258,7 +258,7 @@ static struct platform_driver w90p910_keypad_driv=
er =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 w90p910_keypad_probe,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __=
devexit_p(w90p910_keypad_remove),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
nuc900-keypad",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
nuc900-kpi",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =C2=A0=3D=
 THIS_MODULE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
> --
> 1.6.3.3
>



--=20
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
