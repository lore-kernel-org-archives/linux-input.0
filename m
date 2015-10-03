From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] input: Port rotary_encoder to of_property_read_bool
Date: Sat, 3 Oct 2015 15:44:51 -0300
Message-ID: <CAAEAJfAkVCf1ar-RO-A1Sd-rO4o4yC8RriEuo8t4+6c5-_yLFw@mail.gmail.com>
References: <1387239038-19089-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33800 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCSow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Oct 2015 14:44:52 -0400
Received: by wicfx3 with SMTP id fx3so71164541wic.1
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2015 11:44:51 -0700 (PDT)
In-Reply-To: <1387239038-19089-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 16 December 2013 at 21:10, Ben Gamari <bgamari.foss@gmail.com> wrote=
:
> ---
>  drivers/input/misc/rotary_encoder.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc=
/rotary_encoder.c
> index f920ba7..52049db 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -175,12 +175,9 @@ static struct rotary_encoder_platform_data *rota=
ry_encoder_parse_dt(struct devic
>         pdata->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
>         pdata->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
>
> -       pdata->relative_axis =3D !!of_get_property(np,
> -                                       "rotary-encoder,relative-axis=
", NULL);
> -       pdata->rollover =3D !!of_get_property(np,
> -                                       "rotary-encoder,rollover", NU=
LL);
> -       pdata->half_period =3D !!of_get_property(np,
> -                                       "rotary-encoder,half-period",=
 NULL);
> +       pdata->relative_axis =3D of_property_read_bool(np, "rotary-en=
coder,relative-axis");
> +       pdata->rollover =3D of_property_read_bool(np, "rotary-encoder=
,rollover");
> +       pdata->half_period =3D of_property_read_bool(np, "rotary-enco=
der,half-period");
>
>         return pdata;
>  }
> --
> 1.8.3.2
>

Hm, looks like this one felt through the cracks. It applies cleanly on
linux-next
and it looks fine, except the commit log is a bit off.

Ben, you should resend this one. The format is not quite right:

* needs your Signed-off-by
* needs some commit log. Something simple like "This commit is a
cosmetic cleanup,
changing the driver to use of_property_read_bool to read boolean
devicetree properties."
* needs a better subject "input: rotary-encoder: Use of_property_read_b=
ool".

=46eel free to add my Acked-by to it.

Thanks,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
