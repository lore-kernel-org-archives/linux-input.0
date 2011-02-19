From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio: Compile error fix (altera_ps2.c)
Date: Sat, 19 Feb 2011 13:45:49 -0800
Message-ID: <20110219214549.GA4933@core.coreip.homeip.net>
References: <1298145859-10892-1-git-send-email-dustan.bower@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59022 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1BSVp4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Feb 2011 16:45:56 -0500
Content-Disposition: inline
In-Reply-To: <1298145859-10892-1-git-send-email-dustan.bower@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dustan Bower <dustan.bower@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>

On Sat, Feb 19, 2011 at 03:04:19PM -0500, Dustan Bower wrote:
> Fixed compile error, today's linux-next tree:
>=20
>   CC [M]  drivers/input/serio/altera_ps2.o
> drivers/input/serio/altera_ps2.c:182:1: error: expected =E2=80=98,=E2=
=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
> make[1]: *** [drivers/input/serio/altera_ps2.o] Error 1
> make: *** [_module_drivers/input/serio] Error 2
>=20
> Signed-off-by: Dustan Bower <dustan.bower@gmail.com>

Thanks Dustan.

Grant, maybe you could amend the original patch so that we do not
introduce bisection failure point?

> ---
>  drivers/input/serio/altera_ps2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/a=
ltera_ps2.c
> index 3fee88b..d363dc4 100644
> --- a/drivers/input/serio/altera_ps2.c
> +++ b/drivers/input/serio/altera_ps2.c
> @@ -178,7 +178,7 @@ static int __devexit altera_ps2_remove(struct pla=
tform_device *pdev)
>  static const struct of_device_id altera_ps2_match[] =3D {
>  	{ .compatible =3D "ALTR,ps2-1.0", },
>  	{},
> -}
> +};
>  MODULE_DEVICE_TABLE(of, altera_ps2_match);
>  #else /* CONFIG_OF */
>  #define altera_ps2_match NULL
> --=20
> 1.7.4.1
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
