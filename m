From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wm831x-ts - Default pressure measurements on
Date: Wed, 9 Mar 2011 15:11:39 +0100
Message-ID: <20110309141139.GA5482@polaris.bitmath.org>
References: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51223 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932374Ab1CIOLx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 09:11:53 -0500
Content-Disposition: inline
In-Reply-To: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

Hi Mark,

> tslib expects pressure measurements so enable them by default for better
> compatibility.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

I cannot speak for the rationale of this patch, but logically,

>  drivers/input/touchscreen/wm831x-ts.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
> index 3c397c8..560200d 100644
> --- a/drivers/input/touchscreen/wm831x-ts.c
> +++ b/drivers/input/touchscreen/wm831x-ts.c
> @@ -259,7 +259,10 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
>  	else
>  		wm831x_ts->pd_irq = platform_get_irq_byname(pdev, "TCHPD");
>  
> -	wm831x_ts->pressure = pdata && pdata->pressure;
> +	if (pdata)
> +		wm831x_ts->pressure = pdata->pressure;
> +	else
> +		wm831x_ts->pressure = true;

wm831x_ts->pressure = !pdata || pdata->pressure;

should suffice.

Henrik
