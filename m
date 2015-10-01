From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/3] Input: alps: drop unlikely before IS_ERR_OR_NULL
Date: Thu, 1 Oct 2015 09:30:19 +0200
Message-ID: <20151001073019.GE1829@pali>
References: <03d18502ed7ed417f136c091f417d2d88c147ec6.1443667610.git.geliangtang@163.com>
 <081982d1188978b6020952afb4c2dcf3bc42fa1f.1443667610.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34070 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbJAHaW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 03:30:22 -0400
Content-Disposition: inline
In-Reply-To: <081982d1188978b6020952afb4c2dcf3bc42fa1f.1443667610.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 01 October 2015 10:55:30 Geliang Tang wrote:
> IS_ERR_OR_NULL already contain an unlikely compiler flag. Drop it.
>=20
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 4d24686..b4f146a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1367,7 +1367,7 @@ static void alps_report_bare_ps2_packet(struct =
psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev =3D priv->dev2;
>  		dev2 =3D psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,

Hm... I do not like this change. If I read code

 if (unlikely(IS_ERR_OR_NULL(priv->dev3)))

then I know that it is really unlikely that condition will be truth and
so this is some case of error/exception or something that normally does
not happen too much.

But if I read code

 if (IS_ERR_OR_NULL(priv->dev3))

I know nothing about chance that this condition will be truth. Explicit
unlikely in previous example give me more information.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
