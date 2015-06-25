From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [patch] HID: wacom: NULL dereferences on error in probe()
Date: Thu, 25 Jun 2015 13:59:17 -0700
Message-ID: <558C6BA5.8040905@gmail.com>
References: <20150624142743.GA1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36727 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbFYU7W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 16:59:22 -0400
In-Reply-To: <20150624142743.GA1702@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On 6/24/2015 7:27 AM, Dan Carpenter wrote:
> We can't pass a NULL to input_unregister_device().
>=20
> Fixes: 2a6cdbdd4cc0 ('HID: wacom: Introduce new 'touch_input' device'=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20

Looks reasonable to me.
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

--=20
Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 4c0ffca..44958d7 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1271,11 +1271,13 @@ fail_leds:
>  	pad_input_dev =3D NULL;
>  	wacom_wac->pad_registered =3D false;
>  fail_register_pad_input:
> -	input_unregister_device(touch_input_dev);
> +	if (touch_input_dev)
> +		input_unregister_device(touch_input_dev);
>  	wacom_wac->touch_input =3D NULL;
>  	wacom_wac->touch_registered =3D false;
>  fail_register_touch_input:
> -	input_unregister_device(pen_input_dev);
> +	if (pen_input_dev)
> +		input_unregister_device(pen_input_dev);
>  	wacom_wac->pen_input =3D NULL;
>  	wacom_wac->pen_registered =3D false;
>  fail_register_pen_input:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
