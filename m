From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 2/2 v3] Input: atmel_mxt_ts - Make CHG line high after the
 interrupts are enabled
Date: Wed, 13 Apr 2011 14:17:49 +0900
Message-ID: <BANLkTikQ1Z+_7N9-Do_56Ry-1+vUVjOdiA@mail.gmail.com>
References: <4D821E00.5060104@atmel.com>
	<AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>
	<4D95DB70.2090604@atmel.com>
	<BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
	<4D9F0AA2.3010501@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33278 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1DMFRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 01:17:50 -0400
Received: by qyg14 with SMTP id 14so155957qyg.19
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2011 22:17:49 -0700 (PDT)
In-Reply-To: <4D9F0AA2.3010501@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

2011/4/8 Iiro Valkonen <iiro.valkonen@atmel.com>:
> Make the CHG line (interrupt line) go high after the interrupts have =
been enabled to make sure
> we don't miss the falling edge.
>
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
> v3: Change the locations where this is done to ensure correct operati=
on at FW update,
> =A0 =A0and to get rid of some error handling
>
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 12 ++++++++----
> =A01 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index 4012436..5f09f57 100644
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
> @@ -981,6 +977,10 @@ static ssize_t mxt_update_fw_store(struct device=
 *dev,
>
> =A0 =A0 =A0 =A0enable_irq(data->irq);
>
> + =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> +
> =A0 =A0 =A0 =A0return count;
> =A0}
>
> @@ -1090,6 +1090,10 @@ static int __devinit mxt_probe(struct i2c_clie=
nt *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_object;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> +
> =A0 =A0 =A0 =A0error =3D input_register_device(input_dev);
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> --
> 1.7.0.4
>
>

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.

--=20
- Joonyoung Shim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
