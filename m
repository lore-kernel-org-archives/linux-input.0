From: Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4 - change F12 clip to inactive
 border debug
Date: Tue, 11 Apr 2017 10:27:22 -0700
Message-ID: <CAFXsbZqAvku-XV4ERTBvzr6oC2QL4poNSqUKf8J-qEGr5qthqQ@mail.gmail.com>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org> <1490403540-31425-3-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34894 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdDKR1Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 13:27:24 -0400
Received: by mail-io0-f194.google.com with SMTP id t68so1667988iof.2
        for <linux-input@vger.kernel.org>; Tue, 11 Apr 2017 10:27:24 -0700 (PDT)
In-Reply-To: <1490403540-31425-3-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>

One a Synaptics S7817, this patch works correctly.

Tested-by: Chris Healy <cphealy@gmail.com>

On Fri, Mar 24, 2017 at 5:58 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The data in F12_2D_Ctrl8 corresponds to the inactive border width used by the
> RMI device. It is not in pixel units and should not be treated as a clip value.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_f12.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 07aff43..8b0db08 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -113,20 +113,16 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
>         }
>
>         if (rmi_register_desc_has_subpacket(item, 2)) {
> -               sensor->axis_align.clip_x_low = buf[offset];
> -               sensor->axis_align.clip_x_high = sensor->max_x
> -                                                       - buf[offset + 1];
> -               sensor->axis_align.clip_y_low = buf[offset + 2];
> -               sensor->axis_align.clip_y_high = sensor->max_y
> -                                                       - buf[offset + 3];
> +               /* Units 1/128 sensor pitch */
> +               rmi_dbg(RMI_DEBUG_FN, &fn->dev,
> +                       "%s: Inactive Border xlo:%d xhi:%d ylo:%d yhi:%d\n",
> +                       __func__,
> +                       buf[offset], buf[offset + 1],
> +                       buf[offset + 2], buf[offset + 3]);
> +
>                 offset += 4;
>         }
>
> -       rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x low: %d x high: %d y low: %d y high: %d\n",
> -               __func__,
> -               sensor->axis_align.clip_x_low, sensor->axis_align.clip_x_high,
> -               sensor->axis_align.clip_y_low, sensor->axis_align.clip_y_high);
> -
>         if (rmi_register_desc_has_subpacket(item, 3)) {
>                 rx_receivers = buf[offset];
>                 tx_receivers = buf[offset + 1];
> --
> 2.7.4
>
