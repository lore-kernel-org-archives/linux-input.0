From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 2/2 v2] Input: atmel_mxt_ts - Make CHG line high after the
 interrupts are enabled
Date: Fri, 8 Apr 2011 13:56:45 +0900
Message-ID: <BANLkTi=PRjx3nN0LQs9Asdj0PHj-ripv4g@mail.gmail.com>
References: <4D821E00.5060104@atmel.com>
	<AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>
	<4D95DB70.2090604@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58056 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1DHE4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2011 00:56:46 -0400
Received: by qwk3 with SMTP id 3so1886273qwk.19
        for <linux-input@vger.kernel.org>; Thu, 07 Apr 2011 21:56:46 -0700 (PDT)
In-Reply-To: <4D95DB70.2090604@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

2011/4/1 Iiro Valkonen <iiro.valkonen@atmel.com>:
> This is version 2 of the patch, where sysfs group is correctly remove=
d in case of error, and the firmware update is also considered (mxt_mak=
e_highchg is also called from mxt_initialize).
>
> Original description:
>
> Make the CHG line (interrupt line) go high after the interrupts have =
been enabled to make sure we don't miss the falling edge.
>
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 14 ++++++++++----
> =A01 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index 4012436..08ea846 100644
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
> @@ -832,6 +828,10 @@ static int mxt_initialize(struct mxt_data *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
> =A0 =A0 =A0 =A0info->matrix_ysize =3D val;
>
> + =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> +

This is unnecessary patch. If you add this for firmware update part,
how about move to mxt_update_fw_store()?

> =A0 =A0 =A0 =A0dev_info(&client->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Family ID: %d Variant=
 ID: %d Version: %d Build: %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->family_id, info-=
>variant_id, info->version,
> @@ -1098,8 +1098,14 @@ static int __devinit mxt_probe(struct i2c_clie=
nt *client,
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_unregister_device;
>
> + =A0 =A0 =A0 error =3D mxt_make_highchg(data);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_remove_sysfs_group;
> +

This is ok, but how about move this to the below request_threaded_irq()
instead of adding error handling?

> =A0 =A0 =A0 =A0return 0;
>
> +err_remove_sysfs_group:
> + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> =A0err_unregister_device:
> =A0 =A0 =A0 =A0input_unregister_device(input_dev);
> =A0 =A0 =A0 =A0input_dev =3D NULL;
> --
> 1.7.0.4
>

Thanks.

--=20
- Joonyoung Shim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
