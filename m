From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 2/2] Input: atmel_mxt_ts - Make CHG line high after the
 interrupts are enabled
Date: Mon, 21 Mar 2011 20:56:05 +0900
Message-ID: <AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>
References: <4D821E00.5060104@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33148 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1CUL4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 07:56:07 -0400
Received: by qyk7 with SMTP id 7so2361627qyk.19
        for <linux-input@vger.kernel.org>; Mon, 21 Mar 2011 04:56:05 -0700 (PDT)
In-Reply-To: <4D821E00.5060104@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi, Iiro.

2011/3/17 Iiro Valkonen <iiro.valkonen@atmel.com>:
> Make the CHG line (interrupt line) go high after the interrupts have =
been enabled to make sure we don't miss the falling edge.
>
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index f8cd478..ca2062a 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -804,10 +804,6 @@ static int mxt_initialize(struct mxt_data *data)
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
>
> - =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> - =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> -
> =A0 =A0 =A0 =A0mxt_handle_pdata(data);
>
> =A0 =A0 =A0 =A0/* Backup to memory */
> @@ -1098,6 +1094,10 @@ static int __devinit mxt_probe(struct i2c_clie=
nt *client,
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_unregister_device;
>
> + =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister_device;
> +

You are missing one error handling about sysfs_create_group() and pleas=
e
consider firmware update flow also.

Thanks.

> =A0 =A0 =A0 =A0return 0;
>
> =A0err_unregister_device:
> --
> 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
- Joonyoung Shim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
