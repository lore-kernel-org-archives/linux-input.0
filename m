From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x-ts - Remove use of ternery operator
Date: Mon, 31 Jan 2011 09:20:58 -0800
Message-ID: <20110131172057.GA31891@core.coreip.homeip.net>
References: <1296475315-15704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:50097 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab1AaRVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 12:21:08 -0500
Received: by pxi15 with SMTP id 15so883512pxi.19
        for <linux-input@vger.kernel.org>; Mon, 31 Jan 2011 09:21:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296475315-15704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolsfonmicro.com

On Mon, Jan 31, 2011 at 12:01:55PM +0000, Mark Brown wrote:
> While being applied the driver was modified to add use of the ternery
> operator. Write the conditionals out longhand as I find it terribly
> unhelpful for legibility.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This is a bit of a preference issue but as I'm most likely to be
> updating the code it would be very helpful if you could apply it.
> 
>  drivers/input/touchscreen/wm831x-ts.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
> index a6121bd..1022f71 100644
> --- a/drivers/input/touchscreen/wm831x-ts.c
> +++ b/drivers/input/touchscreen/wm831x-ts.c
> @@ -76,9 +76,14 @@ static irqreturn_t wm831x_ts_data_irq(int irq, void *irq_data)
>  	struct wm831x *wm831x = wm831x_ts->wm831x;
>  	static int data_types[] = { ABS_X, ABS_Y, ABS_PRESSURE };
>  	u16 data[3];
> -	int count = wm831x_ts->pressure ? 3 : 2;
> +	int count;
>  	int i, ret;
>  
> +	if (wm831x_ts->pressure)
> +		count = 3;
> +	else
> +		count = 2;
> +

Hm, OK, although I really wish we did not use 4 lines for something as
simple as this.

-- 
Dmitry
