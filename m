From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 28/40] Input: atmel_mxt_ts - Add CHG line handling in
 bootloader code
Date: Fri, 22 Feb 2013 17:45:20 -0800
Message-ID: <CANLzEkuXj3M6phmA2vrOpO9ofiMzLf47RHeN3G1GWdtwJ-FXOQ@mail.gmail.com>
References: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
	<1361555907-19840-29-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62817 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3BWBpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Feb 2013 20:45:21 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so1192912oag.32
        for <linux-input@vger.kernel.org>; Fri, 22 Feb 2013 17:45:21 -0800 (PST)
In-Reply-To: <1361555907-19840-29-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Olof Johansson <olofj@chromium.org>

On Fri, Feb 22, 2013 at 9:58 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
> The bootloader state machine toggles the CHG/Interrupt line to indicate when
> it has transitioned between states. Waiting for this event improves bootloader
> reliability.
>
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |   29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index a1f196b..f182228 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -430,6 +430,27 @@ static int mxt_probe_bootloader(struct mxt_data *data)
>         return 0;
>  }
>
> +static int mxt_wait_for_chg(struct mxt_data *data)
> +{
> +       int timeout_counter = 0;
> +       int count = 1E6;
> +
> +       if (data->pdata->read_chg == NULL) {

This also assumes the existence of data->pdata. If data->pdata ==
NULL, you're going to have a bad time.

> +               msleep(20);
> +               return 0;
> +       }
> +
> +       while ((timeout_counter++ <= count) && data->pdata->read_chg())
> +               udelay(20);
> +
> +       if (timeout_counter > count) {
> +               dev_err(&data->client->dev, "mxt_wait_for_chg() timeout!\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +

> --
> 1.7.10.4
>



-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
