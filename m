From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:Avoid extra comparision in report_event api
Date: Thu, 29 Jan 2015 11:04:48 -0800
Message-ID: <20150129190448.GB33547@dtor-ws>
References: <mukesh.sharma091@gmail.com>
 <1422557798-106138-1-git-send-email-mukesh.sharma091@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47340 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbbA2TEx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 14:04:53 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so37792042ier.1
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 11:04:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422557798-106138-1-git-send-email-mukesh.sharma091@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mukesh Sharma <mukesh.sharma091@gmail.com>
Cc: linux-input@vger.kernel.org, aksgarg1989@gmail.com

On Thu, Jan 29, 2015 at 10:56:38AM -0800, Mukesh Sharma wrote:
> From: Mukesh Sharma <mukesh.sharma091@gmail.com>
>=20
> Set button->type to EV_KEY if no type is defined by platform or devic=
e
> tree structure hence we can remove the extra comparision operation fr=
om
> gpio_keys_gpio_report_event.
>=20
> Signed-off-by: Mukesh Sharma <mukesh.sharma091@gmail.com>

Did you try building this change?

  CC [M]  drivers/input/keyboard/gpio_keys.o
drivers/input/keyboard/gpio_keys.c: In function =E2=80=98gpio_keys_setu=
p_key=E2=80=99:
drivers/input/keyboard/gpio_keys.c:509:2: error: assignment of member
=E2=80=98type=E2=80=99 in read-only object
  button->type =3D button->type ?: EV_KEY;
  ^
make[1]: *** [drivers/input/keyboard/gpio_keys.o] Error 1
make: *** [drivers/input/keyboard/gpio_keys.o] Error 2

Thanks.

> ---
>  drivers/input/keyboard/gpio_keys.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index 883d6ae..9256ff9 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -335,14 +335,13 @@ static void gpio_keys_gpio_report_event(struct =
gpio_button_data *bdata)
>  {
>  	const struct gpio_keys_button *button =3D bdata->button;
>  	struct input_dev *input =3D bdata->input;
> -	unsigned int type =3D button->type ?: EV_KEY;
>  	int state =3D (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ but=
ton->active_low;
> =20
> -	if (type =3D=3D EV_ABS) {
> +	if (button->type =3D=3D EV_ABS) {
>  		if (state)
> -			input_event(input, type, button->code, button->value);
> +			input_event(input, button->type, button->code, button->value);
>  	} else {
> -		input_event(input, type, button->code, !!state);
> +		input_event(input, button->type, button->code, !!state);
>  	}
>  	input_sync(input);
>  }
> @@ -507,8 +506,8 @@ static int gpio_keys_setup_key(struct platform_de=
vice *pdev,
>  		isr =3D gpio_keys_irq_isr;
>  		irqflags =3D 0;
>  	}
> -
> -	input_set_capability(input, button->type ?: EV_KEY, button->code);
> +	button->type =3D button->type ?: EV_KEY;
> +	input_set_capability(input, button->type, button->code);
> =20
>  	/*
>  	 * Install custom action to cancel release timer and
> --=20
> 1.7.9.5
>=20
>=20
> ---
> This email has been checked for viruses by Avast antivirus software.
> http://www.avast.com
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
