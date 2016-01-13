From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Tue, 12 Jan 2016 22:44:59 -0800
Message-ID: <CAKdAkRSZpc7WmGB=Wnk=_YQ1Tj2Fc_PhiqSFuyg+iGctzaNbNg@mail.gmail.com>
References: <1452666204-372-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35217 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcAMGpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 01:45:00 -0500
In-Reply-To: <1452666204-372-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Lin <yajohn@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, "jeffrey.lin" <jeffrey.lin@rad-ic.com>, roger.yang@rad-ic.com, KP.li@rad-ic.com, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Jeffrey,

On Tue, Jan 12, 2016 at 10:23 PM, Jeffrey Lin <yajohn@gmail.com> wrote:
> This patch is porting Raydium I2C touch driver. Developer can enable raydium touch driver by modifying define
> "CONFIG_TOUCHSCREEN_RM_TS".
>
> Signed-off-by: jeffrey lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/rm31100_ts.c | 571 +++++++++++++++------------------
>  1 file changed, 250 insertions(+), 321 deletions(-)
>
> diff --git a/drivers/input/touchscreen/rm31100_ts.c b/drivers/input/touchscreen/rm31100_ts.c
> index 941fa31..e024bbd 100644
> --- a/drivers/input/touchscreen/rm31100_ts.c
> +++ b/drivers/input/touchscreen/rm31100_ts.c
> @@ -28,14 +28,11 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

You seem to have sent incremental patch against the version you sent
earlier. Until the driver gets accepted into mainline kernel please
continue posting the full patch.

Thanks.

-- 
Dmitry
