From: Yufeng Shen <miletus@google.com>
Subject: Re: [PATCH 5/7] input: atmel_mxt_ts: only apply mxt_platform_data
 blen and threshold on mxt224, not mxt224e
Date: Wed, 20 Feb 2013 13:29:05 -0500
Message-ID: <CAPDwgkPK2Eb_7Sc_MJggkhEXJV-7+H992NO-Vo8FPC=-h5Y_5w@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
	<1360246668-2291-6-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:50195 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758925Ab3BTS3H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 13:29:07 -0500
Received: by mail-vc0-f182.google.com with SMTP id fl17so5268003vcb.41
        for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 10:29:05 -0800 (PST)
In-Reply-To: <1360246668-2291-6-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>, Benson Leung <bleung@chromium.org>

On Thu, Feb 7, 2013 at 9:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> From: Peter Meerwald <p.meerwald@bct-electronic.com>
>
> on the mxt224e, the upper 4 bits of blen are gain and the threshold should probably be set in CTECONFIG
>
> mxt_handle_pdata() is problematic as there is no way to NOT apply settings
>
> Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7fdd439..313b201 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -673,14 +673,6 @@ static void mxt_handle_pdata(struct mxt_data *data)
>         mxt_write_object(data, MXT_TOUCH_MULTI_T9, MXT_TOUCH_ORIENT,
>                         pdata->orient);
>
> -       /* Set touchscreen burst length */
> -       mxt_write_object(data, MXT_TOUCH_MULTI_T9,
> -                       MXT_TOUCH_BLEN, pdata->blen);
> -
> -       /* Set touchscreen threshold */
> -       mxt_write_object(data, MXT_TOUCH_MULTI_T9,
> -                       MXT_TOUCH_TCHTHR, pdata->threshold);
> -
>         /* Set touchscreen resolution */
>         mxt_write_object(data, MXT_TOUCH_MULTI_T9,
>                         MXT_TOUCH_XRANGE_LSB, (pdata->x_size - 1) & 0xff);
> @@ -693,6 +685,14 @@ static void mxt_handle_pdata(struct mxt_data *data)
>
>         /* Set touchscreen voltage */
>         if (pdata->voltage && data->info.family_id == MXT224_ID) {

As Benson noted in patch 5, what about the device that is neither 224
nor 224E ? burst length
and  threshold will no longer be applied.

> +               /* Set touchscreen burst length */
> +               mxt_write_object(data, MXT_TOUCH_MULTI_T9,
> +                               MXT_TOUCH_BLEN, pdata->blen);
> +
> +               /* Set touchscreen threshold */
> +               mxt_write_object(data, MXT_TOUCH_MULTI_T9,
> +                               MXT_TOUCH_TCHTHR, pdata->threshold);
> +
>                 if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
>                         voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
>                                 MXT_VOLTAGE_STEP;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
